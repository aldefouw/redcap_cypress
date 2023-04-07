-- UPDATE redcap_user_rights SET username = 'test_user', user_rights = 1, lock_record = 1, design = 1, record_create = 1, record_delete = 1;

-- INSERT INTO redcap_user_rights (project_id, username, expiration, role_id, group_id, lock_record, lock_record_multiform, lock_record_customize, data_export_tool, data_import_tool, data_comparison_tool, data_logging, file_repository, double_data, user_rights, data_access_groups, graphical, reports, design, calendar, data_entry, api_token, api_export, api_import, mobile_app, mobile_app_download_data, record_create, record_rename, record_delete, dts, participants, data_quality_design, data_quality_execute, data_quality_resolution, random_setup, random_dashboard, random_perform, realtime_webservice_mapping, realtime_webservice_adjudicate)
-- VALUES
-- (13,'test_user',NULL,NULL,NULL,0,0,0,1,1,1,1,1,0,1,1,1,1,1,1,'[my_first_instrument,1]',NULL,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0);

-- UPDATE redcap_projects SET auth_meth = 'table';