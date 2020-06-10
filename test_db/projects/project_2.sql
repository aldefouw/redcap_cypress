START TRANSACTION;

  	USE `REDCAP_DB_NAME`;
  	SET AUTOCOMMIT=0;
  	SET UNIQUE_CHECKS=0;
  	SET FOREIGN_KEY_CHECKS=0;

  	INSERT INTO redcap_data (project_id, event_id, record, field_name, value) VALUES (2, 2, 1, 'ethnicity', 1);

COMMIT;