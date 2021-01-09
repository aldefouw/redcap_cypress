START TRANSACTION;

  	USE `REDCAP_DB_NAME`;
  	SET AUTOCOMMIT=0;
  	SET UNIQUE_CHECKS=0;
  	SET FOREIGN_KEY_CHECKS=0;
 
 	
 	INSERT INTO redcap_projects 
 	(project_id,
	project_name,
	app_title,
	status,
	creation_time,
	production_time,
	inactive_time,
	created_by,
	draft_mode,
	surveys_enabled,
	repeatforms,
	scheduling,
	purpose,
	purpose_other,
	show_which_records,
	__SALT__,
	count_project,
	investigators,
	project_note,
	online_offline,
	auth_meth,
	double_data_entry,
	project_language,
	project_encoding,
	is_child_of,
	date_shift_max,
	institution,
	site_org_type,
	grant_cite,
	project_contact_name,
	project_contact_email,
	headerlogo,
	auto_inc_set,
	custom_data_entry_note,
	custom_index_page_note,
	order_id_by,
	custom_reports,
	report_builder,
	disable_data_entry,
	google_translate_default,
	require_change_reason,
	dts_enabled,
	project_pi_firstname,
	project_pi_mi,
	project_pi_lastname,
	project_pi_email,
	project_pi_alias,
	project_pi_username,
	project_pi_pub_exclude,
	project_pub_matching_institution,
	project_irb_number,
	project_grant_number,
	history_widget_enabled,
	secondary_pk,
	custom_record_label,
	display_project_logo_institution,
	imported_from_rs,
	display_today_now_button,
	auto_variable_naming,
	randomization,
	enable_participant_identifiers,
	survey_email_participant_field,
	survey_phone_participant_field,
	data_entry_trigger_url,
	template_id,
	date_deleted)
 	VALUES (14,'compare_project','Compare Project',0,'2021-01-08 14:31:23',NULL,NULL,2,0,0,0,0,2,'0',0,'4a1a3a3267',1,NULL,NULL,1,'table',1,'English',NULL,NULL,364,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,0,NULL,0,0,'Andrew','B','Poppe','andrew.poppe@yale.edu','Poppe AB',NULL,NULL,NULL,'12345678',NULL,1,NULL,NULL,0,0,1,0,0,0,NULL,NULL,NULL,NULL,NULL);

	INSERT INTO redcap_events_arms (arm_id,project_id,arm_num,arm_name) VALUES (15,14,1,'Arm 1');

	INSERT INTO redcap_events_metadata (event_id,arm_id,day_offset,offset_min,offset_max,descrip) VALUES ('41', '15', '0', '0', '0', 'Event 1');

	INSERT INTO redcap_metadata VALUES (14,'my_first_instrument_complete',NULL,'my_first_instrument',NULL,2,NULL,'Form Status','select','Complete?','0, Incomplete \\n 1, Unverified \\n 2, Complete',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,0),
    (14,'record_id',NULL,'my_first_instrument','My First Instrument',1,NULL,NULL,'text','Record ID',NULL,NULL,NULL,NULL,NULL,'soft_typed',NULL,0,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,0),
    (14,'text_1',NULL,'my_first_instrument','My First Instrument',1,NULL,NULL,'text',NULL,NULL,NULL,NULL,NULL,NULL,'soft_typed',NULL,0,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,0),
    (14,'text_2',NULL,'my_first_instrument','My First Instrument',1,NULL,NULL,'text',NULL,NULL,NULL,NULL,NULL,NULL,'soft_typed',NULL,0,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,0);
  
	INSERT INTO redcap_user_rights (project_id,username,expiration,role_id,group_id,lock_record,lock_record_multiform,lock_record_customize,data_export_tool,data_import_tool,data_comparison_tool,data_logging,file_repository,double_data,user_rights,data_access_groups,graphical,reports,design,calendar,data_entry,api_token,api_export,api_import,mobile_app,mobile_app_download_data,record_create,record_rename,record_delete,dts,participants,data_quality_design,data_quality_execute,data_quality_resolution,random_setup,random_dashboard,random_perform,realtime_webservice_mapping,realtime_webservice_adjudicate,external_module_config)
	VALUES (14,'test_admin',NULL,NULL,NULL,0,0,0,2,0,1,1,1,0,1,1,1,1,1,1,'[my_first_instrument,1]',NULL,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,NULL),
	(14,'test_user',NULL,NULL,NULL,0,0,0,2,0,1,1,1,0,1,1,1,1,1,1,'[my_first_instrument,1]',NULL,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,NULL),
	(14,'test_user2',NULL,NULL,NULL,0,0,0,2,0,1,1,1,0,1,1,1,1,1,1,'[my_first_instrument,1]',NULL,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,NULL);

	INSERT INTO redcap_data (project_id, event_id, record, field_name, value) VALUES 
	  (14, 41, 'Record1--1', 'text_1', 'Debussy'),
	  (14, 41, 'Record1--1', 'text_2', 'Ravel'),
	  (14, 41, 'Record1--1', 'record_id', 'Record1--1'),
	  (14, 41, 'Record1--1', 'my_first_instrument_complete',0),
	  (14, 41, 'Record1--2', 'text_1', 'Debussy'),
	  (14, 41, 'Record1--2', 'text_2', 'Satie'),
	  (14, 41, 'Record1--2', 'record_id', 'Record1--2'),
	  (14, 41, 'Record1--2', 'my_first_instrument_complete',0),
	  (14, 41, 'Record2--2', 'text_1', 'Satie'),
	  (14, 41, 'Record2--2', 'text_2', 'Debussy'),
	  (14, 41, 'Record2--2', 'record_id', 'Record2--2'),
	  (14, 41, 'Record2--2', 'my_first_instrument_complete',0),
	  (14, 41, 'Test', 'text_1', 'Debussy'),
	  (14, 41, 'Test', 'record_id', 'Test'),
	  (14, 41, 'Test', 'my_first_instrument_complete',0);

COMMIT;