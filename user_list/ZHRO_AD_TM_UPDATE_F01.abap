*&---------------------------------------------------------------------*
*&  Include           ZHRO_AD_TM_UPDATE_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  EXPORT_NEW_DATA
*&---------------------------------------------------------------------*
*       Export new data
*----------------------------------------------------------------------*
FORM export_new_data .

  DATA: lv_seqnr TYPE n LENGTH 9.

  PERFORM export_directory CHANGING lv_seqnr.
  PERFORM export_data USING lv_seqnr.

ENDFORM.                    " EXPORT_NEW_DATA
*&---------------------------------------------------------------------*
*&      Form  EXPORT_DIRECTORY
*&---------------------------------------------------------------------*
*       Export directory
*----------------------------------------------------------------------*
FORM export_directory CHANGING fv_seqnr.

  DATA: ls_id_key            TYPE ts_id_key,
        ls_if_version        TYPE ts_if_version,
        ls_if_results        TYPE ts_if_results,
        lt_if_results        TYPE tt_if_results.

  MOVE:  pernr-pernr TO ls_id_key-pernr,
         gc_if_name  TO ls_id_key-fldid.

  IMPORT if_version  TO ls_if_version
         if_results  TO lt_if_results
         FROM DATABASE zhr_pcl2(id) ID ls_id_key.

  ls_if_version-cdate = sy-datum.
  ls_if_version-ctime = sy-uzeit.
  ls_if_version-cprog = sy-repid.
  ls_if_version-uname = sy-uname.

  SORT lt_if_results BY seqnr DESCENDING.
  READ TABLE lt_if_results INTO ls_if_results INDEX 1.

  ls_if_results-seqnr = fv_seqnr = ls_if_results-seqnr + 1.
  ls_if_results-frper = gv_frper.
  ls_if_results-frbeg = gv_frbeg.
  ls_if_results-frend = gv_frend.
  ls_if_results-rundt = sy-datum.
  ls_if_results-runtm = sy-uzeit.
  ls_if_results-abkrs = pernr-abkrs.
  SORT lt_if_results BY seqnr ASCENDING.
  APPEND ls_if_results TO lt_if_results.

  zhr_pcl2-aedtm = sy-datum.
  zhr_pcl2-uname = sy-uname.
  zhr_pcl2-pgmid = sy-repid.
  zhr_pcl2-versn = gc_if_version.
  EXPORT if_version FROM ls_if_version
         if_results FROM lt_if_results
         TO DATABASE zhr_pcl2(id) ID ls_id_key.

ENDFORM.                    " EXPORT_DIRECTORY
*&---------------------------------------------------------------------*
*&      Form  GET_NEW_DATA
*&---------------------------------------------------------------------*
*       Get new data
*----------------------------------------------------------------------*
FORM get_new_data .

  DATA: ls_new_p0000 TYPE ts_p0000,
        ls_new_p0001 TYPE ts_p0001,
        ls_new_p0002 TYPE ts_p0002,
        ls_new_p0105 TYPE ts_p0105.

  LOOP AT p0000
    WHERE begda LE gv_frend
      AND endda GE gv_frbeg.
    MOVE-CORRESPONDING p0000 TO ls_new_p0000.
    APPEND ls_new_p0000 TO gt_new_p0000.
  ENDLOOP.

  LOOP AT p0001
    WHERE begda LE gv_frend
      AND endda GE gv_frbeg.
    MOVE-CORRESPONDING p0001 TO ls_new_p0001.
    APPEND ls_new_p0001 TO gt_new_p0001.
  ENDLOOP.

  LOOP AT p0002
    WHERE begda LE gv_frend
      AND endda GE gv_frbeg.
    MOVE-CORRESPONDING p0002 TO ls_new_p0002.
    APPEND ls_new_p0002 TO gt_new_p0002.
  ENDLOOP.

  LOOP AT p0105
    WHERE begda LE gv_frend
      AND endda GE gv_frbeg
      AND ( usrty EQ gc_network_id OR
            usrty EQ gc_email_addr ).
    MOVE-CORRESPONDING p0105 TO ls_new_p0105.
    APPEND ls_new_p0105 TO gt_new_p0105.
  ENDLOOP.

ENDFORM.                    " GET_NEW_DATA
*&---------------------------------------------------------------------*
*&      Form  INIT_GLOBALS
*&---------------------------------------------------------------------*
*       Initialize global variables
*----------------------------------------------------------------------*
FORM init_globals .

  CLEAR:  gt_old_p0000[],
          gt_old_p0001[],
          gt_old_p0002[],
          gt_old_p0105[].

  CLEAR:  gt_new_p0000[],
          gt_new_p0001[],
          gt_new_p0002[],
          gt_new_p0105[].

  CLEAR:  gs_old_p0000,
          gs_old_p0001,
          gs_old_p0002,
          gs_old_p0105.

  CLEAR:  gs_new_p0000,
          gs_new_p0001,
          gs_new_p0002,
          gs_new_p0105.

  CLEAR:  zhr_pcl2, t569v, t549a, t549q.

  CLEAR:  gv_frper, gv_frbeg, gv_frend.

  CLEAR:  gs_employee_data,
          gs_old_employee_data,
          gs_new_employee_data.

  CLEAR:  gv_effective_date.

  CLEAR:  gs_change_blocks.

  CLEAR:  gv_date_01,
          gv_date_06,
          gv_date_07,
          gv_date_08,
          gv_date_09,
          gv_date_11,
          gv_date_12,
          gv_date_98,
          gv_date_99.

  CLEAR:  gv_abart,
          gv_trfkz,
          gv_zeinh.

  MOVE '0' TO gs_export_flags-ed_export.        "Reset the export flag for the employee data record

ENDFORM.                    " INIT_GLOBALS
*&---------------------------------------------------------------------*
*&      Form  EXPORT_DATA
*&---------------------------------------------------------------------*
*       Export data
*----------------------------------------------------------------------*
FORM export_data USING fv_seqnr.

  DATA: ls_if_key       TYPE ts_if_key,
        ls_if_version   TYPE ts_if_version.

  MOVE: pernr-pernr TO ls_if_key-pernr,
        fv_seqnr    TO ls_if_key-seqnr,
        gc_if_name  TO ls_if_key-fldid.

  ls_if_version-cdate = sy-datum.
  ls_if_version-ctime = sy-uzeit.
  ls_if_version-cprog = sy-repid.
  ls_if_version-uname = sy-uname.

  zhr_pcl2-aedtm = sy-datum.
  zhr_pcl2-uname = sy-uname.
  zhr_pcl2-pgmid = sy-repid.
  zhr_pcl2-versn = gc_if_version.

  EXPORT if_version FROM ls_if_version
         p0000_exp  FROM gt_new_p0000
         p0001_exp  FROM gt_new_p0001
         p0002_exp  FROM gt_new_p0002
         p0105_exp  FROM gt_new_p0105
         TO DATABASE zhr_pcl2(if) ID ls_if_key.

ENDFORM.                    " EXPORT_DATA
*&---------------------------------------------------------------------*
*&      Form  GET_CURRENT_PERIOD
*&---------------------------------------------------------------------*
*       Get Current Period
*----------------------------------------------------------------------*
*      <--FV_FRPER  Current Period
*      <--FV_FRBEG  Period Begin Date
*      <--FV_FREND  Period End Date
*----------------------------------------------------------------------*
FORM get_current_period  CHANGING fv_frper
                                  fv_frbeg
                                  fv_frend.

*  SELECT  * FROM t569v WHERE
*    abkrs EQ pernr-abkrs AND
*    vwsaz EQ '1'.
*
*    SELECT * FROM t549a WHERE
*      abkrs EQ pernr-abkrs.
*
*      SELECT * FROM t549q WHERE
*        permo EQ t549a-permo AND
*        pabrj EQ t569v-pabrj AND
*        pabrp EQ t569v-pabrp.
*
*        CONCATENATE t569v-pabrj t569v-pabrp INTO fv_frper.
*        MOVE t549q-begda TO fv_frbeg.
*        MOVE t549q-endda TO fv_frend.
*
*      ENDSELECT.
*
*    ENDSELECT.
*
*  ENDSELECT.

  MOVE sy-datum TO : fv_frbeg, fv_frend.

ENDFORM.                    " GET_CURRENT_PERIOD
*&---------------------------------------------------------------------*
*&      Form  GET_OLD_DATA
*&---------------------------------------------------------------------*
*       Get old data from ZHR_PCL2 cluster table
*----------------------------------------------------------------------*
FORM get_old_data .

  DATA: lv_seqnr      TYPE n LENGTH 9,
        ls_if_key     TYPE ts_if_key,
        ls_if_version TYPE ts_if_version.

  PERFORM get_last_seqnr CHANGING lv_seqnr.

  MOVE: pernr-pernr TO ls_if_key-pernr,
        lv_seqnr    TO ls_if_key-seqnr,
        gc_if_name  TO ls_if_key-fldid.

  IMPORT if_version TO ls_if_version
         p0000_exp  TO gt_old_p0000
         p0001_exp  TO gt_old_p0001
         p0002_exp  TO gt_old_p0002
         p0105_exp  TO gt_old_p0105
         FROM DATABASE zhr_pcl2(if) ID ls_if_key.

ENDFORM.                    " GET_OLD_DATA
*&---------------------------------------------------------------------*
*&      Form  GET_LAST_SEQNR
*&---------------------------------------------------------------------*
*       Get the latest sequence number
*----------------------------------------------------------------------*
*      <--FV_SEQNR  Sequence number
*----------------------------------------------------------------------*
FORM get_last_seqnr  CHANGING fv_seqnr.

  DATA: ls_id_key       TYPE ts_id_key,
        ls_if_version   TYPE ts_if_version,
        ls_if_results   TYPE ts_if_results,
        lt_if_results   TYPE tt_if_results.

  ls_id_key-pernr = pernr-pernr.
  ls_id_key-fldid = gc_if_name.
  IMPORT if_version  TO ls_if_version
         if_results  TO lt_if_results
         FROM DATABASE zhr_pcl2(id) ID ls_id_key.

  SORT lt_if_results BY seqnr DESCENDING.
  READ TABLE lt_if_results INTO ls_if_results INDEX 1.
  fv_seqnr = ls_if_results-seqnr.

ENDFORM.                    " GET_LAST_SEQNR
*&---------------------------------------------------------------------*
*&      Form  BEGIN
*&---------------------------------------------------------------------*
*       Begiin of interface
*----------------------------------------------------------------------*
FORM begin .

  DATA: ls_column_names TYPE ts_column_names.

  go_structdescr_ed ?= cl_abap_typedescr=>describe_by_name( 'TS_EMPLOYEE_DATA'  ).

  MOVE: 'USRID1' TO ls_column_names-field, 'NetworkID' TO ls_column_names-name.
  APPEND ls_column_names TO gt_column_names.
  MOVE: 'VORNA1' TO ls_column_names-field, 'Stericorp User List_First name' TO ls_column_names-name.
  APPEND ls_column_names TO gt_column_names.
  MOVE: 'NACHN1' TO ls_column_names-field, 'Stericorp User List_Last name' TO ls_column_names-name.
  APPEND ls_column_names TO gt_column_names.
  MOVE: 'EMAIL1' TO ls_column_names-field, 'Stericorp User List_Email' TO ls_column_names-name.
  APPEND ls_column_names TO gt_column_names.
  MOVE: 'PERNR'  TO ls_column_names-field, 'SAP_ID' TO ls_column_names-name.
  APPEND ls_column_names TO gt_column_names.
  MOVE: 'NACHN2' TO ls_column_names-field, 'SAP_Last name' TO ls_column_names-name.
  APPEND ls_column_names TO gt_column_names.
  MOVE: 'VORNA2' TO ls_column_names-field, 'SAP_First name' TO ls_column_names-name.
  APPEND ls_column_names TO gt_column_names.
  MOVE: 'STAT2'  TO ls_column_names-field, 'SAP_Employment Status' TO ls_column_names-name.
  APPEND ls_column_names TO gt_column_names.
  MOVE: 'EMAIL2' TO ls_column_names-field, 'SAP_Email' TO ls_column_names-name.
  APPEND ls_column_names TO gt_column_names.
  MOVE: 'LOCAT'  TO ls_column_names-field, 'Work Location' TO ls_column_names-name.
  APPEND ls_column_names TO gt_column_names.
  MOVE: 'PLANS'  TO ls_column_names-field, 'Job Title' TO ls_column_names-name.
  APPEND ls_column_names TO gt_column_names.
  MOVE: 'USRID2' TO ls_column_names-field, 'Manager_NetworkID' TO ls_column_names-name.
  APPEND ls_column_names TO gt_column_names.
  MOVE: 'REGION' TO ls_column_names-field, 'Region' TO ls_column_names-name.
  APPEND ls_column_names TO gt_column_names.

  PERFORM get_header CHANGING gs_header.
  APPEND gs_header TO gt_file_out.

ENDFORM.                    " BEGIN
*&---------------------------------------------------------------------*
*&      Form  GET_HEADER
*&---------------------------------------------------------------------*
*       Get the header line
*----------------------------------------------------------------------*
*      <--FS_HEADER  Header line
*----------------------------------------------------------------------*
FORM get_header  CHANGING fs_header TYPE ts_raw_line.

  DATA: lv_index        TYPE i,
        ls_component    TYPE abap_compdescr,
        ls_column_names TYPE ts_column_names.

  LOOP AT go_structdescr_ed->components INTO ls_component.

    lv_index = lv_index + 1.
    READ TABLE gt_column_names INTO ls_column_names WITH KEY field = ls_component-name.
    IF lv_index EQ 1.
      fs_header = ls_column_names-name.
      CONTINUE.
    ENDIF.
    CONCATENATE fs_header ',' ls_column_names-name INTO fs_header.

  ENDLOOP.

ENDFORM.                    " GET_HEADER
*&---------------------------------------------------------------------*
*&      Form  CHANGE_VALIDATION
*&---------------------------------------------------------------------*
*       Change validation logic
*----------------------------------------------------------------------*
FORM change_validation .

* Set change block flags to get old/new data.  Then clear again after.
  PERFORM set_cb_flags.

* Process old data
  PERFORM set_old_data_records.
*  PERFORM get_dates.
*  PERFORM get_comp_details.
*  PERFORM get_bank_details.
  PERFORM get_ad_tm_data USING gc_part.

* Process new data
  PERFORM set_new_data_records.
*  PERFORM get_dates.
*  PERFORM get_comp_details.
*  PERFORM get_bank_details.
  PERFORM get_ad_tm_data USING gc_part.

  CLEAR: gs_change_blocks.   "Clear the change block flags

* Check for changes and there respective effective dates.
  PERFORM check_for_changes.

ENDFORM.                    " CHANGE_VALIDATION
*&---------------------------------------------------------------------*
*&      Form  SET_CB_FLAGS
*&---------------------------------------------------------------------*
*       Set the change block flags for getting old/new results
*----------------------------------------------------------------------*
FORM set_cb_flags .

*  MOVE 'X' TO : gs_change_blocks-cb_1,
*                gs_change_blocks-cb_2,
*                gs_change_blocks-cb_3,
*                gs_change_blocks-cb_4,
*                gs_change_blocks-cb_5,
*                gs_change_blocks-cb_6,
*                gs_change_blocks-cb_7,
*                gs_change_blocks-cb_8,
*                gs_change_blocks-cb_9,
*                gs_change_blocks-cb_10,
*                gs_change_blocks-cb_11,
*                gs_change_blocks-cb_12,
*                gs_change_blocks-cb_13,
*                gs_change_blocks-cb_14,
*                gs_change_blocks-cb_15,
*                gs_change_blocks-cb_16,
*                gs_change_blocks-cb_17,
*                gs_change_blocks-cb_18,
*                gs_change_blocks-cb_19,
*                gs_change_blocks-cb_20,
*                gs_change_blocks-cb_21,
*                gs_change_blocks-cb_22,
*                gs_change_blocks-cb_23,
*                gs_change_blocks-cb_24,
*                gs_change_blocks-cb_25,
*                gs_change_blocks-cb_26,
*                gs_change_blocks-cb_27,
*                gs_change_blocks-cb_28,
*                gs_change_blocks-cb_29,
*                gs_change_blocks-cb_30,
*                gs_change_blocks-cb_31,
*                gs_change_blocks-cb_32,
*                gs_change_blocks-cb_33,
*                gs_change_blocks-cb_34,
*                gs_change_blocks-cb_35,
*                gs_change_blocks-cb_36,
*                gs_change_blocks-cb_37,
*                gs_change_blocks-cb_38,
*                gs_change_blocks-cb_39,
*                gs_change_blocks-cb_40,
*                gs_change_blocks-cb_41,
*                gs_change_blocks-cb_42,
*                gs_change_blocks-cb_43,
*                gs_change_blocks-cb_44,
*                gs_change_blocks-cb_45,
*                gs_change_blocks-cb_46.

ENDFORM.                    " SET_CB_FLAGS
*&---------------------------------------------------------------------*
*&      Form  SET_OLD_DATA_RECORDS
*&---------------------------------------------------------------------*
*       Set old data records
*----------------------------------------------------------------------*
FORM set_old_data_records .

  DATA: lr_p0000 TYPE REF TO data,
        lr_p0001 TYPE REF TO data,
        lr_p0002 TYPE REF TO data,
        lr_p0105 TYPE REF TO data,
        lr_t0105 TYPE REF TO data.

  SORT gt_old_p0000 BY endda DESCENDING.
  READ TABLE gt_old_p0000 INTO gs_old_p0000 INDEX 1.

  SORT gt_old_p0001 BY endda DESCENDING.
  READ TABLE gt_old_p0001 INTO gs_old_p0001 INDEX 1.

  SORT gt_old_p0002 BY endda DESCENDING.
  READ TABLE gt_old_p0002 INTO gs_old_p0002 INDEX 1.

  SORT gt_old_p0105 BY endda DESCENDING.

  CREATE DATA lr_p0000 TYPE ts_p0000.
  CREATE DATA lr_p0001 TYPE ts_p0001.
  CREATE DATA lr_p0002 TYPE ts_p0002.
  CREATE DATA lr_p0105 TYPE ts_p0105.
  CREATE DATA lr_t0105 TYPE tt_p0105.

  ASSIGN lr_p0000->* TO <gs_p0000>.
  ASSIGN lr_p0001->* TO <gs_p0001>.
  ASSIGN lr_p0002->* TO <gs_p0002>.
  ASSIGN lr_p0105->* TO <gs_p0105>.
  ASSIGN lr_t0105->* TO <gt_p0105>.

  <gs_p0000> = gs_old_p0000.
  <gs_p0001> = gs_old_p0001.
  <gs_p0002> = gs_old_p0002.
  <gs_p0105> = gs_old_p0105.
  <gt_p0105> = gt_old_p0105[].

  ASSIGN gs_old_employee_data TO <gs_employee_data>.

ENDFORM.                    " SET_OLD_DATA_RECORDS
*&---------------------------------------------------------------------*
*&      Form  SET_NEW_DATA_RECORDS
*&---------------------------------------------------------------------*
*       Set new data records
*----------------------------------------------------------------------*
FORM set_new_data_records .

  DATA: lr_p0000 TYPE REF TO data,
        lr_p0001 TYPE REF TO data,
        lr_p0002 TYPE REF TO data,
        lr_p0105 TYPE REF TO data,
        lr_t0105 TYPE REF TO data.

  SORT gt_new_p0000 BY endda DESCENDING.
  READ TABLE gt_new_p0000 INTO gs_new_p0000 INDEX 1.

  SORT gt_new_p0001 BY endda DESCENDING.
  READ TABLE gt_new_p0001 INTO gs_new_p0001 INDEX 1.

  SORT gt_new_p0002 BY endda DESCENDING.
  READ TABLE gt_new_p0002 INTO gs_new_p0002 INDEX 1.

  SORT gt_new_p0105 BY endda DESCENDING.

  CREATE DATA lr_p0000 TYPE ts_p0000.
  CREATE DATA lr_p0001 TYPE ts_p0001.
  CREATE DATA lr_p0002 TYPE ts_p0002.
  CREATE DATA lr_p0105 TYPE ts_p0105.
  CREATE DATA lr_t0105 TYPE tt_p0105.

  ASSIGN lr_p0000->* TO <gs_p0000>.
  ASSIGN lr_p0001->* TO <gs_p0001>.
  ASSIGN lr_p0002->* TO <gs_p0002>.
  ASSIGN lr_p0105->* TO <gs_p0105>.
  ASSIGN lr_t0105->* TO <gt_p0105>.

  <gs_p0000> = gs_new_p0000.
  <gs_p0001> = gs_new_p0001.
  <gs_p0002> = gs_new_p0002.
  <gs_p0105> = gs_new_p0105.
  <gt_p0105> = gt_new_p0105[].

  ASSIGN gs_new_employee_data TO <gs_employee_data>.

ENDFORM.                    " SET_NEW_DATA_RECORDS
**&---------------------------------------------------------------------*
**&      Form  GET_DATES
**&---------------------------------------------------------------------*
**       Get dates from Infotype 41
**----------------------------------------------------------------------*
*FORM get_dates .
*
*  DATA: lv_darnn TYPE c LENGTH 5 VALUE 'DARNN',
*        lv_datnn TYPE c LENGTH 5 VALUE 'DATNN',
*        lv_num   TYPE n LENGTH 2.
*
*  FIELD-SYMBOLS: <lv_darnn> TYPE data,
*                 <lv_datnn> TYPE data.
*
*  CLEAR: gv_date_01, "Original Hire Date
*         gv_date_06, "Ajusted Service Date
*         gv_date_07, "Last Day Worked
*         gv_date_08, "Last Day Paid
*         gv_date_09, "Rehire Date
*         gv_date_11, "Tax ID Expiry Date
*         gv_date_12, "Seniority Date
*         gv_date_98, "Hire Date
*         gv_date_99. "Termination Date
*
*  CHECK <gs_p0041> IS NOT INITIAL.
*
*  DO 12 TIMES.
*    lv_num = lv_num + 1.
*    lv_darnn+3(2) = lv_num.
*    lv_datnn+3(2) = lv_num.
*
*    ASSIGN COMPONENT lv_darnn OF STRUCTURE <gs_p0041> TO <lv_darnn>.
*    ASSIGN COMPONENT lv_datnn OF STRUCTURE <gs_p0041> TO <lv_datnn>.
*
*
*    CASE <lv_darnn>.
*      WHEN '01'.
*        MOVE <lv_datnn> TO gv_date_01.   "Original Hire Date
*      WHEN '06'.
*        MOVE <lv_datnn> TO gv_date_06.   "Ajusted Service Date
*      WHEN '07'.
*        MOVE <lv_datnn> TO gv_date_07.   "Last Day Worked
*      WHEN '08'.
*        MOVE <lv_datnn> TO gv_date_08.   "Last Day Paid
*      WHEN '09'.
*        MOVE <lv_datnn> TO gv_date_09.   "Rehire Date
*      WHEN '11'.
*        MOVE <lv_datnn> TO gv_date_11.   "Tax ID Expiry Date
*      WHEN '12'.
*        MOVE <lv_datnn> TO gv_date_12.   "Seniority Date
*      WHEN OTHERS.
*    ENDCASE.
*
*  ENDDO.
*
*ENDFORM.                    " GET_DATES
**&---------------------------------------------------------------------*
**&      Form  GET_COMP_DETAILS
**&---------------------------------------------------------------------*
**       Get compensation details
**----------------------------------------------------------------------*
*FORM get_comp_details .
*
*  FIELD-SYMBOLS: <lv_persg>,
*                 <lv_persk>,
*                 <lv_trfgb>,
*                 <lv_trfar>.
*
*  CLEAR: gv_abart,
*         gv_trfkz,
*         gv_zeinh.
*
*  ASSIGN COMPONENT 'PERSG' OF STRUCTURE <gs_p0001> TO <lv_persg>.
*  ASSIGN COMPONENT 'PERSK' OF STRUCTURE <gs_p0001> TO <lv_persk>.
*  ASSIGN COMPONENT 'TRFGB' OF STRUCTURE <gs_p0008> TO <lv_trfgb>.
*  ASSIGN COMPONENT 'TRFAR' OF STRUCTURE <gs_p0008> TO <lv_trfar>.
*
*  SELECT SINGLE abart trfkz FROM t503 INTO (gv_abart, gv_trfkz)
*    WHERE persg EQ <lv_persg>
*      AND persk EQ <lv_persk>.
*
*  CALL FUNCTION 'RP_ZEINH_GET'
*    EXPORTING
*      p_molga        = '07'
*      p_trfgb        = <lv_trfgb>
*      p_trfar        = <lv_trfar>
*      p_trfkz        = gv_trfkz
*      p_date         = gv_frbeg
*    IMPORTING
*      p_zeinh        = gv_zeinh
*    EXCEPTIONS
*      no_entry_t549r = 1
*      illegal_zeinh  = 2
*      OTHERS         = 3.
*
*ENDFORM.                    " GET_COMP_DETAILS
**&---------------------------------------------------------------------*
**&      Form  GET_BANK_DETAILS
**&---------------------------------------------------------------------*
**       Get bank details
**----------------------------------------------------------------------*
*FORM get_bank_details .
*
*  FIELD-SYMBOLS: <lv_subty>, <lv_begda>, <lv_bankl>, <lv_bankn>, <lv_zlsch>, <lv_betrg>.
*
*  CLEAR gs_bank.
*
*  CHECK <gt_p0009> IS NOT INITIAL.
*
*  LOOP AT <gt_p0009> ASSIGNING <gs_p0009>.
*    ASSIGN COMPONENT 'SUBTY' OF STRUCTURE <gs_p0009> TO <lv_subty>.
*    IF <lv_subty> EQ '0'.
*      ASSIGN COMPONENT 'BEGDA' OF STRUCTURE <gs_p0009> TO <lv_begda>.
*      ASSIGN COMPONENT 'BANKL' OF STRUCTURE <gs_p0009> TO <lv_bankl>.
*      ASSIGN COMPONENT 'BANKN' OF STRUCTURE <gs_p0009> TO <lv_bankn>.
*      ASSIGN COMPONENT 'ZLSCH' OF STRUCTURE <gs_p0009> TO <lv_zlsch>.
*      IF <lv_zlsch> EQ 'C'.
*        MOVE '' TO gs_bank-method_of_payment.
*        EXIT.
*      ELSE.
*        MOVE 'D' TO gs_bank-method_of_payment.
*      ENDIF.
*      MOVE <lv_bankl> TO gs_bank-bank_key.
*      MOVE <lv_bankn> TO gs_bank-bank_account_number.
*      EXIT.
*    ENDIF.
*  ENDLOOP.
*
*  IF sy-subrc NE 0.
*    MOVE '' TO gs_bank-method_of_payment.
*  ENDIF.
*
**  LOOP AT <gt_p0009> ASSIGNING <gs_p0009>.
**    ASSIGN COMPONENT 'SUBTY' OF STRUCTURE <gs_p0009> TO <lv_subty>.
**    IF <lv_subty> EQ '1'.
**      ASSIGN COMPONENT 'BEGDA' OF STRUCTURE <gs_p0009> TO <lv_begda>.
**      ASSIGN COMPONENT 'BANKL' OF STRUCTURE <gs_p0009> TO <lv_bankl>.
**      ASSIGN COMPONENT 'BANKN' OF STRUCTURE <gs_p0009> TO <lv_bankn>.
**      ASSIGN COMPONENT 'BETRG' OF STRUCTURE <gs_p0009> TO <lv_betrg>.
**      MOVE <lv_begda> TO gs_bank-effective_date_s.
**      MOVE <lv_bankl>+1(3) TO gs_bank-secondary_bank.
**      MOVE <lv_bankl>+4(5) TO gs_bank-secondary_branch.
**      MOVE <lv_bankn> TO gs_bank-second_accnt_no.
**      MOVE <lv_betrg> TO gs_bank-second_dep_amnt.
**      SHIFT gs_bank-second_dep_amnt LEFT DELETING LEADING space.
**      EXIT.
**    ENDIF.
**  ENDLOOP.
*
*ENDFORM.                    " GET_BANK_DETAILS
*&---------------------------------------------------------------------*
*&      Form  GET_AD_TM_DATA
*&---------------------------------------------------------------------*
*       Get data based on field symbols and parameters
*----------------------------------------------------------------------*
*       -->FV_ALL   If '1', then process all fields
*                   Else process only the fields that need to be
*                   compared for changes
*----------------------------------------------------------------------*
FORM get_ad_tm_data USING fv_all.

  FIELD-SYMBOLS: <lv_return>.

  CLEAR <gs_employee_data>.

  LOOP AT go_structdescr_ed->components INTO gs_component.
    ASSIGN COMPONENT gs_component-name OF STRUCTURE <gs_employee_data> TO <lv_return>.
    PERFORM (gs_component-name) IN PROGRAM zhro_ad_tm_update IF FOUND USING <lv_return>.
    IF fv_all EQ gc_all.
      CONCATENATE '_' gs_component-name INTO gs_component-name.
      PERFORM (gs_component-name) IN PROGRAM zhro_ad_tm_update IF FOUND USING <lv_return>.
    ENDIF.
  ENDLOOP.

ENDFORM.                    " GET_AD_TM_DATA
*&---------------------------------------------------------------------*
*&      Form  CHECK_FOR_CHANGES
*&---------------------------------------------------------------------*
*       Check for changes
*----------------------------------------------------------------------*
FORM check_for_changes .

*  PERFORM check_for_new_action.
  PERFORM check_for_field_changes.

ENDFORM.                    " CHECK_FOR_CHANGES
**&---------------------------------------------------------------------*
**&      Form  CHECK_FOR_NEW_ACTION
**&---------------------------------------------------------------------*
**       Check if there are any new personnel actions
**----------------------------------------------------------------------*
*FORM check_for_new_action .
*
*  IF gs_old_p0000-begda NE gs_new_p0000-begda. "New action
*    MOVE '1' TO gs_export_flags-ed_export.
*  ENDIF.
*
*ENDFORM.                    " CHECK_FOR_NEW_ACTION
*&---------------------------------------------------------------------*
*&      Form  CHECK_FOR_FIELD_CHANGES
*&---------------------------------------------------------------------*
*       Check if any field value has changed.
*----------------------------------------------------------------------*
FORM check_for_field_changes .

  DATA: lv_sname TYPE c LENGTH 30. "Subroutine name

  FIELD-SYMBOLS: <lv_old>, <lv_new>.

  LOOP AT go_structdescr_ed->components INTO gs_component.
    ASSIGN COMPONENT gs_component-name OF STRUCTURE gs_old_employee_data TO <lv_old>.
    ASSIGN COMPONENT gs_component-name OF STRUCTURE gs_new_employee_data TO <lv_new>.
    IF <lv_new> NE <lv_old>.
      MOVE '1' TO gs_export_flags-ed_export.
*      CONCATENATE gs_component-name '_EFF_DATE' INTO lv_sname.
*     Get the effective date, if we don't have one yet
*      IF gv_effective_date IS INITIAL.
*        PERFORM (lv_sname) IN PROGRAM zhro_adp_nomitek_mx IF FOUND CHANGING gv_effective_date.
*      ENDIF.
*      CONCATENATE gs_component-name '_CB' INTO lv_sname.
*     Set the change block for export
*      PERFORM (lv_sname) IN PROGRAM zhro_adpid_crm IF FOUND.
    ENDIF.
  ENDLOOP.

ENDFORM.                    " CHECK_FOR_FIELD_CHANGES
*&---------------------------------------------------------------------*
*&      Form  FILL_AD_TM_RECORDS
*&---------------------------------------------------------------------*
*       Fill the AD Team Member records with data
*----------------------------------------------------------------------*
FORM fill_ad_tm_records .

  ASSIGN gs_employee_data TO <gs_employee_data>.

  CLEAR: gs_employee_data, gs_line_out.
  IF gs_export_flags-ed_export EQ '1'.
    PERFORM get_ad_tm_data USING gc_all.
    APPEND gs_employee_data TO gt_employee_data.
    PERFORM convert_to_csv CHANGING gs_line_out.
    APPEND gs_line_out TO gt_file_out.
    gv_number_of_records = gv_number_of_records + 1.
    gv_num_exported_pernr = gv_num_exported_pernr + 1.
  ENDIF.

ENDFORM.                    " FILL_AD_TM_RECORDS
*&---------------------------------------------------------------------*
*&      Form  WRITE_TO_FILE
*&---------------------------------------------------------------------*
*       Write records to the file
*----------------------------------------------------------------------*
FORM write_to_file .

  DATA: lv_lines TYPE i.

  DESCRIBE TABLE gt_file_out LINES lv_lines.
  CHECK lv_lines GT 0.

  IF p_pc EQ 'X'.
    PERFORM create_file_on_pc USING p_pfile gt_file_out.
  ELSEIF p_srv EQ 'X'.
    PERFORM create_file_on_srv USING p_sfile p_backup gt_file_out.
  ENDIF.

ENDFORM.                    " WRITE_TO_FILE
*&---------------------------------------------------------------------*
*&      Form  VALIDATE_EMPLOYEE
*&---------------------------------------------------------------------*
*       Employee Validation
*----------------------------------------------------------------------*
FORM validate_employee .

*  IF gt_new_p0185[] IS INITIAL.
**   skip employees that have ADP IDs only in the future.
*    REJECT.
*  ENDIF.

  PERFORM get_data_to_validate.
* PERFORM check_error_e002.
*  PERFORM check_error_e003.
*  PERFORM check_error_e004.
  PERFORM check_error_e005.
*  PERFORM check_error_e008.
*  PERFORM check_error_e011.
*  PERFORM check_error_e013.
*  PERFORM check_error_e014.
*  PERFORM check_error_e015.
*  PERFORM check_error_e016.
*  PERFORM check_error_e017.
*  PERFORM check_error_e018.
*  PERFORM check_error_e019.
*  PERFORM check_error_e020.
*  PERFORM check_error_e021.
*  PERFORM check_error_e022.
*  PERFORM check_error_e023.
*  PERFORM check_error_e024.
*  PERFORM check_error_e025.
*  PERFORM check_error_e026.
*  PERFORM check_error_e027.
*
*  PERFORM check_error_w005.
*  PERFORM check_error_w013.

  PERFORM clear_globals.

ENDFORM.                    " VALIDATE_EMPLOYEE
**&---------------------------------------------------------------------*
**&      Form  ACTION_BASED_VALIDATION
**&---------------------------------------------------------------------*
**       This is to add any extra logic that is based on Actions.
**       For example, only send addresses and bank details on Hires
**       and Re-Hires.
**----------------------------------------------------------------------*
*FORM action_based_validation .
*
*  CHECK gs_old_p0000-begda NE gs_new_p0000-begda. "New action
*
*  CASE gs_new_p0000-massn.
*    WHEN 'T0' OR 'T5' .
*      MOVE 'X' TO :
*        gs_change_blocks-cb_1,
*        gs_change_blocks-cb_2,
*        gs_change_blocks-cb_3,
*        gs_change_blocks-cb_4,
*        gs_change_blocks-cb_5,
*        gs_change_blocks-cb_6,
*        gs_change_blocks-cb_7,
*        gs_change_blocks-cb_8,
*        gs_change_blocks-cb_9,
*        gs_change_blocks-cb_10,
*        gs_change_blocks-cb_11,
*        gs_change_blocks-cb_12,
*        gs_change_blocks-cb_13,
*        gs_change_blocks-cb_14,
*        gs_change_blocks-cb_15,
*        gs_change_blocks-cb_16,
*        gs_change_blocks-cb_17,
*        gs_change_blocks-cb_18,
*        gs_change_blocks-cb_19,
*        gs_change_blocks-cb_21,
*        gs_change_blocks-cb_35,
*        gs_change_blocks-cb_37,
*        gs_change_blocks-cb_39,
*        gs_change_blocks-cb_40,
*        gs_change_blocks-cb_42.
*    WHEN 'T4'.
*      MOVE 'X' TO gs_change_blocks-cb_41.
*    WHEN OTHERS.
*
*  ENDCASE.
*
*ENDFORM.                    " ACTION_BASED_VALIDATION
*&---------------------------------------------------------------------*
*&      Form  DATA_COLLECTION
*&---------------------------------------------------------------------*
*       Data Collectin Routine
*----------------------------------------------------------------------*
FORM data_collection .

  PERFORM init_globals.
  PERFORM get_old_data.
  PERFORM get_current_period CHANGING gv_frper gv_frbeg gv_frend.
  PERFORM get_new_data.

ENDFORM.                    " DATA_COLLECTION
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E002
**&---------------------------------------------------------------------*
*FORM check_error_e002 .
*
*  IF gs_new_p0369-nimss IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E002'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E002
*&---------------------------------------------------------------------*
*&      Form  CHECK_ERROR_E003
*&---------------------------------------------------------------------*
FORM check_error_e003 .

*  IF gs_new_p0185-icnum IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E003'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.

ENDFORM.                    " CHECK_ERROR_E003
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E004
**&---------------------------------------------------------------------*
*FORM check_error_e004 .
*
*  LOOP AT gt_new_p0185 INTO gs_new_p0185
*    WHERE ictyp EQ gc_adp_id.
*    EXIT.
*  ENDLOOP.
*
*  LOOP AT gt_old_p0185 INTO gs_old_p0185
*    WHERE ictyp EQ gc_adp_id.
*    EXIT.
*  ENDLOOP.
*
*  IF gs_new_p0185-icnum NE gs_old_p0185-icnum.
*    PERFORM error
*                USING
*                   'E'
*                   'E004'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E004
*&---------------------------------------------------------------------*
*&      Form  CHECK_ERROR_E005
*&---------------------------------------------------------------------*
FORM check_error_e005 .

  LOOP AT gt_new_p0105 INTO gs_new_p0105
    WHERE usrty EQ gc_network_id.
    EXIT.
  ENDLOOP.

  IF gs_new_p0105-usrid IS INITIAL.
    PERFORM error
                USING
                   'E'
                   'E005'
                   space
                   space
                   space
                   space.
  ENDIF.

ENDFORM.                    " CHECK_ERROR_E005
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E008
**&---------------------------------------------------------------------*
*FORM check_error_e008 .
*
*  IF gs_new_p0008 IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E008'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E008
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E011
**&---------------------------------------------------------------------*
*FORM check_error_e011 .
*
*  DATA: lv_darnn    TYPE c LENGTH 5 VALUE 'DARNN',
*        lv_datnn    TYPE c LENGTH 5 VALUE 'DATNN',
*        lv_num      TYPE n LENGTH 2,
*        lv_date_07  TYPE dardt,       "Last Day Worked
*        lv_date_08  TYPE dardt.       "Last Day Paid
*
*  FIELD-SYMBOLS: <lv_darnn> TYPE data,
*                 <lv_datnn> TYPE data.
*
*
*  DO 12 TIMES.
*    lv_num = lv_num + 1.
*    lv_darnn+3(2) = lv_num.
*    lv_datnn+3(2) = lv_num.
*
*    ASSIGN COMPONENT lv_darnn OF STRUCTURE gs_new_p0041 TO <lv_darnn>.
*    ASSIGN COMPONENT lv_datnn OF STRUCTURE gs_new_p0041 TO <lv_datnn>.
*
*    CASE <lv_darnn>.
*      WHEN '07'.
*        MOVE <lv_datnn> TO lv_date_07.   "Last Day Worked
*      WHEN OTHERS.
*    ENDCASE.
*
*  ENDDO.
*
*  CASE gs_new_p0000-massn.
*    WHEN  'S6'.  "Termination
*      IF lv_date_07 IS INITIAL.
*        PERFORM error
*                    USING
*                       'E'
*                       'E011'
*                       space
*                       space
*                       space
*                       space.
*      ENDIF.
*    WHEN OTHERS.
*  ENDCASE.
*
*ENDFORM.                    " CHECK_ERROR_E011
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E013
**&---------------------------------------------------------------------*
*FORM check_error_e013 .
*
*  LOOP AT gt_new_p0185 INTO gs_new_p0185
*    WHERE ictyp EQ gc_rfc_num.
*    EXIT.
*  ENDLOOP.
*
*  IF gs_new_p0185-icnum IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E013'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E013
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E014
**&---------------------------------------------------------------------*
*FORM check_error_e014 .
*
*  DATA: lv_darnn    TYPE c LENGTH 5 VALUE 'DARNN',
*        lv_datnn    TYPE c LENGTH 5 VALUE 'DATNN',
*        lv_num      TYPE n LENGTH 2,
*        lv_date_06  TYPE dardt.       "Adjusted Service Date
*
*  FIELD-SYMBOLS: <lv_darnn> TYPE data,
*                 <lv_datnn> TYPE data.
*
*  DO 12 TIMES.
*
*    lv_num = lv_num + 1.
*    lv_darnn+3(2) = lv_num.
*    lv_datnn+3(2) = lv_num.
*
*    ASSIGN COMPONENT lv_darnn OF STRUCTURE gs_new_p0041 TO <lv_darnn>.
*    ASSIGN COMPONENT lv_datnn OF STRUCTURE gs_new_p0041 TO <lv_datnn>.
*
*    CASE <lv_darnn>.
*      WHEN '06'.
*        MOVE <lv_datnn> TO lv_date_06.   "Adjusted Service Date
*      WHEN OTHERS.
*    ENDCASE.
*
*  ENDDO.
*
*  IF lv_date_06 IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E014'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E014
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E015
**&---------------------------------------------------------------------*
*FORM check_error_e015 .
*
*  IF  gs_new_p0002-gbdat IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E015'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E015
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E016
**&---------------------------------------------------------------------*
*FORM check_error_e016 .
*
*  IF gs_new_p0002-famst IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E016'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E016
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E017
**&---------------------------------------------------------------------*
*FORM check_error_e017 .
*
*  IF gs_new_p0002-gesch IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E017'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E017
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E018
**&---------------------------------------------------------------------*
*FORM check_error_e018 .
*
*  IF gs_new_p0001-yywork_location IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E018'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E018
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E019
**&---------------------------------------------------------------------*
*FORM check_error_e019 .
*
*
*  CASE gs_new_p0000-massn.
*    WHEN 'S1' OR                "New Hire
*         'S7'.                  "Rehire
*      IF gt_new_p0009[] IS INITIAL.
*        PERFORM error
*                    USING
*                       'E'
*                       'E019'
*                       space
*                       space
*                       space
*                       space.
*      ENDIF.
*  ENDCASE.
*
*ENDFORM.                    " CHECK_ERROR_E019
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E020
**&---------------------------------------------------------------------*
*FORM check_error_e020 .
*
*  IF gt_new_p0002 IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E020'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E020
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E021
**&---------------------------------------------------------------------*
*FORM check_error_e021 .
*
*  DATA: fv_return LIKE gs_employee_data-contract_type.
*
*  PERFORM mapping_contract_type USING gs_new_p0001-persg CHANGING fv_return.
*
*  IF fv_return IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E021'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E021
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E022
**&---------------------------------------------------------------------*
*FORM check_error_e022 .
*
*  DATA: fv_return LIKE gs_employee_data-nomitek_cocode.
*
*  PERFORM mapping_cocode USING gs_new_p0001-bukrs CHANGING fv_return.
*
*  IF fv_return IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E022'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E022
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E023
**&---------------------------------------------------------------------*
*FORM check_error_e023 .
*
*  DATA: fv_return LIKE gs_employee_data-payroll_area.
*
*  PERFORM mapping_abkrs USING gs_new_p0001-abkrs CHANGING fv_return.
*
*  IF fv_return IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E023'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E023
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E024
**&---------------------------------------------------------------------*
*FORM check_error_e024 .
*
*  DATA: ls_p0009 LIKE LINE OF gt_new_p0009.
*
*  CASE gs_new_p0000-massn.
*    WHEN 'S1' OR                "New Hire
*         'S7'.                  "Rehire
*
*      LOOP AT gt_new_p0009 INTO ls_p0009
*        WHERE subty EQ 0.
*        EXIT.
*      ENDLOOP.
*      IF ls_p0009-zlsch NE 'Z'.
*        PERFORM error
*                    USING
*                       'E'
*                       'E024'
*                       space
*                       space
*                       space
*                       space.
*      ENDIF.
*
*  ENDCASE.
*
*ENDFORM.                    " CHECK_ERROR_E024
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E025
**&---------------------------------------------------------------------*
*FORM check_error_e025 .
*
*  CLEAR gs_new_p0033.
*  READ TABLE gt_new_p0033 INTO gs_new_p0033 WITH KEY subty = '9013'.
*
*
*  IF  gs_new_p0033-aus02 IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E025'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E025
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E026
**&---------------------------------------------------------------------*
*FORM check_error_e026 .
*
*  IF  gs_new_p9001 IS INITIAL OR gt_new_p9001[] IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E026'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E026
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_E027
**&---------------------------------------------------------------------*
*FORM check_error_e027 .
*
*  CLEAR gs_new_p0033.
*  READ TABLE gt_new_p0033 INTO gs_new_p0033 WITH KEY subty = '9013'.
*
*  IF gs_new_p0033-aus02 IS INITIAL.
*    PERFORM error
*                USING
*                   'E'
*                   'E027'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_E027
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_W001
**&---------------------------------------------------------------------*
*FORM check_error_w001 .
*
*  DATA: lv_darnn    TYPE c LENGTH 5 VALUE 'DARNN',
*        lv_datnn    TYPE c LENGTH 5 VALUE 'DATNN',
*        lv_num      TYPE n LENGTH 2,
*        lv_date_06  TYPE dardt.       "Adjusted Service Date
*
*  FIELD-SYMBOLS: <lv_darnn> TYPE data,
*                 <lv_datnn> TYPE data.
*
*  DO 12 TIMES.
*
*    lv_num = lv_num + 1.
*    lv_darnn+3(2) = lv_num.
*    lv_datnn+3(2) = lv_num.
*
*    ASSIGN COMPONENT lv_darnn OF STRUCTURE gs_new_p0041 TO <lv_darnn>.
*    ASSIGN COMPONENT lv_datnn OF STRUCTURE gs_new_p0041 TO <lv_datnn>.
*
*    CASE <lv_darnn>.
*      WHEN '06'.
*        MOVE <lv_datnn> TO lv_date_06.   "Adjusted Service Date
*      WHEN OTHERS.
*    ENDCASE.
*
*  ENDDO.
*
*  IF lv_date_06 IS INITIAL.
*    PERFORM error
*                USING
*                   'W'
*                   'W001'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_W001
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_W002
**&---------------------------------------------------------------------*
*FORM check_error_w002 .
*
*  IF gs_new_p0002-famst IS INITIAL.
*    PERFORM error
*                USING
*                   'W'
*                   'W002'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_W002
*&---------------------------------------------------------------------*
*&      Form  GET_DATA_TO_VALIDATE
*&---------------------------------------------------------------------*
FORM get_data_to_validate .

  SORT gt_new_p0105 BY endda DESCENDING.

ENDFORM.                    " GET_DATA_TO_VALIDATE
*&---------------------------------------------------------------------*
*&      Form  CLEAR_GLOBALS
*&---------------------------------------------------------------------*
FORM clear_globals .

  CLEAR: gs_new_p0000,
         gs_new_p0001,
         gs_new_p0002,
         gs_new_p0105.

ENDFORM.                    " CLEAR_GLOBALS
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_W003
**&---------------------------------------------------------------------*
*FORM check_error_w003 .
*
*  IF gs_new_p0002-sprsl IS INITIAL.
*    PERFORM error
*                USING
*                   'W'
*                   'W003'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_W003
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_W004
**&---------------------------------------------------------------------*
*FORM check_error_w004 .
*
*  IF gs_new_p0002-gesch IS INITIAL.
*    PERFORM error
*                USING
*                   'W'
*                   'W004'
*                   space
*                   space
*                   space
*                   space.
*  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_W004
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_W005
**&---------------------------------------------------------------------*
*FORM check_error_w005 .
*
*  CASE gs_new_p0000-massn.
*    WHEN 'S1' OR                "New Hire
*         'S7'.                  "Rehire
*      IF gt_new_p0006[] IS INITIAL.
*        PERFORM error
*                    USING
*                       'W'
*                       'W005'
*                       space
*                       space
*                       space
*                       space.
*      ENDIF.
*
*  ENDCASE.
*
*ENDFORM.                    " CHECK_ERROR_W005
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_W006
**&---------------------------------------------------------------------*
*FORM check_error_w006 .
*
**  IF gs_new_p0105-usrid_long IS INITIAL.
**    PERFORM error
**                USING
**                   'W'
**                   'W006'
**                   space
**                   space
**                   space
**                   space.
**  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_W006
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_W007
**&---------------------------------------------------------------------*
*FORM check_error_w007 .
*
*  CASE gs_new_p0000-massn.
*    WHEN '7A' OR                "New Hire
*         '7G'.                  "Rehire
*      IF gt_new_p0009[] IS INITIAL.
*        PERFORM error
*                    USING
*                       'W'
*                       'W007'
*                       space
*                       space
*                       space
*                       space.
*      ENDIF.
*  ENDCASE.
*
*ENDFORM.                    " CHECK_ERROR_W007
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_W008
**&---------------------------------------------------------------------*
*FORM check_error_w008 .
*
**  IF gs_new_p0461 IS INITIAL.
**    PERFORM error
**                USING
**                   'W'
**                   'W008'
**                   space
**                   space
**                   space
**                   space.
**  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_W008
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_W009
**&---------------------------------------------------------------------*
*FORM check_error_w009 .
*
**  IF gs_new_p0462 IS INITIAL.
**    PERFORM error
**                USING
**                   'W'
**                   'W009'
**                   space
**                   space
**                   space
**                   space.
**  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_W009
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_W010
**&---------------------------------------------------------------------*
*FORM check_error_w010 .
*
**  IF gs_new_p0463 IS INITIAL.
**    PERFORM error
**                USING
**                   'W'
**                   'W010'
**                   space
**                   space
**                   space
**                   space.
**  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_W010
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_W011
**&---------------------------------------------------------------------*
*FORM check_error_w011 .
*
**  IF gs_new_p0464 IS INITIAL.
**    PERFORM error
**                USING
**                   'W'
**                   'W011'
**                   space
**                   space
**                   space
**                   space.
**  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_W011
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_W012
**&---------------------------------------------------------------------*
*FORM check_error_w012 .
*
**  IF gs_new_p0033 IS INITIAL.
**    PERFORM error
**                USING
**                   'W'
**                   'W012'
**                   space
**                   space
**                   space
**                   space.
**  ENDIF.
*
*ENDFORM.                    " CHECK_ERROR_W012
**&---------------------------------------------------------------------*
**&      Form  CHECK_ERROR_W013
**&---------------------------------------------------------------------*
*FORM check_error_w013 .
*
*  DATA: lv_darnn    TYPE c LENGTH 5 VALUE 'DARNN',
*        lv_datnn    TYPE c LENGTH 5 VALUE 'DATNN',
*        lv_num      TYPE n LENGTH 2,
*        lv_date_01  TYPE dardt.       "Original hire date
*
*  FIELD-SYMBOLS: <lv_darnn> TYPE data,
*                 <lv_datnn> TYPE data.
*
*
*  DO 12 TIMES.
*    lv_num = lv_num + 1.
*    lv_darnn+3(2) = lv_num.
*    lv_datnn+3(2) = lv_num.
*
*    ASSIGN COMPONENT lv_darnn OF STRUCTURE gs_new_p0041 TO <lv_darnn>.
*    ASSIGN COMPONENT lv_datnn OF STRUCTURE gs_new_p0041 TO <lv_datnn>.
*
*    CASE <lv_darnn>.
*      WHEN '01'.
*        MOVE <lv_datnn> TO lv_date_01.   "Original hire date
*      WHEN OTHERS.
*    ENDCASE.
*
*  ENDDO.
*
*  CASE gs_new_p0000-massn.
*    WHEN  'S1'  OR "Hire
*          'S7'.    "Rehire
*      IF lv_date_01 IS INITIAL.
*        PERFORM error
*                    USING
*                       'W'
*                       'W013'
*                       space
*                       space
*                       space
*                       space.
*      ENDIF.
*    WHEN OTHERS.
*  ENDCASE.
*
*ENDFORM.                    " CHECK_ERROR_W013
