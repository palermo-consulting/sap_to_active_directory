*&---------------------------------------------------------------------*
*& Report  ZHRO_ACTIVE_DIR
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zhro_active_dir.

INCLUDE: zhro_active_dir_d0,
         zhro_active_dir_s0,
         zhro_active_dir_f0.


GET pernr.
  PERFORM get_pernr.

END-OF-SELECTION.
  PERFORM write_to_file.
