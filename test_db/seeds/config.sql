
UPDATE redcap_config SET value='REDCAP_VERSION_MAGIC_STRING' WHERE field_name='redcap_version';
UPDATE redcap_config SET value='BASE_URL' WHERE field_name='redcap_base_url';
UPDATE redcap_config SET value='table' WHERE field_name='auth_meth_global';
UPDATE redcap_config SET value='sha512' WHERE field_name='password_algo';
UPDATE redcap_config SET value='0' WHERE field_name='is_development_server';
