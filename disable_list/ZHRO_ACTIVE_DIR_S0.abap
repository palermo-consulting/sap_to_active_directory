*&---------------------------------------------------------------------*
*&  Include           ZHRO_ACTIVE_DIR_S0
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-003.
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: p_pc TYPE c RADIOBUTTON GROUP rb1 USER-COMMAND uc1.
SELECTION-SCREEN COMMENT 3(17) text-004.
PARAMETERS: p_pfile TYPE c LENGTH 255 VISIBLE LENGTH 80.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
PARAMETERS: p_srv TYPE c RADIOBUTTON GROUP rb1 DEFAULT 'X'.
SELECTION-SCREEN COMMENT 3(17) text-005.
PARAMETERS: p_sfile TYPE c LENGTH 255 VISIBLE LENGTH 80 LOWER CASE. "DEFAULT '\\SCB2FS\SAPDR1\\HCM\TemSeFile.txt'.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE text-010.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(19) text-011 FOR FIELD p_backup.
PARAMETERS: p_backup TYPE c LENGTH 255 VISIBLE LENGTH 80 MODIF ID bop LOWER CASE.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b4.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_pfile.

  CALL METHOD cl_gui_frontend_services=>file_save_dialog
    CHANGING
      filename             = gv_filename
      path                 = gv_path
      fullpath             = gv_fullpath
    EXCEPTIONS
      cntl_error           = 1
      error_no_gui         = 2
      not_supported_by_gui = 3
      OTHERS               = 4.

  IF gv_fullpath IS NOT INITIAL.

    gs_dynpfields-fieldname = 'P_PFILE'.
    gs_dynpfields-fieldvalue = gv_fullpath.
    APPEND gs_dynpfields TO gt_dynpfields.

    CALL FUNCTION 'DYNP_VALUES_UPDATE'
      EXPORTING
        dyname               = sy-repid
        dynumb               = sy-dynnr
      TABLES
        dynpfields           = gt_dynpfields
      EXCEPTIONS
        invalid_abapworkarea = 1
        invalid_dynprofield  = 2
        invalid_dynproname   = 3
        invalid_dynpronummer = 4
        invalid_request      = 5
        no_fielddescription  = 6
        undefind_error       = 7
        OTHERS               = 8.

    p_pfile = gv_fullpath.

  ENDIF.

AT SELECTION-SCREEN OUTPUT.

  IF p_pc EQ 'X'.
    LOOP AT SCREEN.
      IF screen-name EQ 'P_SFILE'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.
      IF screen-name EQ 'P_PFILE'.
        screen-input = '1'.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'BOP'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ELSEIF p_srv EQ 'X'.
    LOOP AT SCREEN.
      IF screen-name EQ 'P_PFILE'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.
      IF screen-name EQ 'P_SFILE'.
        screen-input = '1'.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'BOP'.
        screen-input = '1'.
        MODIFY SCREEN.
      ENDIF.
    ENDLOOP.
  ENDIF.

  IF sy-slset EQ 'CUS&DEFAULT'.
    CONCATENATE gc_path1 gc_filename INTO p_sfile.
    CONCATENATE gc_path2 gc_archive '\' gc_filename INTO p_backup.
    CONCATENATE p_sfile '.' gc_ext INTO p_sfile.
    CONCATENATE p_backup '_' sy-datum '.' gc_ext INTO p_backup.
  ENDIF.


AT SELECTION-SCREEN ON p_pfile.
  IF sy-ucomm NE 'UC1' AND sy-ucomm NE 'UC2'.
    IF p_pc EQ 'X' AND p_pfile IS INITIAL.
      MESSAGE e016(rp) WITH 'Please provide a full PC path and filename.'.
    ENDIF.
  ENDIF.

AT SELECTION-SCREEN ON p_sfile.
  IF sy-ucomm NE 'UC1' AND sy-ucomm NE 'UC2'.
    IF p_srv EQ 'X' AND p_sfile IS INITIAL.
      MESSAGE e016(rp) WITH 'Please provide a full server path and filename.'.
    ENDIF.
  ENDIF.

AT SELECTION-SCREEN.

  IF p_pc EQ 'X'.
    p_sfile = gv_sfile.
  ELSE.
    CLEAR p_pfile.
  ENDIF.
