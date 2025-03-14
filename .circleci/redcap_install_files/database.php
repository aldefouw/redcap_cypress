<?php

/**
 * Set this variable to TRUE if you are having problems and need to see as much error logging information as
 * possible. This will cause all errors/warnings/notices to be logged to your web server's error log. Once
 * the issue has been resolved, we recommend setting this back to FALSE to avoid unnecessary logging of warnings.
 */
global $log_all_errors;
$log_all_errors = FALSE;

//********************************************************************************************************************
// MYSQL DATABASE CONNECTION:
// Replace the values inside the single quotes below with the values for your MySQL configuration. 
// If not using the default port 3306, then append a colon and port number to the hostname (e.g. $hostname = 'example.com:3307';).

$hostname   = 'db';         //your_mysql_host_name
$db         = 'redcap';     //your_mysql_db_name
$username   = 'root';       //your_mysql_db_username
$password   = 'root';       //your_mysql_db_password

// You may optionally utilize a database connection over SSL/TLS for improved security. To do so, at minimum
// you must provide the path of the key file, the certificate file, and certificate authority file.
$db_ssl_key  	= '';		// e.g., '/etc/mysql/ssl/client-key.pem'
$db_ssl_cert 	= '';		// e.g., '/etc/mysql/ssl/client-cert.pem'
$db_ssl_ca   	= '';		// e.g., '/etc/mysql/ssl/ca-cert.pem'
$db_ssl_capath 	= NULL;
$db_ssl_cipher 	= NULL;
$db_ssl_verify_server_cert = false; // Set to TRUE to force the database connection to verify the SSL certificate

// For greater security, you may instead want to place the database connection values in a separate file that is not 
// accessible via the web. To do this, uncomment the line below and set it as the path to your database connection file
// located elsewhere on your web server. The file included should contain all the variables from above.

// include 'path_to_db_conn_file.php';


//********************************************************************************************************************
// SALT VARIABLE:
// Add a random value for the $salt variable below, preferably alpha-numeric with 8 characters or more. This value wll be 
// used for data de-identification hashing for data exports. Do NOT change this value once it has been initially set.

$salt = '1669ed600d';


//********************************************************************************************************************
// DATA TRANSFER SERVICES (DTS):
// If using REDCap DTS, uncomment the lines below and provide the database connection values for connecting to
// the MySQL database containing the DTS tables (even if the same as the values above).

// $dtsHostname 	= 'your_dts_host_name';
// $dtsDb 			= 'your_dts_db_name';
// $dtsUsername 	= 'your_dts_db_username';
// $dtsPassword 	= 'your_dts_db_password';
