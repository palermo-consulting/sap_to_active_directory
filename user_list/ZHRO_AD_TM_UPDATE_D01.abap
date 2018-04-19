*&---------------------------------------------------------------------*
*&  Include           ZHRO_AD_TM_UPDATE_D01
*&---------------------------------------------------------------------*


TABLES: pernr, zhr_pcl2, t569v, t549a, t549q, t000.

INFOTYPES:  0000,
            0001,
            0002,
            0105.

TYPES: BEGIN OF ts_if_results,
         seqnr(9) TYPE n,
         frper(6) TYPE n,
         frbeg    TYPE d,
         frend    TYPE d,
         rundt LIKE pc261-rundt,
         runtm LIKE pc261-runtm,
         abkrs LIKE pc261-abkrs,
       END OF ts_if_results,

       BEGIN OF ts_id_key,
         pernr LIKE pernr-pernr,
         fldid LIKE t532a-fldid,
       END OF ts_id_key,

       BEGIN OF ts_if_key,
         pernr LIKE pernr-pernr,
         seqnr(9) TYPE n,
         fldid LIKE t532a-fldid,
       END OF ts_if_key,

       BEGIN OF ts_if_version,
         cdate TYPE d,
         ctime TYPE t,
         cprog LIKE sy-repid,
         uname LIKE sy-uname,
       END OF ts_if_version.

TYPES: BEGIN OF ts_p0000,
        pernr(000008) TYPE n,
        infty(000004) TYPE c,
        subty(000004) TYPE c,
        objps(000002) TYPE c,
        sprps(000001) TYPE c,
        endda TYPE d,
        begda TYPE d,
        seqnr(000003) TYPE n,
        aedtm TYPE d,
        uname(000012) TYPE c,
        histo(000001) TYPE c,
        itxex(000001) TYPE c,
        refex(000001) TYPE c,
        ordex(000001) TYPE c,
        itbld(000002) TYPE c,
        preas(000002) TYPE c,
        flag1(000001) TYPE c,
        flag2(000001) TYPE c,
        flag3(000001) TYPE c,
        flag4(000001) TYPE c,
        rese1(000002) TYPE c,
        rese2(000002) TYPE c,
        grpvl(000004) TYPE c,
        massn(000002) TYPE c,
        massg(000002) TYPE c,
        stat1(000001) TYPE c,
        stat2(000001) TYPE c,
        stat3(000001) TYPE c,
      END OF ts_p0000.
TYPES: BEGIN OF ts_p0001,
        pernr(000008) TYPE n,
        infty(000004) TYPE c,
        subty(000004) TYPE c,
        objps(000002) TYPE c,
        sprps(000001) TYPE c,
        endda TYPE d,
        begda TYPE d,
        seqnr(000003) TYPE n,
        aedtm TYPE d,
        uname(000012) TYPE c,
        histo(000001) TYPE c,
        itxex(000001) TYPE c,
        refex(000001) TYPE c,
        ordex(000001) TYPE c,
        itbld(000002) TYPE c,
        preas(000002) TYPE c,
        flag1(000001) TYPE c,
        flag2(000001) TYPE c,
        flag3(000001) TYPE c,
        flag4(000001) TYPE c,
        rese1(000002) TYPE c,
        rese2(000002) TYPE c,
        grpvl(000004) TYPE c,
        bukrs(000004) TYPE c,
        werks(000004) TYPE c,
        persg(000001) TYPE c,
        persk(000002) TYPE c,
        vdsk1(000014) TYPE c,
        gsber(000004) TYPE c,
        btrtl(000004) TYPE c,
        juper(000004) TYPE c,
        abkrs(000002) TYPE c,
        ansvh(000002) TYPE c,
        kostl(000010) TYPE c,
        orgeh(000008) TYPE n,
        plans(000008) TYPE n,
        stell(000008) TYPE n,
        mstbr(000008) TYPE c,
        sacha(000003) TYPE c,
        sachp(000003) TYPE c,
        sachz(000003) TYPE c,
        sname(000030) TYPE c,
        ename(000040) TYPE c,
        otype(000002) TYPE c,
        sbmod(000004) TYPE c,
        kokrs(000004) TYPE c,
        fistl(000016) TYPE c,
        geber(000010) TYPE c,
        fkber(000016) TYPE c,
        grant_nbr(000020) TYPE c,
        sgmnt(000010) TYPE c,
        yysupervisor_id(000008) TYPE n,
        yymanager_flag(000001) TYPE c,
        yywork_location(000008) TYPE c,
      END OF ts_p0001.
TYPES: BEGIN OF ts_p0002,
        pernr(000008) TYPE n,
        infty(000004) TYPE c,
        subty(000004) TYPE c,
        objps(000002) TYPE c,
        sprps(000001) TYPE c,
        endda TYPE d,
        begda TYPE d,
        seqnr(000003) TYPE n,
        aedtm TYPE d,
        uname(000012) TYPE c,
        histo(000001) TYPE c,
        itxex(000001) TYPE c,
        refex(000001) TYPE c,
        ordex(000001) TYPE c,
        itbld(000002) TYPE c,
        preas(000002) TYPE c,
        flag1(000001) TYPE c,
        flag2(000001) TYPE c,
        flag3(000001) TYPE c,
        flag4(000001) TYPE c,
        rese1(000002) TYPE c,
        rese2(000002) TYPE c,
        grpvl(000004) TYPE c,
        inits(000010) TYPE c,
        nachn(000040) TYPE c,
        name2(000040) TYPE c,
        nach2(000040) TYPE c,
        vorna(000040) TYPE c,
        cname(000080) TYPE c,
        titel(000015) TYPE c,
        titl2(000015) TYPE c,
        namzu(000015) TYPE c,
        vorsw(000015) TYPE c,
        vors2(000015) TYPE c,
        rufnm(000040) TYPE c,
        midnm(000040) TYPE c,
        knznm(000002) TYPE n,
        anred(000001) TYPE c,
        gesch(000001) TYPE c,
        gbdat TYPE d,
        gblnd(000003) TYPE c,
        gbdep(000003) TYPE c,
        gbort(000040) TYPE c,
        natio(000003) TYPE c,
        nati2(000003) TYPE c,
        nati3(000003) TYPE c,
        sprsl(000001) TYPE c,
        konfe(000002) TYPE c,
        famst(000001) TYPE c,
        famdt TYPE d,
        anzkd(000002) TYPE p DECIMALS 000000,
        nacon(000001) TYPE c,
        permo(000002) TYPE c,
        perid(000020) TYPE c,
        gbpas TYPE d,
        fnamk(000040) TYPE c,
        lnamk(000040) TYPE c,
        fnamr(000040) TYPE c,
        lnamr(000040) TYPE c,
        nabik(000040) TYPE c,
        nabir(000040) TYPE c,
        nickk(000040) TYPE c,
        nickr(000040) TYPE c,
        gbjhr(000004) TYPE n,
        gbmon(000002) TYPE n,
        gbtag(000002) TYPE n,
        nchmc(000025) TYPE c,
        vnamc(000025) TYPE c,
        namz2(000015) TYPE c,
      END OF ts_p0002.
TYPES: BEGIN OF ts_p0105,
        pernr(000008) TYPE n,
        infty(000004) TYPE c,
        subty(000004) TYPE c,
        objps(000002) TYPE c,
        sprps(000001) TYPE c,
        endda TYPE d,
        begda TYPE d,
        seqnr(000003) TYPE n,
        aedtm TYPE d,
        uname(000012) TYPE c,
        histo(000001) TYPE c,
        itxex(000001) TYPE c,
        refex(000001) TYPE c,
        ordex(000001) TYPE c,
        itbld(000002) TYPE c,
        preas(000002) TYPE c,
        flag1(000001) TYPE c,
        flag2(000001) TYPE c,
        flag3(000001) TYPE c,
        flag4(000001) TYPE c,
        rese1(000002) TYPE c,
        rese2(000002) TYPE c,
        grpvl(000004) TYPE c,
        usrty(000004) TYPE c,
        usrid(000030) TYPE c,
        usrid_long(000241) TYPE c,
      END OF ts_p0105.

TYPES: BEGIN OF ts_employee_data,
        usrid1           TYPE c LENGTH 30,
        vorna1           TYPE c LENGTH 40,
        nachn1           TYPE c LENGTH 40,
        email1           TYPE c LENGTH 241,
        pernr            TYPE c LENGTH 8,
        nachn2           TYPE c LENGTH 40,
        vorna2           TYPE c LENGTH 40,
        stat2            TYPE c LENGTH 8,
        email2           TYPE c LENGTH 241,
        locat            TYPE c LENGTH 40,
        plans            TYPE c LENGTH 40,
        usrid2           TYPE c LENGTH 30,
        region           TYPE c LENGTH 2,
END OF ts_employee_data,

BEGIN OF ts_export_flags,
  ed_export TYPE c LENGTH 1, "Employee data export flag; 1 = export, 0 = don't export
END OF ts_export_flags,

BEGIN OF ts_change_blocks,
  cb_1  TYPE c LENGTH 1,   "X = Export Change Block 1
  cb_2  TYPE c LENGTH 1,   "X = Export Change Block 2
  cb_3  TYPE c LENGTH 1,   "X = Export Change Block 3
  cb_4  TYPE c LENGTH 1,   "X = Export Change Block 4
  cb_5  TYPE c LENGTH 1,   "X = Export Change Block 5
  cb_6  TYPE c LENGTH 1,   "X = Export Change Block 6
  cb_7  TYPE c LENGTH 1,   "X = Export Change Block 7
  cb_8  TYPE c LENGTH 1,   "X = Export Change Block 8
  cb_9  TYPE c LENGTH 1,   "X = Export Change Block 9
  cb_10 TYPE c LENGTH 1,   "X = Export Change Block 10
  cb_11 TYPE c LENGTH 1,   "X = Export Change Block 11
  cb_12 TYPE c LENGTH 1,   "X = Export Change Block 12
  cb_13 TYPE c LENGTH 1,   "X = Export Change Block 13
  cb_14 TYPE c LENGTH 1,   "X = Export Change Block 14
  cb_15 TYPE c LENGTH 1,   "X = Export Change Block 15
  cb_16 TYPE c LENGTH 1,   "X = Export Change Block 16
  cb_17 TYPE c LENGTH 1,   "X = Export Change Block 17
  cb_18 TYPE c LENGTH 1,   "X = Export Change Block 18
  cb_19 TYPE c LENGTH 1,   "X = Export Change Block 19
  cb_20 TYPE c LENGTH 1,   "X = Export Change Block 20
  cb_21 TYPE c LENGTH 1,   "X = Export Change Block 21
  cb_22 TYPE c LENGTH 1,   "X = Export Change Block 22
  cb_23 TYPE c LENGTH 1,   "X = Export Change Block 23
  cb_24 TYPE c LENGTH 1,   "X = Export Change Block 24
  cb_25 TYPE c LENGTH 1,   "X = Export Change Block 25
  cb_26 TYPE c LENGTH 1,   "X = Export Change Block 26
  cb_27 TYPE c LENGTH 1,   "X = Export Change Block 27
  cb_28 TYPE c LENGTH 1,   "X = Export Change Block 28
  cb_29 TYPE c LENGTH 1,   "X = Export Change Block 29
  cb_30 TYPE c LENGTH 1,   "X = Export Change Block 30
  cb_31 TYPE c LENGTH 1,   "X = Export Change Block 31
  cb_32 TYPE c LENGTH 1,   "X = Export Change Block 32
  cb_33 TYPE c LENGTH 1,   "X = Export Change Block 33
  cb_34 TYPE c LENGTH 1,   "X = Export Change Block 34
  cb_35 TYPE c LENGTH 1,   "X = Export Change Block 35
  cb_36 TYPE c LENGTH 1,   "X = Export Change Block 36
  cb_37 TYPE c LENGTH 1,   "X = Export Change Block 37
  cb_38 TYPE c LENGTH 1,   "X = Export Change Block 38
  cb_39 TYPE c LENGTH 1,   "X = Export Change Block 39
  cb_40 TYPE c LENGTH 1,   "X = Export Change Block 40
  cb_41 TYPE c LENGTH 1,   "X = Export Change Block 41
  cb_42 TYPE c LENGTH 1,   "X = Export Change Block 42
  cb_43 TYPE c LENGTH 1,   "X = Export Change Block 43
  cb_44 TYPE c LENGTH 1,   "X = Export Change Block 44
  cb_45 TYPE c LENGTH 1,   "X = Export Change Block 45
  cb_46 TYPE c LENGTH 1,   "X = Export Change Block 46
END OF ts_change_blocks,

BEGIN OF ts_column_names,
  field TYPE c LENGTH 25,
  name  TYPE c LENGTH 40,
END OF ts_column_names.

TYPES: tt_if_results    TYPE STANDARD TABLE OF ts_if_results,
       tt_p0000         TYPE STANDARD TABLE OF ts_p0000,
       tt_p0001         TYPE STANDARD TABLE OF ts_p0001,
       tt_p0002         TYPE STANDARD TABLE OF ts_p0002,
       tt_p0105         TYPE STANDARD TABLE OF ts_p0105.

TYPES: tt_employee_data TYPE STANDARD TABLE OF ts_employee_data,
       tt_column_names  TYPE STANDARD TABLE OF ts_column_names.

TYPES  tv_raw_length TYPE i.
CONSTANTS gc_raw_length TYPE tv_raw_length VALUE 2000.
TYPES ts_raw_line TYPE c LENGTH gc_raw_length.

CONSTANTS: gc_if_version LIKE zhr_pcl2-versn VALUE '01',
           gc_if_name    LIKE t532a-fldid    VALUE 'ADTM'. "Active Directory Team Member Update

CONSTANTS: gc_network_id      LIKE p0105-usrty VALUE '9002',
           gc_email_addr      LIKE p0105-usrty VALUE '0010'.

CONSTANTS: gc_part TYPE c LENGTH 1 VALUE space,
           gc_all  TYPE c LENGTH 1 VALUE '1'.

DATA:      gc_path1   TYPE c LENGTH 25  VALUE '\\ilnoad08.stericorp.com\',
           gc_system  TYPE c LENGTH 10  VALUE 'SAPPROD',
           gc_path2   TYPE c LENGTH 14  VALUE 'AD-SAP Import\',
           gc_archive TYPE c LENGTH 32  VALUE '\\scvmerpfs\HCM\SRCL AD\Archive\',
           gc_file    TYPE c LENGTH 8   VALUE 'userlist'.

CONSTANTS: gc_ext TYPE c LENGTH 3 VALUE 'CSV'.

FIELD-SYMBOLS: <gs_p0000> TYPE ts_p0000,
               <gs_p0001> TYPE ts_p0001,
               <gs_p0002> TYPE ts_p0002,
               <gs_p0105> TYPE ts_p0105,
               <gt_p0105> TYPE tt_p0105,
               <gs_employee_data> TYPE ts_employee_data.

DATA: gt_old_p0000 TYPE tt_p0000.
DATA: gt_old_p0001 TYPE tt_p0001.
DATA: gt_old_p0002 TYPE tt_p0002.
DATA: gt_old_p0105 TYPE tt_p0105.

DATA: gt_new_p0000 TYPE tt_p0000.
DATA: gt_new_p0001 TYPE tt_p0001.
DATA: gt_new_p0002 TYPE tt_p0002.
DATA: gt_new_p0105 TYPE tt_p0105.

DATA: gs_old_p0000 TYPE ts_p0000.
DATA: gs_old_p0001 TYPE ts_p0001.
DATA: gs_old_p0002 TYPE ts_p0002.
DATA: gs_old_p0105 TYPE ts_p0105.

DATA: gs_new_p0000 TYPE ts_p0000.
DATA: gs_new_p0001 TYPE ts_p0001.
DATA: gs_new_p0002 TYPE ts_p0002.
DATA: gs_new_p0105 TYPE ts_p0105.


DATA: gs_header   TYPE ts_raw_line,
      gs_line_out TYPE ts_raw_line,
      gt_file_out TYPE STANDARD TABLE OF ts_raw_line.

DATA: gv_frper TYPE n LENGTH 6,   "Payroll period
      gv_frbeg TYPE d,            "Payroll period begin date
      gv_frend TYPE d.            "Payroll period end date

DATA: gs_component      TYPE         abap_compdescr,
      go_structdescr_ed TYPE REF TO  cl_abap_structdescr.  "Structure description for Employee Data

DATA: gv_date_01            TYPE dardt,       "Original Hire Date
      gv_date_06            TYPE dardt,       "Ajusted Service Date
      gv_date_07            TYPE dardt,       "Last Day Worked
      gv_date_08            TYPE dardt,       "Last Day Paid
      gv_date_09            TYPE dardt,       "Rehire Date
      gv_date_11            TYPE dardt,       "Tax ID Expiry Date
      gv_date_12            TYPE dardt,       "Seniority Date
      gv_date_98            TYPE dardt,       "Hire Date
      gv_date_99            TYPE dardt.       "Termination Date

DATA: gv_abart              TYPE t503-abart,  "1 = Hourly, 3 = Salaried
      gv_trfkz              TYPE t503-trfkz,  "For getting the payroll frequency
      gv_zeinh              TYPE t549r-zeinh. "Payroll frequency

DATA: gt_employee_data      TYPE tt_employee_data,
      gs_employee_data      TYPE ts_employee_data,
      gs_old_employee_data  TYPE ts_employee_data,
      gs_new_employee_data  TYPE ts_employee_data,
      gt_column_names       TYPE tt_column_names.

DATA: gv_effective_date     TYPE d.

DATA: gs_change_blocks      TYPE ts_change_blocks,
      gs_export_flags       TYPE ts_export_flags.

DATA: gv_num_exported_pernr  TYPE n LENGTH 6,
      gv_num_selected_pernr  LIKE gv_num_exported_pernr,
      gv_num_rejected_pernr  LIKE gv_num_exported_pernr,
      gv_number_of_records   TYPE i.
