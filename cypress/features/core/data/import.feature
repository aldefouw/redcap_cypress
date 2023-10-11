Feature: Data Collection and Storage

As a REDCap end user
I want to see that Data Collection and Storage is functioning as expected

Scenario: Project Setup 1 - Create Project 16_DataImport_v1115
    Given I am an "admin" user who logs into REDCap
    And I create a project named "16_DataImport_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
    When I click on the link labeled "User Rights"
    And I enter "test_user" into the field identified by "[id=new_username]"
    And I click on the button labeled "Add with custom rights"
    And I check the checkbox identified by "[name=design]"
    And I check the checkbox identified by "[name=data_import_tool]"
    And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking"
    And I check the checkbox identified by "[name=lock_record_multiform]"
    And I click on the button labeled "Save Changes" in the dialog box

Scenario: Project Setup - 2   
    When I click on the link labeled "Project Setup"
    When I click on the link labeled "Other Functionality"
    And I click on the button labeled "Erase all data"
    And I click on the button labeled "Erase all data" in the dialog box 
    And I close the popup

Scenario: Project Setup - 3
    And I click on the link labeled "Project Setup"
    And I disable longitudinal mode
    And I open the dialog box for the Repeatable Instruments and Events module
    And I uncheck the checkbox labeled "Data Types"
    And I click on the button labeled "Save" in the dialog box
    And I should see that repeatable instruments are disabled
    And I click on the link labeled "Dictionary"
    Given I upload the data dictionary located at "core\16_DataImportDD.csv"
    Then I should see "Changes Made Successfully!"
 
    
Scenario: 1 - Login as Test User and download Templates for both Rows and Columns
    Given I am a "standard" user who logs into REDCap
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "16_DataImport_v1115"
    And I click on the link labeled "Data Import Tool"
    And I download a Data Import Template file "rows" by clicking on the link labeled "Download your Data Import Template"
    Then I should have a file named "Template_rows.csv"
    And I download a Data Import Template file "columns" by clicking on the link labeled "Download your Data Import Template"
    Then I should have a file named "Template_columns.csv"

Scenario: 2 - Upload Template_rows file (data in rows) - Test import rows
    Given I upload a "csv" format file located at "/import_files/Import1_Template_Rows_Data.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I click on the button labeled "Import Data" 
    Then I should see "Import Successful!"
  

Scenario: 3 - Upload modified Template_rows file - Testing formatting date
    Given I select "DD/MM/YYYY or YYYY-MM-DD" from the dropdown identified by "select[name=date_format]"
    And I upload a "csv" format file located at "/import_files/Import1_Template_Rows_Data_modified.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then Records "100,200,300" should contain text "(existing record)" in brackets
    And I should see old value "(1943-02-25)" and new value "1943-01-28" for Record "200" and field named "bdate" in the Data Display Table
    And I click on the button labeled "Import Data" 
    Then I should see "Import Successful!"
  
Scenario: 4 - Test import Columns
    Given I select "Columns" from the dropdown identified by "select[name=format]"
    Given I select "MM/DD/YYYY or YYYY-MM-DD" from the dropdown identified by "select[name=date_format]"
    Given I upload a "csv" format file located at "/import_files/Import1_Template_Columns_Data.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I click on the button labeled "Import Data" 
    Then I should see "Import Successful!"
    Given I click on the link labeled "Record Status Dashboard"
    Then I see a "circle_yellow" bubble for Record "4000" and Instrument named "Text Validation"
    And I see a "circle_green" bubble for Record "4001" and Instrument named "Text Validation"
    And I see a "circle_red" bubble for Record "4001" and Instrument named "Data Types"

Scenario: 5 - Testing improper data format
    Given I click on the link labeled "Data Import Tool"
    And I select "Columns" from the dropdown identified by "select[name=format]"
    Given I upload a "csv" format file located at "/import_files/Import1_Template_Columns_Data_modified.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see error "Invalid date format." corresponding to the field named "bdate" for record "4002" in Error Display Table
    And I should see error "The value is not a valid category for multiple_dropdown_auto" corresponding to the field named "multiple_dropdown_auto" for record "4002" in Error Display Table
    And I should see error "The value you provided could not be validated because it does not follow the expected format." corresponding to the field named "integer" for record "4002" in Error Display Table

Scenario: 6 - Testing Repeating Events and Instruments 
    When I click on the link labeled "Project Setup"
    And I enable longitudinal mode
    Then I should see that longitudinal mode is "enabled"
    And I open the dialog box for the Repeatable Instruments and Events module
    And I select "-- not repeating --" on the dropdown field labeled "Event 2 (Arm 1: Arm 1)"
    And I click on the button labeled "Save" on the dialog box for the Repeatable Instruments and Events module
    And I should see that repeatable instruments are disabled
    Given I click on the link labeled "Data Import Tool"
    Given I upload a "csv" format file located at "/import_files/Import1_Template_Rows_Data_modified.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "ERROR: The following values for 'redcap_event_name' are not valid unique event names for this project,"

Scenario: 7 - Testing Repeatable Events and Instruments
    Given I upload a "csv" format file located at "/import_files/Import1_Template_Rows_Data_Scenario7.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I click on the button labeled "Import Data" 
    Then I should see "Import Successful!"
    And I click on the link labeled "Project Setup"
    And I open the dialog box for the Repeatable Instruments and Events module
    And I select "Repeat Entire Event (repeat all instruments together)" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)"
    And I click on the button labeled "Save" on the dialog box for the Repeatable Instruments and Events module
    And I close the popup
    And I should see that repeatable instruments are modifiable

Scenario: 8 - Testing Repeatable Instance
    Given I click on the link labeled "Data Import Tool"
    Given I upload a "csv" format file located at "/import_files/Import1_Template_Rows_Data_Scenario8.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I click on the button labeled "Import Data"
    Then I should see "Import Successful!"
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "5000" and click on the bubble
    Then I should see "(2)" instances in the instance table
    Given the AJAX "POST" request at "index.php?*" tagged by "update" is being monitored
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "5001" and click on the bubble
    And the AJAX request tagged by "update" has completed
    Then I should see "(2)" instances in the instance table
    Given the AJAX "POST" request at "index.php?*" tagged by "update" is being monitored
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "5002" and click on the bubble
    And the AJAX request tagged by "update" has completed
    Then I should see "(2)" instances in the instance table

Scenario: 9 - Testing Repeatable Instance
    Given I click on the link labeled "Project Setup"
    And I should see that repeatable instruments are modifiable
    And I open the dialog box for the Repeatable Instruments and Events module
    And I select "Repeat Instruments (repeat independently of each other)" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)"
    And I click on the button labeled "Save" on the dialog box for the Repeatable Instruments and Events module
    And I close the popup
    Given I click on the link labeled "Data Import Tool"
    Given I upload a "csv" format file located at "/import_files/Import1_Template_Rows_Repeat.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I click on the button labeled "Import Data"
    Then I should see "Import Successful!"
    Given I click on the link labeled "Record Status Dashboard"
    Given the AJAX "POST" request at "index.php?*" tagged by "update1" is being monitored
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "5000" and click on the bubble
    And the AJAX request tagged by "update1" has completed
    Then I should see "(3)" instances in the instance table
    Given the AJAX "POST" request at "index.php?*" tagged by "update2" is being monitored
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "5001" and click on the bubble
    And the AJAX request tagged by "update2" has completed
    Then I should see "(3)" instances in the instance table
    Given the AJAX "POST" request at "index.php?*" tagged by "update3" is being monitored
    And I locate the bubble for the "Text Validation" instrument on event "Event 1" for record ID "5002" and click on the bubble
    And the AJAX request tagged by "update3" has completed
    Then I should see "(3)" instances in the instance table
    
    Given I click on the link labeled "Project Setup"
    And I open the dialog box for the Repeatable Instruments and Events module
    And I select "-- not repeating --" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)"
    And I click on the button labeled "Save" on the dialog box for the Repeatable Instruments and Events module
    And I close the popup
    And I should see that repeatable instruments are disabled

Scenario: 10 - Testing Locking
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "5002"
    And I click on the button labeled "Choose action for record"
    And I select the option labeled " Lock entire record"
    And I should see a dialog containing the following text: "Do you wish to LOCK record \"5002\"?"
    And I click on the button labeled "Lock entire record" in the dialog box
    Then I should see a dialog containing the following text: "Record \"5002\" is now LOCKED"
    And I click on the button labeled "OK" in the dialog box
    #Wait added due to element detached from the DOM error
    And I wait for 3 seconds
    Given I click on the link labeled "Data Import Tool"
    Given I upload a "csv" format file located at "/import_files/Import1_Template_Rows_Data_Scenario10.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "Errors were detected in the import file that prevented it from being loaded."
    And I should see error "This record has been locked at the record level. No value within this record can be modified." corresponding to the field named "data_types_complete" for record "5002" in Error Display Table
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "5002"
    And I click on the button labeled "Choose action for record"
    And I select the option labeled "Unlock entire record"
    And I should see a dialog containing the following text: "Do you wish to UNLOCK record \"5002\"?"
    And I click on the button labeled "Unlock entire record" in the dialog box
    Then I should see a dialog containing the following text: "Record \"5002\" is now UNLOCKED"
    And I click on the button labeled "OK" in the dialog box
    Then I logout

Scenario: 11 - Testing user privileges
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled " My Projects"
    And I click on the link labeled "16_DataImport_v1115"
    And I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I uncheck the User Right named "Create Records"
    And I save changes within the context of User Rights
    Then I logout

    Given I am a "standard" user who logs into REDCap
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "16_DataImport_v1115"
    And I click on the link labeled "Data Import Tool"
    Given I upload a "csv" format file located at "/import_files/Import1_Template_Rows_Data_Scenario11.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "Your user privileges do NOT allow you to create new records."

Scenario: 12 - Testing formatting date and Blank Record
    Given I click on the link labeled "Data Import Tool"
    And I select "Yes, blank values in the file will overwrite existing values" from the dropdown identified by "select[name=overwriteBehavior]"
    Then I should see a dialog containing the following text: "Are you sure you wish to REPLACE EXISTING SAVED VALUES WITH BLANK VALUES"
    And I click on the button labeled "Yes, I understand" in the dialog box
    Given I upload a "csv" format file located at "/import_files/Import1_Template_Rows_Data_Scenario12.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I should see new value "(1940-07-07)" for Record "5002" and field named "bdate" in the Data Display Table
    And I should see new value "(Ringo)" for Record "5002" and field named "name" in the Data Display Table
    And I should see new value "(drummer)" for Record "5002" and field named "instrument" in the Data Display Table
    And I click on the button labeled "Import Data"
    Then I should see "Import Successful!"
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "5002" and click on the bubble
    # Additional step definition for the below three steps had to be written for an exact match
    Then I should see that the field named exactly " Name " contains the value of ""
    Then I should see that the field named exactly " Text " contains the value of ""
    Then I should see that the field named exactly " Text Box " contains the value of ""
    Then I logout

Scenario: 13 - Testing DAGs
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled " My Projects"
    And I click on the link labeled "16_DataImport_v1115"
    And I click on the link labeled "DAGs"
    And the AJAX "GET" request at "index.php?route=DataAccessGroupsController:getDagSwitcherTable&tablerowsonly*" tagged by "dataAccess" is being monitored
    And I enter "Beatles" into the field identified by "[id=new_group]"
    And the AJAX request tagged by "dataAccess" has completed
    And the AJAX "POST" request at "index.php?route=DataAccessGroupsController:ajax&pid*" tagged by "dataAccess1" is being monitored
    And I click on the button labeled " Add Group"
    And the AJAX request tagged by "dataAccess1" has completed
    And the AJAX "GET" request at "index.php?route=DataAccessGroupsController:ajax&pid*" tagged by "dataAccessUser" is being monitored
    And I select "test_user (Test User)" from the dropdown identified by "select[id=group_users]"
    And the AJAX request tagged by "dataAccessUser" has completed
    And I select "Beatles" from the dropdown identified by "select[id=groups]"
    And the AJAX "POST" request at "index.php?route=DataAccessGroupsController:ajax&pid*" tagged by "dataAccessAddUser" is being monitored
    And I click on the button labeled "Assign"
    And the AJAX request tagged by "dataAccessAddUser" has completed
    Then I logout
    Given I am a "standard" user who logs into REDCap
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "16_DataImport_v1115"
    And I click on the link labeled "Data Import Tool"
    Given I upload a "csv" format file located at "/import_files/Import1_Template_rows_dag.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "ERROR: Illegal use of 'redcap_data_access_group' field!"
    Then I logout

Scenario: 14 - Testing DAGs
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled " My Projects"
    And I click on the link labeled "16_DataImport_v1115"
    And I click on the link labeled "Data Import Tool"
    Given I upload a "csv" format file located at "/import_files/Import1_Template_rows_dag.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I click on the button labeled "Import Data"
    Then I should see "Import Successful!"
    
Scenario: 15 - Testing Survey IdentifierAndTimestamp
    Given I upload a "csv" format file located at "/import_files/Import1_Template_Rows_Data_Scenario15.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I should see old value "(George)" and new value "George Harrison" for Record "5001" and field named "name" in the Data Display Table
    And I should see new value "04/05/2023" for Record "5000" and field named "redcap_survey_identifier" in the Data Display Table
    And I click on the button labeled "Import Data"
    Then I should see "Import Successful!"

Scenario: 16 - Testing import of time with missing minutes or seconds
    And I click on the link labeled "Dictionary"
    # 16_DataImportv1115_DD_Date_Tests.csv is not available to download, hence 16_DataImportv1005_DD_Date_Tests.csv is used
    Given I upload the data dictionary located at "core\16_DataImportv1005_DD_Date_Tests.csv"
    Then I should see "Changes Made Successfully!"
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "5002" and click on the bubble
    And I should see "Record ID"
    And I should see "Date value - first two digits of the year component are missing"
    And I should see "Datetime value - first two digits of the year component are missing"
    And I should see "Datetime value - missing a minutes component"
    And I should see "Datetime_seconds value - missing a seconds component"

Scenario: 17 - Testing import of time with missing minutes or seconds
    Given I click on the link labeled "Project Setup"
    And I disable longitudinal mode
    And I click on the link labeled "Data Import Tool"
    And I upload a "csv" format file located at "/import_files/16_DataImportv1005_DateTests.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "Errors were detected in the import file that prevented it from being loaded."
    Then I should see error "Invalid date format. (NOTE: Dates must be imported here only in M/D/Y format or Y-M-D format, regardless of the specific date format designated for this field.)" corresponding to the field named "date_missing_century" for record "5002" in Error Display Table
    Then I should see error "Invalid date format. (NOTE: Dates must be imported here only in M/D/Y H:M[:S] format, regardless of the specific date format designated for this field.)" corresponding to the field named "datetime_missing_century" for record "5002" in Error Display Table
    Then I should see error "Invalid date format. (NOTE: Dates must be imported here only in M/D/Y H:M[:S] format, regardless of the specific date format designated for this field.)" corresponding to the field named "datetime_missing_mins" for record "5002" in Error Display Table
    Then I should see error "Invalid date format. (NOTE: Dates must be imported here only in M/D/Y H:M[:S] format, regardless of the specific date format designated for this field.)" corresponding to the field named "datetime_secs_missing_secs" for record "5002" in Error Display Table

Scenario: 18 - Testing import of time with missing minutes or seconds- Missing “seconds” and missing “minutes” are appended as “00”
    Given I select "DD/MM/YYYY or YYYY-MM-DD" from the dropdown identified by "select[name=date_format]"
    And I upload a "csv" format file located at "/import_files/16_DataImportv1005_DateTests.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I click on the button labeled "Import Data"
    Then I should see "Import Successful!"
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "View Report" for the report named "All data"
    Then I should see corrected value "04-14-2021 13:00" for Record "5002" and field named "Datetime value - missing a minutes component" in the Report Table
    And I should see corrected value "04-14-2021 13:55:00" for Record "5002" and field named "Datetime_seconds value - missing a seconds component" in the Report Table

Scenario: 19 - Logout
    Then I logout