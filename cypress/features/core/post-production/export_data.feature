Feature: Export Data

  As a REDCap end user
  I want to see that Export Data is functioning as expected

  Scenario: Project Setup 1 - Create Project 21_ExportDataExtraction_v1115
    Given I am a "standard" user who logs into REDCap
    And I create a project named "21_ExportDataExtraction_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
    
  Scenario: Project setup 2 - Upload Data Dictionary
    Given I click on the link labeled "Dictionary"
    And I upload the data dictionary located at "core/21_ExportDataExtractionDD_v1115.csv"

  Scenario: Project setup 3 -Setting up Events
    Given I click on the link labeled "Project Setup"
    And I click on the link labeled "Other Functionality"
    And I click on the button labeled "Erase all data"
    And I click on the button labeled "Erase all data" in the dialog box
    Then I should see "All data has now been deleted from the project!"
    When I close the popup
    And I click on the link labeled "Project Setup"
    And I enable surveys for the project
    And I should see that longitudinal mode is "enabled"
    # Have to click the below link twice for it to work.. Not sure why
    And I click on the link labeled "Designer"
    And I click on the link labeled "Designer"
    And I enable the Data Collection Instrument labeled "Survey" as survey
    Then I should see "Your survey settings were successfully saved!"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    And I click on the link labeled "Arm 2:"
    And I click on the link labeled "Delete Arm 2"
    Then I should see "DELETE ARM 2? Deleting Arm 2 will also delete ALL events associated with Arm 2. Are you sure you wish to do this?" in an alert box
    And I click on the link labeled "Arm 1:"
    And I delete the Event Name of "Event Three"
    Then I click on the link labeled "Designate Instruments for My Events"
    And I enable the Data Collection Instrument named "Export" for the Event named "Event 1"
    And I enable the Data Collection Instrument named "Survey" for the Event named "Event 1"
    And I enable the Data Collection Instrument named "Survey" for the Event named "Event 2"
    Then I click on the link labeled "Project Setup"
    And I should see that repeatable instruments are modifiable
    And I open the dialog box for the Repeatable Instruments and Events module
    And I select "Repeat Entire Event (repeat all instruments together)" on the dropdown field labeled "Event 1"
    And I select "Repeat Instruments (repeat independently of each other)" on the dropdown field labeled "Event 2"
    And I check the checkbox labeled "Survey"
    And I click on the button labeled "Save"
    Then I should see "Your settings for repeating instruments and/or events have been successfully saved. (The page will now reload.)" in an alert box
    And I should see that auto-numbering is "enabled"
    And I should see that the scheduling module is "disabled"
    And I should see that the randomization module is "disabled"
    And I should see that the designate an email field for communications setting is "disabled"

  Scenario: Project Setup 4 - Import Data File
    Given I click on the link labeled "Data Import Tool"
    And I should see "Instructions"
    And I upload a "csv" format file located at "import_files/core/21_ExportDataExtractionIMP_v1115.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "DATA DISPLAY TABLE"
    And I should see "(new record)"
    When I click on the button labeled "Import Data"
    Then I should see "Import Successful!"
    And I click on the link labeled "Record Status Dashboard"
    # This is for Event 2 for Record ID 1
    # Getting the Event wrong. Need to locate Event 2 but have to give Event 1 in the step definition below
    And I locate the bubble for the "Survey" instrument on event "Event 1" for record ID "1" and click the repeating instrument bubble for the first instance
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    And I click on the button labeled "Submit"
    And I click on the button labeled "Close survey"
    And I logout
    # This is for Event 2 for Record ID 2
    Given I am a "standard" user who logs into REDCap
    Then I should see "New Project"
    Then I click on the link labeled "My Projects"
    Then I should see "Project Title"
    And I click on the link labeled "21_ExportDataExtraction_v1115"
    Then I should see "Record Status Dashboard"
    And I click on the link labeled "Record Status Dashboard"
    # Getting the Event wrong. Need to locate Event 2 but have to give Event 1 in the step definition below
    And I locate the bubble for the "Survey" instrument on event "Event 1" for record ID "2" and click the repeating instrument bubble for the first instance
    And I click on the button labeled "Survey options"
    And I click on the survey option label containing "Open survey" label
    And I click on the button labeled "Submit"
    And I click on the button labeled "Close survey"
    And I logout
        
  Scenario: 1 - Login
    Given I am a "standard" user who logs into REDCap
    Then I should see "New Project"

  Scenario: 2 - Open project
    Given I click on the link labeled "My Projects"
    Then I should see "Project Title"
    And I click on the link labeled "21_ExportDataExtraction_v1115"
    Then I should see "21_ExportDataExtraction_v1115"
    And I should see "Record Status Dashboard"
    # Manual script - Verify the project complies with all project setup steps in the Test Requirements section of this script.
    # Do I need to check this

  Scenario: 3 - Mark First name and Last name as identifier
    Then I click on the link labeled "Project Setup"
    And I click on the button labeled "Online Designer"
    Then I should see "Instrument name"
    And I click on the table cell containing a link labeled "Export"
    And I edit the Data Collection Instrument field labeled "Last name"
    And I click on the element identified by "input[id=field_phi1]"
    Then I click on the button labeled "Save"
    And I edit the Data Collection Instrument field labeled "First name"
    And I click on the element identified by "input[id=field_phi1]"
    Then I click on the button labeled "Save"
    
  Scenario: 4 - Move to production
    Given I am an "admin" user who logs into REDCap
    Then I should see "Control Center"
    And  I click on the link labeled "Control Center"
    Then I should see "Browse Projects"
    And  I click on the link labeled "Browse Projects"
    And I wait for 2 seconds
    And I enter "21_ExportDataExtraction_v1115" into the field identified by "input[id=project_search]"
    And I click on the button labeled "Search project title"
    Then I should see "21_ExportDataExtraction_v1115"
    Then I click on the link labeled "21_ExportDataExtraction_v1115"
    Then I should see "Project Setup"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far." in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    # Then I should see "Success! The project is now in production."
    Then I should see "Production"

  Scenario: 5a - Verify export option - CSV / Microsoft Excel (raw data)
    Given I am a "standard" user who logs into REDCap
    Then I should see "New Project"
    And I click on the link labeled "My Projects"
    Then I should see "21_ExportDataExtraction_v1115"
    And I click on the link labeled "21_ExportDataExtraction_v1115"
    Then I should see "Data Exports, Reports, and Stats"
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see "View Report"
    And I should see "Export Data"
    And I should see "Stats & Charts"
    And I click on the button labeled "Export Data"
    Then I should see "Exporting \"All data (all records and fields)\""
    And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
    Then I should see "Remove all tagged Identifier fields"
    And I should see "Hash the Record ID field"
    And I should see "Remove unvalidated Text fields"
    And I should see "Remove Notes/Essay box fields"
    And I should see "Remove all date and datetime fields"
    And I should see "Shift all dates by value between 0 and 364 days"
    And I should see "Also shift all survey completion timestamps by value between 0 and 364 days"
    Then I click on the button labeled "Cancel" in the dialog box
    Then I should see "My Reports & Exports"

  Scenario: 5b - Verify export option - CSV / Microsoft Excel (labels)
    Given I click on the button labeled "Export Data"
    Then I should see "Exporting \"All data (all records and fields)\""
    And I click on the radio labeled "CSV / Microsoft Excel (labels)" in the dialog box
    Then I should see "Remove all tagged Identifier fields"
    And I should see "Hash the Record ID field"
    And I should see "Remove unvalidated Text fields"
    And I should see "Remove Notes/Essay box fields"
    And I should see "Remove all date and datetime fields"
    And I should see "Shift all dates by value between 0 and 364 days"
    And I should see "Also shift all survey completion timestamps by value between 0 and 364 days"
    Then I click on the button labeled "Cancel" in the dialog box
    Then I should see "My Reports & Exports"

  Scenario: 5c - Verify export option - SPSS Statistical Software
    Given I click on the button labeled "Export Data"
    Then I should see "Exporting \"All data (all records and fields)\""
    And I click on the radio labeled "SPSS Statistical Software" in the dialog box
    Then I should see "Remove all tagged Identifier fields"
    And I should see "Hash the Record ID field"
    And I should see "Remove unvalidated Text fields"
    And I should see "Remove Notes/Essay box fields"
    And I should see "Remove all date and datetime fields"
    And I should see "Shift all dates by value between 0 and 364 days"
    And I should see "Also shift all survey completion timestamps by value between 0 and 364 days"
    Then I click on the button labeled "Cancel" in the dialog box
    Then I should see "My Reports & Exports"

  Scenario: 5d - Verify export option - SAS Statistical Software
    Given I click on the button labeled "Export Data"
    Then I should see "Exporting \"All data (all records and fields)\""
    And I click on the radio labeled "SAS Statistical Software" in the dialog box
    Then I should see "Remove all tagged Identifier fields"
    And I should see "Hash the Record ID field"
    And I should see "Remove unvalidated Text fields"
    And I should see "Remove Notes/Essay box fields"
    And I should see "Remove all date and datetime fields"
    And I should see "Shift all dates by value between 0 and 364 days"
    And I should see "Also shift all survey completion timestamps by value between 0 and 364 days"
    Then I click on the button labeled "Cancel" in the dialog box
    Then I should see "My Reports & Exports"

  Scenario: 5e - Verify export option - R Statistical Software
    Given I click on the button labeled "Export Data"
    Then I should see "Exporting \"All data (all records and fields)\""
    And I click on the radio labeled "R Statistical Software" in the dialog box
    Then I should see "Remove all tagged Identifier fields"
    And I should see "Hash the Record ID field"
    And I should see "Remove unvalidated Text fields"
    And I should see "Remove Notes/Essay box fields"
    And I should see "Remove all date and datetime fields"
    And I should see "Shift all dates by value between 0 and 364 days"
    And I should see "Also shift all survey completion timestamps by value between 0 and 364 days"
    Then I click on the button labeled "Cancel" in the dialog box
    Then I should see "My Reports & Exports"

  Scenario: 5f - Verify export option - Stata Statistical Software
    Given I click on the button labeled "Export Data"
    Then I should see "Exporting \"All data (all records and fields)\""
    And I click on the radio labeled "Stata Statistical Software" in the dialog box
    Then I should see "Remove all tagged Identifier fields"
    And I should see "Hash the Record ID field"
    And I should see "Remove unvalidated Text fields"
    And I should see "Remove Notes/Essay box fields"
    And I should see "Remove all date and datetime fields"
    And I should see "Shift all dates by value between 0 and 364 days"
    And I should see "Also shift all survey completion timestamps by value between 0 and 364 days"
    Then I click on the button labeled "Cancel" in the dialog box
    Then I should see "My Reports & Exports"

  Scenario: 5g - Verify export option - CDISC ODM (XML)
    Given I click on the button labeled "Export Data"
    Then I should see "Exporting \"All data (all records and fields)\""
    And I click on the radio labeled "CDISC ODM (XML)" in the dialog box
    Then I should see "Remove all tagged Identifier fields"
    And I should see "Hash the Record ID field"
    And I should see "Remove unvalidated Text fields"
    And I should see "Remove Notes/Essay box fields"
    And I should see "Remove all date and datetime fields"
    And I should see "Shift all dates by value between 0 and 364 days"
    And I should see "Also shift all survey completion timestamps by value between 0 and 364 days"
    Then I click on the button labeled "Cancel" in the dialog box
    Then I should see "My Reports & Exports"

  Scenario: 6 - Export Data in csvlabels format and verify the exported data
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see "Export Data"
    When I export data for the report named "All data" in "csvlabels" format
   Then I should see "Data export was successful!"
    Then I should receive a download to a "csv" file
    Then I should have a "csv" file that contains the headings below
    | "Record ID" | "Event Name" | "Repeat Instrument" | "Repeat Instance" | "Survey Identifier" | "Last name" | "First name" | DOB | Reminder | Complete? | "Survey Timestamp" | Description | Complete? |
    Then I should have a "csv" file that contains the data "Survey" for record ID "1" and fieldname '"Repeat Instrument"'
    Then I should have a "csv" file that contains 8 distinct records
    Then I should have a "csv" file that contains 20 rows
    Then I should have a "csv" file that contains 11 repeating instrument rows
    # 11 rows show the Repeat Instrument name “Survey” - do I need to verify this? 
    # I am verifying 11 repeating instruments in the above step; 
    # and also verifying Repeat instrument has Survey as name for Record ID 1
    Then I should have a "csv" file that contains data in field '"Survey Timestamp"' listed on 2 rows
    Then I should have a "csv" file that contains the data "2019-06-17" for record ID "1" and fieldname "DOB"
    Then I should have a "csv" file that contains today's date for the fieldname '"Survey Timestamp"' for record ID "1" 
    Then I should have a "csv" file that contains record ID "1" listed on 4 rows
    Then I should have a "csv" file that contains 2 repeating instances of the event '"Event 1"' for record ID "1"
    Then I should have a "csv" file that contains 2 repeating instances of the event '"Event 2"' for record ID "1"
    Then I should have a "csv" file that contains record ID "2" listed on 3 rows
    Then I should have a "csv" file that contains 1 repeating instances of the event '"Event 1"' for record ID "2"
    Then I should have a "csv" file that contains 2 repeating instances of the event '"Event 2"' for record ID "2"
    # Dialog box closes on its own
    And I click on the button labeled "Close" in the dialog box
    Then I should see "My Reports & Exports"

  Scenario: 7 - Export Data in csvraw format and verify the exported data
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see "Export Data"
    When I export data for the report named "All data" in "csvraw" format
    Then I should see "Data export was successful!"
    Then I should receive a download to a "csv" file
    Then I should have a "csv" file that contains the headings below
    | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_survey_identifier | lname | fname | dob | reminder | export_complete | survey_timestamp | description | survey_complete |
    Then I should have a "csv" file that contains the data 'survey' for record ID "1" and fieldname 'redcap_repeat_instrument'
    Then I should have a "csv" file that contains 8 distinct records
    Then I should have a "csv" file that contains 20 rows
    Then I should have a "csv" file that contains 11 repeating instrument rows
    # 11 rows show the Repeat Instrument name “survey” - do I need to verify this? 
    # I am verifying 11 repeating instruments in the above step; 
    # and also verifying redcap_repeat_instrument has survey as name for Record ID 1
    Then I should have a "csv" file that contains data in field "survey_timestamp" listed on 2 rows
    Then I should have a "csv" file that contains record ID "1" listed on 4 rows
    Then I should have a "csv" file that contains record ID "2" listed on 3 rows
    And I click on the button labeled "Close" in the dialog box
    Then I should see "My Reports & Exports"

  Scenario: 8 - Make custom selections; export and verify the data
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see "Export Data"
    And I click on the button labeled "Make custom selections"
    And I select the option "Survey" from the list of Instruments in the custom selection option
    And I select the option "Event 2" from the list of Events in the custom selection option
    And I click the element containing the following text: "Export Data"
    And I click on the input element labeled "CSV / Microsoft Excel (raw data)"
    And I click on the button labeled "Export Data" in the dialog box
    Then I should see "Data export was successful!"
    Then I should receive a download to a "csv" file
    Then I should have a "csv" file that contains the headings below
    | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_survey_identifier | survey_timestamp | description | survey_complete |
    Then I should have a "csv" file that contains the data 'survey' for record ID "1" and fieldname 'redcap_repeat_instrument'
    Then I should have a "csv" file that contains 8 distinct records
    Then I should have a "csv" file that contains 11 rows
    Then I should have a "csv" file that contains data in field "survey_timestamp" listed on 2 rows
    And I click on the button labeled "Close" in the dialog box
    Then I should see "My Reports & Exports"

  Scenario: 9 - Export Data in csvraw format and check Hashed Record ID and other options and verify the exported data
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see "Export Data"
    When I click on the button labeled "Export Data"
    And I click on the checkbox identified by "input[id=deid-remove-identifiers]"
    And I click on the checkbox identified by "input[id=deid-hashid]"
    And I click on the checkbox identified by "input[id=deid-remove-text]"
    And I click on the checkbox identified by "input[id=deid-remove-notes]"
    And I click on the checkbox identified by "input[id=deid-dates-remove]"
    And I click on the input element labeled "CSV / Microsoft Excel (raw data)"
    And I click on the button labeled "Export Data" in the dialog box
    Then I should see "Data export was successful!"
    Then I should receive a download to a "csv" file
    Then I should have a "csv" file that contains the headings below
    | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | export_complete | survey_timestamp | survey_complete |
    # Data is raw.. Have to check this with hashed Record ID.. Is that needed? Heading is raw, means data is raw.
    # Then I should have a "csv" file that contains the data 'survey' for record ID "1" and fieldname 'redcap_repeat_instrument'
    Then I should have a "csv" file that contains 8 distinct records
    Then I should have a "csv" file that contains 20 rows
    And I should have a "csv" file that contains hashed record ID of length 32
    Then I should have a "csv" file that contains data in field "survey_timestamp" listed on 2 rows
    Then I should have a "csv" file that does not contain the fieldname "lname"
    Then I should have a "csv" file that does not contain the fieldname "fname"
    Then I should have a "csv" file that does not contain the fieldname "redcap_survey_identifier"
    Then I should have a "csv" file that does not contain the fieldname "reminder"
    Then I should have a "csv" file that does not contain the fieldname "description"
    Then I should have a "csv" file that does not contain the fieldname "dob"
    And I click on the button labeled "Close" in the dialog box
    Then I should see "My Reports & Exports"

  Scenario: 10 - Export Data in csvraw format and check Hashed Record ID and other options and verify the exported data
    Given I should see "Export Data"
    When I click on the button labeled "Export Data"
    And I click on the checkbox identified by "input[id=deid-dates-remove]"
    And I click on the checkbox identified by "input[id=deid-dates-shift]"
    And I click on the checkbox identified by "input[id=deid-surveytimestamps-shift]"
    And I click on the input element labeled "CSV / Microsoft Excel (raw data)"
    And I click on the button labeled "Export Data" in the dialog box
    Then I should see "Data export was successful!"
    Then I should see "DATE SHIFTED to an unknown value between 0 and  364 days"
    Then I should receive a download to a "csv" file
    Then I should have a "csv" file that contains the headings below
    | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | dob | export_complete | survey_timestamp | survey_complete |
    # Data is raw.. Have to check this with hashed Record ID.. Is that needed? Heading is raw, meand data is raw.
    # Then I should have a "csv" file that contains the data 'survey' for record ID "1" and fieldname 'redcap_repeat_instrument'
    Then I should have a "csv" file that contains 20 rows
    Then I should have a "csv" file that contains data in field "survey_timestamp" listed on 2 rows
    Then I should have a "csv" file that does not contain the data "2019-06-17" for record ID "1" and fieldname "dob"
    Then I should have a "csv" file that does not contain today's date for the fieldname "survey_timestamp" for record ID "1"
    And I click on the button labeled "Close" in the dialog box
    Then I should see "My Reports & Exports"

  Scenario: 11 - Edit User Rights - De-Identified in Data Exports
    Given I click on the link labeled "User Rights"
    And I click to edit username "test_user (Test User)"
    And I click on the button labeled "Edit user privileges"
    # Below step definition marks De-Identified in Data Exports
    And I click on the element identified by "input[name=data_export_tool][value=2]"
    And I click on the button labeled "Save Changes"
    Then I should see "was successfully edited"

  Scenario: 12 - Verify user cannot remove De-identification options
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    Then I click on the button labeled "Export Data"
    Then I should see "Given that you have limited export rights, you may NOT modify the options below, except the Date fields option"
    # Below 3 step definition verifies the checkbox cannot be unchecked
    And I should see the checkbox identified by "input[id=deid-remove-identifiers]", checked
    When I click on the checkbox identified by "input[id=deid-remove-identifiers]"
    Then I should see the checkbox identified by "input[id=deid-remove-identifiers]", checked
    # Below 3 step definition verifies the checkbox cannot be checked
    And I should see the checkbox identified by "input[id=deid-hashid]", unchecked
    When I click on the checkbox identified by "input[id=deid-hashid]"
    Then I should see the checkbox identified by "input[id=deid-hashid]", unchecked
    # Below 3 step definition verifies the checkbox cannot be unchecked
    And I should see the checkbox identified by "input[id=deid-remove-text]", checked
    When I click on the checkbox identified by "input[id=deid-remove-text]"
    Then I should see the checkbox identified by "input[id=deid-remove-text]", checked
    # Below 3 step definition verifies the checkbox cannot be unchecked
    And I should see the checkbox identified by "input[id=deid-remove-notes]", checked
    When I click on the checkbox identified by "input[id=deid-remove-notes]"
    Then I should see the checkbox identified by "input[id=deid-remove-notes]", checked
    And I click on the input element labeled "CSV / Microsoft Excel (raw data)"
    And I click on the button labeled "Export Data" in the dialog box
    Then I should see "Data export was successful!"
    Then I should see "DATE SHIFTED to an unknown value between 0 and  364 days"
    Then I should receive a download to a "csv" file
    Then I should have a "csv" file that contains the headings below
    | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | dob | export_complete | survey_timestamp | survey_complete |
    # Data is raw.. Have to check this with hashed Record ID.. Is that needed? Heading is raw, meand data is raw.
    # Then I should have a "csv" file that contains the data 'survey' for record ID "1" and fieldname 'redcap_repeat_instrument'
    Then I should have a "csv" file that contains 20 rows
    Then I should have a "csv" file that contains data in field "survey_timestamp" listed on 2 rows
    Then I should have a "csv" file that does not contain the data "2019-06-17" for record ID "1" and fieldname "dob"
    Then I should have a "csv" file that does not contain today's date for the fieldname "survey_timestamp" for record ID "1"
    Then I should have a "csv" file that does not contain the fieldname "lname"
    Then I should have a "csv" file that does not contain the fieldname "fname"
    Then I should have a "csv" file that does not contain the fieldname "redcap_survey_identifier"
    Then I should have a "csv" file that does not contain the fieldname "reminder"
    Then I should have a "csv" file that does not contain the fieldname "description"
    And I click on the button labeled "Close" in the dialog box
    Then I should see "My Reports & Exports"

  Scenario: 13 - Edit User Rights - No Access in Data Exports
    Given I click on the link labeled "User Rights"
    And I click to edit username "test_user (Test User)"
    And I click on the button labeled "Edit user privileges"
    # Below step definition marks No Access in Data Exports
    And I click on the element identified by "input[name=data_export_tool][value=0]"
    And I click on the button labeled "Save Changes"
    Then I should see "was successfully edited"

  Scenario: 14 - Verify user cannot export data
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see a button labeled "View Report"
    Then I should see a button labeled "Stats & Charts"
    Then I should NOT see a button labeled "Export Data"

  Scenario: 15 - Logout
    Then I logout