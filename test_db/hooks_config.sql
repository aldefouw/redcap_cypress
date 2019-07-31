SET FOREIGN_KEY_CHECKS=0;

UPDATE redcap_config 
SET value = 'REDCAP_HOOKS_PATH' 
WHERE field_name = 'hook_functions_file';

SET FOREIGN_KEY_CHECKS=1;