START TRANSACTION;

  	USE `REDCAP_DB_NAME`;
  	SET AUTOCOMMIT=0;
  	SET UNIQUE_CHECKS=0;
  	SET FOREIGN_KEY_CHECKS=0;
 
	DELETE FROM redcap_data WHERE project_id = 3;
    DELETE FROM redcap_record_list WHERE project_id = 3;
    DELETE FROM redcap_record_counts WHERE project_id = 3;
    DELETE FROM redcap_user_rights WHERE project_id = 3 AND username IN ('test_admin', 'test_user', 'test_user2');

COMMIT;