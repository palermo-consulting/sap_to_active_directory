*&---------------------------------------------------------------------*
*&  Include           ZHRO_ACTIVE_DIR_D0
*&---------------------------------------------------------------------*
TABLES: pernr.

INFOTYPES:  0000, 0001, 0002, 0105.

TYPES: BEGIN OF ts_data,
        pernr   LIKE p0001-pernr,
        usrid   LIKE p0105-usrid,
        nachn   LIKE p0002-nachn,
        vorna   LIKE p0002-vorna,
        begda   TYPE c LENGTH 10,
        mntxt   LIKE t529t-mntxt,
        stat2   LIKE t529u-text1,
        bukrs   LIKE p0001-bukrs,
        butxt   LIKE t001-butxt,
        ort01   LIKE t777a-ort01,
        kltxt   LIKE cskt-ltext,
        region  TYPE c LENGTH 2,
       END OF ts_data.

TYPES: tt_data TYPE STANDARD TABLE OF ts_data,
       ts_line TYPE c LENGTH 342,
       tt_file TYPE STANDARD TABLE OF ts_line.

DATA: gt_data TYPE tt_data.

DATA:     gv_sfile          TYPE c LENGTH 255,
          gv_path           TYPE string,
          gv_fullpath       TYPE string,
          gv_filename       TYPE string,
          gt_dynpfields     TYPE STANDARD TABLE OF dynpread,
          gs_dynpfields     TYPE dynpread.

CONSTANTS: gc_path1     TYPE c LENGTH 40  VALUE '\\ilnoad08.stericorp.com\AS-SAP Disable\',
           gc_path2     TYPE c LENGTH 29  VALUE '\\scvmerpfs\HCM\SRCL AD\',
           gc_archive   TYPE c LENGTH 7   VALUE 'Archive',
           gc_filename  TYPE c LENGTH 12  VALUE 'disablelist'.

CONSTANTS: gc_ext TYPE c LENGTH 3 VALUE 'csv'.
