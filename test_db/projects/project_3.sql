START TRANSACTION;

  	USE `REDCAP_DB_NAME`;
  	SET AUTOCOMMIT=0;
  	SET UNIQUE_CHECKS=0;
  	SET FOREIGN_KEY_CHECKS=0;
 
	DELETE FROM redcap_metadata WHERE project_id = 3;

 	UPDATE redcap_projects SET double_data_entry = 1 WHERE project_id = 3;

	INSERT INTO redcap_metadata VALUES (3,'my_first_instrument_complete',NULL,'my_first_instrument',NULL,2,NULL,'Form Status','select','Complete?','0, Incomplete \\n 1, Unverified \\n 2, Complete',NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,0),
    (3,'record_id',NULL,'my_first_instrument','My First Instrument',1,NULL,NULL,'text','Record ID',NULL,NULL,NULL,NULL,NULL,'soft_typed',NULL,0,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,0),
    (3,'text_1',NULL,'my_first_instrument','My First Instrument',1,NULL,NULL,'text',NULL,NULL,NULL,NULL,NULL,NULL,'soft_typed',NULL,0,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,0),
    (3,'text_2',NULL,'my_first_instrument','My First Instrument',1,NULL,NULL,'text',NULL,NULL,NULL,NULL,NULL,NULL,'soft_typed',NULL,0,NULL,0,NULL,NULL,NULL,NULL,0,NULL,NULL,0);
  
	INSERT INTO redcap_user_rights (project_id,username,expiration,role_id,group_id,lock_record,lock_record_multiform,lock_record_customize,data_export_tool,data_import_tool,data_comparison_tool,data_logging,file_repository,double_data,user_rights,data_access_groups,graphical,reports,design,calendar,data_entry,api_token,api_export,api_import,mobile_app,mobile_app_download_data,record_create,record_rename,record_delete,dts,participants,data_quality_design,data_quality_execute,data_quality_resolution,random_setup,random_dashboard,random_perform,realtime_webservice_mapping,realtime_webservice_adjudicate,external_module_config)
	VALUES (3,'test_admin',NULL,NULL,NULL,0,0,0,2,0,1,1,1,0,1,1,1,1,1,1,'[my_first_instrument,1]',NULL,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,NULL),
	(3,'test_user',NULL,NULL,NULL,0,0,0,2,0,1,1,1,0,1,1,1,1,1,1,'[my_first_instrument,1]',NULL,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,NULL),
	(3,'test_user2',NULL,NULL,NULL,0,0,0,2,0,1,1,1,0,1,1,1,1,1,1,'[my_first_instrument,1]',NULL,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,NULL);

	INSERT INTO redcap_data (project_id, event_id, record, field_name, value) VALUES 
	  (3, 18, 'Record1--1', 'text_1', 'Debussy'),
	  (3, 18, 'Record1--1', 'text_2', 'Ravel'),
	  (3, 18, 'Record1--1', 'record_id', 'Record1--1'),
	  (3, 18, 'Record1--1', 'my_first_instrument_complete',0),
	  (3, 18, 'Record1--2', 'text_1', 'Debussy'),
	  (3, 18, 'Record1--2', 'text_2', 'Satie'),
	  (3, 18, 'Record1--2', 'record_id', 'Record1--2'),
	  (3, 18, 'Record1--2', 'my_first_instrument_complete',0),
	  (3, 18, 'Record2--2', 'text_1', 'Satie'),
	  (3, 18, 'Record2--2', 'text_2', 'Debussy'),
	  (3, 18, 'Record2--2', 'record_id', 'Record2--2'),
	  (3, 18, 'Record2--2', 'my_first_instrument_complete',0),
	  (3, 18, 'Test', 'text_1', 'Debussy'),
	  (3, 18, 'Test', 'record_id', 'Test'),
	  (3, 18, 'Test', 'my_first_instrument_complete',0);

COMMIT;