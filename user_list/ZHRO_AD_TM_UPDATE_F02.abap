*&---------------------------------------------------------------------*
*&  Include           ZHRO_AD_TM_UPDATE_F02
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*&      Form  USRID1
*&---------------------------------------------------------------------*
*       NetworkID
*----------------------------------------------------------------------*
*      -->FV_RETURN  NetworkID
*----------------------------------------------------------------------*
FORM usrid1   USING fv_return.

  FIELD-SYMBOLS: <lv_usrid>, <lv_usrty>.

  LOOP AT <gt_p0105> ASSIGNING <gs_p0105>.
    ASSIGN COMPONENT 'USRTY' OF STRUCTURE <gs_p0105> TO <lv_usrty>.
    IF <lv_usrty> EQ gc_network_id.
      ASSIGN COMPONENT 'USRID' OF STRUCTURE <gs_p0105> TO <lv_usrid>.
      EXIT.
    ENDIF.
  ENDLOOP.
  IF sy-subrc EQ 0.
    MOVE <lv_usrid> TO fv_return.
  ENDIF.

ENDFORM.                    "USRID1
*&---------------------------------------------------------------------*
*&      Form  VORNA1
*&---------------------------------------------------------------------*
*       Stericorp User List_First name
*----------------------------------------------------------------------*
*      -->FV_RETURN  Stericorp User List_First name
*----------------------------------------------------------------------*
FORM _vorna1   USING fv_return.

  FIELD-SYMBOLS: <lv_vorna>.

  ASSIGN COMPONENT 'VORNA' OF STRUCTURE <gs_p0002> TO <lv_vorna>.

  MOVE <lv_vorna> TO fv_return.

ENDFORM.                    "VORNA1
*&---------------------------------------------------------------------*
*&      Form  NACHN1
*&---------------------------------------------------------------------*
*       Stericorp User List_Last name
*----------------------------------------------------------------------*
*      -->FV_RETURN  Stericorp User List_Last name
*----------------------------------------------------------------------*
FORM _nachn1   USING fv_return.

  FIELD-SYMBOLS: <lv_nachn>.

  ASSIGN COMPONENT 'NACHN' OF STRUCTURE <gs_p0002> TO <lv_nachn>.

  MOVE <lv_nachn> TO fv_return.

ENDFORM.                    "NACHN1
*&---------------------------------------------------------------------*
*&      Form  EMAIL1
*&---------------------------------------------------------------------*
*       Stericorp User List_Email
*----------------------------------------------------------------------*
*      -->FV_RETURN  Stericorp User List_Email
*----------------------------------------------------------------------*
FORM _email1   USING fv_return.

  DATA: lv_email TYPE string.

  FIELD-SYMBOLS: <lv_usrid_long>, <lv_usrty>.

  CLEAR <gs_p0105>.
  LOOP AT <gt_p0105> ASSIGNING <gs_p0105>.
    ASSIGN COMPONENT 'USRTY' OF STRUCTURE <gs_p0105> TO <lv_usrty>.
    IF <lv_usrty> EQ gc_email_addr.
      ASSIGN COMPONENT 'USRID_LONG' OF STRUCTURE <gs_p0105> TO <lv_usrid_long>.
      EXIT.
    ENDIF.
  ENDLOOP.
  IF sy-subrc EQ 0.
    MOVE <lv_usrid_long> TO fv_return.
    lv_email = fv_return.
    FIND 'no email' IN lv_email IGNORING CASE.
    IF sy-subrc EQ 0.
      CLEAR fv_return.
    ENDIF.

    IF fv_return EQ '0'.
      CLEAR fv_return.
    ENDIF.
  ENDIF.

ENDFORM.                    "EMAIL1
*&---------------------------------------------------------------------*
*&      Form  PERNR
*&---------------------------------------------------------------------*
*       SAP_ID
*----------------------------------------------------------------------*
*      -->FV_RETURN  SAP_ID
*----------------------------------------------------------------------*
FORM _pernr    USING fv_return.

  FIELD-SYMBOLS: <lv_pernr>.

  ASSIGN COMPONENT 'PERNR' OF STRUCTURE <gs_p0000> TO <lv_pernr>.

  MOVE <lv_pernr> TO fv_return.
  SHIFT fv_return LEFT DELETING LEADING '0'.

ENDFORM.                    "PERNR
*&---------------------------------------------------------------------*
*&      Form  NACHN2
*&---------------------------------------------------------------------*
*       SAP_Last name
*----------------------------------------------------------------------*
*      -->FV_RETURN  SAP_Last name
*----------------------------------------------------------------------*
FORM _nachn2   USING fv_return.

  FIELD-SYMBOLS: <lv_nachn>.

  ASSIGN COMPONENT 'NACHN' OF STRUCTURE <gs_p0002> TO <lv_nachn>.

  MOVE <lv_nachn> TO fv_return.

ENDFORM.                    "NACHN2
*&---------------------------------------------------------------------*
*&      Form  VORNA2
*&---------------------------------------------------------------------*
*       SAP_First name
*----------------------------------------------------------------------*
*      -->FV_RETURN  SAP_First name
*----------------------------------------------------------------------*
FORM _vorna2   USING fv_return.

  FIELD-SYMBOLS: <lv_vorna>.

  ASSIGN COMPONENT 'VORNA' OF STRUCTURE <gs_p0002> TO <lv_vorna>.

  MOVE <lv_vorna> TO fv_return.

ENDFORM.                    "VORNA2
*&---------------------------------------------------------------------*
*&      Form  STAT2
*&---------------------------------------------------------------------*
*       SAP_Employment Status
*----------------------------------------------------------------------*
*      -->FV_RETURN  SAP_Employment Status
*----------------------------------------------------------------------*
FORM _stat2    USING fv_return.

  FIELD-SYMBOLS: <lv_stat2>.

  ASSIGN COMPONENT 'STAT2' OF STRUCTURE <gs_p0000> TO <lv_stat2>.
  PERFORM mapping_status USING <lv_stat2> CHANGING fv_return.

ENDFORM.                    "STAT2
*&---------------------------------------------------------------------*
*&      Form  EMAIL2
*&---------------------------------------------------------------------*
*       SAP_Email
*----------------------------------------------------------------------*
*      -->FV_RETURN  SAP_Email
*----------------------------------------------------------------------*
FORM _email2   USING fv_return.

  FIELD-SYMBOLS: <lv_usrid_long>, <lv_usrty>.
  DATA: lv_email TYPE string.

*  CLEAR <gs_p0105>.
  LOOP AT <gt_p0105> ASSIGNING <gs_p0105>.
    ASSIGN COMPONENT 'USRTY' OF STRUCTURE <gs_p0105> TO <lv_usrty>.
    IF <lv_usrty> EQ gc_email_addr.
      ASSIGN COMPONENT 'USRID_LONG' OF STRUCTURE <gs_p0105> TO <lv_usrid_long>.
      EXIT.
    ENDIF.
  ENDLOOP.
  IF sy-subrc EQ 0.
    MOVE <lv_usrid_long> TO fv_return.
    lv_email = fv_return.
    FIND 'no email' IN lv_email IGNORING CASE.
    IF sy-subrc EQ 0.
      CLEAR fv_return.
    ENDIF.

    IF fv_return EQ '0'.
      CLEAR fv_return.
    ENDIF.
  ENDIF.

ENDFORM.                    "EMAIL2
*&---------------------------------------------------------------------*
*&      Form  LOCAT
*&---------------------------------------------------------------------*
*       Work Location
*----------------------------------------------------------------------*
*      -->FV_RETURN  Work Location
*----------------------------------------------------------------------*
FORM locat    USING fv_return.

  FIELD-SYMBOLS: <lv_yywork_location>.

  ASSIGN COMPONENT 'YYWORK_LOCATION' OF STRUCTURE <gs_p0001> TO <lv_yywork_location>.
  PERFORM mapping_location USING <lv_yywork_location> CHANGING fv_return.

ENDFORM.                    "LOCAT
*&---------------------------------------------------------------------*
*&      Form  PLANS
*&---------------------------------------------------------------------*
*       Job Title
*----------------------------------------------------------------------*
*      -->FV_RETURN  Job Title
*----------------------------------------------------------------------*
FORM plans    USING fv_return.

  FIELD-SYMBOLS: <lv_plans>.

  ASSIGN COMPONENT 'PLANS' OF STRUCTURE <gs_p0001> TO <lv_plans>.
  PERFORM mapping_job_title USING <lv_plans> CHANGING fv_return.

ENDFORM.                    "PLANS
*&---------------------------------------------------------------------*
*&      Form  USRID2
*&---------------------------------------------------------------------*
*       Manager_NetworkID
*----------------------------------------------------------------------*
*      -->FV_RETURN  Manager_NetworkID
*----------------------------------------------------------------------*
FORM usrid2   USING fv_return.

  FIELD-SYMBOLS: <lv_yysupervisor_id>.

  ASSIGN COMPONENT 'YYSUPERVISOR_ID' OF STRUCTURE <gs_p0001> TO <lv_yysupervisor_id>.
  PERFORM get_manager_networkid USING <lv_yysupervisor_id> CHANGING fv_return.

ENDFORM.                    "USRID2
*&---------------------------------------------------------------------*
*&      Form  REGION
*&---------------------------------------------------------------------*
*       Region
*----------------------------------------------------------------------*
*      -->FV_RETURN  Region
*----------------------------------------------------------------------*
FORM _region   USING fv_return.

  FIELD-SYMBOLS: <lv_bukrs>.

  ASSIGN COMPONENT 'BUKRS' OF STRUCTURE <gs_p0001> TO <lv_bukrs>.
  PERFORM get_region USING <lv_bukrs> CHANGING fv_return.

ENDFORM.                    "REGION
