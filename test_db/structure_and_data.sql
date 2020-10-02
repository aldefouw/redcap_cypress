  DROP DATABASE `REDCAP_DB_NAME`;
  CREATE DATABASE `REDCAP_DB_NAME`;
  USE `REDCAP_DB_NAME`;

  SET FOREIGN_KEY_CHECKS=0;
  
  CREATE TABLE `redcap_actions` (
`action_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`survey_id` int(10) DEFAULT NULL,
`action_trigger` enum('MANUAL','ENDOFSURVEY','SURVEYQUESTION') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`action_response` enum('NONE','EMAIL_PRIMARY','EMAIL_SECONDARY','EMAIL_TERTIARY','STOPSURVEY','PROMPT') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`custom_text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`recipient_id` int(10) DEFAULT NULL COMMENT 'FK user_information',
PRIMARY KEY (`action_id`),
UNIQUE KEY `survey_recipient_id` (`survey_id`,`recipient_id`),
KEY `project_id` (`project_id`),
KEY `recipient_id` (`recipient_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_alerts` (
`alert_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`alert_title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`email_deleted` tinyint(1) NOT NULL DEFAULT '0',
`alert_expiration` datetime DEFAULT NULL,
`form_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Instrument Name',
`form_name_event` int(10) DEFAULT NULL COMMENT 'Event ID',
`alert_condition` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Conditional logic',
`ensure_logic_still_true` tinyint(1) NOT NULL DEFAULT '0',
`prevent_piping_identifiers` tinyint(1) NOT NULL DEFAULT '1',
`email_incomplete` tinyint(1) DEFAULT '0' COMMENT 'Send alert for any form status?',
`email_from` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Email From',
`email_to` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Email To',
`email_cc` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Email CC',
`email_bcc` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Email BCC',
`email_subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Subject',
`alert_message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Message',
`email_failed` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`email_attachment_variable` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'REDCap file variables',
`email_attachment1` int(10) DEFAULT NULL,
`email_attachment2` int(10) DEFAULT NULL,
`email_attachment3` int(10) DEFAULT NULL,
`email_attachment4` int(10) DEFAULT NULL,
`email_attachment5` int(10) DEFAULT NULL,
`email_repetitive` tinyint(1) DEFAULT '0' COMMENT 'Re-send alert on form re-save?',
`cron_send_email_on` enum('now','date','time_lag','next_occurrence') COLLATE utf8mb4_unicode_ci DEFAULT 'now' COMMENT 'When to send alert',
`cron_send_email_on_date` datetime DEFAULT NULL COMMENT 'Exact time to send',
`cron_send_email_on_time_lag_days` int(4) DEFAULT NULL,
`cron_send_email_on_time_lag_hours` int(3) DEFAULT NULL,
`cron_send_email_on_time_lag_minutes` int(3) DEFAULT NULL,
`cron_send_email_on_next_day_type` enum('DAY','WEEKDAY','WEEKENDDAY','SUNDAY','MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DAY',
`cron_send_email_on_next_time` time DEFAULT NULL,
`cron_repeat_for` smallint(4) NOT NULL DEFAULT '0' COMMENT 'Repeat every # of days',
`cron_repeat_for_units` enum('DAYS','HOURS','MINUTES') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DAYS',
`email_timestamp_sent` datetime DEFAULT NULL COMMENT 'Time last alert was sent',
`email_sent` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Has at least one alert been sent?',
PRIMARY KEY (`alert_id`),
KEY `alert_expiration` (`alert_expiration`),
KEY `email_attachment1` (`email_attachment1`),
KEY `email_attachment2` (`email_attachment2`),
KEY `email_attachment3` (`email_attachment3`),
KEY `email_attachment4` (`email_attachment4`),
KEY `email_attachment5` (`email_attachment5`),
KEY `form_name_event` (`form_name_event`),
KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_alerts_recurrence` (
`aq_id` int(10) NOT NULL AUTO_INCREMENT,
`alert_id` int(10) DEFAULT NULL,
`creation_date` datetime DEFAULT NULL,
`record` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`event_id` int(10) DEFAULT NULL,
`instrument` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`instance` smallint(4) DEFAULT NULL,
`send_option` enum('now','date','time_lag','next_occurrence') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'now',
`times_sent` smallint(4) DEFAULT NULL,
`last_sent` datetime DEFAULT NULL,
`status` enum('IDLE','QUEUED','SENDING') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'IDLE',
`first_send_time` datetime DEFAULT NULL,
`next_send_time` datetime DEFAULT NULL,
PRIMARY KEY (`aq_id`),
UNIQUE KEY `alert_id_record_instrument_instance` (`alert_id`,`record`,`event_id`,`instrument`,`instance`),
KEY `creation_date` (`creation_date`),
KEY `event_id` (`event_id`),
KEY `first_send_time` (`first_send_time`),
KEY `last_sent` (`last_sent`),
KEY `next_send_time_alert_id_status` (`next_send_time`,`alert_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_alerts_sent` (
`alert_sent_id` int(10) NOT NULL AUTO_INCREMENT,
`alert_id` int(10) NOT NULL,
`record` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`event_id` int(10) DEFAULT NULL,
`instrument` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`instance` smallint(4) DEFAULT '1',
`last_sent` datetime DEFAULT NULL,
PRIMARY KEY (`alert_sent_id`),
UNIQUE KEY `alert_id_record_event_instrument_instance` (`alert_id`,`record`,`event_id`,`instrument`,`instance`),
KEY `event_id_record_alert_id` (`event_id`,`record`,`alert_id`),
KEY `last_sent` (`last_sent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_alerts_sent_log` (
`alert_sent_log_id` int(10) NOT NULL AUTO_INCREMENT,
`alert_sent_id` int(10) DEFAULT NULL,
`time_sent` datetime DEFAULT NULL,
`email_from` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`email_to` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`email_cc` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`email_bcc` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`subject` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`attachment_names` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`alert_sent_log_id`),
KEY `alert_sent_id_time_sent` (`alert_sent_id`,`time_sent`),
KEY `email_from` (`email_from`),
KEY `time_sent` (`time_sent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_auth` (
`username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
`password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Hash of user''s password',
`password_salt` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Unique random salt for password',
`legacy_hash` int(1) NOT NULL DEFAULT '0' COMMENT 'Using older legacy hash for password storage?',
`temp_pwd` int(1) NOT NULL DEFAULT '0' COMMENT 'Flag to force user to re-enter password',
`password_question` int(10) DEFAULT NULL COMMENT 'PK of question',
`password_answer` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Hashed answer to password recovery question',
`password_question_reminder` datetime DEFAULT NULL COMMENT 'When to prompt user to set up security question',
`password_reset_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`username`),
UNIQUE KEY `password_reset_key` (`password_reset_key`),
KEY `password_question` (`password_question`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_auth_history` (
`username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
`password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
`timestamp` datetime DEFAULT NULL,
KEY `username_password` (`username`(191),`password`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores last 5 passwords';

CREATE TABLE `redcap_auth_questions` (
`qid` int(10) NOT NULL AUTO_INCREMENT,
`question` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`qid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_config` (
`field_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
`value` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores global settings';

CREATE TABLE `redcap_crons` (
`cron_id` int(10) NOT NULL AUTO_INCREMENT,
`cron_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Unique name for each job',
`external_module_id` int(11) DEFAULT NULL,
`cron_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`cron_enabled` enum('ENABLED','DISABLED') COLLATE utf8mb4_unicode_ci DEFAULT 'ENABLED',
`cron_frequency` int(10) DEFAULT NULL COMMENT 'seconds',
`cron_max_run_time` int(10) DEFAULT NULL COMMENT 'max # seconds a cron should run',
`cron_instances_max` int(2) NOT NULL DEFAULT '1' COMMENT 'Number of instances that can run simultaneously',
`cron_instances_current` int(2) NOT NULL DEFAULT '0' COMMENT 'Current number of instances running',
`cron_last_run_start` datetime DEFAULT NULL,
`cron_last_run_end` datetime DEFAULT NULL,
`cron_times_failed` int(2) NOT NULL DEFAULT '0' COMMENT 'After X failures, set as Disabled',
`cron_external_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'URL to call for custom jobs not defined by REDCap',
PRIMARY KEY (`cron_id`),
UNIQUE KEY `cron_name_module_id` (`cron_name`,`external_module_id`),
KEY `external_module_id` (`external_module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='List of all jobs to be run by universal cron job';

CREATE TABLE `redcap_crons_history` (
`ch_id` int(10) NOT NULL AUTO_INCREMENT,
`cron_id` int(10) DEFAULT NULL,
`cron_run_start` datetime DEFAULT NULL,
`cron_run_end` datetime DEFAULT NULL,
`cron_run_status` enum('PROCESSING','COMPLETED','FAILED') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`cron_info` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Any pertinent info that might be logged',
PRIMARY KEY (`ch_id`),
KEY `cron_id` (`cron_id`),
KEY `cron_run_end` (`cron_run_end`),
KEY `cron_run_start` (`cron_run_start`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='History of all jobs run by universal cron job';

CREATE TABLE `redcap_dashboard_ip_location_cache` (
`ip` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
`latitude` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`longitude` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`city` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`region` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`country` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_data` (
`project_id` int(10) NOT NULL DEFAULT '0',
`event_id` int(10) DEFAULT NULL,
`record` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`field_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`instance` smallint(4) DEFAULT NULL,
KEY `event_id_instance` (`event_id`,`instance`),
KEY `proj_record_field` (`project_id`,`record`,`field_name`),
KEY `project_field` (`project_id`,`field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_data_access_groups` (
`group_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`group_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`group_id`),
KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_data_dictionaries` (
`dd_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`doc_id` int(10) DEFAULT NULL,
`ui_id` int(10) DEFAULT NULL,
PRIMARY KEY (`dd_id`),
KEY `doc_id` (`doc_id`),
KEY `project_id` (`project_id`),
KEY `ui_id` (`ui_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_data_quality_resolutions` (
`res_id` int(10) NOT NULL AUTO_INCREMENT,
`status_id` int(10) DEFAULT NULL COMMENT 'FK from data_quality_status',
`ts` datetime DEFAULT NULL COMMENT 'Date/time added',
`user_id` int(10) DEFAULT NULL COMMENT 'Current user',
`response_requested` int(1) NOT NULL DEFAULT '0' COMMENT 'Is a response requested?',
`response` enum('DATA_MISSING','TYPOGRAPHICAL_ERROR','CONFIRMED_CORRECT','WRONG_SOURCE','OTHER') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Response category if user responded to query',
`comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Text for comment',
`current_query_status` enum('OPEN','CLOSED','VERIFIED','DEVERIFIED') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Current query status of thread',
`upload_doc_id` int(10) DEFAULT NULL COMMENT 'FK of uploaded document',
`field_comment_edited` int(1) NOT NULL DEFAULT '0' COMMENT 'Denote if field comment was edited',
PRIMARY KEY (`res_id`),
KEY `doc_id` (`upload_doc_id`),
KEY `status_id` (`status_id`),
KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_data_quality_rules` (
`rule_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`rule_order` int(3) DEFAULT '1',
`rule_name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`rule_logic` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`real_time_execute` int(1) NOT NULL DEFAULT '0' COMMENT 'Run in real-time on data entry forms?',
PRIMARY KEY (`rule_id`),
KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_data_quality_status` (
`status_id` int(10) NOT NULL AUTO_INCREMENT,
`rule_id` int(10) DEFAULT NULL COMMENT 'FK from data_quality_rules table',
`pd_rule_id` int(2) DEFAULT NULL COMMENT 'Name of pre-defined rules',
`non_rule` int(1) DEFAULT NULL COMMENT '1 for non-rule, else NULL',
`project_id` int(11) DEFAULT NULL,
`record` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`event_id` int(10) DEFAULT NULL,
`field_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Only used if field-level is required',
`repeat_instrument` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`instance` smallint(4) NOT NULL DEFAULT '1',
`status` int(2) DEFAULT NULL COMMENT 'Current status of discrepancy',
`exclude` int(1) NOT NULL DEFAULT '0' COMMENT 'Hide from results',
`query_status` enum('OPEN','CLOSED','VERIFIED','DEVERIFIED') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Status of data query',
`assigned_user_id` int(10) DEFAULT NULL COMMENT 'UI ID of user assigned to query',
PRIMARY KEY (`status_id`),
UNIQUE KEY `nonrule_proj_record_event_field` (`non_rule`,`project_id`,`record`,`event_id`,`field_name`,`instance`),
UNIQUE KEY `pd_rule_proj_record_event_field` (`pd_rule_id`,`record`,`event_id`,`field_name`,`project_id`,`instance`),
UNIQUE KEY `rule_record_event` (`rule_id`,`record`,`event_id`,`instance`),
KEY `assigned_user_id` (`assigned_user_id`),
KEY `event_id` (`event_id`),
KEY `pd_rule_proj_record_event` (`pd_rule_id`,`record`,`event_id`,`project_id`,`instance`),
KEY `project_query_status` (`project_id`,`query_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_ddp_log_view` (
`ml_id` int(10) NOT NULL AUTO_INCREMENT,
`time_viewed` datetime DEFAULT NULL COMMENT 'Time the data was displayed to the user',
`user_id` int(10) DEFAULT NULL COMMENT 'PK from user_information table',
`project_id` int(10) DEFAULT NULL,
`source_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ID value from source system (e.g. MRN)',
PRIMARY KEY (`ml_id`),
KEY `project_id` (`project_id`),
KEY `source_id` (`source_id`(191)),
KEY `time_viewed` (`time_viewed`),
KEY `user_project` (`user_id`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_ddp_log_view_data` (
`ml_id` int(10) DEFAULT NULL COMMENT 'PK from ddp_log_view table',
`source_field` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Field name from source system',
`source_timestamp` datetime DEFAULT NULL COMMENT 'Date of service from source system',
`md_id` int(10) DEFAULT NULL COMMENT 'PK from ddp_records_data table',
KEY `md_id` (`md_id`),
KEY `ml_id` (`ml_id`),
KEY `source_field` (`source_field`),
KEY `source_timestamp` (`source_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_ddp_mapping` (
`map_id` int(10) NOT NULL AUTO_INCREMENT,
`external_source_field_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Unique name of field mapped from external data source',
`is_record_identifier` int(1) DEFAULT NULL COMMENT '1=Yes, Null=No',
`project_id` int(10) DEFAULT NULL,
`event_id` int(10) DEFAULT NULL,
`field_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`temporal_field` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'REDCap date field',
`preselect` enum('MIN','MAX','FIRST','LAST','NEAR') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Preselect a source value for temporal fields only',
PRIMARY KEY (`map_id`),
UNIQUE KEY `project_field_event_source` (`project_id`,`event_id`,`field_name`,`external_source_field_name`),
UNIQUE KEY `project_identifier` (`project_id`,`is_record_identifier`),
KEY `event_id` (`event_id`),
KEY `external_source_field_name` (`external_source_field_name`),
KEY `field_name` (`field_name`),
KEY `temporal_field` (`temporal_field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_ddp_preview_fields` (
`project_id` int(10) NOT NULL,
`field1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`field2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`field3` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`field4` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`field5` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_ddp_records` (
`mr_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`record` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`updated_at` datetime DEFAULT NULL COMMENT 'Time of last data fetch',
`item_count` int(10) DEFAULT NULL COMMENT 'New item count (as of last viewing)',
`fetch_status` enum('QUEUED','FETCHING') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Current status of data fetch for this record',
`future_date_count` int(10) NOT NULL DEFAULT '0' COMMENT 'Count of datetime reference fields with values in the future',
PRIMARY KEY (`mr_id`),
UNIQUE KEY `project_record` (`project_id`,`record`),
KEY `project_id_fetch_status` (`fetch_status`,`project_id`),
KEY `project_updated_at` (`updated_at`,`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_ddp_records_data` (
`md_id` int(10) NOT NULL AUTO_INCREMENT,
`map_id` int(10) NOT NULL COMMENT 'PK from ddp_mapping table',
`mr_id` int(10) DEFAULT NULL COMMENT 'PK from ddp_records table',
`source_timestamp` datetime DEFAULT NULL COMMENT 'Date of service from source system',
`source_value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Encrypted data value from source system',
`source_value2` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`adjudicated` int(1) NOT NULL DEFAULT '0' COMMENT 'Has source value been adjudicated?',
`exclude` int(1) NOT NULL DEFAULT '0' COMMENT 'Has source value been excluded?',
PRIMARY KEY (`md_id`),
KEY `map_id_mr_id_timestamp_value` (`map_id`,`mr_id`,`source_timestamp`,`source_value2`(128)),
KEY `map_id_timestamp` (`map_id`,`source_timestamp`),
KEY `mr_id_adjudicated` (`mr_id`,`adjudicated`),
KEY `mr_id_exclude` (`mr_id`,`exclude`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Cached data values from web service';

CREATE TABLE `redcap_docs` (
`docs_id` int(11) NOT NULL AUTO_INCREMENT,
`project_id` int(10) NOT NULL DEFAULT '0',
`docs_date` date DEFAULT NULL,
`docs_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`docs_size` double DEFAULT NULL,
`docs_type` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`docs_file` longblob DEFAULT NULL,
`docs_comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`docs_rights` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`export_file` int(1) NOT NULL DEFAULT '0',
`temp` int(1) NOT NULL DEFAULT '0' COMMENT 'Is file only a temp file?',
PRIMARY KEY (`docs_id`),
KEY `docs_name` (`docs_name`(191)),
KEY `project_id_comment` (`project_id`,`docs_comment`(190)),
KEY `project_id_export_file_temp` (`project_id`,`export_file`,`temp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_docs_to_edocs` (
`docs_id` int(11) NOT NULL COMMENT 'PK redcap_docs',
`doc_id` int(11) NOT NULL COMMENT 'PK redcap_edocs_metadata',
PRIMARY KEY (`docs_id`,`doc_id`),
KEY `doc_id` (`doc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_edocs_metadata` (
`doc_id` int(10) NOT NULL AUTO_INCREMENT,
`stored_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'stored name',
`mime_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`doc_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`doc_size` int(10) DEFAULT NULL,
`file_extension` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`gzipped` int(1) NOT NULL DEFAULT '0' COMMENT 'Is file gzip compressed?',
`project_id` int(10) DEFAULT NULL,
`stored_date` datetime DEFAULT NULL COMMENT 'stored date',
`delete_date` datetime DEFAULT NULL COMMENT 'date deleted',
`date_deleted_server` datetime DEFAULT NULL COMMENT 'When really deleted from server',
PRIMARY KEY (`doc_id`),
KEY `date_deleted` (`delete_date`,`date_deleted_server`),
KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_ehr_access_tokens` (
`patient` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`mrn` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'If different from patient id',
`token_owner` int(11) DEFAULT NULL COMMENT 'REDCap User ID',
`expiration` datetime DEFAULT NULL,
`access_token` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`refresh_token` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`permission_Patient` tinyint(1) DEFAULT NULL,
`permission_Observation` tinyint(1) DEFAULT NULL,
`permission_Condition` tinyint(1) DEFAULT NULL,
`permission_MedicationOrder` tinyint(1) DEFAULT NULL,
`permission_AllergyIntolerance` tinyint(1) DEFAULT NULL,
UNIQUE KEY `token_owner_mrn` (`token_owner`,`mrn`),
UNIQUE KEY `token_owner_patient` (`token_owner`,`patient`),
KEY `access_token` (`access_token`(190)),
KEY `expiration` (`expiration`),
KEY `mrn` (`mrn`),
KEY `patient` (`patient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_ehr_datamart_revisions` (
`id` int(11) unsigned NOT NULL AUTO_INCREMENT,
`project_id` int(11) DEFAULT NULL,
`request_id` int(11) DEFAULT NULL,
`user_id` int(11) DEFAULT NULL,
`mrns` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`date_min` date DEFAULT NULL,
`date_max` date DEFAULT NULL,
`fields` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`approved` tinyint(1) NOT NULL DEFAULT '0',
`is_deleted` tinyint(1) NOT NULL DEFAULT '0',
`created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`executed_at` timestamp NULL DEFAULT NULL,
PRIMARY KEY (`id`),
UNIQUE KEY `request_id` (`request_id`),
KEY `project_id` (`project_id`),
KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_ehr_user_map` (
`ehr_username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`redcap_userid` int(11) DEFAULT NULL,
UNIQUE KEY `ehr_username` (`ehr_username`),
UNIQUE KEY `redcap_userid` (`redcap_userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_ehr_user_projects` (
`project_id` int(11) DEFAULT NULL,
`redcap_userid` int(11) DEFAULT NULL,
UNIQUE KEY `project_id_userid` (`project_id`,`redcap_userid`),
KEY `redcap_userid` (`redcap_userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_esignatures` (
`esign_id` int(11) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`record` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`event_id` int(10) DEFAULT NULL,
`form_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`instance` smallint(4) NOT NULL DEFAULT '1',
`username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`timestamp` datetime DEFAULT NULL,
PRIMARY KEY (`esign_id`),
UNIQUE KEY `proj_rec_event_form_instance` (`project_id`,`record`,`event_id`,`form_name`,`instance`),
KEY `event_id` (`event_id`),
KEY `username` (`username`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_events_arms` (
`arm_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) NOT NULL DEFAULT '0',
`arm_num` int(2) NOT NULL DEFAULT '1',
`arm_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Arm 1',
PRIMARY KEY (`arm_id`),
UNIQUE KEY `proj_arm_num` (`project_id`,`arm_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_events_calendar` (
`cal_id` int(10) NOT NULL AUTO_INCREMENT,
`record` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_id` int(10) DEFAULT NULL,
`event_id` int(10) DEFAULT NULL,
`baseline_date` date DEFAULT NULL,
`group_id` int(10) DEFAULT NULL,
`event_date` date DEFAULT NULL,
`event_time` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'HH:MM',
`event_status` int(2) DEFAULT NULL COMMENT 'NULL=Ad Hoc, 0=Due Date, 1=Scheduled, 2=Confirmed, 3=Cancelled, 4=No Show',
`note_type` int(2) DEFAULT NULL,
`notes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`extra_notes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`cal_id`),
KEY `event_id` (`event_id`),
KEY `group_id` (`group_id`),
KEY `project_date` (`project_id`,`event_date`),
KEY `project_record` (`project_id`,`record`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Calendar Data';

CREATE TABLE `redcap_events_forms` (
`event_id` int(10) NOT NULL DEFAULT '0',
`form_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
UNIQUE KEY `event_form` (`event_id`,`form_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_events_metadata` (
`event_id` int(10) NOT NULL AUTO_INCREMENT,
`arm_id` int(10) NOT NULL DEFAULT '0' COMMENT 'FK for events_arms',
`day_offset` float NOT NULL DEFAULT '0' COMMENT 'Days from Start Date',
`offset_min` float NOT NULL DEFAULT '0',
`offset_max` float NOT NULL DEFAULT '0',
`descrip` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Event 1' COMMENT 'Event Name',
`external_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`custom_event_label` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`event_id`),
KEY `arm_dayoffset_descrip` (`arm_id`,`day_offset`,`descrip`),
KEY `day_offset` (`day_offset`),
KEY `descrip` (`descrip`),
KEY `external_id` (`external_id`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_events_repeat` (
`event_id` int(10) DEFAULT NULL,
`form_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`custom_repeat_form_label` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
UNIQUE KEY `event_id_form` (`event_id`,`form_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_external_links` (
`ext_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`link_order` int(5) NOT NULL DEFAULT '1',
`link_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`link_label` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`open_new_window` int(10) NOT NULL DEFAULT '0',
`link_type` enum('LINK','POST_AUTHKEY','REDCAP_PROJECT') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'LINK',
`user_access` enum('ALL','DAG','SELECTED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ALL',
`append_record_info` int(1) NOT NULL DEFAULT '0' COMMENT 'Append record and event to URL',
`append_pid` int(1) NOT NULL DEFAULT '0' COMMENT 'Append project_id to URL',
`link_to_project_id` int(10) DEFAULT NULL,
PRIMARY KEY (`ext_id`),
KEY `link_to_project_id` (`link_to_project_id`),
KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_external_links_dags` (
`ext_id` int(11) NOT NULL AUTO_INCREMENT,
`group_id` int(10) NOT NULL DEFAULT '0',
PRIMARY KEY (`ext_id`,`group_id`),
KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_external_links_exclude_projects` (
`ext_id` int(11) NOT NULL AUTO_INCREMENT,
`project_id` int(10) NOT NULL DEFAULT '0',
PRIMARY KEY (`ext_id`,`project_id`),
KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Projects to exclude for global external links';

CREATE TABLE `redcap_external_links_users` (
`ext_id` int(11) NOT NULL AUTO_INCREMENT,
`username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
PRIMARY KEY (`ext_id`,`username`),
KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_external_module_settings` (
`external_module_id` int(11) NOT NULL,
`project_id` int(11) DEFAULT NULL,
`key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
`type` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'string',
`value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
KEY `external_module_id` (`external_module_id`),
KEY `key` (`key`(191)),
KEY `project_id` (`project_id`),
KEY `value` (`value`(190))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_external_modules` (
`external_module_id` int(11) NOT NULL AUTO_INCREMENT,
`directory_prefix` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
PRIMARY KEY (`external_module_id`),
UNIQUE KEY `directory_prefix` (`directory_prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_external_modules_downloads` (
`module_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
`module_id` int(11) DEFAULT NULL,
`time_downloaded` datetime DEFAULT NULL,
`time_deleted` datetime DEFAULT NULL,
PRIMARY KEY (`module_name`),
UNIQUE KEY `module_id` (`module_id`),
KEY `time_deleted` (`time_deleted`),
KEY `time_downloaded` (`time_downloaded`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Modules downloaded from the external modules repository';

CREATE TABLE `redcap_external_modules_log` (
`log_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
`timestamp` datetime NOT NULL,
`ui_id` int(11) DEFAULT NULL,
`ip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`external_module_id` int(11) DEFAULT NULL,
`project_id` int(11) DEFAULT NULL,
`record` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`message` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
PRIMARY KEY (`log_id`),
KEY `external_module_id` (`external_module_id`),
KEY `message` (`message`(190)),
KEY `record` (`record`),
KEY `redcap_log_redcap_projects_record` (`project_id`,`record`),
KEY `timestamp` (`timestamp`),
KEY `ui_id` (`ui_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_external_modules_log_parameters` (
`log_id` bigint(20) unsigned NOT NULL,
`name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
`value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
PRIMARY KEY (`log_id`,`name`(191)),
KEY `name` (`name`(191)),
KEY `value` (`value`(190))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_folders` (
`folder_id` int(10) NOT NULL AUTO_INCREMENT,
`ui_id` int(10) DEFAULT NULL,
`name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`position` int(10) DEFAULT NULL,
`foreground` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`background` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`collapsed` tinyint(1) NOT NULL DEFAULT '0',
PRIMARY KEY (`folder_id`),
UNIQUE KEY `ui_id_name_uniq` (`ui_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_folders_projects` (
`ui_id` int(10) DEFAULT NULL,
`project_id` int(10) DEFAULT NULL,
`folder_id` int(10) DEFAULT NULL,
UNIQUE KEY `ui_id_project_folder` (`ui_id`,`project_id`,`folder_id`),
KEY `folder_id` (`folder_id`),
KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_history_size` (
`date` date NOT NULL DEFAULT '1000-01-01',
`size_db` float DEFAULT NULL COMMENT 'MB',
`size_files` float DEFAULT NULL COMMENT 'MB',
PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Space usage of REDCap database and uploaded files.';

CREATE TABLE `redcap_history_version` (
`date` date NOT NULL DEFAULT '1000-01-01',
`redcap_version` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='History of REDCap versions installed on this server.';

CREATE TABLE `redcap_instrument_zip` (
`iza_id` int(10) NOT NULL DEFAULT '0',
`instrument_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
`upload_count` smallint(5) NOT NULL DEFAULT '1',
PRIMARY KEY (`iza_id`,`instrument_id`),
KEY `instrument_id` (`instrument_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_instrument_zip_authors` (
`iza_id` int(10) NOT NULL AUTO_INCREMENT,
`author_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`iza_id`),
UNIQUE KEY `author_name` (`author_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_instrument_zip_origins` (
`server_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
`upload_count` smallint(5) NOT NULL DEFAULT '1',
PRIMARY KEY (`server_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_ip_banned` (
`ip` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
`time_of_ban` timestamp NULL DEFAULT NULL,
PRIMARY KEY (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_ip_cache` (
`ip_hash` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
`timestamp` timestamp NULL DEFAULT NULL,
KEY `ip_hash` (`ip_hash`),
KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_library_map` (
`project_id` int(10) NOT NULL DEFAULT '0',
`form_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
`type` int(11) NOT NULL DEFAULT '0' COMMENT '1 = Downloaded; 2 = Uploaded',
`library_id` int(10) NOT NULL DEFAULT '0',
`upload_timestamp` datetime DEFAULT NULL,
`acknowledgement` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`acknowledgement_cache` datetime DEFAULT NULL,
`promis_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PROMIS instrument key',
`scoring_type` enum('EACH_ITEM','END_ONLY') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'If has scoring, what type?',
`battery` tinyint(1) NOT NULL DEFAULT '0',
`promis_battery_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'PROMIS battery key',
PRIMARY KEY (`project_id`,`form_name`,`type`,`library_id`),
KEY `form_name` (`form_name`),
KEY `library_id` (`library_id`),
KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_locking_data` (
`ld_id` int(11) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`record` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`event_id` int(10) DEFAULT NULL,
`form_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`instance` smallint(4) NOT NULL DEFAULT '1',
`username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`timestamp` datetime DEFAULT NULL,
PRIMARY KEY (`ld_id`),
UNIQUE KEY `proj_rec_event_form_instance` (`project_id`,`record`,`event_id`,`form_name`,`instance`),
KEY `event_id` (`event_id`),
KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_locking_labels` (
`ll_id` int(11) NOT NULL AUTO_INCREMENT,
`project_id` int(11) DEFAULT NULL,
`form_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`label` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`display` int(1) NOT NULL DEFAULT '1',
`display_esignature` int(1) NOT NULL DEFAULT '0',
PRIMARY KEY (`ll_id`),
UNIQUE KEY `project_form` (`project_id`,`form_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_log_event` (
`log_event_id` int(11) NOT NULL AUTO_INCREMENT,
`project_id` int(10) NOT NULL DEFAULT '0',
`ts` bigint(14) DEFAULT NULL,
`user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`ip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`page` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`event` enum('UPDATE','INSERT','DELETE','SELECT','ERROR','LOGIN','LOGOUT','OTHER','DATA_EXPORT','DOC_UPLOAD','DOC_DELETE','MANAGE','LOCK_RECORD','ESIGNATURE') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`object_type` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`sql_log` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pk` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`event_id` int(10) DEFAULT NULL,
`data_values` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`description` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`legacy` int(1) NOT NULL DEFAULT '0',
`change_reason` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`log_event_id`),
KEY `description` (`description`),
KEY `event_project` (`event`,`project_id`),
KEY `object_type` (`object_type`),
KEY `pk` (`pk`(191)),
KEY `ts` (`ts`),
KEY `user` (`user`(191)),
KEY `user_project` (`project_id`,`user`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_log_view` (
`log_view_id` int(11) NOT NULL AUTO_INCREMENT,
`ts` timestamp NULL DEFAULT NULL,
`user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`event` enum('LOGIN_SUCCESS','LOGIN_FAIL','LOGOUT','PAGE_VIEW') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`ip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`browser_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`browser_version` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`full_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`page` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_id` int(10) DEFAULT NULL,
`event_id` int(10) DEFAULT NULL,
`record` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`form_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`miscellaneous` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`session_id` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`log_view_id`),
KEY `browser_name` (`browser_name`(191)),
KEY `browser_version` (`browser_version`(191)),
KEY `event` (`event`),
KEY `ip` (`ip`),
KEY `page` (`page`(191)),
KEY `project_event_record` (`project_id`,`event_id`,`record`(191)),
KEY `session_id` (`session_id`),
KEY `ts` (`ts`),
KEY `user_project` (`user`(191),`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_log_view_requests` (
`lvr_id` int(10) NOT NULL AUTO_INCREMENT,
`log_view_id` int(10) DEFAULT NULL COMMENT 'FK from redcap_log_view',
`mysql_process_id` int(10) DEFAULT NULL COMMENT 'Process ID for MySQL',
`php_process_id` int(10) DEFAULT NULL COMMENT 'Process ID for PHP',
`script_execution_time` float DEFAULT NULL COMMENT 'Total PHP script execution time (seconds)',
`is_ajax` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is request an AJAX request?',
`ui_id` int(11) DEFAULT NULL COMMENT 'FK from redcap_user_information',
PRIMARY KEY (`lvr_id`),
UNIQUE KEY `log_view_id` (`log_view_id`),
UNIQUE KEY `log_view_id_time_ui_id` (`log_view_id`,`script_execution_time`,`ui_id`),
KEY `mysql_process_id` (`mysql_process_id`),
KEY `php_process_id` (`php_process_id`),
KEY `ui_id` (`ui_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_messages` (
`message_id` int(10) NOT NULL AUTO_INCREMENT,
`thread_id` int(10) DEFAULT NULL COMMENT 'Thread that message belongs to (FK from redcap_messages_threads)',
`sent_time` datetime DEFAULT NULL COMMENT 'Time message was sent',
`author_user_id` int(10) DEFAULT NULL COMMENT 'Author of message (FK from redcap_user_information)',
`message_body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'The message itself',
`attachment_doc_id` int(10) DEFAULT NULL COMMENT 'doc_id if there is an attachment (FK from redcap_edocs_metadata)',
`stored_url` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`message_id`),
KEY `attachment_doc_id` (`attachment_doc_id`),
KEY `author_user_id` (`author_user_id`),
KEY `message_body` (`message_body`(190)),
KEY `sent_time` (`sent_time`),
KEY `thread_id` (`thread_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_messages_recipients` (
`recipient_id` int(10) NOT NULL AUTO_INCREMENT,
`thread_id` int(10) DEFAULT NULL COMMENT 'Thread that recipient belongs to (FK from redcap_messages_threads)',
`recipient_user_id` int(10) DEFAULT NULL COMMENT 'Individual recipient in thread (FK from redcap_user_information)',
`all_users` tinyint(1) DEFAULT '0' COMMENT 'Set if recipients = ALL USERS',
`prioritize` tinyint(1) NOT NULL DEFAULT '0',
`conv_leader` tinyint(1) NOT NULL DEFAULT '0',
PRIMARY KEY (`recipient_id`),
UNIQUE KEY `recipient_user_thread_id` (`recipient_user_id`,`thread_id`),
KEY `thread_id_users` (`thread_id`,`all_users`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_messages_status` (
`status_id` int(10) NOT NULL AUTO_INCREMENT,
`message_id` int(10) DEFAULT NULL COMMENT 'FK from redcap_messages',
`recipient_id` int(10) DEFAULT NULL COMMENT 'Individual recipient in thread (FK from redcap_messages_recipients)',
`recipient_user_id` int(10) DEFAULT NULL COMMENT 'Individual recipient in thread (FK from redcap_user_information)',
`urgent` tinyint(1) NOT NULL DEFAULT '0',
PRIMARY KEY (`status_id`),
KEY `message_id` (`message_id`),
KEY `recipient_id` (`recipient_id`),
KEY `recipient_user_id` (`recipient_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_messages_threads` (
`thread_id` int(10) NOT NULL AUTO_INCREMENT,
`type` enum('CHANNEL','NOTIFICATION','CONVERSATION') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Type of entity',
`channel_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Only for channels',
`invisible` tinyint(1) NOT NULL DEFAULT '0',
`archived` tinyint(1) NOT NULL DEFAULT '0',
`project_id` int(11) DEFAULT NULL COMMENT 'Associated project',
PRIMARY KEY (`thread_id`),
KEY `project_id` (`project_id`),
KEY `type_channel` (`type`,`channel_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_metadata` (
`project_id` int(10) NOT NULL DEFAULT '0',
`field_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
`field_phi` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`form_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`form_menu_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`field_order` float DEFAULT NULL,
`field_units` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_preceding_header` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_label` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_enum` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_note` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_validation_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_validation_min` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_validation_max` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_validation_checktype` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`branching_logic` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`field_req` int(1) NOT NULL DEFAULT '0',
`edoc_id` int(10) DEFAULT NULL COMMENT 'image/file attachment',
`edoc_display_img` int(1) NOT NULL DEFAULT '0',
`custom_alignment` enum('LH','LV','RH','RV') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'RV = NULL = default',
`stop_actions` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`question_num` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`grid_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Unique name of grid group',
`grid_rank` int(1) NOT NULL DEFAULT '0',
`misc` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Miscellaneous field attributes',
`video_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`video_display_inline` tinyint(1) NOT NULL DEFAULT '0',
PRIMARY KEY (`project_id`,`field_name`),
KEY `edoc_id` (`edoc_id`),
KEY `field_name` (`field_name`),
KEY `project_id_fieldorder` (`project_id`,`field_order`),
KEY `project_id_form` (`project_id`,`form_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_metadata_archive` (
`project_id` int(10) NOT NULL DEFAULT '0',
`field_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
`field_phi` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`form_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`form_menu_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`field_order` float DEFAULT NULL,
`field_units` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_preceding_header` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_label` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_enum` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_note` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_validation_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_validation_min` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_validation_max` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_validation_checktype` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`branching_logic` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`field_req` int(1) NOT NULL DEFAULT '0',
`edoc_id` int(10) DEFAULT NULL COMMENT 'image/file attachment',
`edoc_display_img` int(1) NOT NULL DEFAULT '0',
`custom_alignment` enum('LH','LV','RH','RV') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'RV = NULL = default',
`stop_actions` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`question_num` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`grid_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Unique name of grid group',
`grid_rank` int(1) NOT NULL DEFAULT '0',
`misc` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Miscellaneous field attributes',
`video_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`video_display_inline` tinyint(1) NOT NULL DEFAULT '0',
`pr_id` int(10) DEFAULT NULL,
UNIQUE KEY `project_field_prid` (`project_id`,`field_name`,`pr_id`),
KEY `edoc_id` (`edoc_id`),
KEY `field_name` (`field_name`),
KEY `pr_id` (`pr_id`),
KEY `project_id_form` (`project_id`,`form_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_metadata_prod_revisions` (
`pr_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) NOT NULL DEFAULT '0',
`ui_id_requester` int(10) DEFAULT NULL,
`ui_id_approver` int(10) DEFAULT NULL,
`ts_req_approval` datetime DEFAULT NULL,
`ts_approved` datetime DEFAULT NULL,
PRIMARY KEY (`pr_id`),
KEY `project_approved` (`project_id`,`ts_approved`),
KEY `project_user` (`project_id`,`ui_id_requester`),
KEY `ui_id_approver` (`ui_id_approver`),
KEY `ui_id_requester` (`ui_id_requester`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_metadata_temp` (
`project_id` int(10) NOT NULL DEFAULT '0',
`field_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
`field_phi` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`form_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`form_menu_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`field_order` float DEFAULT NULL,
`field_units` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_preceding_header` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_label` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_enum` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_note` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_validation_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_validation_min` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_validation_max` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`element_validation_checktype` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`branching_logic` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`field_req` int(1) NOT NULL DEFAULT '0',
`edoc_id` int(10) DEFAULT NULL COMMENT 'image/file attachment',
`edoc_display_img` int(1) NOT NULL DEFAULT '0',
`custom_alignment` enum('LH','LV','RH','RV') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'RV = NULL = default',
`stop_actions` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`question_num` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`grid_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Unique name of grid group',
`grid_rank` int(1) NOT NULL DEFAULT '0',
`misc` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Miscellaneous field attributes',
`video_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`video_display_inline` tinyint(1) NOT NULL DEFAULT '0',
PRIMARY KEY (`project_id`,`field_name`),
KEY `edoc_id` (`edoc_id`),
KEY `field_name` (`field_name`),
KEY `project_id_form` (`project_id`,`form_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_mobile_app_devices` (
`device_id` int(10) NOT NULL AUTO_INCREMENT,
`uuid` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_id` int(10) DEFAULT NULL,
`nickname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`revoked` tinyint(4) NOT NULL DEFAULT '0',
PRIMARY KEY (`device_id`),
UNIQUE KEY `uuid_project_id` (`uuid`,`project_id`),
KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_mobile_app_files` (
`af_id` int(10) NOT NULL AUTO_INCREMENT,
`doc_id` int(10) NOT NULL,
`type` enum('ESCAPE_HATCH','LOGGING') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`user_id` int(10) DEFAULT NULL,
`device_id` int(10) DEFAULT NULL,
PRIMARY KEY (`af_id`),
KEY `device_id` (`device_id`),
KEY `doc_id` (`doc_id`),
KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_mobile_app_log` (
`mal_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`ui_id` int(11) DEFAULT NULL,
`log_event_id` int(10) DEFAULT NULL,
`device_id` int(10) DEFAULT NULL,
`event` enum('INIT_PROJECT','INIT_DOWNLOAD_DATA','INIT_DOWNLOAD_DATA_PARTIAL','REINIT_PROJECT','REINIT_DOWNLOAD_DATA','REINIT_DOWNLOAD_DATA_PARTIAL','SYNC_DATA') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`longitude` double DEFAULT NULL,
`latitude` double DEFAULT NULL,
PRIMARY KEY (`mal_id`),
KEY `device_id` (`device_id`),
KEY `log_event_id` (`log_event_id`),
KEY `project_id_event` (`project_id`,`event`),
KEY `ui_id` (`ui_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_new_record_cache` (
`project_id` int(10) NOT NULL DEFAULT '0',
`event_id` int(10) DEFAULT NULL,
`arm_id` int(11) DEFAULT NULL,
`record` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`creation_time` datetime DEFAULT NULL,
UNIQUE KEY `proj_record_event` (`project_id`,`record`,`event_id`),
UNIQUE KEY `record_arm` (`record`,`arm_id`),
KEY `arm_id` (`arm_id`),
KEY `creation_time` (`creation_time`),
KEY `event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Save new record names to prevent record duplication';

CREATE TABLE `redcap_page_hits` (
`date` date NOT NULL,
`page_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`page_hits` float NOT NULL DEFAULT '1',
UNIQUE KEY `date` (`date`,`page_name`),
KEY `page_name` (`page_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_project_checklist` (
`list_id` int(11) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`list_id`),
UNIQUE KEY `project_name` (`project_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_projects` (
`project_id` int(10) NOT NULL AUTO_INCREMENT,
`project_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`app_title` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`status` int(1) NOT NULL DEFAULT '0',
`creation_time` datetime DEFAULT NULL,
`production_time` datetime DEFAULT NULL,
`inactive_time` datetime DEFAULT NULL,
`created_by` int(10) DEFAULT NULL COMMENT 'FK from User Info',
`draft_mode` int(1) NOT NULL DEFAULT '0',
`surveys_enabled` int(1) NOT NULL DEFAULT '0' COMMENT '0 = forms only, 1 = survey+forms, 2 = single survey only',
`repeatforms` int(1) NOT NULL DEFAULT '0',
`scheduling` int(1) NOT NULL DEFAULT '0',
`purpose` int(2) DEFAULT NULL,
`purpose_other` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`show_which_records` int(1) NOT NULL DEFAULT '0',
`__SALT__` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Alphanumeric hash unique to each project',
`count_project` int(1) NOT NULL DEFAULT '1',
`investigators` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_note` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`online_offline` int(1) NOT NULL DEFAULT '1',
`auth_meth` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`double_data_entry` int(1) NOT NULL DEFAULT '0',
`project_language` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'English',
`project_encoding` enum('japanese_sjis','chinese_utf8','chinese_utf8_traditional') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Encoding to be used for various exported files',
`is_child_of` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`date_shift_max` int(10) NOT NULL DEFAULT '364',
`institution` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`site_org_type` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`grant_cite` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_contact_name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_contact_email` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`headerlogo` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`auto_inc_set` int(1) NOT NULL DEFAULT '0',
`custom_data_entry_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`custom_index_page_note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`order_id_by` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`custom_reports` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Legacy report builder',
`report_builder` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`disable_data_entry` int(1) NOT NULL DEFAULT '0',
`google_translate_default` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`require_change_reason` int(1) NOT NULL DEFAULT '0',
`dts_enabled` int(1) NOT NULL DEFAULT '0',
`project_pi_firstname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_pi_mi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_pi_lastname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_pi_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_pi_alias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_pi_username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_pi_pub_exclude` int(1) DEFAULT NULL,
`project_pub_matching_institution` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_irb_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_grant_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`history_widget_enabled` int(1) NOT NULL DEFAULT '1',
`secondary_pk` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'field_name of seconary identifier',
`secondary_pk_display_value` tinyint(1) NOT NULL DEFAULT '1',
`secondary_pk_display_label` tinyint(1) NOT NULL DEFAULT '1',
`custom_record_label` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`display_project_logo_institution` int(1) NOT NULL DEFAULT '1',
`imported_from_rs` int(1) NOT NULL DEFAULT '0' COMMENT 'If imported from REDCap Survey',
`display_today_now_button` int(1) NOT NULL DEFAULT '1',
`auto_variable_naming` int(1) NOT NULL DEFAULT '0',
`randomization` int(1) NOT NULL DEFAULT '0',
`enable_participant_identifiers` int(1) NOT NULL DEFAULT '0',
`survey_email_participant_field` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Field name that stores participant email',
`survey_phone_participant_field` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Field name that stores participant phone number',
`data_entry_trigger_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'URL for sending Post request when a record is created or modified',
`template_id` int(10) DEFAULT NULL COMMENT 'If created from a project template, the project_id of the template',
`date_deleted` datetime DEFAULT NULL COMMENT 'Time that project was flagged for deletion',
`data_resolution_enabled` int(1) NOT NULL DEFAULT '1' COMMENT '0=Disabled, 1=Field comment log, 2=Data Quality resolution workflow',
`field_comment_edit_delete` int(1) NOT NULL DEFAULT '1' COMMENT 'Allow users to edit or delete Field Comments',
`realtime_webservice_enabled` int(1) NOT NULL DEFAULT '0' COMMENT 'Is real-time web service enabled for external data import?',
`realtime_webservice_type` enum('CUSTOM','FHIR') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CUSTOM',
`realtime_webservice_offset_days` float NOT NULL DEFAULT '7' COMMENT 'Default value of days offset',
`realtime_webservice_offset_plusminus` enum('+','-','+-') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '+-' COMMENT 'Default value of plus-minus range for days offset',
`last_logged_event` datetime DEFAULT NULL,
`survey_queue_custom_text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`survey_auth_enabled` int(1) NOT NULL DEFAULT '0',
`survey_auth_field1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`survey_auth_event_id1` int(10) DEFAULT NULL,
`survey_auth_field2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`survey_auth_event_id2` int(10) DEFAULT NULL,
`survey_auth_field3` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`survey_auth_event_id3` int(10) DEFAULT NULL,
`survey_auth_min_fields` enum('1','2','3') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`survey_auth_apply_all_surveys` int(1) NOT NULL DEFAULT '1',
`survey_auth_custom_message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`survey_auth_fail_limit` int(2) DEFAULT NULL,
`survey_auth_fail_window` int(3) DEFAULT NULL,
`twilio_enabled` int(1) NOT NULL DEFAULT '0',
`twilio_account_sid` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`twilio_auth_token` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`twilio_from_number` bigint(16) DEFAULT NULL,
`twilio_voice_language` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
`twilio_option_voice_initiate` tinyint(1) NOT NULL DEFAULT '0',
`twilio_option_sms_initiate` tinyint(1) NOT NULL DEFAULT '0',
`twilio_option_sms_invite_make_call` tinyint(1) NOT NULL DEFAULT '0',
`twilio_option_sms_invite_receive_call` tinyint(1) NOT NULL DEFAULT '0',
`twilio_option_sms_invite_web` tinyint(1) NOT NULL DEFAULT '0',
`twilio_default_delivery_preference` enum('EMAIL','VOICE_INITIATE','SMS_INITIATE','SMS_INVITE_MAKE_CALL','SMS_INVITE_RECEIVE_CALL','SMS_INVITE_WEB') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EMAIL',
`twilio_request_inspector_checked` datetime DEFAULT NULL,
`twilio_request_inspector_enabled` int(1) NOT NULL DEFAULT '1',
`twilio_append_response_instructions` int(1) NOT NULL DEFAULT '1',
`twilio_multiple_sms_behavior` enum('OVERWRITE','CHOICE','FIRST') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'CHOICE',
`two_factor_exempt_project` tinyint(1) NOT NULL DEFAULT '0',
`two_factor_force_project` tinyint(1) NOT NULL DEFAULT '0',
`disable_autocalcs` tinyint(1) NOT NULL DEFAULT '0',
`custom_public_survey_links` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pdf_custom_header_text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pdf_show_logo_url` tinyint(1) NOT NULL DEFAULT '1',
`pdf_hide_secondary_field` tinyint(1) NOT NULL DEFAULT '0',
`shared_library_enabled` tinyint(1) NOT NULL DEFAULT '1',
`allow_delete_record_from_log` tinyint(1) NOT NULL DEFAULT '0',
`delete_file_repository_export_files` int(3) NOT NULL DEFAULT '0' COMMENT 'Will auto-delete files after X days',
`custom_project_footer_text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`custom_project_footer_text_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`google_recaptcha_enabled` tinyint(1) NOT NULL DEFAULT '0',
`datamart_allow_repeat_revision` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If true, a normal user can run a revision multiple times',
`datamart_allow_create_revision` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If true, a normal user can request a new revision',
`datamart_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Is project a Clinical Data Mart project?',
`datamart_cron_enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'If true, the cron job will pull data automatically for all records at a specified interval X times per day.',
PRIMARY KEY (`project_id`),
UNIQUE KEY `project_name` (`project_name`),
UNIQUE KEY `twilio_from_number` (`twilio_from_number`),
KEY `app_title` (`app_title`(190)),
KEY `created_by` (`created_by`),
KEY `delete_file_repository_export_files` (`delete_file_repository_export_files`),
KEY `last_logged_event` (`last_logged_event`),
KEY `project_note` (`project_note`(190)),
KEY `survey_auth_event_id1` (`survey_auth_event_id1`),
KEY `survey_auth_event_id2` (`survey_auth_event_id2`),
KEY `survey_auth_event_id3` (`survey_auth_event_id3`),
KEY `template_id` (`template_id`),
KEY `twilio_account_sid` (`twilio_account_sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores project-level values';

CREATE TABLE `redcap_projects_external` (
`project_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Brief user-defined project identifier unique within custom_type',
`custom_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Brief user-defined name for the resource/category/bucket under which the project falls',
`app_title` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`creation_time` datetime DEFAULT NULL,
`project_pi_firstname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_pi_mi` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_pi_lastname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_pi_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_pi_alias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_pi_pub_exclude` int(1) DEFAULT NULL,
`project_pub_matching_institution` text COLLATE utf8mb4_unicode_ci NOT NULL,
PRIMARY KEY (`project_id`,`custom_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_projects_templates` (
`project_id` int(10) NOT NULL DEFAULT '0',
`title` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`enabled` int(1) NOT NULL DEFAULT '0' COMMENT 'If enabled, template is visible to users in list.',
PRIMARY KEY (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Info about which projects are used as templates';

CREATE TABLE `redcap_pub_articles` (
`article_id` int(10) NOT NULL AUTO_INCREMENT,
`pubsrc_id` int(10) NOT NULL,
`pub_id` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'The publication source''s ID for the article (e.g., a PMID in the case of PubMed)',
`title` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`volume` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`issue` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pages` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`journal` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`journal_abbrev` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pub_date` date DEFAULT NULL,
`epub_date` date DEFAULT NULL,
PRIMARY KEY (`article_id`),
UNIQUE KEY `pubsrc_id` (`pubsrc_id`,`pub_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Articles pulled from a publication source (e.g., PubMed)';

CREATE TABLE `redcap_pub_authors` (
`author_id` int(10) NOT NULL AUTO_INCREMENT,
`article_id` int(10) DEFAULT NULL,
`author` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`author_id`),
KEY `article_id` (`article_id`),
KEY `author` (`author`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_pub_matches` (
`match_id` int(11) NOT NULL AUTO_INCREMENT,
`article_id` int(11) NOT NULL,
`project_id` int(11) DEFAULT NULL,
`external_project_id` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'FK 1/2 referencing redcap_projects_external (not explicitly defined as FK to allow redcap_projects_external to be blown away)',
`external_custom_type` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'FK 2/2 referencing redcap_projects_external (not explicitly defined as FK to allow redcap_projects_external to be blown away)',
`search_term` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
`matched` int(1) DEFAULT NULL,
`matched_time` datetime DEFAULT NULL,
`email_count` int(11) NOT NULL DEFAULT '0',
`email_time` datetime DEFAULT NULL,
`unique_hash` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
PRIMARY KEY (`match_id`),
UNIQUE KEY `unique_hash` (`unique_hash`),
KEY `article_id` (`article_id`),
KEY `external_custom_type` (`external_custom_type`),
KEY `external_project_id` (`external_project_id`),
KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_pub_mesh_terms` (
`mesh_id` int(10) NOT NULL AUTO_INCREMENT,
`article_id` int(10) DEFAULT NULL,
`mesh_term` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`mesh_id`),
KEY `article_id` (`article_id`),
KEY `mesh_term` (`mesh_term`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_pub_sources` (
`pubsrc_id` int(11) NOT NULL,
`pubsrc_name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
`pubsrc_last_crawl_time` datetime DEFAULT NULL,
PRIMARY KEY (`pubsrc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='The different places where we grab publications from';

CREATE TABLE `redcap_randomization` (
`rid` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`stratified` int(1) NOT NULL DEFAULT '1' COMMENT '1=Stratified, 0=Block',
`group_by` enum('DAG','FIELD') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Randomize by group?',
`target_field` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`target_event` int(10) DEFAULT NULL,
`source_field1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event1` int(10) DEFAULT NULL,
`source_field2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event2` int(10) DEFAULT NULL,
`source_field3` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event3` int(10) DEFAULT NULL,
`source_field4` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event4` int(10) DEFAULT NULL,
`source_field5` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event5` int(10) DEFAULT NULL,
`source_field6` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event6` int(10) DEFAULT NULL,
`source_field7` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event7` int(10) DEFAULT NULL,
`source_field8` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event8` int(10) DEFAULT NULL,
`source_field9` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event9` int(10) DEFAULT NULL,
`source_field10` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event10` int(10) DEFAULT NULL,
`source_field11` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event11` int(10) DEFAULT NULL,
`source_field12` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event12` int(10) DEFAULT NULL,
`source_field13` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event13` int(10) DEFAULT NULL,
`source_field14` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event14` int(10) DEFAULT NULL,
`source_field15` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`source_event15` int(10) DEFAULT NULL,
PRIMARY KEY (`rid`),
UNIQUE KEY `project_id` (`project_id`),
KEY `source_event1` (`source_event1`),
KEY `source_event10` (`source_event10`),
KEY `source_event11` (`source_event11`),
KEY `source_event12` (`source_event12`),
KEY `source_event13` (`source_event13`),
KEY `source_event14` (`source_event14`),
KEY `source_event15` (`source_event15`),
KEY `source_event2` (`source_event2`),
KEY `source_event3` (`source_event3`),
KEY `source_event4` (`source_event4`),
KEY `source_event5` (`source_event5`),
KEY `source_event6` (`source_event6`),
KEY `source_event7` (`source_event7`),
KEY `source_event8` (`source_event8`),
KEY `source_event9` (`source_event9`),
KEY `target_event` (`target_event`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_randomization_allocation` (
`aid` int(10) NOT NULL AUTO_INCREMENT,
`rid` int(10) NOT NULL DEFAULT '0',
`project_status` int(1) NOT NULL DEFAULT '0' COMMENT 'Used in dev or prod status',
`is_used_by` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Used by a record?',
`group_id` int(10) DEFAULT NULL COMMENT 'DAG',
`target_field` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field3` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field4` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field5` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field6` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field7` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field8` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field9` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field10` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field11` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field12` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field13` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field14` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
`source_field15` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Data value',
PRIMARY KEY (`aid`),
UNIQUE KEY `rid_status_usedby` (`rid`,`project_status`,`is_used_by`),
KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_record_counts` (
`project_id` int(11) NOT NULL,
`record_count` int(11) DEFAULT NULL,
`time_of_count` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
`record_list_status` enum('NOT_STARTED','PROCESSING','COMPLETE','FIX_SORT') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NOT_STARTED',
PRIMARY KEY (`project_id`),
KEY `time_of_count` (`time_of_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_record_dashboards` (
`rd_id` int(11) NOT NULL AUTO_INCREMENT,
`project_id` int(11) DEFAULT NULL,
`title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`filter_logic` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`orientation` enum('V','H') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'H',
`group_by` enum('form','event') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'event',
`selected_forms_events` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`arm` tinyint(2) DEFAULT NULL,
`sort_event_id` int(11) DEFAULT NULL,
`sort_field_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`sort_order` enum('ASC','DESC') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ASC',
PRIMARY KEY (`rd_id`),
KEY `project_id` (`project_id`),
KEY `sort_event_id` (`sort_event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_record_list` (
`project_id` int(10) NOT NULL,
`arm` tinyint(2) NOT NULL,
`record` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
`dag_id` int(10) DEFAULT NULL,
`sort` mediumint(7) DEFAULT NULL,
PRIMARY KEY (`project_id`,`arm`,`record`),
KEY `dag_project_arm` (`dag_id`,`project_id`,`arm`),
KEY `project_record` (`project_id`,`record`),
KEY `sort_project_arm` (`sort`,`project_id`,`arm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_reports` (
`report_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) NOT NULL,
`title` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`report_order` int(3) DEFAULT NULL,
`user_access` enum('ALL','SELECTED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ALL',
`user_edit_access` enum('ALL','SELECTED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ALL',
`description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`combine_checkbox_values` tinyint(1) NOT NULL DEFAULT '0',
`output_dags` int(1) NOT NULL DEFAULT '0',
`output_survey_fields` int(1) NOT NULL DEFAULT '0',
`orderby_field1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`orderby_sort1` enum('ASC','DESC') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`orderby_field2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`orderby_sort2` enum('ASC','DESC') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`orderby_field3` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`orderby_sort3` enum('ASC','DESC') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`advanced_logic` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`filter_type` enum('RECORD','EVENT') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EVENT',
`dynamic_filter1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`dynamic_filter2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`dynamic_filter3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`report_id`),
UNIQUE KEY `project_report_order` (`project_id`,`report_order`),
KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_reports_access_dags` (
`report_id` int(10) NOT NULL AUTO_INCREMENT,
`group_id` int(10) NOT NULL DEFAULT '0',
PRIMARY KEY (`report_id`,`group_id`),
KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_reports_access_roles` (
`report_id` int(10) NOT NULL DEFAULT '0',
`role_id` int(10) NOT NULL DEFAULT '0',
PRIMARY KEY (`report_id`,`role_id`),
KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_reports_access_users` (
`report_id` int(10) NOT NULL AUTO_INCREMENT,
`username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
PRIMARY KEY (`report_id`,`username`),
KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_reports_edit_access_dags` (
`report_id` int(10) NOT NULL AUTO_INCREMENT,
`group_id` int(10) NOT NULL DEFAULT '0',
PRIMARY KEY (`report_id`,`group_id`),
KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_reports_edit_access_roles` (
`report_id` int(10) NOT NULL DEFAULT '0',
`role_id` int(10) NOT NULL DEFAULT '0',
PRIMARY KEY (`report_id`,`role_id`),
KEY `role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_reports_edit_access_users` (
`report_id` int(10) NOT NULL AUTO_INCREMENT,
`username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
PRIMARY KEY (`report_id`,`username`),
KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_reports_fields` (
`report_id` int(10) DEFAULT NULL,
`field_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`field_order` int(3) DEFAULT NULL,
`limiter_group_operator` enum('AND','OR') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`limiter_event_id` int(10) DEFAULT NULL,
`limiter_operator` enum('E','NE','GT','GTE','LT','LTE','CHECKED','UNCHECKED','CONTAINS','NOT_CONTAIN','STARTS_WITH','ENDS_WITH') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`limiter_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
UNIQUE KEY `report_id_field_name_order` (`report_id`,`field_name`,`field_order`),
KEY `field_name` (`field_name`),
KEY `limiter_event_id` (`limiter_event_id`),
KEY `report_id_field_order` (`report_id`,`field_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_reports_filter_dags` (
`report_id` int(10) NOT NULL AUTO_INCREMENT,
`group_id` int(10) NOT NULL DEFAULT '0',
PRIMARY KEY (`report_id`,`group_id`),
KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_reports_filter_events` (
`report_id` int(10) NOT NULL AUTO_INCREMENT,
`event_id` int(10) NOT NULL DEFAULT '0',
PRIMARY KEY (`report_id`,`event_id`),
KEY `event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_reports_folders` (
`folder_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`name` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`position` smallint(4) DEFAULT NULL,
PRIMARY KEY (`folder_id`),
UNIQUE KEY `position_project_id` (`position`,`project_id`),
KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_reports_folders_items` (
`folder_id` int(10) DEFAULT NULL,
`report_id` int(10) DEFAULT NULL,
UNIQUE KEY `folder_id_report_id` (`folder_id`,`report_id`),
KEY `report_id` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_sendit_docs` (
`document_id` int(11) NOT NULL AUTO_INCREMENT,
`doc_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`doc_orig_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`doc_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`doc_size` int(11) DEFAULT NULL,
`send_confirmation` int(1) NOT NULL DEFAULT '0',
`expire_date` datetime DEFAULT NULL,
`username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`location` int(1) NOT NULL DEFAULT '0' COMMENT '1 = Home page; 2 = File Repository; 3 = Form',
`docs_id` int(11) NOT NULL DEFAULT '0',
`date_added` datetime DEFAULT NULL,
`date_deleted` datetime DEFAULT NULL COMMENT 'When really deleted from server (only applicable for location=1)',
PRIMARY KEY (`document_id`),
KEY `date_added` (`date_added`),
KEY `docs_id_location` (`location`,`docs_id`),
KEY `expire_location_deleted` (`expire_date`,`location`,`date_deleted`),
KEY `user_id` (`username`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_sendit_recipients` (
`recipient_id` int(11) NOT NULL AUTO_INCREMENT,
`email_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`sent_confirmation` int(1) NOT NULL DEFAULT '0',
`download_date` datetime DEFAULT NULL,
`download_count` int(11) NOT NULL DEFAULT '0',
`document_id` int(11) NOT NULL DEFAULT '0' COMMENT 'FK from redcap_sendit_docs',
`guid` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pwd` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`recipient_id`),
KEY `document_id` (`document_id`),
KEY `email_address` (`email_address`(191)),
KEY `guid` (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_sessions` (
`session_id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL,
`session_data` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`session_expiration` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores user authentication session data';

CREATE TABLE `redcap_surveys` (
`survey_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`form_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'NULL = assume first form',
`title` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey title',
`instructions` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey instructions',
`acknowledgement` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey acknowledgement',
`question_by_section` int(1) NOT NULL DEFAULT '0' COMMENT '0 = one-page survey',
`display_page_number` int(1) NOT NULL DEFAULT '1',
`question_auto_numbering` int(1) NOT NULL DEFAULT '1',
`survey_enabled` int(1) NOT NULL DEFAULT '1',
`save_and_return` int(1) NOT NULL DEFAULT '0',
`save_and_return_code_bypass` tinyint(1) NOT NULL DEFAULT '0',
`logo` int(10) DEFAULT NULL COMMENT 'FK for redcap_edocs_metadata',
`hide_title` int(1) NOT NULL DEFAULT '0',
`view_results` int(1) NOT NULL DEFAULT '0',
`min_responses_view_results` int(5) NOT NULL DEFAULT '10',
`check_diversity_view_results` int(1) NOT NULL DEFAULT '0',
`end_survey_redirect_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'URL to redirect to after completing survey',
`survey_expiration` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Timestamp when survey expires',
`promis_skip_question` int(1) NOT NULL DEFAULT '0' COMMENT 'Allow participants to skip questions on PROMIS CATs',
`survey_auth_enabled_single` int(1) NOT NULL DEFAULT '0' COMMENT 'Enable Survey Login for this single survey?',
`edit_completed_response` int(1) NOT NULL DEFAULT '0' COMMENT 'Allow respondents to return and edit a completed response?',
`hide_back_button` tinyint(1) NOT NULL DEFAULT '0',
`show_required_field_text` tinyint(1) NOT NULL DEFAULT '1',
`confirmation_email_subject` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`confirmation_email_content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`confirmation_email_from` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`confirmation_email_attach_pdf` tinyint(1) DEFAULT '0',
`confirmation_email_attachment` int(10) DEFAULT NULL COMMENT 'FK for redcap_edocs_metadata',
`text_to_speech` int(1) NOT NULL DEFAULT '0',
`text_to_speech_language` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
`end_survey_redirect_next_survey` tinyint(1) NOT NULL DEFAULT '0',
`theme` int(10) DEFAULT NULL,
`text_size` tinyint(2) DEFAULT NULL,
`font_family` tinyint(2) DEFAULT NULL,
`theme_text_buttons` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`theme_bg_page` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`theme_text_title` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`theme_bg_title` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`theme_text_sectionheader` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`theme_bg_sectionheader` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`theme_text_question` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`theme_bg_question` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`enhanced_choices` smallint(1) NOT NULL DEFAULT '0',
`repeat_survey_enabled` tinyint(1) NOT NULL DEFAULT '0',
`repeat_survey_btn_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`repeat_survey_btn_location` enum('BEFORE_SUBMIT','AFTER_SUBMIT') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BEFORE_SUBMIT',
`response_limit` int(7) DEFAULT NULL,
`response_limit_include_partials` tinyint(1) NOT NULL DEFAULT '1',
`response_limit_custom_text` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`survey_time_limit_days` smallint(3) DEFAULT NULL,
`survey_time_limit_hours` tinyint(2) DEFAULT NULL,
`survey_time_limit_minutes` tinyint(2) DEFAULT NULL,
`email_participant_field` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`end_of_survey_pdf_download` tinyint(4) NOT NULL DEFAULT '0',
`pdf_auto_archive` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=Disabled, 1=Normal, 2=eConsent',
`pdf_econsent_version` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pdf_econsent_type` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pdf_econsent_firstname_field` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pdf_econsent_firstname_event_id` int(11) DEFAULT NULL,
`pdf_econsent_lastname_field` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pdf_econsent_lastname_event_id` int(11) DEFAULT NULL,
`pdf_econsent_dob_field` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pdf_econsent_dob_event_id` int(11) DEFAULT NULL,
`pdf_econsent_allow_edit` tinyint(1) NOT NULL DEFAULT '0',
`pdf_econsent_signature_field1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pdf_econsent_signature_field2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pdf_econsent_signature_field3` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pdf_econsent_signature_field4` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`pdf_econsent_signature_field5` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`survey_id`),
UNIQUE KEY `logo` (`logo`),
UNIQUE KEY `project_form` (`project_id`,`form_name`),
KEY `confirmation_email_attachment` (`confirmation_email_attachment`),
KEY `pdf_econsent_dob_event_id` (`pdf_econsent_dob_event_id`),
KEY `pdf_econsent_firstname_event_id` (`pdf_econsent_firstname_event_id`),
KEY `pdf_econsent_lastname_event_id` (`pdf_econsent_lastname_event_id`),
KEY `survey_expiration_enabled` (`survey_expiration`,`survey_enabled`),
KEY `theme` (`theme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table for survey data';

CREATE TABLE `redcap_surveys_emails` (
`email_id` int(10) NOT NULL AUTO_INCREMENT,
`survey_id` int(10) DEFAULT NULL,
`email_subject` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`email_content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`email_sender` int(10) DEFAULT NULL COMMENT 'FK ui_id from redcap_user_information',
`email_account` enum('1','2','3') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Sender''s account (1=Primary, 2=Secondary, 3=Tertiary)',
`email_static` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Sender''s static email address (only for scheduled invitations)',
`email_sent` datetime DEFAULT NULL COMMENT 'Null=Not sent yet (scheduled)',
`delivery_type` enum('PARTICIPANT_PREF','EMAIL','VOICE_INITIATE','SMS_INITIATE','SMS_INVITE_MAKE_CALL','SMS_INVITE_RECEIVE_CALL','SMS_INVITE_WEB') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EMAIL',
`append_survey_link` tinyint(1) NOT NULL DEFAULT '1',
PRIMARY KEY (`email_id`),
KEY `email_sender` (`email_sender`),
KEY `email_sent` (`email_sent`),
KEY `survey_id_email_sent` (`survey_id`,`email_sent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track emails sent out';

CREATE TABLE `redcap_surveys_emails_recipients` (
`email_recip_id` int(10) NOT NULL AUTO_INCREMENT,
`email_id` int(10) DEFAULT NULL COMMENT 'FK redcap_surveys_emails',
`participant_id` int(10) DEFAULT NULL COMMENT 'FK redcap_surveys_participants',
`static_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Static email address of recipient (used when participant has no email)',
`static_phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Static phone number of recipient (used when participant has no phone number)',
`delivery_type` enum('EMAIL','VOICE_INITIATE','SMS_INITIATE','SMS_INVITE_MAKE_CALL','SMS_INVITE_RECEIVE_CALL','SMS_INVITE_WEB') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EMAIL',
PRIMARY KEY (`email_recip_id`),
KEY `emt_id` (`email_id`),
KEY `participant_id` (`participant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Track email recipients';

CREATE TABLE `redcap_surveys_emails_send_rate` (
`esr_id` int(10) NOT NULL AUTO_INCREMENT,
`sent_begin_time` datetime DEFAULT NULL COMMENT 'Time email batch was sent',
`emails_per_batch` int(10) DEFAULT NULL COMMENT 'Number of emails sent in this batch',
`emails_per_minute` int(6) DEFAULT NULL COMMENT 'Number of emails sent per minute for this batch',
PRIMARY KEY (`esr_id`),
KEY `sent_begin_time` (`sent_begin_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Capture the rate that emails are sent per minute by REDCap';

CREATE TABLE `redcap_surveys_erase_twilio_log` (
`tl_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`ts` datetime DEFAULT NULL,
`sid` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`sid_hash` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`tl_id`),
UNIQUE KEY `sid` (`sid`),
UNIQUE KEY `sid_hash` (`sid_hash`),
KEY `project_id` (`project_id`),
KEY `ts` (`ts`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Temporary storage of Twilio logs to be deleted';

CREATE TABLE `redcap_surveys_login` (
`ts` datetime DEFAULT NULL,
`response_id` int(10) DEFAULT NULL,
`login_success` tinyint(1) NOT NULL DEFAULT '1',
KEY `response_id` (`response_id`),
KEY `ts_response_id_success` (`ts`,`response_id`,`login_success`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_surveys_participants` (
`participant_id` int(10) NOT NULL AUTO_INCREMENT,
`survey_id` int(10) DEFAULT NULL,
`event_id` int(10) DEFAULT NULL,
`hash` varchar(10) CHARACTER SET latin1 COLLATE latin1_general_cs DEFAULT NULL,
`legacy_hash` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Migrated from RS',
`access_code` varchar(9) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`access_code_numeral` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`participant_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'NULL if public survey',
`participant_identifier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`participant_phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`delivery_preference` enum('EMAIL','VOICE_INITIATE','SMS_INITIATE','SMS_INVITE_MAKE_CALL','SMS_INVITE_RECEIVE_CALL','SMS_INVITE_WEB') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`link_expiration` datetime DEFAULT NULL,
`link_expiration_override` tinyint(1) NOT NULL DEFAULT '0',
PRIMARY KEY (`participant_id`),
UNIQUE KEY `access_code` (`access_code`),
UNIQUE KEY `access_code_numeral` (`access_code_numeral`),
UNIQUE KEY `hash` (`hash`),
UNIQUE KEY `legacy_hash` (`legacy_hash`),
KEY `event_id` (`event_id`),
KEY `participant_email_phone` (`participant_email`(191),`participant_phone`),
KEY `survey_event_email` (`survey_id`,`event_id`,`participant_email`(191))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Table for survey data';

CREATE TABLE `redcap_surveys_pdf_archive` (
`doc_id` int(10) DEFAULT NULL,
`record` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`event_id` int(10) DEFAULT NULL,
`survey_id` int(10) DEFAULT NULL,
`instance` smallint(4) NOT NULL DEFAULT '1',
`identifier` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`version` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`type` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`ip` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
UNIQUE KEY `doc_id` (`doc_id`),
UNIQUE KEY `record_event_survey_instance` (`record`,`event_id`,`survey_id`,`instance`),
KEY `event_id` (`event_id`),
KEY `survey_id` (`survey_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_surveys_phone_codes` (
`pc_id` int(10) NOT NULL AUTO_INCREMENT,
`phone_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
`twilio_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
`access_code` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`project_id` int(10) DEFAULT NULL,
PRIMARY KEY (`pc_id`),
KEY `participant_twilio_phone` (`phone_number`,`twilio_number`),
KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_surveys_queue` (
`sq_id` int(10) NOT NULL AUTO_INCREMENT,
`survey_id` int(10) DEFAULT NULL,
`event_id` int(10) DEFAULT NULL,
`active` int(1) NOT NULL DEFAULT '1' COMMENT 'Is it currently active?',
`auto_start` int(1) NOT NULL DEFAULT '0' COMMENT 'Automatically start if next after survey completion',
`condition_surveycomplete_survey_id` int(10) DEFAULT NULL COMMENT 'survey_id of trigger',
`condition_surveycomplete_event_id` int(10) DEFAULT NULL COMMENT 'event_id of trigger',
`condition_andor` enum('AND','OR') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Include survey complete AND/OR logic',
`condition_logic` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Logic using field values',
PRIMARY KEY (`sq_id`),
UNIQUE KEY `survey_event` (`survey_id`,`event_id`),
KEY `condition_surveycomplete_event_id` (`condition_surveycomplete_event_id`),
KEY `condition_surveycomplete_survey_event` (`condition_surveycomplete_survey_id`,`condition_surveycomplete_event_id`),
KEY `event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_surveys_queue_hashes` (
`project_id` int(10) NOT NULL DEFAULT '0',
`record` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
`hash` varchar(10) CHARACTER SET latin1 COLLATE latin1_general_cs DEFAULT NULL,
PRIMARY KEY (`project_id`,`record`),
UNIQUE KEY `hash` (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_surveys_response` (
`response_id` int(11) NOT NULL AUTO_INCREMENT,
`participant_id` int(10) DEFAULT NULL,
`record` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`instance` smallint(4) NOT NULL DEFAULT '1',
`start_time` datetime DEFAULT NULL,
`first_submit_time` datetime DEFAULT NULL,
`completion_time` datetime DEFAULT NULL,
`return_code` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`results_code` varchar(8) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`response_id`),
UNIQUE KEY `participant_record` (`participant_id`,`record`,`instance`),
KEY `completion_time` (`completion_time`),
KEY `first_submit_time` (`first_submit_time`),
KEY `record_participant` (`record`,`participant_id`,`instance`),
KEY `results_code` (`results_code`),
KEY `return_code` (`return_code`),
KEY `start_time` (`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_surveys_scheduler` (
`ss_id` int(10) NOT NULL AUTO_INCREMENT,
`survey_id` int(10) DEFAULT NULL,
`event_id` int(10) DEFAULT NULL,
`active` int(1) NOT NULL DEFAULT '1' COMMENT 'Is it currently active?',
`email_subject` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey invitation subject',
`email_content` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Survey invitation text',
`email_sender` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Static email address of sender',
`condition_surveycomplete_survey_id` int(10) DEFAULT NULL COMMENT 'survey_id of trigger',
`condition_surveycomplete_event_id` int(10) DEFAULT NULL COMMENT 'event_id of trigger',
`condition_andor` enum('AND','OR') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Include survey complete AND/OR logic',
`condition_logic` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Logic using field values',
`condition_send_time_option` enum('IMMEDIATELY','TIME_LAG','NEXT_OCCURRENCE','EXACT_TIME') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'When to send invites after condition is met',
`condition_send_time_lag_days` int(4) DEFAULT NULL COMMENT 'Wait X days to send invites after condition is met',
`condition_send_time_lag_hours` int(2) DEFAULT NULL COMMENT 'Wait X hours to send invites after condition is met',
`condition_send_time_lag_minutes` int(2) DEFAULT NULL COMMENT 'Wait X seconds to send invites after condition is met',
`condition_send_next_day_type` enum('DAY','WEEKDAY','WEEKENDDAY','SUNDAY','MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Wait till specific day/time to send invites after condition is met',
`condition_send_next_time` time DEFAULT NULL COMMENT 'Wait till specific day/time to send invites after condition is met',
`condition_send_time_exact` datetime DEFAULT NULL COMMENT 'Wait till exact date/time to send invites after condition is met',
`delivery_type` enum('EMAIL','VOICE_INITIATE','SMS_INITIATE','SMS_INVITE_MAKE_CALL','SMS_INVITE_RECEIVE_CALL','PARTICIPANT_PREF','SMS_INVITE_WEB') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'EMAIL',
`reminder_type` enum('TIME_LAG','NEXT_OCCURRENCE','EXACT_TIME') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'When to send reminders after original invite is sent',
`reminder_timelag_days` int(3) DEFAULT NULL COMMENT 'Wait X days to send reminders',
`reminder_timelag_hours` int(2) DEFAULT NULL COMMENT 'Wait X hours to send reminders',
`reminder_timelag_minutes` int(2) DEFAULT NULL COMMENT 'Wait X seconds to send reminders',
`reminder_nextday_type` enum('DAY','WEEKDAY','WEEKENDDAY','SUNDAY','MONDAY','TUESDAY','WEDNESDAY','THURSDAY','FRIDAY','SATURDAY') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Wait till specific day/time to send reminders',
`reminder_nexttime` time DEFAULT NULL COMMENT 'Wait till specific day/time to send reminders',
`reminder_exact_time` datetime DEFAULT NULL COMMENT 'Wait till exact date/time to send reminders',
`reminder_num` int(3) NOT NULL DEFAULT '0' COMMENT 'Reminder recurrence',
`reeval_before_send` int(1) NOT NULL DEFAULT '0',
PRIMARY KEY (`ss_id`),
UNIQUE KEY `survey_event` (`survey_id`,`event_id`),
KEY `condition_surveycomplete_event_id` (`condition_surveycomplete_event_id`),
KEY `condition_surveycomplete_survey_event` (`condition_surveycomplete_survey_id`,`condition_surveycomplete_event_id`),
KEY `event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_surveys_scheduler_queue` (
`ssq_id` int(10) NOT NULL AUTO_INCREMENT,
`ss_id` int(10) DEFAULT NULL COMMENT 'FK for surveys_scheduler table',
`email_recip_id` int(10) DEFAULT NULL COMMENT 'FK for redcap_surveys_emails_recipients table',
`reminder_num` int(3) NOT NULL DEFAULT '0' COMMENT 'Email reminder instance (0 = original invitation)',
`record` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'NULL if record not created yet',
`instance` smallint(4) NOT NULL DEFAULT '1',
`scheduled_time_to_send` datetime DEFAULT NULL COMMENT 'Time invitation will be sent',
`status` enum('QUEUED','SENDING','SENT','DID NOT SEND','DELETED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'QUEUED' COMMENT 'Survey invitation status (default=QUEUED)',
`time_sent` datetime DEFAULT NULL COMMENT 'Actual time invitation was sent',
`reason_not_sent` enum('EMAIL ADDRESS NOT FOUND','PHONE NUMBER NOT FOUND','EMAIL ATTEMPT FAILED','UNKNOWN','SURVEY ALREADY COMPLETED','VOICE/SMS SETTING DISABLED','ERROR SENDING SMS','ERROR MAKING VOICE CALL','LINK HAD ALREADY EXPIRED') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Explanation of why invitation did not send, if applicable',
PRIMARY KEY (`ssq_id`),
UNIQUE KEY `email_recip_id_record` (`email_recip_id`,`record`,`reminder_num`,`instance`),
UNIQUE KEY `ss_id_record` (`ss_id`,`record`,`reminder_num`,`instance`),
KEY `send_sent_status` (`scheduled_time_to_send`,`time_sent`,`status`),
KEY `status` (`status`),
KEY `time_sent` (`time_sent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_surveys_short_codes` (
`ts` datetime DEFAULT NULL,
`participant_id` int(10) DEFAULT NULL,
`code` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
UNIQUE KEY `code` (`code`),
KEY `participant_id_ts` (`participant_id`,`ts`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_surveys_themes` (
`theme_id` int(10) NOT NULL AUTO_INCREMENT,
`theme_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`ui_id` int(10) DEFAULT NULL COMMENT 'NULL = Theme is available to all users',
`theme_text_buttons` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`theme_bg_page` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`theme_text_title` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`theme_bg_title` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`theme_text_sectionheader` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`theme_bg_sectionheader` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`theme_text_question` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`theme_bg_question` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`theme_id`),
KEY `theme_name` (`theme_name`),
KEY `ui_id` (`ui_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_todo_list` (
`request_id` int(11) NOT NULL AUTO_INCREMENT,
`request_from` int(11) DEFAULT NULL,
`request_to` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`todo_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`action_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`status` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`request_time` datetime DEFAULT NULL,
`project_id` int(10) DEFAULT NULL,
`request_completion_time` datetime DEFAULT NULL,
`request_completion_userid` int(11) DEFAULT NULL,
`comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`request_id`),
KEY `project_id` (`project_id`),
KEY `request_completion_userid` (`request_completion_userid`),
KEY `request_from` (`request_from`),
KEY `request_time` (`request_time`),
KEY `status` (`status`),
KEY `todo_type` (`todo_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_two_factor_response` (
`tf_id` int(10) NOT NULL AUTO_INCREMENT,
`user_id` int(10) DEFAULT NULL,
`time_sent` datetime DEFAULT NULL,
`phone_number` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`verified` tinyint(1) NOT NULL DEFAULT '0',
PRIMARY KEY (`tf_id`),
KEY `phone_number` (`phone_number`),
KEY `time_sent` (`time_sent`),
KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_user_information` (
`ui_id` int(10) NOT NULL AUTO_INCREMENT,
`username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`user_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Primary email',
`user_email2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Secondary email',
`user_email3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Tertiary email',
`user_phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`user_phone_sms` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`user_firstname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`user_lastname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`user_inst_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`super_user` int(1) NOT NULL DEFAULT '0',
`account_manager` int(1) NOT NULL DEFAULT '0',
`user_creation` datetime DEFAULT NULL COMMENT 'Time user account was created',
`user_firstvisit` datetime DEFAULT NULL,
`user_firstactivity` datetime DEFAULT NULL,
`user_lastactivity` datetime DEFAULT NULL,
`user_lastlogin` datetime DEFAULT NULL,
`user_suspended_time` datetime DEFAULT NULL,
`user_expiration` datetime DEFAULT NULL COMMENT 'Time at which the user will be automatically suspended from REDCap',
`user_access_dashboard_view` datetime DEFAULT NULL,
`user_access_dashboard_email_queued` enum('QUEUED','SENDING') COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Tracks status of email reminder for User Access Dashboard',
`user_sponsor` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Username of user''s sponsor or contact person',
`user_comments` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Miscellaneous comments about user',
`allow_create_db` int(1) NOT NULL DEFAULT '1',
`email_verify_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Primary email verification code',
`email2_verify_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Secondary email verification code',
`email3_verify_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Tertiary email verification code',
`datetime_format` enum('M-D-Y_24','M-D-Y_12','M/D/Y_24','M/D/Y_12','M.D.Y_24','M.D.Y_12','D-M-Y_24','D-M-Y_12','D/M/Y_24','D/M/Y_12','D.M.Y_24','D.M.Y_12','Y-M-D_24','Y-M-D_12','Y/M/D_24','Y/M/D_12','Y.M.D_24','Y.M.D_12') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'M/D/Y_12' COMMENT 'User''s preferred datetime viewing format',
`number_format_decimal` enum('.',',') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '.' COMMENT 'User''s preferred decimal format',
`number_format_thousands_sep` enum(',','.','','SPACE','''') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT ',' COMMENT 'User''s preferred thousands separator',
`two_factor_auth_secret` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`display_on_email_users` int(1) NOT NULL DEFAULT '1',
`two_factor_auth_twilio_prompt_phone` tinyint(1) NOT NULL DEFAULT '1',
`two_factor_auth_code_expiration` int(3) NOT NULL DEFAULT '2',
`api_token` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`messaging_email_preference` enum('NONE','2_HOURS','4_HOURS','6_HOURS','8_HOURS','12_HOURS','DAILY') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '4_HOURS',
`messaging_email_urgent_all` tinyint(1) NOT NULL DEFAULT '1',
`messaging_email_ts` datetime DEFAULT NULL,
`ui_state` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`api_token_auto_request` tinyint(1) NOT NULL DEFAULT '0',
`fhir_data_mart_create_project` tinyint(1) NOT NULL DEFAULT '0',
PRIMARY KEY (`ui_id`),
UNIQUE KEY `api_token` (`api_token`),
UNIQUE KEY `email2_verify_code` (`email2_verify_code`),
UNIQUE KEY `email3_verify_code` (`email3_verify_code`),
UNIQUE KEY `email_verify_code` (`email_verify_code`),
UNIQUE KEY `username` (`username`),
KEY `two_factor_auth_secret` (`two_factor_auth_secret`),
KEY `user_access_dashboard_email_queued` (`user_access_dashboard_email_queued`),
KEY `user_access_dashboard_view` (`user_access_dashboard_view`),
KEY `user_comments` (`user_comments`(190)),
KEY `user_creation` (`user_creation`),
KEY `user_email` (`user_email`(191)),
KEY `user_expiration` (`user_expiration`),
KEY `user_firstactivity` (`user_firstactivity`),
KEY `user_firstname` (`user_firstname`(191)),
KEY `user_firstvisit` (`user_firstvisit`),
KEY `user_inst_id` (`user_inst_id`(191)),
KEY `user_lastactivity` (`user_lastactivity`),
KEY `user_lastlogin` (`user_lastlogin`),
KEY `user_lastname` (`user_lastname`(191)),
KEY `user_sponsor` (`user_sponsor`(191)),
KEY `user_suspended_time` (`user_suspended_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_user_rights` (
`project_id` int(10) NOT NULL DEFAULT '0',
`username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
`expiration` date DEFAULT NULL,
`role_id` int(10) DEFAULT NULL,
`group_id` int(10) DEFAULT NULL,
`lock_record` int(1) NOT NULL DEFAULT '0',
`lock_record_multiform` int(1) NOT NULL DEFAULT '0',
`lock_record_customize` int(1) NOT NULL DEFAULT '0',
`data_export_tool` int(1) NOT NULL DEFAULT '1',
`data_import_tool` int(1) NOT NULL DEFAULT '1',
`data_comparison_tool` int(1) NOT NULL DEFAULT '1',
`data_logging` int(1) NOT NULL DEFAULT '1',
`file_repository` int(1) NOT NULL DEFAULT '1',
`double_data` int(1) NOT NULL DEFAULT '0',
`user_rights` int(1) NOT NULL DEFAULT '1',
`data_access_groups` int(1) NOT NULL DEFAULT '1',
`graphical` int(1) NOT NULL DEFAULT '1',
`reports` int(1) NOT NULL DEFAULT '1',
`design` int(1) NOT NULL DEFAULT '0',
`calendar` int(1) NOT NULL DEFAULT '1',
`data_entry` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`api_token` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`api_export` int(1) NOT NULL DEFAULT '0',
`api_import` int(1) NOT NULL DEFAULT '0',
`mobile_app` int(1) NOT NULL DEFAULT '0',
`mobile_app_download_data` int(1) NOT NULL DEFAULT '0',
`record_create` int(1) NOT NULL DEFAULT '1',
`record_rename` int(1) NOT NULL DEFAULT '0',
`record_delete` int(1) NOT NULL DEFAULT '0',
`dts` int(1) NOT NULL DEFAULT '0' COMMENT 'DTS adjudication page',
`participants` int(1) NOT NULL DEFAULT '1',
`data_quality_design` int(1) NOT NULL DEFAULT '0',
`data_quality_execute` int(1) NOT NULL DEFAULT '0',
`data_quality_resolution` int(1) NOT NULL DEFAULT '0' COMMENT '0=No access, 1=View only, 2=Respond, 3=Open, close, respond, 4=Open only, 5=Open and respond',
`random_setup` int(1) NOT NULL DEFAULT '0',
`random_dashboard` int(1) NOT NULL DEFAULT '0',
`random_perform` int(1) NOT NULL DEFAULT '0',
`realtime_webservice_mapping` int(1) NOT NULL DEFAULT '0' COMMENT 'User can map fields for RTWS',
`realtime_webservice_adjudicate` int(1) NOT NULL DEFAULT '0' COMMENT 'User can adjudicate data for RTWS',
`external_module_config` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`project_id`,`username`),
UNIQUE KEY `api_token` (`api_token`),
KEY `group_id` (`group_id`),
KEY `project_id` (`project_id`),
KEY `role_id` (`role_id`),
KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_user_roles` (
`role_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`role_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name of user role',
`lock_record` int(1) NOT NULL DEFAULT '0',
`lock_record_multiform` int(1) NOT NULL DEFAULT '0',
`lock_record_customize` int(1) NOT NULL DEFAULT '0',
`data_export_tool` int(1) NOT NULL DEFAULT '1',
`data_import_tool` int(1) NOT NULL DEFAULT '1',
`data_comparison_tool` int(1) NOT NULL DEFAULT '1',
`data_logging` int(1) NOT NULL DEFAULT '1',
`file_repository` int(1) NOT NULL DEFAULT '1',
`double_data` int(1) NOT NULL DEFAULT '0',
`user_rights` int(1) NOT NULL DEFAULT '1',
`data_access_groups` int(1) NOT NULL DEFAULT '1',
`graphical` int(1) NOT NULL DEFAULT '1',
`reports` int(1) NOT NULL DEFAULT '1',
`design` int(1) NOT NULL DEFAULT '0',
`calendar` int(1) NOT NULL DEFAULT '1',
`data_entry` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`api_export` int(1) NOT NULL DEFAULT '0',
`api_import` int(1) NOT NULL DEFAULT '0',
`mobile_app` int(1) NOT NULL DEFAULT '0',
`mobile_app_download_data` int(1) NOT NULL DEFAULT '0',
`record_create` int(1) NOT NULL DEFAULT '1',
`record_rename` int(1) NOT NULL DEFAULT '0',
`record_delete` int(1) NOT NULL DEFAULT '0',
`dts` int(1) NOT NULL DEFAULT '0' COMMENT 'DTS adjudication page',
`participants` int(1) NOT NULL DEFAULT '1',
`data_quality_design` int(1) NOT NULL DEFAULT '0',
`data_quality_execute` int(1) NOT NULL DEFAULT '0',
`data_quality_resolution` int(1) NOT NULL DEFAULT '0' COMMENT '0=No access, 1=View only, 2=Respond, 3=Open, close, respond',
`random_setup` int(1) NOT NULL DEFAULT '0',
`random_dashboard` int(1) NOT NULL DEFAULT '0',
`random_perform` int(1) NOT NULL DEFAULT '0',
`realtime_webservice_mapping` int(1) NOT NULL DEFAULT '0' COMMENT 'User can map fields for RTWS',
`realtime_webservice_adjudicate` int(1) NOT NULL DEFAULT '0' COMMENT 'User can adjudicate data for RTWS',
`external_module_config` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`role_id`),
KEY `project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_user_whitelist` (
`username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_validation_types` (
`validation_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Unique name for Data Dictionary',
`validation_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Label in Online Designer',
`regex_js` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`regex_php` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`data_type` enum('date','datetime','datetime_seconds','email','integer','mrn','number','number_comma_decimal','phone','postal_code','ssn','text','time','char') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`legacy_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`visible` int(1) NOT NULL DEFAULT '1' COMMENT 'Show in Online Designer?',
UNIQUE KEY `validation_name` (`validation_name`),
KEY `data_type` (`data_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `redcap_web_service_cache` (
`cache_id` int(10) NOT NULL AUTO_INCREMENT,
`project_id` int(10) DEFAULT NULL,
`service` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`category` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`value` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
`label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
PRIMARY KEY (`cache_id`),
UNIQUE KEY `project_service_cat_value` (`project_id`,`service`,`category`,`value`),
KEY `category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `redcap_actions`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`recipient_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`survey_id`) REFERENCES `redcap_surveys` (`survey_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_alerts`
ADD FOREIGN KEY (`email_attachment1`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`email_attachment2`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`email_attachment3`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`email_attachment4`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`email_attachment5`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`form_name_event`) REFERENCES `redcap_events_metadata` (`event_id`),
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_alerts_recurrence`
ADD FOREIGN KEY (`alert_id`) REFERENCES `redcap_alerts` (`alert_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`);

ALTER TABLE `redcap_alerts_sent`
ADD FOREIGN KEY (`alert_id`) REFERENCES `redcap_alerts` (`alert_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_alerts_sent_log`
ADD FOREIGN KEY (`alert_sent_id`) REFERENCES `redcap_alerts_sent` (`alert_sent_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_auth`
ADD FOREIGN KEY (`password_question`) REFERENCES `redcap_auth_questions` (`qid`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_crons`
ADD FOREIGN KEY (`external_module_id`) REFERENCES `redcap_external_modules` (`external_module_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_crons_history`
ADD FOREIGN KEY (`cron_id`) REFERENCES `redcap_crons` (`cron_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_data_access_groups`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_data_dictionaries`
ADD FOREIGN KEY (`doc_id`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`ui_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_data_quality_resolutions`
ADD FOREIGN KEY (`status_id`) REFERENCES `redcap_data_quality_status` (`status_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`upload_doc_id`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`user_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_data_quality_rules`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_data_quality_status`
ADD FOREIGN KEY (`assigned_user_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`rule_id`) REFERENCES `redcap_data_quality_rules` (`rule_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_ddp_log_view`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`user_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_ddp_log_view_data`
ADD FOREIGN KEY (`md_id`) REFERENCES `redcap_ddp_records_data` (`md_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`ml_id`) REFERENCES `redcap_ddp_log_view` (`ml_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_ddp_mapping`
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_ddp_preview_fields`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_ddp_records`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_ddp_records_data`
ADD FOREIGN KEY (`map_id`) REFERENCES `redcap_ddp_mapping` (`map_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`mr_id`) REFERENCES `redcap_ddp_records` (`mr_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_docs`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_docs_to_edocs`
ADD FOREIGN KEY (`doc_id`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`docs_id`) REFERENCES `redcap_docs` (`docs_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_edocs_metadata`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_ehr_access_tokens`
ADD FOREIGN KEY (`token_owner`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_ehr_datamart_revisions`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`request_id`) REFERENCES `redcap_todo_list` (`request_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`user_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_ehr_user_map`
ADD FOREIGN KEY (`redcap_userid`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_ehr_user_projects`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`redcap_userid`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_esignatures`
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_events_arms`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_events_calendar`
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`group_id`) REFERENCES `redcap_data_access_groups` (`group_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_events_forms`
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_events_metadata`
ADD FOREIGN KEY (`arm_id`) REFERENCES `redcap_events_arms` (`arm_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_events_repeat`
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_external_links`
ADD FOREIGN KEY (`link_to_project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_external_links_dags`
ADD FOREIGN KEY (`ext_id`) REFERENCES `redcap_external_links` (`ext_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`group_id`) REFERENCES `redcap_data_access_groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_external_links_exclude_projects`
ADD FOREIGN KEY (`ext_id`) REFERENCES `redcap_external_links` (`ext_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_external_links_users`
ADD FOREIGN KEY (`ext_id`) REFERENCES `redcap_external_links` (`ext_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_external_module_settings`
ADD FOREIGN KEY (`external_module_id`) REFERENCES `redcap_external_modules` (`external_module_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_external_modules_log_parameters`
ADD FOREIGN KEY (`log_id`) REFERENCES `redcap_external_modules_log` (`log_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_folders`
ADD FOREIGN KEY (`ui_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_folders_projects`
ADD FOREIGN KEY (`folder_id`) REFERENCES `redcap_folders` (`folder_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`ui_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_instrument_zip`
ADD FOREIGN KEY (`iza_id`) REFERENCES `redcap_instrument_zip_authors` (`iza_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_library_map`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_locking_data`
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_locking_labels`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_log_view_requests`
ADD FOREIGN KEY (`log_view_id`) REFERENCES `redcap_log_view` (`log_view_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`ui_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_messages`
ADD FOREIGN KEY (`attachment_doc_id`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`author_user_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`thread_id`) REFERENCES `redcap_messages_threads` (`thread_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_messages_recipients`
ADD FOREIGN KEY (`recipient_user_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`thread_id`) REFERENCES `redcap_messages_threads` (`thread_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_messages_status`
ADD FOREIGN KEY (`message_id`) REFERENCES `redcap_messages` (`message_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`recipient_id`) REFERENCES `redcap_messages_recipients` (`recipient_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`recipient_user_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_messages_threads`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_metadata`
ADD FOREIGN KEY (`edoc_id`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_metadata_archive`
ADD FOREIGN KEY (`edoc_id`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`pr_id`) REFERENCES `redcap_metadata_prod_revisions` (`pr_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_metadata_prod_revisions`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`ui_id_approver`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`ui_id_requester`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_metadata_temp`
ADD FOREIGN KEY (`edoc_id`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_mobile_app_devices`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_mobile_app_files`
ADD FOREIGN KEY (`device_id`) REFERENCES `redcap_mobile_app_devices` (`device_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`doc_id`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`user_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_mobile_app_log`
ADD FOREIGN KEY (`device_id`) REFERENCES `redcap_mobile_app_devices` (`device_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`log_event_id`) REFERENCES `redcap_log_event` (`log_event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`ui_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_new_record_cache`
ADD FOREIGN KEY (`arm_id`) REFERENCES `redcap_events_arms` (`arm_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_project_checklist`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_projects`
ADD FOREIGN KEY (`created_by`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`survey_auth_event_id1`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`survey_auth_event_id2`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`survey_auth_event_id3`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`template_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_projects_templates`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_pub_articles`
ADD FOREIGN KEY (`pubsrc_id`) REFERENCES `redcap_pub_sources` (`pubsrc_id`);

ALTER TABLE `redcap_pub_authors`
ADD FOREIGN KEY (`article_id`) REFERENCES `redcap_pub_articles` (`article_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_pub_matches`
ADD FOREIGN KEY (`article_id`) REFERENCES `redcap_pub_articles` (`article_id`) ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON UPDATE CASCADE;

ALTER TABLE `redcap_pub_mesh_terms`
ADD FOREIGN KEY (`article_id`) REFERENCES `redcap_pub_articles` (`article_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_randomization`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event1`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event10`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event11`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event12`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event13`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event14`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event15`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event2`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event3`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event4`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event5`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event6`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event7`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event8`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`source_event9`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`target_event`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_randomization_allocation`
ADD FOREIGN KEY (`group_id`) REFERENCES `redcap_data_access_groups` (`group_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`rid`) REFERENCES `redcap_randomization` (`rid`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_record_counts`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_record_dashboards`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`sort_event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_record_list`
ADD FOREIGN KEY (`dag_id`) REFERENCES `redcap_data_access_groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_reports`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_reports_access_dags`
ADD FOREIGN KEY (`group_id`) REFERENCES `redcap_data_access_groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`report_id`) REFERENCES `redcap_reports` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_reports_access_roles`
ADD FOREIGN KEY (`report_id`) REFERENCES `redcap_reports` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`role_id`) REFERENCES `redcap_user_roles` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_reports_access_users`
ADD FOREIGN KEY (`report_id`) REFERENCES `redcap_reports` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_reports_edit_access_dags`
ADD FOREIGN KEY (`group_id`) REFERENCES `redcap_data_access_groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`report_id`) REFERENCES `redcap_reports` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_reports_edit_access_roles`
ADD FOREIGN KEY (`report_id`) REFERENCES `redcap_reports` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`role_id`) REFERENCES `redcap_user_roles` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_reports_edit_access_users`
ADD FOREIGN KEY (`report_id`) REFERENCES `redcap_reports` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_reports_fields`
ADD FOREIGN KEY (`limiter_event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`report_id`) REFERENCES `redcap_reports` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_reports_filter_dags`
ADD FOREIGN KEY (`group_id`) REFERENCES `redcap_data_access_groups` (`group_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`report_id`) REFERENCES `redcap_reports` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_reports_filter_events`
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`report_id`) REFERENCES `redcap_reports` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_reports_folders`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_reports_folders_items`
ADD FOREIGN KEY (`folder_id`) REFERENCES `redcap_reports_folders` (`folder_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`report_id`) REFERENCES `redcap_reports` (`report_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_sendit_recipients`
ADD FOREIGN KEY (`document_id`) REFERENCES `redcap_sendit_docs` (`document_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys`
ADD FOREIGN KEY (`confirmation_email_attachment`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`logo`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`pdf_econsent_dob_event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`pdf_econsent_firstname_event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`pdf_econsent_lastname_event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`theme`) REFERENCES `redcap_surveys_themes` (`theme_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys_emails`
ADD FOREIGN KEY (`email_sender`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE SET NULL ON UPDATE SET NULL,
ADD FOREIGN KEY (`survey_id`) REFERENCES `redcap_surveys` (`survey_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys_emails_recipients`
ADD FOREIGN KEY (`email_id`) REFERENCES `redcap_surveys_emails` (`email_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`participant_id`) REFERENCES `redcap_surveys_participants` (`participant_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys_erase_twilio_log`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys_login`
ADD FOREIGN KEY (`response_id`) REFERENCES `redcap_surveys_response` (`response_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys_participants`
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`survey_id`) REFERENCES `redcap_surveys` (`survey_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys_pdf_archive`
ADD FOREIGN KEY (`doc_id`) REFERENCES `redcap_edocs_metadata` (`doc_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`survey_id`) REFERENCES `redcap_surveys` (`survey_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys_phone_codes`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys_queue`
ADD FOREIGN KEY (`condition_surveycomplete_event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`condition_surveycomplete_survey_id`) REFERENCES `redcap_surveys` (`survey_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`survey_id`) REFERENCES `redcap_surveys` (`survey_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys_queue_hashes`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys_response`
ADD FOREIGN KEY (`participant_id`) REFERENCES `redcap_surveys_participants` (`participant_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys_scheduler`
ADD FOREIGN KEY (`condition_surveycomplete_event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`condition_surveycomplete_survey_id`) REFERENCES `redcap_surveys` (`survey_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`event_id`) REFERENCES `redcap_events_metadata` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`survey_id`) REFERENCES `redcap_surveys` (`survey_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys_scheduler_queue`
ADD FOREIGN KEY (`email_recip_id`) REFERENCES `redcap_surveys_emails_recipients` (`email_recip_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`ss_id`) REFERENCES `redcap_surveys_scheduler` (`ss_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys_short_codes`
ADD FOREIGN KEY (`participant_id`) REFERENCES `redcap_surveys_participants` (`participant_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_surveys_themes`
ADD FOREIGN KEY (`ui_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_todo_list`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`request_completion_userid`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE SET NULL,
ADD FOREIGN KEY (`request_from`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_two_factor_response`
ADD FOREIGN KEY (`user_id`) REFERENCES `redcap_user_information` (`ui_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_user_rights`
ADD FOREIGN KEY (`group_id`) REFERENCES `redcap_data_access_groups` (`group_id`) ON DELETE SET NULL ON UPDATE CASCADE,
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (`role_id`) REFERENCES `redcap_user_roles` (`role_id`) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE `redcap_user_roles`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `redcap_web_service_cache`
ADD FOREIGN KEY (`project_id`) REFERENCES `redcap_projects` (`project_id`) ON DELETE CASCADE ON UPDATE CASCADE;
-- REDCAP INSTALLATION INITIAL DATA --

INSERT INTO redcap_user_information (username, user_email, user_firstname, user_lastname, super_user, user_firstvisit) VALUES
('site_admin', 'joe.user@projectredcap.org', 'Joe', 'User', 1, now());

INSERT INTO redcap_crons (cron_name, cron_description, cron_enabled, cron_frequency, cron_max_run_time, cron_instances_max, cron_instances_current, cron_last_run_end, cron_times_failed, cron_external_url) VALUES
('PubMed', 'Query the PubMed API to find publications associated with PIs in REDCap, and store publication attributes and PI/project info. Emails will then be sent to any PIs that have been found to have publications in PubMed, and (if applicable) will be asked to associate their publication to a REDCap project.', 'DISABLED', 86400, 7200, 1, 0, NULL, 0, NULL),
('RemoveTempAndDeletedFiles', 'Delete all files from the REDCap temp directory, and delete all edoc and Send-It files marked for deletion.', 'ENABLED', 120, 600, 1, 0, NULL, 0, NULL),
('ExpireSurveys', 'For any surveys where an expiration timestamp is set, if the timestamp <= NOW, then make the survey inactive.', 'ENABLED', 120, 600, 1, 0, NULL, 0, NULL),
('SurveyInvitationEmailer', 'Mailer that sends any survey invitations that have been scheduled.', 'ENABLED', 60, 1800, 5, 0, NULL, 0, NULL),
('DeleteProjects', 'Delete all projects that are scheduled for permanent deletion', 'ENABLED', 300, 1200, 1, 0, NULL, 0, NULL),
('ClearIPCache',  'Clear all IP addresses older than X minutes from the redcap_ip_cache table.',  'ENABLED',  180,  60,  1,  0, NULL , 0, NULL),
('ExpireUsers', 'For any users whose expiration timestamp is set, if the timestamp <= NOW, then suspend the user''s account and set expiration time back to NULL.', 'ENABLED', 120, 600, 1, 0, NULL, 0, NULL),
('WarnUsersAccountExpiration', 'For any users whose expiration timestamp is set, if the expiration time is less than X days from now, then email the user to warn them of their impending account expiration.', 'ENABLED', 86400, 600, 1, 0, NULL, 0, NULL),
('SuspendInactiveUsers', 'For any users whose last login time exceeds the defined max days of inactivity, auto-suspend their account (if setting enabled).', 'ENABLED', 86400, 600, 1, 0, NULL, 0, NULL),
('ReminderUserAccessDashboard', 'At a regular interval, email all users to remind them to visit the User Access Dashboard page. Enables the ReminderUserAccessDashboardEmail cron job.', 'ENABLED', 86400, 600, 1, 0, NULL, 0, NULL),
('ReminderUserAccessDashboardEmail', 'Email all users in batches to remind them to visit the User Access Dashboard page. Will disable itself when done.', 'DISABLED', 60, 1800, 5, 0, NULL, 0, NULL),
('DDPQueueRecordsAllProjects', 'Queue records that are ready to be fetched from the external source system via the DDP service.', 'ENABLED', 300, 600, 1, 0, NULL, 0, NULL),
('DDPFetchRecordsAllProjects', 'Fetch data from the external source system for records already queued by the DDP service.', 'ENABLED', 60, 1800, 5, 0, NULL, 0, NULL),
('PurgeCronHistory', 'Purges all rows from the crons history table that are older than one week.', 'ENABLED', 86400, 600, 1, 0, NULL, 0, NULL),
('UpdateUserPasswordAlgo', 'Send email to all Table-based users telling them to log in for the purpose of upgrading their password security (one time only)', 'DISABLED', 86400, 7200, 1, 0, NULL, 0, NULL),
('AutomatedSurveyInvitationsDatediffChecker', 'Check all conditional logic in Automated Surveys Invitations that uses "today" inside datediff() function', 'DISABLED', 43200, 7200, 1, 0, NULL, 0, NULL),
('AutomatedSurveyInvitationsDatediffChecker2', 'Check all conditional logic in Automated Surveys Invitations that uses "today" inside datediff() function - replacement for AutomatedSurveyInvitationsDatediffChecker', 'ENABLED', 14400, 7200, 1, 0, NULL, 0, NULL),
('ClearSurveyShortCodes', 'Clear all survey short codes older than X minutes.',  'ENABLED',  300,  60,  1,  0, NULL , 0, NULL),
('ClearLogViewRequests', 'Clear all items from redcap_log_view_requests table older than X hours.',  'ENABLED',  1800,  300,  1,  0, NULL , 0, NULL),
('EraseTwilioLog', 'Clear all items from redcap_surveys_erase_twilio_log table.',  'ENABLED',  120,  300,  1,  0, NULL , 0, NULL),
('ClearNewRecordCache', 'Clear all items from redcap_new_record_cache table older than X hours.',  'ENABLED',  10800,  300,  1,  0, NULL , 0, NULL),
('FixStuckSurveyInvitations', 'Reset any survey invitations stuck in SENDING status for than X hours back to QUEUED status.',  'ENABLED',  3600,  300,  1,  0, NULL , 0, NULL),
('DbUsage', 'Record the daily space usage of the database tables and the uploaded files stored on the server.', 'ENABLED', 86400, 600, 1, 0, NULL, 0, NULL),
('RemoveOutdatedRecordCounts', 'Delete all rows from the record counts table older than X days.', 'ENABLED', 3600, 60, 1, 0, NULL, 0, NULL),
('DDPReencryptData', 'Re-encrypt all DDP data from the external source system.', 'ENABLED', 60, 1800, 10, 0, NULL, 0, NULL),
('UserMessagingEmailNotifications', 'Send notification emails to users who are logged out but have received a user message or notification.', 'ENABLED', 60, 600, 1, 0, NULL, 0, NULL),
('CacheStatsReportingUrl', 'Generate the stats reporting URL and store it in the config table.', 'ENABLED', 10800, 1200, 1, 0, NULL, 0, NULL),
('ExternalModuleValidation', 'Perform various validation checks on External Modules that are installed.', 'ENABLED', 1800, 300, 1, 0, NULL, 0, NULL),
('CheckREDCapRepoUpdates', 'Check if any installed External Modules have updates available on the REDCap Repo.', 'ENABLED', 10800, 300, 1, 0, NULL, 0, NULL),
('CheckREDCapVersionUpdates', 'Check if there is a newer REDCap version available', 'ENABLED', 10800, 300, 1, 0, NULL, 0, NULL),
('DeleteFileRepositoryExportFiles', 'For projects with this feature enabled, delete all archived data export files older than X days.', 'ENABLED', 43200, 300, 1, 0, NULL, 0, NULL),
('AlertsNotificationsSender', 'Sends notifications for Alerts', 'ENABLED', 60, 1800, 5, 0, NULL, 0, NULL),
('AlertsNotificationsDatediffChecker', 'Check all conditional logic in Alerts that uses "today" inside datediff() function', 'ENABLED', 14400, 7200, 1, 0, NULL, 0, NULL),
('ClinicalDataMartDataFetch', 'Fetches EHR data for all Clinical Data Mart projects', 'ENABLED', 43200, 3600, 1, 0, NULL, 0, NULL);

INSERT INTO redcap_auth_questions (qid, question) VALUES
(1, 'What was your childhood nickname?'),
(2, 'In what city did you meet your spouse/significant other?'),
(3, 'What is the name of your favorite childhood friend?'),
(4, 'What street did you live on in third grade?'),
(5, 'What is your oldest sibling''s birthday month and year? (e.g., January 1900)'),
(6, 'What is the middle name of your oldest child?'),
(7, 'What is your oldest sibling''s middle name?'),
(8, 'What school did you attend for sixth grade?'),
(9, 'What was your childhood phone number including area code? (e.g., 000-000-0000)'),
(10, 'What is your oldest cousin''s first and last name?'),
(11, 'What was the name of your first stuffed animal?'),
(12, 'In what city or town did your mother and father meet?'),
(13, 'Where were you when you had your first kiss?'),
(14, 'What is the first name of the boy or girl that you first kissed?'),
(15, 'What was the last name of your third grade teacher?'),
(16, 'In what city does your nearest sibling live?'),
(17, 'What is your oldest brother''s birthday month and year? (e.g., January 1900)'),
(18, 'What is your maternal grandmother''s maiden name?'),
(19, 'In what city or town was your first job?'),
(20, 'What is the name of the place your wedding reception was held?'),
(21, 'What is the name of a college you applied to but didn''t attend?');

INSERT INTO redcap_config (field_name, value) VALUES
('allow_outbound_http', '1'),
('drw_upload_option_enabled', '1'),
('pdf_econsent_system_custom_text', ''),
('alerts_email_freeform_domain_whitelist', ''),
('alerts_allow_email_variables', '1'),
('alerts_allow_email_freeform', '1'),
('azure_quickstart', '0'),
('google_recaptcha_site_key', ''),
('google_recaptcha_secret_key', ''),
('aws_quickstart', '0'),
('user_messaging_prevent_admin_messaging', '0'),
('homepage_announcement_login', '1'),
('azure_app_name', ''),
('azure_app_secret', ''),
('azure_container', ''),
('redcap_updates_community_user', ''),
('redcap_updates_community_password', ''),
('redcap_updates_user', ''),
('redcap_updates_password', ''),
('redcap_updates_password_encrypted', '1'),
('redcap_updates_available', ''),
('redcap_updates_available_last_check', ''),
('realtime_webservice_convert_timestamp_from_gmt', '0'),
('fhir_convert_timestamp_from_gmt', '0'),
('db_collation', 'utf8mb4_unicode_ci'),
('db_character_set', 'utf8mb4'),
('external_modules_updates_available', ''),
('external_modules_updates_available_last_check', ''),
('pdf_econsent_system_ip', '1'),
('pdf_econsent_filesystem_type', ''),
('pdf_econsent_filesystem_host', ''),
('pdf_econsent_filesystem_username', ''),
('pdf_econsent_filesystem_password', ''),
('pdf_econsent_filesystem_path', ''),
('pdf_econsent_filesystem_private_key_path', ''),
('pdf_econsent_system_enabled', '1'),
('enable_edit_prod_repeating_setup', '1'),
('user_sponsor_set_expiration_days', '365'),
('user_sponsor_dashboard_enable', '1'),
('clickjacking_prevention', '0'),
('external_module_alt_paths', ''),
('aafAccessUrl', ''),
('aafAllowLocalsCreateDB', ''),
('aafAud', ''),
('aafDisplayOnEmailUsers', ''),
('aafIss', ''),
('aafPrimaryField', ''),
('aafScopeTarget', ''),
('external_modules_project_custom_text', ''),
('is_development_server', '0'),
('fhir_data_mart_create_project', '0'),
('fhir_data_fetch_interval', '24'),
('fhir_url_user_access', ''),
('fhir_custom_text', ''),
('fhir_display_info_project_setup', '1'),
('fhir_source_system_custom_name', 'EHR'),
('fhir_user_rights_super_users_only', '1'),
('fhir_stop_fetch_inactivity_days', '7'),
('fhir_ddp_enabled', '0'),
('api_token_request_type', 'admin_approve'),
('fhir_endpoint_authorize_url', ''),
('fhir_endpoint_token_url', ''),
('fhir_ehr_mrn_identifier', ''),
('fhir_client_id', ''),
('fhir_client_secret', ''),
('fhir_endpoint_base_url', ''),
('report_stats_url', ''),
('user_messaging_enabled', '1'),
('auto_prod_changes_check_identifiers', '0'),
('bioportal_api_url', 'https://data.bioontology.org/'),
('send_emails_admin_tasks', '1'),
('display_project_xml_backup_option', '1'),
('cross_domain_access_control', ''),
('google_cloud_storage_edocs_bucket', ''),
('google_cloud_storage_temp_bucket', ''),
('amazon_s3_endpoint', ''),
('proxy_username_password', ''),
('homepage_contact_url', ''),
('bioportal_api_token', ''),
('two_factor_auth_ip_range_alt', ''),
('two_factor_auth_trust_period_days_alt', '0'),
('two_factor_auth_trust_period_days', '0'),
('two_factor_auth_email_enabled', '1'),
('two_factor_auth_authenticator_enabled', '1'),
('two_factor_auth_ip_check_enabled', '0'),
('two_factor_auth_ip_range', ''),
('two_factor_auth_ip_range_include_private', '0'),
('two_factor_auth_duo_enabled', '0'),
('two_factor_auth_duo_ikey', ''),
('two_factor_auth_duo_skey', ''),
('two_factor_auth_duo_hostname', ''),
('bioportal_ontology_list_cache_time', ''),
('bioportal_ontology_list', ''),
('redcap_survey_base_url', ''),
('enable_ontology_auto_suggest', '1'),
('enable_survey_text_to_speech', '1'),
('enable_field_attachment_video_url', '1'),
('google_oauth2_client_id', ''),
('google_oauth2_client_secret', ''),
('two_factor_auth_twilio_enabled', '0'),
('two_factor_auth_twilio_account_sid', ''),
('two_factor_auth_twilio_auth_token', ''),
('two_factor_auth_twilio_from_number', ''),
('two_factor_auth_enabled', '0'),
('allow_kill_mysql_process', '0'),
('mobile_app_enabled', '1'),
('twilio_display_info_project_setup', '0'),
('twilio_enabled_global', '1'),
('twilio_enabled_by_super_users_only', '1'),
('field_comment_log_enabled_default', '1'),
('from_email', ''),
('promis_enabled', '1'),
('promis_api_base_url', 'https://www.redcap-cats.org/promis_api/'),
('sams_logout', ''),
('promis_registration_id', ''),
('promis_token', ''),
('hook_functions_file', ''),
('project_encoding', ''),
('default_datetime_format', 'M/D/Y_12'),
('default_number_format_decimal', '.'),
('default_number_format_thousands_sep', ','),
('homepage_announcement', ''),
('password_algo', 'md5'),
('password_recovery_custom_text', ''),
('user_access_dashboard_enable', '1'),
('user_access_dashboard_custom_notification', ''),
('suspend_users_inactive_send_email', 1),
('suspend_users_inactive_days', 180),
('suspend_users_inactive_type', ''),
('page_hit_threshold_per_minute', '600'),
('enable_http_compression', '1'),
('realtime_webservice_data_fetch_interval', '24'),
('realtime_webservice_url_metadata', ''),
('realtime_webservice_url_data', ''),
('realtime_webservice_url_user_access', ''),
('realtime_webservice_global_enabled', '0'),
('realtime_webservice_custom_text', ''),
('realtime_webservice_display_info_project_setup', '1'),
('realtime_webservice_source_system_custom_name', ''),
('realtime_webservice_user_rights_super_users_only', '1'),
('realtime_webservice_stop_fetch_inactivity_days', '7'),
('amazon_s3_key', ''),
('amazon_s3_secret', ''),
('amazon_s3_bucket', ''),
('system_offline_message', ''),
('openid_provider_url', ''),
('openid_provider_name', ''),
('file_attachment_upload_max', ''),
('data_entry_trigger_enabled', '1'),
('redcap_base_url_display_error_on_mismatch', '1'),
('email_domain_whitelist', ''),
('helpfaq_custom_text', ''),
('randomization_global', '1'),
('login_custom_text', ''),
('auto_prod_changes', '4'),
('enable_edit_prod_events', '1'),
('allow_create_db_default', '1'),
('api_enabled', '1'),
('auth_meth_global', 'none'),
('auto_report_stats', '1'),
('auto_report_stats_last_sent', '2000-01-01'),
('autologout_timer', '30'),
('certify_text_create', ''),
('certify_text_prod', ''),
('homepage_custom_text', ''),
('dts_enabled_global', '0'),
('display_nonauth_projects', '1'),
('display_project_logo_institution', '0'),
('display_today_now_button', '1'),
('edoc_field_option_enabled', '1'),
('edoc_upload_max', ''),
('edoc_storage_option', '0'),
('file_repository_upload_max', ''),
('file_repository_enabled', '1'),
('temp_files_last_delete', now()),
('edoc_path', ''),
('enable_edit_survey_response', '1'),
('enable_plotting', '2'),
('enable_plotting_survey_results', '1'),
('enable_projecttype_singlesurvey', '1'),
('enable_projecttype_forms', '1'),
('enable_projecttype_singlesurveyforms', '1'),
('enable_url_shortener', '1'),
('enable_user_whitelist', '0'),
('logout_fail_limit', '5'),
('logout_fail_window', '15'),
('footer_links', ''),
('footer_text', ''),
('google_translate_enabled', '0'),
('googlemap_key',''),
('grant_cite', ''),
('headerlogo', ''),
('homepage_contact', ''),
('homepage_contact_email', ''),
('homepage_grant_cite', ''),
('identifier_keywords', 'name, street, address, city, county, precinct, zip, postal, date, phone, fax, mail, ssn, social security, mrn, dob, dod, medical, record, id, age'),
('institution', ''),
('language_global','English'),
('login_autocomplete_disable', '0'),
('login_logo', ''),
('my_profile_enable_edit','1'),
('password_history_limit','0'),
('password_reset_duration','0'),
('project_contact_email', ''),
('project_contact_name', ''),
('project_language', 'English'),
('proxy_hostname', ''),
('pub_matching_enabled', '0'),
('redcap_base_url', ''),
('pub_matching_emails', '0'),
('pub_matching_email_days', '7'),
('pub_matching_email_limit', '3'),
('pub_matching_email_text', ''),
('pub_matching_email_subject', ''),
('pub_matching_institution', 'Vanderbilt\nMeharry'),
('redcap_last_install_date', CURRENT_DATE),
('redcap_version', '9.1.8'),
('sendit_enabled', '1'),
('sendit_upload_max', ''),
('shared_library_enabled', '1'),
('shibboleth_logout', ''),
('shibboleth_username_field', 'none'),
('site_org_type', ''),
('superusers_only_create_project', '0'),
('superusers_only_move_to_prod', '1'),
('system_offline', '0');

INSERT INTO `redcap_pub_sources` (`pubsrc_id`, `pubsrc_name`, `pubsrc_last_crawl_time`) VALUES
(1, 'PubMed', NULL);

INSERT INTO `redcap_validation_types` (`validation_name`, `validation_label`, `regex_js`, `regex_php`, `data_type`, `legacy_value`, `visible`) VALUES
('alpha_only', 'Letters only', '/^[a-z]+$/i', '/^[a-z]+$/i', 'text', NULL, 0),
('date_dmy', 'Date (D-M-Y)', '/^((29([-\\/])02\\3(\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00)))|((((0[1-9]|1\\d|2[0-8])([-\\/])(0[1-9]|1[012]))|((29|30)([-\\/])(0[13-9]|1[012]))|(31([-\\/])(0[13578]|1[02])))(\\11|\\15|\\18)\\d{4}))$/', '/^((29([-\\/])02\\3(\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00)))|((((0[1-9]|1\\d|2[0-8])([-\\/])(0[1-9]|1[012]))|((29|30)([-\\/])(0[13-9]|1[012]))|(31([-\\/])(0[13578]|1[02])))(\\11|\\15|\\18)\\d{4}))$/', 'date', NULL, 1),
('date_mdy', 'Date (M-D-Y)', '/^((02([-\\/])29\\3(\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00)))|((((0[1-9]|1[012])([-\\/])(0[1-9]|1\\d|2[0-8]))|((0[13-9]|1[012])([-\\/])(29|30))|((0[13578]|1[02])([-\\/])31))(\\11|\\15|\\19)\\d{4}))$/', '/^((02([-\\/])29\\3(\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00)))|((((0[1-9]|1[012])([-\\/])(0[1-9]|1\\d|2[0-8]))|((0[13-9]|1[012])([-\\/])(29|30))|((0[13578]|1[02])([-\\/])31))(\\11|\\15|\\19)\\d{4}))$/', 'date', NULL, 1),
('date_ymd', 'Date (Y-M-D)', '/^(((\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00))([-\\/])02(\\6)29)|(\\d{4}([-\\/])((0[1-9]|1[012])(\\9)(0[1-9]|1\\d|2[0-8])|((0[13-9]|1[012])(\\9)(29|30))|((0[13578]|1[02])(\\9)31))))$/', '/^(((\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00))([-\\/])02(\\6)29)|(\\d{4}([-\\/])((0[1-9]|1[012])(\\9)(0[1-9]|1\\d|2[0-8])|((0[13-9]|1[012])(\\9)(29|30))|((0[13578]|1[02])(\\9)31))))$/', 'date', 'date', 1),
('datetime_dmy', 'Datetime (D-M-Y H:M)', '/^((29([-\\/])02\\3(\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00)))|((((0[1-9]|1\\d|2[0-8])([-\\/])(0[1-9]|1[012]))|((29|30)([-\\/])(0[13-9]|1[012]))|(31([-\\/])(0[13578]|1[02])))(\\11|\\15|\\18)\\d{4})) (\\d|[0-1]\\d|[2][0-3]):[0-5]\\d$/', '/^((29([-\\/])02\\3(\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00)))|((((0[1-9]|1\\d|2[0-8])([-\\/])(0[1-9]|1[012]))|((29|30)([-\\/])(0[13-9]|1[012]))|(31([-\\/])(0[13578]|1[02])))(\\11|\\15|\\18)\\d{4})) (\\d|[0-1]\\d|[2][0-3]):[0-5]\\d$/', 'datetime', NULL, 1),
('datetime_mdy', 'Datetime (M-D-Y H:M)', '/^((02([-\\/])29\\3(\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00)))|((((0[1-9]|1[012])([-\\/])(0[1-9]|1\\d|2[0-8]))|((0[13-9]|1[012])([-\\/])(29|30))|((0[13578]|1[02])([-\\/])31))(\\11|\\15|\\19)\\d{4})) (\\d|[0-1]\\d|[2][0-3]):[0-5]\\d$/', '/^((02([-\\/])29\\3(\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00)))|((((0[1-9]|1[012])([-\\/])(0[1-9]|1\\d|2[0-8]))|((0[13-9]|1[012])([-\\/])(29|30))|((0[13578]|1[02])([-\\/])31))(\\11|\\15|\\19)\\d{4})) (\\d|[0-1]\\d|[2][0-3]):[0-5]\\d$/', 'datetime', NULL, 1),
('datetime_seconds_dmy', 'Datetime w/ seconds (D-M-Y H:M:S)', '/^((29([-\\/])02\\3(\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00)))|((((0[1-9]|1\\d|2[0-8])([-\\/])(0[1-9]|1[012]))|((29|30)([-\\/])(0[13-9]|1[012]))|(31([-\\/])(0[13578]|1[02])))(\\11|\\15|\\18)\\d{4})) (\\d|[0-1]\\d|[2][0-3])(:[0-5]\\d){2}$/', '/^((29([-\\/])02\\3(\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00)))|((((0[1-9]|1\\d|2[0-8])([-\\/])(0[1-9]|1[012]))|((29|30)([-\\/])(0[13-9]|1[012]))|(31([-\\/])(0[13578]|1[02])))(\\11|\\15|\\18)\\d{4})) (\\d|[0-1]\\d|[2][0-3])(:[0-5]\\d){2}$/', 'datetime_seconds', NULL, 1),
('datetime_seconds_mdy', 'Datetime w/ seconds (M-D-Y H:M:S)', '/^((02([-\\/])29\\3(\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00)))|((((0[1-9]|1[012])([-\\/])(0[1-9]|1\\d|2[0-8]))|((0[13-9]|1[012])([-\\/])(29|30))|((0[13578]|1[02])([-\\/])31))(\\11|\\15|\\19)\\d{4})) (\\d|[0-1]\\d|[2][0-3])(:[0-5]\\d){2}$/', '/^((02([-\\/])29\\3(\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00)))|((((0[1-9]|1[012])([-\\/])(0[1-9]|1\\d|2[0-8]))|((0[13-9]|1[012])([-\\/])(29|30))|((0[13578]|1[02])([-\\/])31))(\\11|\\15|\\19)\\d{4})) (\\d|[0-1]\\d|[2][0-3])(:[0-5]\\d){2}$/', 'datetime_seconds', NULL, 1),
('datetime_seconds_ymd', 'Datetime w/ seconds (Y-M-D H:M:S)', '/^(((\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00))([-\\/])02(\\6)29)|(\\d{4}([-\\/])((0[1-9]|1[012])(\\9)(0[1-9]|1\\d|2[0-8])|((0[13-9]|1[012])(\\9)(29|30))|((0[13578]|1[02])(\\9)31)))) (\\d|[0-1]\\d|[2][0-3])(:[0-5]\\d){2}$/', '/^(((\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00))([-\\/])02(\\6)29)|(\\d{4}([-\\/])((0[1-9]|1[012])(\\9)(0[1-9]|1\\d|2[0-8])|((0[13-9]|1[012])(\\9)(29|30))|((0[13578]|1[02])(\\9)31)))) (\\d|[0-1]\\d|[2][0-3])(:[0-5]\\d){2}$/', 'datetime_seconds', 'datetime_seconds', 1),
('datetime_ymd', 'Datetime (Y-M-D H:M)', '/^(((\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00))([-\\/])02(\\6)29)|(\\d{4}([-\\/])((0[1-9]|1[012])(\\9)(0[1-9]|1\\d|2[0-8])|((0[13-9]|1[012])(\\9)(29|30))|((0[13578]|1[02])(\\9)31)))) (\\d|[0-1]\\d|[2][0-3]):[0-5]\\d$/', '/^(((\\d{2}([13579][26]|[2468][048]|04|08)|(1600|2[048]00))([-\\/])02(\\6)29)|(\\d{4}([-\\/])((0[1-9]|1[012])(\\9)(0[1-9]|1\\d|2[0-8])|((0[13-9]|1[012])(\\9)(29|30))|((0[13578]|1[02])(\\9)31)))) (\\d|[0-1]\\d|[2][0-3]):[0-5]\\d$/', 'datetime', 'datetime', 1),
('email', 'Email', '/^(?!\\.)((?!.*\\.{2})[a-zA-Z0-9\\u0080-\\u00FF\\u0100-\\u017F\\u0180-\\u024F\\u0250-\\u02AF\\u0300-\\u036F\\u0370-\\u03FF\\u0400-\\u04FF\\u0500-\\u052F\\u0530-\\u058F\\u0590-\\u05FF\\u0600-\\u06FF\\u0700-\\u074F\\u0750-\\u077F\\u0780-\\u07BF\\u07C0-\\u07FF\\u0900-\\u097F\\u0980-\\u09FF\\u0A00-\\u0A7F\\u0A80-\\u0AFF\\u0B00-\\u0B7F\\u0B80-\\u0BFF\\u0C00-\\u0C7F\\u0C80-\\u0CFF\\u0D00-\\u0D7F\\u0D80-\\u0DFF\\u0E00-\\u0E7F\\u0E80-\\u0EFF\\u0F00-\\u0FFF\\u1000-\\u109F\\u10A0-\\u10FF\\u1100-\\u11FF\\u1200-\\u137F\\u1380-\\u139F\\u13A0-\\u13FF\\u1400-\\u167F\\u1680-\\u169F\\u16A0-\\u16FF\\u1700-\\u171F\\u1720-\\u173F\\u1740-\\u175F\\u1760-\\u177F\\u1780-\\u17FF\\u1800-\\u18AF\\u1900-\\u194F\\u1950-\\u197F\\u1980-\\u19DF\\u19E0-\\u19FF\\u1A00-\\u1A1F\\u1B00-\\u1B7F\\u1D00-\\u1D7F\\u1D80-\\u1DBF\\u1DC0-\\u1DFF\\u1E00-\\u1EFF\\u1F00-\\u1FFF\\u20D0-\\u20FF\\u2100-\\u214F\\u2C00-\\u2C5F\\u2C60-\\u2C7F\\u2C80-\\u2CFF\\u2D00-\\u2D2F\\u2D30-\\u2D7F\\u2D80-\\u2DDF\\u2F00-\\u2FDF\\u2FF0-\\u2FFF\\u3040-\\u309F\\u30A0-\\u30FF\\u3100-\\u312F\\u3130-\\u318F\\u3190-\\u319F\\u31C0-\\u31EF\\u31F0-\\u31FF\\u3200-\\u32FF\\u3300-\\u33FF\\u3400-\\u4DBF\\u4DC0-\\u4DFF\\u4E00-\\u9FFF\\uA000-\\uA48F\\uA490-\\uA4CF\\uA700-\\uA71F\\uA800-\\uA82F\\uA840-\\uA87F\\uAC00-\\uD7AF\\uF900-\\uFAFF\\.!#$%&\'*+-/=?^_`{|}~\\-\\d]+)@(?!\\.)([a-zA-Z0-9\\u0080-\\u00FF\\u0100-\\u017F\\u0180-\\u024F\\u0250-\\u02AF\\u0300-\\u036F\\u0370-\\u03FF\\u0400-\\u04FF\\u0500-\\u052F\\u0530-\\u058F\\u0590-\\u05FF\\u0600-\\u06FF\\u0700-\\u074F\\u0750-\\u077F\\u0780-\\u07BF\\u07C0-\\u07FF\\u0900-\\u097F\\u0980-\\u09FF\\u0A00-\\u0A7F\\u0A80-\\u0AFF\\u0B00-\\u0B7F\\u0B80-\\u0BFF\\u0C00-\\u0C7F\\u0C80-\\u0CFF\\u0D00-\\u0D7F\\u0D80-\\u0DFF\\u0E00-\\u0E7F\\u0E80-\\u0EFF\\u0F00-\\u0FFF\\u1000-\\u109F\\u10A0-\\u10FF\\u1100-\\u11FF\\u1200-\\u137F\\u1380-\\u139F\\u13A0-\\u13FF\\u1400-\\u167F\\u1680-\\u169F\\u16A0-\\u16FF\\u1700-\\u171F\\u1720-\\u173F\\u1740-\\u175F\\u1760-\\u177F\\u1780-\\u17FF\\u1800-\\u18AF\\u1900-\\u194F\\u1950-\\u197F\\u1980-\\u19DF\\u19E0-\\u19FF\\u1A00-\\u1A1F\\u1B00-\\u1B7F\\u1D00-\\u1D7F\\u1D80-\\u1DBF\\u1DC0-\\u1DFF\\u1E00-\\u1EFF\\u1F00-\\u1FFF\\u20D0-\\u20FF\\u2100-\\u214F\\u2C00-\\u2C5F\\u2C60-\\u2C7F\\u2C80-\\u2CFF\\u2D00-\\u2D2F\\u2D30-\\u2D7F\\u2D80-\\u2DDF\\u2F00-\\u2FDF\\u2FF0-\\u2FFF\\u3040-\\u309F\\u30A0-\\u30FF\\u3100-\\u312F\\u3130-\\u318F\\u3190-\\u319F\\u31C0-\\u31EF\\u31F0-\\u31FF\\u3200-\\u32FF\\u3300-\\u33FF\\u3400-\\u4DBF\\u4DC0-\\u4DFF\\u4E00-\\u9FFF\\uA000-\\uA48F\\uA490-\\uA4CF\\uA700-\\uA71F\\uA800-\\uA82F\\uA840-\\uA87F\\uAC00-\\uD7AF\\uF900-\\uFAFF\\-\\.\\d]+)((\\.([a-zA-Z\\u0080-\\u00FF\\u0100-\\u017F\\u0180-\\u024F\\u0250-\\u02AF\\u0300-\\u036F\\u0370-\\u03FF\\u0400-\\u04FF\\u0500-\\u052F\\u0530-\\u058F\\u0590-\\u05FF\\u0600-\\u06FF\\u0700-\\u074F\\u0750-\\u077F\\u0780-\\u07BF\\u07C0-\\u07FF\\u0900-\\u097F\\u0980-\\u09FF\\u0A00-\\u0A7F\\u0A80-\\u0AFF\\u0B00-\\u0B7F\\u0B80-\\u0BFF\\u0C00-\\u0C7F\\u0C80-\\u0CFF\\u0D00-\\u0D7F\\u0D80-\\u0DFF\\u0E00-\\u0E7F\\u0E80-\\u0EFF\\u0F00-\\u0FFF\\u1000-\\u109F\\u10A0-\\u10FF\\u1100-\\u11FF\\u1200-\\u137F\\u1380-\\u139F\\u13A0-\\u13FF\\u1400-\\u167F\\u1680-\\u169F\\u16A0-\\u16FF\\u1700-\\u171F\\u1720-\\u173F\\u1740-\\u175F\\u1760-\\u177F\\u1780-\\u17FF\\u1800-\\u18AF\\u1900-\\u194F\\u1950-\\u197F\\u1980-\\u19DF\\u19E0-\\u19FF\\u1A00-\\u1A1F\\u1B00-\\u1B7F\\u1D00-\\u1D7F\\u1D80-\\u1DBF\\u1DC0-\\u1DFF\\u1E00-\\u1EFF\\u1F00-\\u1FFF\\u20D0-\\u20FF\\u2100-\\u214F\\u2C00-\\u2C5F\\u2C60-\\u2C7F\\u2C80-\\u2CFF\\u2D00-\\u2D2F\\u2D30-\\u2D7F\\u2D80-\\u2DDF\\u2F00-\\u2FDF\\u2FF0-\\u2FFF\\u3040-\\u309F\\u30A0-\\u30FF\\u3100-\\u312F\\u3130-\\u318F\\u3190-\\u319F\\u31C0-\\u31EF\\u31F0-\\u31FF\\u3200-\\u32FF\\u3300-\\u33FF\\u3400-\\u4DBF\\u4DC0-\\u4DFF\\u4E00-\\u9FFF\\uA000-\\uA48F\\uA490-\\uA4CF\\uA700-\\uA71F\\uA800-\\uA82F\\uA840-\\uA87F\\uAC00-\\uD7AF\\uF900-\\uFAFF]){2,63})+)$/i', '/^(?!\\.)((?!.*\\.{2})[a-zA-Z0-9\\x{0080}-\\x{00FF}\\x{0100}-\\x{017F}\\x{0180}-\\x{024F}\\x{0250}-\\x{02AF}\\x{0300}-\\x{036F}\\x{0370}-\\x{03FF}\\x{0400}-\\x{04FF}\\x{0500}-\\x{052F}\\x{0530}-\\x{058F}\\x{0590}-\\x{05FF}\\x{0600}-\\x{06FF}\\x{0700}-\\x{074F}\\x{0750}-\\x{077F}\\x{0780}-\\x{07BF}\\x{07C0}-\\x{07FF}\\x{0900}-\\x{097F}\\x{0980}-\\x{09FF}\\x{0A00}-\\x{0A7F}\\x{0A80}-\\x{0AFF}\\x{0B00}-\\x{0B7F}\\x{0B80}-\\x{0BFF}\\x{0C00}-\\x{0C7F}\\x{0C80}-\\x{0CFF}\\x{0D00}-\\x{0D7F}\\x{0D80}-\\x{0DFF}\\x{0E00}-\\x{0E7F}\\x{0E80}-\\x{0EFF}\\x{0F00}-\\x{0FFF}\\x{1000}-\\x{109F}\\x{10A0}-\\x{10FF}\\x{1100}-\\x{11FF}\\x{1200}-\\x{137F}\\x{1380}-\\x{139F}\\x{13A0}-\\x{13FF}\\x{1400}-\\x{167F}\\x{1680}-\\x{169F}\\x{16A0}-\\x{16FF}\\x{1700}-\\x{171F}\\x{1720}-\\x{173F}\\x{1740}-\\x{175F}\\x{1760}-\\x{177F}\\x{1780}-\\x{17FF}\\x{1800}-\\x{18AF}\\x{1900}-\\x{194F}\\x{1950}-\\x{197F}\\x{1980}-\\x{19DF}\\x{19E0}-\\x{19FF}\\x{1A00}-\\x{1A1F}\\x{1B00}-\\x{1B7F}\\x{1D00}-\\x{1D7F}\\x{1D80}-\\x{1DBF}\\x{1DC0}-\\x{1DFF}\\x{1E00}-\\x{1EFF}\\x{1F00}-\\x{1FFF}\\x{20D0}-\\x{20FF}\\x{2100}-\\x{214F}\\x{2C00}-\\x{2C5F}\\x{2C60}-\\x{2C7F}\\x{2C80}-\\x{2CFF}\\x{2D00}-\\x{2D2F}\\x{2D30}-\\x{2D7F}\\x{2D80}-\\x{2DDF}\\x{2F00}-\\x{2FDF}\\x{2FF0}-\\x{2FFF}\\x{3040}-\\x{309F}\\x{30A0}-\\x{30FF}\\x{3100}-\\x{312F}\\x{3130}-\\x{318F}\\x{3190}-\\x{319F}\\x{31C0}-\\x{31EF}\\x{31F0}-\\x{31FF}\\x{3200}-\\x{32FF}\\x{3300}-\\x{33FF}\\x{3400}-\\x{4DBF}\\x{4DC0}-\\x{4DFF}\\x{4E00}-\\x{9FFF}\\x{A000}-\\x{A48F}\\x{A490}-\\x{A4CF}\\x{A700}-\\x{A71F}\\x{A800}-\\x{A82F}\\x{A840}-\\x{A87F}\\x{AC00}-\\x{D7AF}\\x{F900}-\\x{FAFF}\\.!#$%&\'*+-\\/=?^_`{|}~\\-\\d]+)@(?!\\.)([a-zA-Z0-9\\x{0080}-\\x{00FF}\\x{0100}-\\x{017F}\\x{0180}-\\x{024F}\\x{0250}-\\x{02AF}\\x{0300}-\\x{036F}\\x{0370}-\\x{03FF}\\x{0400}-\\x{04FF}\\x{0500}-\\x{052F}\\x{0530}-\\x{058F}\\x{0590}-\\x{05FF}\\x{0600}-\\x{06FF}\\x{0700}-\\x{074F}\\x{0750}-\\x{077F}\\x{0780}-\\x{07BF}\\x{07C0}-\\x{07FF}\\x{0900}-\\x{097F}\\x{0980}-\\x{09FF}\\x{0A00}-\\x{0A7F}\\x{0A80}-\\x{0AFF}\\x{0B00}-\\x{0B7F}\\x{0B80}-\\x{0BFF}\\x{0C00}-\\x{0C7F}\\x{0C80}-\\x{0CFF}\\x{0D00}-\\x{0D7F}\\x{0D80}-\\x{0DFF}\\x{0E00}-\\x{0E7F}\\x{0E80}-\\x{0EFF}\\x{0F00}-\\x{0FFF}\\x{1000}-\\x{109F}\\x{10A0}-\\x{10FF}\\x{1100}-\\x{11FF}\\x{1200}-\\x{137F}\\x{1380}-\\x{139F}\\x{13A0}-\\x{13FF}\\x{1400}-\\x{167F}\\x{1680}-\\x{169F}\\x{16A0}-\\x{16FF}\\x{1700}-\\x{171F}\\x{1720}-\\x{173F}\\x{1740}-\\x{175F}\\x{1760}-\\x{177F}\\x{1780}-\\x{17FF}\\x{1800}-\\x{18AF}\\x{1900}-\\x{194F}\\x{1950}-\\x{197F}\\x{1980}-\\x{19DF}\\x{19E0}-\\x{19FF}\\x{1A00}-\\x{1A1F}\\x{1B00}-\\x{1B7F}\\x{1D00}-\\x{1D7F}\\x{1D80}-\\x{1DBF}\\x{1DC0}-\\x{1DFF}\\x{1E00}-\\x{1EFF}\\x{1F00}-\\x{1FFF}\\x{20D0}-\\x{20FF}\\x{2100}-\\x{214F}\\x{2C00}-\\x{2C5F}\\x{2C60}-\\x{2C7F}\\x{2C80}-\\x{2CFF}\\x{2D00}-\\x{2D2F}\\x{2D30}-\\x{2D7F}\\x{2D80}-\\x{2DDF}\\x{2F00}-\\x{2FDF}\\x{2FF0}-\\x{2FFF}\\x{3040}-\\x{309F}\\x{30A0}-\\x{30FF}\\x{3100}-\\x{312F}\\x{3130}-\\x{318F}\\x{3190}-\\x{319F}\\x{31C0}-\\x{31EF}\\x{31F0}-\\x{31FF}\\x{3200}-\\x{32FF}\\x{3300}-\\x{33FF}\\x{3400}-\\x{4DBF}\\x{4DC0}-\\x{4DFF}\\x{4E00}-\\x{9FFF}\\x{A000}-\\x{A48F}\\x{A490}-\\x{A4CF}\\x{A700}-\\x{A71F}\\x{A800}-\\x{A82F}\\x{A840}-\\x{A87F}\\x{AC00}-\\x{D7AF}\\x{F900}-\\x{FAFF}\\-\\.\\d]+)((\\.([a-zA-Z\\x{0080}-\\x{00FF}\\x{0100}-\\x{017F}\\x{0180}-\\x{024F}\\x{0250}-\\x{02AF}\\x{0300}-\\x{036F}\\x{0370}-\\x{03FF}\\x{0400}-\\x{04FF}\\x{0500}-\\x{052F}\\x{0530}-\\x{058F}\\x{0590}-\\x{05FF}\\x{0600}-\\x{06FF}\\x{0700}-\\x{074F}\\x{0750}-\\x{077F}\\x{0780}-\\x{07BF}\\x{07C0}-\\x{07FF}\\x{0900}-\\x{097F}\\x{0980}-\\x{09FF}\\x{0A00}-\\x{0A7F}\\x{0A80}-\\x{0AFF}\\x{0B00}-\\x{0B7F}\\x{0B80}-\\x{0BFF}\\x{0C00}-\\x{0C7F}\\x{0C80}-\\x{0CFF}\\x{0D00}-\\x{0D7F}\\x{0D80}-\\x{0DFF}\\x{0E00}-\\x{0E7F}\\x{0E80}-\\x{0EFF}\\x{0F00}-\\x{0FFF}\\x{1000}-\\x{109F}\\x{10A0}-\\x{10FF}\\x{1100}-\\x{11FF}\\x{1200}-\\x{137F}\\x{1380}-\\x{139F}\\x{13A0}-\\x{13FF}\\x{1400}-\\x{167F}\\x{1680}-\\x{169F}\\x{16A0}-\\x{16FF}\\x{1700}-\\x{171F}\\x{1720}-\\x{173F}\\x{1740}-\\x{175F}\\x{1760}-\\x{177F}\\x{1780}-\\x{17FF}\\x{1800}-\\x{18AF}\\x{1900}-\\x{194F}\\x{1950}-\\x{197F}\\x{1980}-\\x{19DF}\\x{19E0}-\\x{19FF}\\x{1A00}-\\x{1A1F}\\x{1B00}-\\x{1B7F}\\x{1D00}-\\x{1D7F}\\x{1D80}-\\x{1DBF}\\x{1DC0}-\\x{1DFF}\\x{1E00}-\\x{1EFF}\\x{1F00}-\\x{1FFF}\\x{20D0}-\\x{20FF}\\x{2100}-\\x{214F}\\x{2C00}-\\x{2C5F}\\x{2C60}-\\x{2C7F}\\x{2C80}-\\x{2CFF}\\x{2D00}-\\x{2D2F}\\x{2D30}-\\x{2D7F}\\x{2D80}-\\x{2DDF}\\x{2F00}-\\x{2FDF}\\x{2FF0}-\\x{2FFF}\\x{3040}-\\x{309F}\\x{30A0}-\\x{30FF}\\x{3100}-\\x{312F}\\x{3130}-\\x{318F}\\x{3190}-\\x{319F}\\x{31C0}-\\x{31EF}\\x{31F0}-\\x{31FF}\\x{3200}-\\x{32FF}\\x{3300}-\\x{33FF}\\x{3400}-\\x{4DBF}\\x{4DC0}-\\x{4DFF}\\x{4E00}-\\x{9FFF}\\x{A000}-\\x{A48F}\\x{A490}-\\x{A4CF}\\x{A700}-\\x{A71F}\\x{A800}-\\x{A82F}\\x{A840}-\\x{A87F}\\x{AC00}-\\x{D7AF}\\x{F900}-\\x{FAFF}]){2,63})+)$/u', 'email', NULL, 1),
('integer', 'Integer', '/^[-+]?\\b\\d+\\b$/', '/^[-+]?\\b\\d+\\b$/', 'integer', 'int', 1),
('mrn_10d', 'MRN (10 digits)', '/^\\d{10}$/', '/^\\d{10}$/', 'mrn', NULL, 0),
('mrn_generic', 'MRN (generic)', '/^[a-z0-9-_]+$/i', '/^[a-z0-9-_]+$/i', 'mrn', NULL, 0),
('number', 'Number', '/^[-+]?[0-9]*\\.?[0-9]+([eE][-+]?[0-9]+)?$/', '/^[-+]?[0-9]*\\.?[0-9]+([eE][-+]?[0-9]+)?$/', 'number', 'float', 1),
('number_1dp', 'Number (1 decimal place)', '/^-?\\d+\\.\\d$/', '/^-?\\d+\\.\\d$/', 'number', NULL, 0),
('number_2dp', 'Number (2 decimal places)', '/^-?\\d+\\.\\d{2}$/', '/^-?\\d+\\.\\d{2}$/', 'number', NULL, 0),
('number_3dp', 'Number (3 decimal places)', '/^-?\\d+\\.\\d{3}$/', '/^-?\\d+\\.\\d{3}$/', 'number', NULL, 0),
('number_4dp', 'Number (4 decimal places)', '/^-?\\d+\\.\\d{4}$/', '/^-?\\d+\\.\\d{4}$/', 'number', NULL, 0),
('phone', 'Phone (North America)', '/^(?:\\(?([2-9]0[1-9]|[2-9]1[02-9]|[2-9][2-9][0-9])\\)?)\\s*(?:[.-]\\s*)?([2-9]\\d{2})\\s*(?:[.-]\\s*)?(\\d{4})(?:\\s*(?:#|x\\.?|ext\\.?|extension)\\s*(\\d+))?$/', '/^(?:\\(?([2-9]0[1-9]|[2-9]1[02-9]|[2-9][2-9][0-9])\\)?)\\s*(?:[.-]\\s*)?([2-9]\\d{2})\\s*(?:[.-]\\s*)?(\\d{4})(?:\\s*(?:#|x\\.?|ext\\.?|extension)\\s*(\\d+))?$/', 'phone', NULL, 1),
('phone_australia', 'Phone (Australia)', '/^(\\(0[2-8]\\)|0[2-8])\\s*\\d{4}\\s*\\d{4}$/', '/^(\\(0[2-8]\\)|0[2-8])\\s*\\d{4}\\s*\\d{4}$/', 'phone', NULL, 0),
('postalcode_australia', 'Postal Code (Australia)', '/^\\d{4}$/', '/^\\d{4}$/', 'postal_code', NULL, 0),
('postalcode_canada', 'Postal Code (Canada)', '/^[ABCEGHJKLMNPRSTVXY]{1}\\d{1}[A-Z]{1}\\s*\\d{1}[A-Z]{1}\\d{1}$/i', '/^[ABCEGHJKLMNPRSTVXY]{1}\\d{1}[A-Z]{1}\\s*\\d{1}[A-Z]{1}\\d{1}$/i', 'postal_code', NULL, 0),
('ssn', 'Social Security Number (U.S.)', '/^\\d{3}-\\d\\d-\\d{4}$/', '/^\\d{3}-\\d\\d-\\d{4}$/', 'ssn', NULL, 0),
('time', 'Time (HH:MM)', '/^([0-9]|[0-1][0-9]|[2][0-3]):([0-5][0-9])$/', '/^([0-9]|[0-1][0-9]|[2][0-3]):([0-5][0-9])$/', 'time', NULL, 1),
('time_mm_ss', 'Time (MM:SS)', '/^[0-5]\\d:[0-5]\\d$/', '/^[0-5]\\d:[0-5]\\d$/', 'time', NULL, 0),
('vmrn', 'Vanderbilt MRN', '/^[0-9]{4,9}$/', '/^[0-9]{4,9}$/', 'mrn', NULL, 0),
('zipcode', 'Zipcode (U.S.)', '/^\\d{5}(-\\d{4})?$/', '/^\\d{5}(-\\d{4})?$/', 'postal_code', NULL, 1),
('number_comma_decimal', 'Number (comma as decimal)', '/^[-+]?[0-9]*,?[0-9]+([eE][-+]?[0-9]+)?$/', '/^[-+]?[0-9]*,?[0-9]+([eE][-+]?[0-9]+)?$/', 'number_comma_decimal', NULL, 0),
('number_1dp_comma_decimal',  'Number (1 decimal place - comma as decimal)',  '/^-?\\d+,\\d$/',  '/^-?\\d+,\\d$/',  'number_comma_decimal', NULL ,  '0'),
('number_2dp_comma_decimal',  'Number (2 decimal places - comma as decimal)',  '/^-?\\d+,\\d{2}$/',  '/^-?\\d+,\\d{2}$/',  'number_comma_decimal', NULL ,  '0'),
('number_3dp_comma_decimal',  'Number (3 decimal places - comma as decimal)',  '/^-?\\d+,\\d{3}$/',  '/^-?\\d+,\\d{3}$/',  'number_comma_decimal', NULL ,  '0'),
('number_4dp_comma_decimal',  'Number (4 decimal places - comma as decimal)',  '/^-?\\d+,\\d{4}$/',  '/^-?\\d+,\\d{4}$/',  'number_comma_decimal', NULL ,  '0'),
('postalcode_germany', 'Postal Code (Germany)', '/^(0[1-9]|[1-9]\\d)\\d{3}$/',  '/^(0[1-9]|[1-9]\\d)\\d{3}$/', 'postal_code', NULL, 0),
('postalcode_french', 'Code Postal 5 caracteres (France)', '/^((0?[1-9])|([1-8][0-9])|(9[0-8]))[0-9]{3}$/', '/^((0?[1-9])|([1-8][0-9])|(9[0-8]))[0-9]{3}$/', 'postal_code', NULL, 0);

INSERT INTO redcap_surveys_themes (theme_name, ui_id, theme_text_buttons, theme_bg_page, theme_text_title, theme_bg_title, theme_text_sectionheader, theme_bg_sectionheader, theme_text_question, theme_bg_question) VALUES
('Flat White', NULL, '000000', 'eeeeee', '000000', 'FFFFFF', 'FFFFFF', '444444', '000000', 'FFFFFF'),
('Slate and Khaki', NULL, '000000', 'EBE8D9', '000000', 'c5d5cb', 'FFFFFF', '909A94', '000000', 'f3f3f3'),
('Colorful Pastel', NULL, '000', 'f1fafc', '274e13', 'e9f1e3', '660000', 'F6C2C2', '660000', 'f7f8d7'),
('Blue Skies', NULL, '0C74A9', 'cfe2f3', '0b5394', 'FFFFFF', 'FFFFFF', '0b5394', '0b5394', 'ffffff'),
('Cappucino', NULL, '7d4627', '783f04', '7d4627', 'fff', 'FFFFFF', 'b18b64', '783f04', 'fce5cd'),
('Red Brick', NULL, '000000', '660000', 'ffffff', '990000', 'ffffff', '000000', '000000', 'ffffff'),
('Grayscale', NULL, '30231d', '000000', 'ffffff', '666666', 'ffffff', '444444', '000000', 'eeeeee'),
('Plum', NULL, '000000', '351c75', '000000', 'd9d2e9', 'FFFFFF', '8e7cc3', '000000', 'd9d2e9'),
('Forest Green', NULL, '7f6000', '274e13', 'ffffff', '6aa84f', 'ffffff', '38761d', '7f6000', 'd9ead3'),
('Sunny Day', NULL, 'B2400E', 'FFFF80', 'B2400E', 'FFFFFF', 'FFFFFF', 'f67719', 'b85b16', 'FEFFD3');

INSERT INTO redcap_messages_threads (thread_id, type, channel_name, invisible, archived) VALUES
(1, 'NOTIFICATION', 'What''s new', 0, 0),
(2, 'NOTIFICATION', NULL, 0, 0),
(3, 'NOTIFICATION', 'Notifications', 0, 0);

INSERT INTO redcap_messages_recipients (recipient_id, thread_id, all_users) VALUES 
(1, 1, 1), 
(2, 2, 1),
(3, 3, 1);
