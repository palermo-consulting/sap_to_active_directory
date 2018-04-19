*&---------------------------------------------------------------------*
*&  Include           ZHRO_AD_TM_UPDATE_D02
*&---------------------------------------------------------------------*

DATA:     gv_path           TYPE string,
          gv_fullpath       TYPE string,
          gv_filename       TYPE string,
          gt_dynpfields     TYPE STANDARD TABLE OF dynpread,
          gs_dynpfields     TYPE dynpread.
