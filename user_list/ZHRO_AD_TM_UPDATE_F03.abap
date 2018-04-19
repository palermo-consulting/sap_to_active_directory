*&---------------------------------------------------------------------*
*&  Include           ZHRO_AD_TM_UPDATE_F03
*&---------------------------------------------------------------------*

*--------------------------------------------------------------------------------------------------
* This block of subroutines maps the SAP effective date to the Nomitek field.  These are called by the
* change validation logic.
*--------------------------------------------------------------------------------------------------

*FORM position_id_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0185-begda. ENDFORM.
*FORM co_code_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0001-begda. ENDFORM.
*FORM seniority_date_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0041-begda. ENDFORM.
*FORM employee_status_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0000-begda. ENDFORM.
*FORM home_cost_number_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0001-begda. ENDFORM.
*FORM home_department_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0001-begda. ENDFORM.
*FORM pay_group_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0001-begda. ENDFORM.
*FORM last_name_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0002-begda. ENDFORM.
*FORM first_name_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0002-begda. ENDFORM.
*FORM actual_mar_sta_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0002-begda. ENDFORM.
*FORM tax_id_number_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0002-begda. ENDFORM.
*FORM tax_id_expy_date_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0041-begda. ENDFORM.
*FORM birth_date_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0002-begda. ENDFORM.
*FORM corresp_lang_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0002-begda. ENDFORM.
*FORM gender_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0002-begda. ENDFORM.
*FORM address_line_1_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0006-begda. ENDFORM.
*FORM address_line_2_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0006-begda. ENDFORM.
*FORM address_1_prov_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0006-begda. ENDFORM.
*FORM address_1_city_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0006-begda. ENDFORM.
*FORM address_1_pstlcd_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0006-begda. ENDFORM.
*FORM address_1_cntry_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0006-begda. ENDFORM.
*FORM standard_hours_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0008-begda. ENDFORM.
*FORM rate_type_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0001-begda. ENDFORM.
*FORM rate_amount_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0008-begda. ENDFORM.
*FORM payment_method_eff_date CHANGING fv_effective_date. fv_effective_date = gs_bank-effective_date_p. ENDFORM.
*FORM primary_bank_eff_date CHANGING fv_effective_date. fv_effective_date = gs_bank-effective_date_p. ENDFORM.
*FORM primary_branch_eff_date CHANGING fv_effective_date. fv_effective_date = gs_bank-effective_date_p. ENDFORM.
*FORM primary_accnt_no_eff_date CHANGING fv_effective_date. fv_effective_date = gs_bank-effective_date_p. ENDFORM.
*FORM secondary_bank_eff_date CHANGING fv_effective_date. fv_effective_date = gs_bank-effective_date_s. ENDFORM.
*FORM secondary_branch_eff_date CHANGING fv_effective_date. fv_effective_date = gs_bank-effective_date_s. ENDFORM.
*FORM second_accnt_no_eff_date CHANGING fv_effective_date.fv_effective_date = gs_bank-effective_date_s. ENDFORM.
*FORM second_dep_amnt_eff_date CHANGING fv_effective_date. fv_effective_date = gs_bank-effective_date_s. ENDFORM.
*FORM prov_of_emplymnt_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0461-begda. ENDFORM.
*FORM cra_pa_rq_id_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0033-begda. ENDFORM.
*FORM fedtax_crdt_type_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0463-begda. ENDFORM.
*FORM fedtax_crdt_oamt_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0463-begda. ENDFORM.
*FORM prvtax_crdt_type_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0462-begda. ENDFORM.
*FORM prvtax_crdt_oamt_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0462-begda. ENDFORM.
*FORM dont_calc_fedtax_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0464-begda. ENDFORM.
*FORM dont_calc_c_qpp_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0464-begda. ENDFORM.
*FORM do_not_calc_ei_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0464-begda. ENDFORM.
*FORM employee_occup_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0001-begda. ENDFORM.
*FORM last_day_paid_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0041-begda. ENDFORM.
*FORM payclass_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0033-begda. ENDFORM.
*FORM supervisorflag_eff_date CHANGING fv_effective_date. fv_effective_date = sy-datum. ENDFORM.
*FORM reports_to_id_eff_date CHANGING fv_effective_date. fv_effective_date = sy-datum. ENDFORM.
*FORM timezone_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0462-begda. ENDFORM.
*FORM xfertopayroll_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0001-begda. ENDFORM.
*FORM to_policy_name_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0033-begda. ENDFORM.
**FORM to_plcyass_begda_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0033-begda. ENDFORM.
*FORM work_email_eff_date CHANGING fv_effective_date. fv_effective_date = gs_new_p0105-begda. ENDFORM.


*--------------------------------------------------------------------------------------------------
* This block of subroutines maps a Nomitek field to a change block that tells the interface if the
* field should be exported.  These are called by the change validation logic.  They are left
* purposely unformatted for ease of search.
*--------------------------------------------------------------------------------------------------

*FORM full_name_1_cb. gs_change_blocks-cb_1 = 'X'. ENDFORM.
*FORM contract_type_cb. gs_change_blocks-cb_2 = 'X'. ENDFORM.
*FORM employee_kind_cb. gs_change_blocks-cb_3 = 'X'. ENDFORM.
*FORM social_benefits_cb. gs_change_blocks-cb_4 = 'X'. ENDFORM.
*FORM _original_hiring_date_cb. gs_change_blocks-cb_42 = 'X'. ENDFORM.
*FORM _current_hiring_date_cb. gs_change_blocks-cb_40 = 'X'. ENDFORM.
*FORM _contract_end_date_cb. gs_change_blocks-cb_42 = 'X'. ENDFORM.
*FORM _termination_date_cb. gs_change_blocks-cb_41 = 'X'. ENDFORM.
*FORM _termination_reason_cb. gs_change_blocks-cb_41 = 'X'. ENDFORM.
*FORM nss_number_cb. gs_change_blocks-cb_5 = 'X'. ENDFORM.
*FORM imss_begin_date_cb. gs_change_blocks-cb_5 = 'X'. ENDFORM.
*FORM imss_group_cb. gs_change_blocks-cb_5 = 'X'. ENDFORM.
*FORM date_of_birth_cb. gs_change_blocks-cb_6 = 'X'. ENDFORM.
*FORM rfc_number_cb. gs_change_blocks-cb_7 = 'X'. ENDFORM.
*FORM marital_status_cb. gs_change_blocks-cb_8 = 'X'. ENDFORM.
*FORM gender_cb. gs_change_blocks-cb_9 = 'X'. ENDFORM.
*FORM economic_zone_cb. gs_change_blocks-cb_10 = 'X'. ENDFORM.
*FORM employer_record_cb. gs_change_blocks-cb_11 = 'X'. ENDFORM.
*FORM _years_of_seniority_cb. gs_change_blocks-cb_43 = 'X'. ENDFORM.
*FORM _months_of_seniority_cb. gs_change_blocks-cb_44 = 'X'. ENDFORM.
*FORM _days_of_seniority_cb. gs_change_blocks-cb_45 = 'X'. ENDFORM.
*FORM payment_region_cb. gs_change_blocks-cb_12 = 'X'. ENDFORM.
*FORM responsibility_area_cb. gs_change_blocks-cb_13 = 'X'. ENDFORM.
*FORM company_cost_center_cb. gs_change_blocks-cb_14 = 'X'. ENDFORM.
*FORM department_cost_center_cb. gs_change_blocks-cb_15 = 'X'. ENDFORM.
*FORM sub_department_cost_center_cb. gs_change_blocks-cb_16 = 'X'. ENDFORM.
*FORM job_cb. gs_change_blocks-cb_17 = 'X'. ENDFORM.
*FORM category_key_cb. gs_change_blocks-cb_18 = 'X'. ENDFORM.
*FORM shift_cb. gs_change_blocks-cb_19 = 'X'. ENDFORM.
*FORM non_working_day_cb. gs_change_blocks-cb_20 = 'X'. ENDFORM.
*FORM method_of_payment_cb. gs_change_blocks-cb_21 = 'X'. ENDFORM.
*FORM nationality_name_cb. gs_change_blocks-cb_22 = 'X'. ENDFORM.
*FORM nationality_code_cb. gs_change_blocks-cb_22 = 'X'. ENDFORM.
*FORM accounting_code_cb. gs_change_blocks-cb_22 = 'X'. ENDFORM.
*FORM first_name_cb. gs_change_blocks-cb_1 = 'X'. ENDFORM.
*FORM last_name_cb. gs_change_blocks-cb_1 = 'X'. ENDFORM.
*FORM mothers_last_name1_cb. gs_change_blocks-cb_1 = 'X'. ENDFORM.
*FORM full_name_2_cb. gs_change_blocks-cb_1 = 'X'. ENDFORM.
*FORM address_cb. gs_change_blocks-cb_23 = 'X'. ENDFORM.
*FORM address2_cb. gs_change_blocks-cb_23 = 'X'. ENDFORM.
*FORM town_cb. gs_change_blocks-cb_23 = 'X'. ENDFORM.
*FORM state1_cb. gs_change_blocks-cb_23 = 'X'. ENDFORM.
*FORM postal_code_cb. gs_change_blocks-cb_23 = 'X'. ENDFORM.
*FORM state2_cb. gs_change_blocks-cb_23 = 'X'. ENDFORM.
*FORM telephone_number_cb. gs_change_blocks-cb_23 = 'X'. ENDFORM.
*FORM fathers_name_cb. gs_change_blocks-cb_1 = 'X'. ENDFORM.
*FORM mothers_last_name2_cb. gs_change_blocks-cb_1 = 'X'. ENDFORM.
*FORM saving_account_%_cb. gs_change_blocks-cb_24 = 'X'. ENDFORM.
*FORM saving_account_amount_cb. gs_change_blocks-cb_24 = 'X'. ENDFORM.
*FORM life_and_disability_insuran_cb. gs_change_blocks-cb_25 = 'X'. ENDFORM.
*FORM illness_and_maternitiy_ins_cb. gs_change_blocks-cb_26 = 'X'. ENDFORM.
*FORM saving_fund_cb. gs_change_blocks-cb_27 = 'X'. ENDFORM.
*FORM saving_bank_cb. gs_change_blocks-cb_27 = 'X'. ENDFORM.
*FORM pantry_vouchers_cb. gs_change_blocks-cb_28 = 'X'. ENDFORM.
*FORM food_vouchers_cb. gs_change_blocks-cb_29 = 'X'. ENDFORM.
*FORM profit_sharing_cb. gs_change_blocks-cb_30 = 'X'. ENDFORM.
*FORM holidays_bonus_cb. gs_change_blocks-cb_31 = 'X'. ENDFORM.
*FORM vacational_bonus_cb. gs_change_blocks-cb_32 = 'X'. ENDFORM.
*FORM annual_income_tax_decl_cb. gs_change_blocks-cb_33 = 'X'. ENDFORM.
*FORM tax_declaration_cb. gs_change_blocks-cb_34 = 'X'. ENDFORM.
*FORM bank_key_cb. gs_change_blocks-cb_21 = 'X'. ENDFORM.
*FORM bank_account_number_cb. gs_change_blocks-cb_21 = 'X'. ENDFORM.
*FORM unique_pop_registry_code_cb. gs_change_blocks-cb_35 = 'X'. ENDFORM.
*FORM retroactive_cb. gs_change_blocks-cb_36 = 'X'. ENDFORM.
*FORM _date_of_last_daily_salary_cb. gs_change_blocks-cb_37 = 'X'. ENDFORM.
*FORM amount_of_daily_salary_cb. gs_change_blocks-cb_37 = 'X'. ENDFORM.
*FORM _date_of_prev_daily_salary_cb. gs_change_blocks-cb_38 = 'X'. ENDFORM.
*FORM amnt_of_previous_daily_sal_cb. gs_change_blocks-cb_38 = 'X'. ENDFORM.
*FORM monthly_salary_cb. gs_change_blocks-cb_39 = 'X'. ENDFORM.
*FORM recinto_cb. gs_change_blocks-cb_46 = 'X'. ENDFORM.
