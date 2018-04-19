*&---------------------------------------------------------------------*
*& Report  ZHRO_AD_TM_UPDATE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zhro_ad_tm_update.

INCLUDE zhro_ad_tm_update_d01. "Data structures
INCLUDE zhro_ad_tm_update_d02. "Data structures for file handling
INCLUDE zhro_ad_tm_update_s01.
INCLUDE zhro_ad_tm_update_f01. "Interface Logic
INCLUDE zhro_ad_tm_update_f02. "Field Logic
INCLUDE zhro_ad_tm_update_f03. "Effective Dates and Change Blocks
INCLUDE zhro_ad_tm_update_f04. "Field Mapping
INCLUDE zhro_ad_tm_update_f05. "Auxiliary Routines

INITIALIZATION.

  PERFORM begin.

GET pernr.
  ADD 1 TO gv_num_selected_pernr.
  PERFORM enqueue_pernr.
  PERFORM data_collection.
  PERFORM validate_employee.
  PERFORM export_new_data.
  PERFORM change_validation.
*  PERFORM action_based_validation.
*  perform post_validation.
  PERFORM fill_ad_tm_records.
  PERFORM dequeue_pernr.

END-OF-SELECTION.

  PERFORM write_to_file.
  PERFORM export_summary.
