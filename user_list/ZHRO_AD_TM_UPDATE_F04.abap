*&---------------------------------------------------------------------*
*&  Include           ZHRO_AD_TM_UPDATE_F04
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&      Form  MAPPING_STATUS
*&---------------------------------------------------------------------*
*       Employee status mapping
*----------------------------------------------------------------------*
*      -->FV_STAT2     SAP Employee Status
*      <--FV_RETURN    Employee Status
*----------------------------------------------------------------------*
FORM mapping_status  USING    fv_stat2
                     CHANGING fv_return.

  CASE fv_stat2.
    WHEN '3'.
      MOVE 'Active' TO fv_return.
    WHEN '1'.
      MOVE 'Inactive' TO fv_return.
    WHEN OTHERS.
  ENDCASE.

ENDFORM.                    " MAPPING_STATUS
*&---------------------------------------------------------------------*
*&      Form  MAPPING_LOCATION
*&---------------------------------------------------------------------*
*       Map work location code to text
*----------------------------------------------------------------------*
*      -->FV_LOCATION  Work location code
*      <--FV_RETURN    Work location text
*----------------------------------------------------------------------*
FORM mapping_location  USING    fv_location
                       CHANGING fv_return.

  SELECT SINGLE stext FROM t777a INTO fv_return
    WHERE build EQ fv_location.

ENDFORM.                    " MAPPING_LOCATION
*&---------------------------------------------------------------------*
*&      Form  MAPPING_JOB_TITLE
*&---------------------------------------------------------------------*
*       Map job title code to text
*----------------------------------------------------------------------*
*      -->FV_PLANS    Position number
*      <--FV_RETURN   Job Title
*----------------------------------------------------------------------*
FORM mapping_job_title  USING    fv_plans
                        CHANGING fv_return.

  SELECT stext FROM hrp1000 INTO fv_return
    WHERE plvar EQ '01'
      AND otype EQ 'S'
      AND objid EQ fv_plans
      AND istat EQ '1'
      AND begda LE gv_frend
      AND endda GE gv_frbeg
      AND langu EQ sy-langu
     ORDER BY endda DESCENDING.
    EXIT.
  ENDSELECT.

ENDFORM.                    " MAPPING_JOB_TITLE
*&---------------------------------------------------------------------*
*&      Form  GET_MANAGER_NETWORKID
*&---------------------------------------------------------------------*
*       Get manager's network id
*----------------------------------------------------------------------*
*      -->FV_YYSUPERVISOR_ID  Supervisor ID
*      <--FV_RETURN           Manager's network id
*----------------------------------------------------------------------*
FORM get_manager_networkid  USING    fv_yysupervisor_id
                            CHANGING fv_return.

  SELECT usrid FROM pa0105 INTO fv_return
    WHERE pernr EQ fv_yysupervisor_id
      AND subty EQ gc_network_id
      AND endda GE gv_frbeg
      AND begda LE gv_frend
      ORDER BY endda DESCENDING.
    EXIT.
  ENDSELECT.

ENDFORM.                    " GET_MANAGER_NETWORKID
*&---------------------------------------------------------------------*
*&      Form  GET_REGION
*&---------------------------------------------------------------------*
*       Get region
*----------------------------------------------------------------------*
*      -->FV_BUKRS     Company code
*      <--FV_RETURN    Region
*----------------------------------------------------------------------*
FORM get_region  USING    fv_bukrs
                 CHANGING fv_return.

  DATA lv_land1 LIKE t001-land1.

  SELECT SINGLE land1 FROM t001 INTO lv_land1
    WHERE bukrs EQ fv_bukrs.

  CASE lv_land1.
    WHEN 'CA' OR 'US' OR 'MX' OR 'AR' OR 'CL' OR 'BR'.
      MOVE 'NA' TO fv_return.
    WHEN OTHERS.
      MOVE 'EU' TO fv_return.
  ENDCASE.

ENDFORM.                    " GET_REGION
