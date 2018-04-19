*&---------------------------------------------------------------------*
*&  Include           ZHRO_ACTIVE_DIR_F0
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&  Include           ZHRO_ADTIVE_DIR_F0
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  GET_PERNR
*&---------------------------------------------------------------------*
*       Get PERNR
*----------------------------------------------------------------------*
FORM get_pernr .

  DATA: ls_data TYPE ts_data,
        lv_land LIKE t001-land1.


  MOVE pernr-pernr TO ls_data-pernr.

  rp-provide-from-last p0000 space pn-begda pn-endda.
  IF pnp-sw-found EQ '1'.
    IF p0000-massn NOT IN pnpmassn.
      REJECT.
    ENDIF.
    IF p0000-stat2 NOT IN pnpstat2.
      REJECT.
    ENDIF.

    IF p0000-begda NOT BETWEEN pn-begda AND pn-endda.
      IF p0000-begda GT pn-endda OR
         p0000-aedtm NOT BETWEEN pn-begda AND pn-endda.
        REJECT.
      ENDIF.
    ENDIF.
    WRITE p0000-begda TO ls_data-begda MM/DD/YYYY.
    SELECT mntxt FROM t529t INTO ls_data-mntxt
      WHERE sprsl EQ sy-langu
        AND massn EQ p0000-massn.
    ENDSELECT.
    SELECT text1 FROM t529u INTO ls_data-stat2
      WHERE sprsl EQ sy-langu
        AND statn EQ '2'
        AND statv EQ p0000-stat2.
    ENDSELECT.
  ELSE.
    PERFORM error
                USING
                   'E'
                   'E001'
                   space
                   space
                   space
                   space.
  ENDIF.

  rp-provide-from-last p0001 space pn-begda pn-endda.
  IF pnp-sw-found EQ '1'.
    IF p0001-bukrs NOT IN pnpbukrs.
      REJECT.
    ENDIF.
    MOVE p0001-bukrs TO ls_data-bukrs.
    SELECT butxt land1 FROM t001 INTO (ls_data-butxt, lv_land)
      WHERE bukrs EQ p0001-bukrs.
    ENDSELECT.
    CASE lv_land.
      WHEN 'CA' OR 'US' OR 'MX' OR 'AR' OR 'CL' OR 'BR'.
        ls_data-region = 'NA'.
      WHEN OTHERS.
        ls_data-region = 'EU'.
    ENDCASE.
    SELECT ort01 FROM t777a INTO ls_data-ort01
      WHERE build EQ p0001-yywork_location.
    ENDSELECT.
    SELECT ltext FROM cskt INTO ls_data-kltxt
      WHERE spras EQ sy-langu
        AND kokrs EQ p0001-kokrs
        AND kostl EQ p0001-kostl
        AND datbi EQ '99991231'.
    ENDSELECT.
  ELSE.
    PERFORM error
                USING
                   'E'
                   'E002'
                   space
                   space
                   space
                   space.
  ENDIF.

  rp-provide-from-last p0002 space pn-begda pn-endda.
  IF pnp-sw-found EQ '1'.
    MOVE p0002-nachn TO ls_data-nachn.
    MOVE p0002-vorna TO ls_data-vorna.
  ELSE.
    PERFORM error
                USING
                   'E'
                   'E003'
                   space
                   space
                   space
                   space.
  ENDIF.

  rp-provide-from-last p0105 '9002' pn-begda pn-endda.
  IF pnp-sw-found EQ '1'.
    MOVE p0105-usrid TO ls_data-usrid.
  ELSE.
*    PERFORM error
*                USING
*                   'E'
*                   'E004'
*                   space
*                   space
*                   space
*                   space.
  ENDIF.


  APPEND ls_data TO gt_data.

ENDFORM.                    " GET_PERNR
*&---------------------------------------------------------------------*
*&      Form  ERROR
*&---------------------------------------------------------------------*
*       Write error to screen
*----------------------------------------------------------------------*
FORM error USING fv_etype fv_error_number fv_err_txt1 fv_err_txt2 fv_err_txt3 fv_err_txt4.

* Format color col_background intensified on.
  IF fv_etype EQ 'E'.
    FORMAT COLOR COL_NEGATIVE   INTENSIFIED ON.
  ELSE.
    FORMAT COLOR COL_TOTAL INTENSIFIED ON.
  ENDIF.
  WRITE:/ text-t01.
  WRITE:/ text-t02, pernr-pernr.
  IF fv_etype EQ 'E'.
    WRITE:/ text-t03, fv_error_number.
  ELSE.
    WRITE:/ text-t04, fv_error_number.
  ENDIF.
  WRITE:/ text-t01.
  FORMAT INTENSIFIED OFF.

  CASE fv_error_number.
    WHEN 'E001'.
      WRITE:/2 text-e01.
    WHEN 'E002'.
      WRITE:/2 text-e02.
    WHEN 'E003'.
      WRITE:/2 text-e03.
    WHEN 'E004'.
      WRITE:/2 text-e04.
  ENDCASE.

  IF fv_etype EQ 'E'.
    REJECT.
  ENDIF.

ENDFORM.                    "ERROR
*&---------------------------------------------------------------------*
*&      Form  WRITE_TO_FILE
*&---------------------------------------------------------------------*
*       Write to file
*----------------------------------------------------------------------*
FORM write_to_file .

  DATA: lv_lines TYPE i,
        lt_file  TYPE tt_file.

  DESCRIBE TABLE gt_data LINES lv_lines.
  CHECK lv_lines GE 1.

  PERFORM convert_to_csv_file USING gt_data CHANGING lt_file.
  PERFORM add_header CHANGING lt_file.

  IF p_pc EQ 'X'.
    PERFORM create_file_on_pc USING p_pfile lt_file.
  ELSEIF p_srv EQ 'X'.
    PERFORM create_file_on_srv USING p_sfile p_backup lt_file.
  ENDIF.

ENDFORM.                    " WRITE_TO_FILE
*&---------------------------------------------------------------------*
*&      Form  CONVERT_TO_CSV
*&---------------------------------------------------------------------*
*       Convert a WFN record to a CSV string
*----------------------------------------------------------------------*
FORM convert_to_csv USING fs_data CHANGING fv_return.

  FIELD-SYMBOLS: <lv_field>.

  DATA: lv_string TYPE string.

  DO.
    ASSIGN COMPONENT sy-index OF STRUCTURE fs_data TO <lv_field>.
    IF sy-subrc NE 0.
      EXIT.
    ENDIF.
    IF sy-index EQ 1.
      FIND ',' IN <lv_field>.
      IF sy-subrc EQ 0.
        CONCATENATE '"' <lv_field> '"' INTO lv_string.
        fv_return = lv_string.
      ELSE.
        fv_return = <lv_field>.
      ENDIF.
      CONTINUE.
    ENDIF.
    FIND ',' IN <lv_field>.
    IF sy-subrc EQ 0.
      CONCATENATE '"' <lv_field> '"' INTO lv_string.
      CONCATENATE fv_return ',' lv_string INTO fv_return.
    ELSE.
      CONCATENATE fv_return ',' <lv_field> INTO fv_return.
    ENDIF.
  ENDDO.

ENDFORM.                    " CONVERT_TO_CSV
*&---------------------------------------------------------------------*
*&      Form  CONVERT_TO_CSV_FILE
*&---------------------------------------------------------------------*
*       Convert to CSV File
*----------------------------------------------------------------------*
*      -->FT_DATA  Data table
*      <--FT_FILE  Table representing the CSV file
*----------------------------------------------------------------------*
FORM convert_to_csv_file  USING    ft_data TYPE tt_data
                          CHANGING ft_file TYPE tt_file.

  DATA: ls_data LIKE LINE OF ft_data,
        ls_line LIKE LINE OF ft_file.

  LOOP AT ft_data INTO ls_data.
    PERFORM convert_to_csv
                USING
                   ls_data
                CHANGING
                   ls_line.
    APPEND ls_line TO ft_file.

  ENDLOOP.

ENDFORM.                    " CONVERT_TO_CSV_FILE
*&---------------------------------------------------------------------*
*&      Form  CREATE_FILE_ON_PC
*&---------------------------------------------------------------------*
*       Create the file on the local computer
*----------------------------------------------------------------------*
*      -->FV_FILE     Full file path
*      -->FT_DATATAB  Internal table of TemSe file
*----------------------------------------------------------------------*
FORM create_file_on_pc  USING    fv_file
                                 ft_datatab TYPE tt_file.

  DATA: lv_filename TYPE string.

  IF fv_file IS NOT INITIAL.

    MOVE fv_file TO lv_filename.

    CALL METHOD cl_gui_frontend_services=>gui_download
      EXPORTING
        filename                = lv_filename
        trunc_trailing_blanks   = 'X'
      CHANGING
        data_tab                = ft_datatab
      EXCEPTIONS
        file_write_error        = 1
        no_batch                = 2
        gui_refuse_filetransfer = 3
        invalid_type            = 4
        no_authority            = 5
        unknown_error           = 6
        header_not_allowed      = 7
        separator_not_allowed   = 8
        filesize_not_allowed    = 9
        header_too_long         = 10
        dp_error_create         = 11
        dp_error_send           = 12
        dp_error_write          = 13
        unknown_dp_error        = 14
        access_denied           = 15
        dp_out_of_memory        = 16
        disk_full               = 17
        dp_timeout              = 18
        file_not_found          = 19
        dataprovider_exception  = 20
        control_flush_error     = 21
        not_supported_by_gui    = 22
        error_no_gui            = 23
        OTHERS                  = 24.
    IF sy-subrc EQ 0.
      MESSAGE s016(rp) WITH 'TemSe file created on PC.'.
    ELSE.
      MESSAGE e016(rp) WITH 'Error creating TemSe file on PC.'.
    ENDIF.

  ENDIF.

ENDFORM.                    " CREATE_FILE_ON_PC
*&---------------------------------------------------------------------*
*&      Form  CREATE_FILE_ON_SRV
*&---------------------------------------------------------------------*
*       Create the file on the application server
*----------------------------------------------------------------------*
*      -->FV_FILE     Full file path
*      -->FT_DATATAB  Internal table of TemSe file
*----------------------------------------------------------------------*
FORM create_file_on_srv  USING    fv_file
                                  fv_backup
                                  ft_datatab TYPE tt_file.

  DATA: ls_datatab    TYPE p99st_raw,
        lv_file       TYPE c LENGTH 275.

  lv_file = fv_file.

  OPEN DATASET lv_file FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.
  IF sy-subrc NE 0..
    MESSAGE e016(rp) WITH 'Server path could not be found.'.
  ENDIF.

  LOOP AT ft_datatab INTO ls_datatab.
    TRANSFER ls_datatab TO lv_file.
  ENDLOOP.

  CLOSE DATASET lv_file.

  IF sy-subrc EQ 0.
    MESSAGE s016(rp) WITH 'TemSe file created on server.'.
  ELSE.
    MESSAGE e016(rp) WITH 'Error creating TemSe file on server.'.
  ENDIF.

  IF fv_backup IS NOT INITIAL.
    OPEN DATASET fv_backup FOR OUTPUT IN TEXT MODE ENCODING DEFAULT.
    IF sy-subrc NE 0..
      MESSAGE e016(rp) WITH 'Server path could not be found.'.
    ENDIF.

    LOOP AT ft_datatab INTO ls_datatab.
      TRANSFER ls_datatab TO fv_backup.
    ENDLOOP.

    CLOSE DATASET fv_backup.
  ENDIF.

  IF sy-subrc EQ 0.
    MESSAGE s016(rp) WITH 'TemSe file created on server.'.
  ELSE.
    MESSAGE e016(rp) WITH 'Error creating TemSe file on server.'.
  ENDIF.

ENDFORM.                    " CREATE_FILE_ON_SRV
*&---------------------------------------------------------------------*
*&      Form  ADD_HEADER
*&---------------------------------------------------------------------*
*       Add header to the file
*----------------------------------------------------------------------*
*      <--FT_FILE  CSV File
*----------------------------------------------------------------------*
FORM add_header  CHANGING ft_file TYPE tt_file.

  DATA: ls_line TYPE ts_line.

  MOVE 'Personnel Number,Network ID,Last Name,First Name,Actions Start Date,Action Type,Employment Status,Company Code code,Company Code,Location City,Cost Center,Region' TO ls_line.
  INSERT ls_line INTO ft_file INDEX 1.


ENDFORM.                    " ADD_HEADER
