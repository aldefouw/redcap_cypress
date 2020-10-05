
INSERT INTO redcap_auth (username, password, password_salt, legacy_hash, temp_pwd, password_question, password_answer) 
VALUES 
('test_user','041a2000c14ebefc3fc334cc02dfce4ca4f3552a48f8e2b37c928089d5f7487c52cdc79c90fde50a0ac3a17d1424681fc82c02d2f56f7bb93e315a2e90b4308f','dnuX#SD.#tCve5IjqYB-ueI~D~NFVyIow!xKbW-vM5-aHASdBdDSAja@3j~jkhWyuerjdt22X$W$o&hEY&bK%ojr-AVr4o*kE6cT',0,0,2,'81e66b67c71eca3b2faa7bdf35a00155ce6b61c16646287dc236a7f708467626919e37005d53c05813122974886e1968df564f30be8b5c62ce757336286d105e'),
('test_user2','041a2000c14ebefc3fc334cc02dfce4ca4f3552a48f8e2b37c928089d5f7487c52cdc79c90fde50a0ac3a17d1424681fc82c02d2f56f7bb93e315a2e90b4308f','dnuX#SD.#tCve5IjqYB-ueI~D~NFVyIow!xKbW-vM5-aHASdBdDSAja@3j~jkhWyuerjdt22X$W$o&hEY&bK%ojr-AVr4o*kE6cT',0,0,2,'81e66b67c71eca3b2faa7bdf35a00155ce6b61c16646287dc236a7f708467626919e37005d53c05813122974886e1968df564f30be8b5c62ce757336286d105e'),
('test_admin','041a2000c14ebefc3fc334cc02dfce4ca4f3552a48f8e2b37c928089d5f7487c52cdc79c90fde50a0ac3a17d1424681fc82c02d2f56f7bb93e315a2e90b4308f','dnuX#SD.#tCve5IjqYB-ueI~D~NFVyIow!xKbW-vM5-aHASdBdDSAja@3j~jkhWyuerjdt22X$W$o&hEY&bK%ojr-AVr4o*kE6cT',0,0,2,'81e66b67c71eca3b2faa7bdf35a00155ce6b61c16646287dc236a7f708467626919e37005d53c05813122974886e1968df564f30be8b5c62ce757336286d105e');

INSERT INTO redcap_user_information (ui_id, username, user_email, user_firstname, user_lastname, super_user, account_manager, access_system_config, access_external_module_install, admin_rights, access_admin_dashboards) 
VALUES
(2, 'test_user', 'test_user@example.com', 'Test', 'User', 0, 0, 0, 0, 0, 0),
(4, 'test_user2', 'test_user2@example.com', 'Test', 'User', 0, 0, 0, 0, 0, 0),
(6,'test_admin','test_admin@example.com','Test','User', 1, 1, 1, 1, 1, 1);

INSERT INTO redcap_user_rights (project_id, username, expiration, role_id, group_id, lock_record, lock_record_multiform, lock_record_customize, data_export_tool, data_import_tool, data_comparison_tool, data_logging, file_repository, double_data, user_rights, data_access_groups, graphical, reports, design, calendar, data_entry, api_token, api_export, api_import, mobile_app, mobile_app_download_data, record_create, record_rename, record_delete, dts, participants, data_quality_design, data_quality_execute, data_quality_resolution, random_setup, random_dashboard, random_perform, realtime_webservice_mapping, realtime_webservice_adjudicate, external_module_config) 
VALUES 
(1,'site_admin',NULL,NULL,NULL,0,0,0,1,1,1,1,1,0,0,0,1,1,0,1,'',NULL,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0,0,0,NULL),
(2,'site_admin',NULL,NULL,NULL,0,0,0,1,1,1,1,1,0,0,0,1,1,0,1,'',NULL,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0,0,0,NULL),
(3,'site_admin',NULL,NULL,NULL,0,0,0,1,1,1,1,1,0,0,0,1,1,0,1,'',NULL,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0,0,0,NULL),
(4,'site_admin',NULL,NULL,NULL,0,0,0,1,0,1,1,1,0,0,0,1,1,0,1,'',NULL,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,NULL),
(5,'site_admin',NULL,NULL,NULL,0,0,0,1,1,1,1,1,0,0,0,1,1,0,1,'',NULL,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0,0,0,NULL),
(6,'site_admin',NULL,NULL,NULL,0,0,0,1,1,1,1,1,0,0,0,1,1,0,1,'',NULL,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0,0,0,NULL),
(7,'site_admin',NULL,NULL,NULL,0,0,0,1,1,1,1,1,0,0,0,1,1,0,1,'',NULL,0,0,0,0,1,0,0,0,1,0,1,0,1,1,1,0,0,NULL),
(8,'site_admin',NULL,NULL,NULL,0,0,0,1,1,1,1,1,0,0,0,1,1,0,1,'',NULL,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0,0,0,NULL),
(9,'site_admin',NULL,NULL,NULL,0,0,0,1,0,1,1,1,0,0,0,1,1,0,1,'',NULL,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,NULL),
(10,'site_admin',NULL,NULL,NULL,0,0,0,1,0,1,1,1,0,0,0,1,1,0,1,'',NULL,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,NULL),
(11,'site_admin',NULL,NULL,NULL,0,0,0,1,0,1,1,1,0,0,0,1,1,0,1,'',NULL,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,NULL),
(12,'site_admin',NULL,NULL,NULL,0,0,0,1,1,1,1,1,0,0,0,1,1,0,1,'',NULL,0,0,0,0,1,0,0,0,1,0,1,0,0,0,0,0,0,NULL),
(13,'test_user',NULL,NULL,NULL,0,0,0,1,1,1,1,1,0,1,1,1,1,1,1,'[my_first_instrument,1]',NULL,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,0,0,NULL);

UPDATE redcap_config SET value='REDCAP_VERSION_MAGIC_STRING' WHERE field_name='redcap_version';
UPDATE redcap_config SET value='BASE_URL' WHERE field_name='redcap_base_url';
UPDATE redcap_config SET value='table' WHERE field_name='auth_meth_global';
UPDATE redcap_config SET value='sha512' WHERE field_name='password_algo';
UPDATE redcap_config SET value='1' WHERE field_name='is_development_server';

COMMIT;