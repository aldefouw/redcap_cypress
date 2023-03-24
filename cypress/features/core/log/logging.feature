Feature: Logging

  As a REDCap end user
  I want to see that Logging is functioning as expected

  Scenario: 0 - Project Setup
    When I am an "admin" user who logs into REDCap
    Then I create a project named "Logging_Feature" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/logging.xml"
    And I click on the link labeled "User Rights"
    And I click to edit username "test_admin (Test User)"
    And I click on the button labeled "Edit user privileges"
    And I scroll the user rights page to the bottom
    And I check the User Right named 'Record Locking Customization'
    And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking with E-signature authority"
    Then I should see "NOTICE"
    And I click on the button labeled "Close" in the dialog box
    And I save changes within the context of User Rights

    #Add user 1
    And I click on the link labeled "User Rights"
    Then I enter "test_user" into the username input field
    And I click on the button labeled "Add with custom rights"
    And I check the User Right named 'Project Setup & Design'
    And I check the User Right named 'User Rights'
    And I select the User Right named 'Data Exports' and choose "Full Data Set"
    And I check the User Right named 'Logging'
    And I check the User Right named 'Delete Records'
    And I uncheck the User Right named 'Record Locking Customization'
    And I select the User Right named "Lock/Unlock Records" and choose "Disabled"
    And I check the User Right named "Create Records"
    And I save changes within the context of User Rights

    #Add user 2
    And I click on the link labeled "User Rights"
    And I enter "test_user2" into the username input field
    Then I click on the button labeled "Add with custom rights"
    And I check the User Right named 'User Rights'
    Then I save changes within the context of User Rights

    #enable e-sig
    And I click on the link labeled "Customize & Manage Locking/E-signatures"
    Then I select the option to display E-signature option for the instrument identified by '#savedEsign-text_validation'

    #move to prod
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far." in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box

    Then I should see "The project is now in production."

  Scenario: 1 - Login as test_user
    When I am a "standard" user who logs into REDCap

  Scenario: 2 - Go to my projects and open Logging_Feature
    Then I should see "My Projects"
    When I click on the link labeled "My Projects"
    Then I should see "Logging_Feature"
    When I click on the link labeled "Logging_Feature"
    Then I should see "Logging_Feature" in the title

  Scenario: 3 - Add new record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I enter "Test" into the data entry form field labeled "Name"
    And I enter "test@test.com" into the data entry form field labeled "Email"
    Then I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I clear field and enter "Testing" into the data entry form field labeled "Name"
    Then I select the submit option labeled "Save & Exit Record" on the Data Collection Instrument

  Scenario: 4 - Add new record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I enter "Test2" into the data entry form field labeled "Name"
    And I enter "test2@test.com" into the data entry form field labeled "Email"
    Then I select the submit option labeled "Save & Exit Record" on the Data Collection Instrument

  Scenario: 5 - Add new record
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I enter "Delete" into the data entry form field labeled "Name"
    And I enter "delete@test.com" into the data entry form field labeled "Email"
    Then I select the submit option labeled "Save & Exit Record" on the Data Collection Instrument

  Scenario: 6 - Delete record
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "3"
    And I click on the button labeled "Choose action for record"
    And I select the option labeled "Delete record (all forms)"
    And I click on the button labeled "DELETE RECORD"
    Then I close the popup

  Scenario: 7 - Add new role
    Given I click on the link labeled "User Rights"
    And I enter "Data" into the rolename input field
    And I click on the button labeled "Create role" and I create role
    Then I should see a link labeled "Data"

  Scenario: 8 - Edit role
    Given I click on the link labeled "User Rights"
    And I click to edit role name "Data"
    And I check the User Right named 'Project Setup & Design'
    Then I click on the button labeled "Save Changes"

  Scenario: 9 - Delete role
    Given I click on the link labeled "User Rights"
    And I delete role name "Data"

  Scenario: 10 - add user (completed in project setup)

  Scenario: 11 - edit user (completed in project setup)

  Scenario: 12 - Remove user & Add user
    Given I click on the link labeled "User Rights"
    And I click to edit username "test_user2 (Test User)"
    And I click on the button labeled "Edit user privileges"
    And I click on the button labeled "Remove user" in the dialog box
    And I should see "Remove user?"
    And I click on the button labeled "Remove user" in the dialog box
    Then I should see 'User "test_user2" was successfully deleted'

  #Add testuser2 again since we only have 2 standard users
  #Scenario: Add user
    Given I enter "test_user2" into the username input field
    And I click on the button labeled "Add with custom rights"
    And I check the User Right named 'Project Setup & Design'
    And I check the User Right named 'User Rights'
    And I select the User Right named 'Data Exports' and choose "Full Data Set"
    And I check the User Right named 'Logging'
    And I check the User Right named 'Delete Records'
    And I check the User Right named 'Record Locking Customization'
    And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking with E-signature authority"
    Then I should see "NOTICE"
    And I close the popup
    And I check the User Right named "Create Records"
    And I save changes within the context of User Rights

  Scenario: 13 - Login as test_user2
    When I am a "standard2" user who logs into REDCap

  Scenario: 14 - Data Exports, Reports, and Stats
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Logging_Feature"
    Then I click on the link labeled "Data Exports, Reports, and Stats"
    And I export all data in "csvraw" format and expect 2 records
    And I click on the button labeled "Close" in the dialog box

  Scenario: 15 - Edit user privileges for test_user

    Then I click on the link labeled "User Rights"
    And I click to edit username "test_user (Test User)"
    And I click on the button labeled "Edit user privileges"
    #need a better solution to scroll page to bottom
    And I scroll the user rights page to the bottom
    And I check the User Right named 'Record Locking Customization'
    And I select the User Right named "Lock/Unlock Records" and choose "Disabled"
    And I save changes within the context of User Rights

  Scenario: 16 - Edit record (Lock Record)

    Then I click on the link labeled "Record Status Dashboard"
    And I click on the bubble for the "Text Validation" data collection instrument for record ID "1"
    And I click the element containing the following text: " Lock"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    Then I should see "Instrument locked by test_user2"

  Scenario: 17 - Edit record (E-signature)

    When I click on the link labeled "Record Status Dashboard"
    And I click on the bubble for the "Text Validation" data collection instrument for record ID "1"
    And I check the checkbox identified by 'input[id="__ESIGNATURE__"]'
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    Then I should see "Username/password verification"

    Given I enter the Username: "test_user2" and password "Testing123" for e-signature
    And I click on the button labeled "Save" in the dialog box
    Then I should see "E-signed by test_user2"

  Scenario: 18 - Unlock form
    Given I see "Instrument locked by test_user2"
    And I click on the button labeled "Unlock form"
    Then I should see "UNLOCK FORM?"
    And I click on the button labeled "Unlock"
    Then I should see "UNLOCK SUCCESSFUL!"
    And I click on the button labeled "Close"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

  Scenario: 19 - Enter draft mode and edit instrument

    Then I click on the link labeled "Designer"
    And I enter draft mode
    And I click on the link labeled "Text Validation"
    And I add a new field of type "text" and enter "textbox" into the field labeled "textbox"
    Then I should see "textbox"
    And I click on the link labeled "Designer"
    Then I should see "Data Collection Instruments"

  Scenario: 20 - Create a new instrument

    Then I click on the link labeled "Designer"
    And I create a new data collection instrument called "Form 2"
    Then I should see "Form 2"
    #And I click on the button labeled "Close"

  Scenario: 20 - Submit changes for review

    Then I click on the link labeled "Designer"
    And I submit draft changes for review

  Scenario: 21 - Logging Page

    And I click on the link labeled "Logging"
    Then I should see "Filter by event:"
    And I should see "Filter by user name:"
    And I should see "Filter by record:"
    And I should see "Filter by time range from"
    And I should see "Displaying events (by most recent):"
    And I should see "Time / Date"
    And I should see "Username"
    And I should see "Action"
    And I should see "List of Data Changes"

  Scenario: 22 - Logging: filter by event - Data export

    Then I click on the link labeled "Logging"
    And I select the "Data export" option identified by "export" from the Filter by event dropdown field
    Then I should see 'Download exported data file (CSV raw)' in the logging table
    And I should see 'report_id: ALL, export_format: CSV, rawOrLabel: raw, fields: "record_id, ptname, email, text_validation_complete"' in the logging table

  Scenario: 23 - Logging: filter by event - Manage/Design
    Then I click on the link labeled "Logging"
    And I select the "Manage/Design" option identified by "manage" from the Filter by event dropdown field
    Then I should see 'Approve production project modifications (automatic)' in the logging table
    And I should see 'Create data collection instrument' in the logging table
    And I should see 'Create project field' in the logging table
    And I should see 'Enter draft mode' in the logging table

  Scenario: 24 - Logging: filter by event - User or role
    Then I click on the link labeled "Logging"
    And I select the "User or role created-updated-deleted" option identified by "user" from the Filter by event dropdown field
    Then I should see 'Updated User' in the logging table
    And I should see 'Created User' in the logging table
    And I should see 'Deleted User' in the logging table
    And I should see "user = 'test_user'" in the logging table
    And I should see "user = 'test_user2'" in the logging table
    And I should see "role = 'Data'" in the logging table

  Scenario: 25 - Logging: filter by event - Record created-updated-deleted
    Then I click on the link labeled "Logging"
    And I select the "Record created-updated-deleted" option identified by "record" from the Filter by event dropdown field
    Then I should see 'Updated Record' in the logging table
    And I should see 'Created Record' in the logging table
    And I should see 'Deleted Record' in the logging table
    And I should see "record_id = '3'" in the logging table
    And I should see "ptname = 'Delete', email = 'delete@test.com', text_validation_complete = '0', record_id = '3'" in the logging table
    And I should see "ptname = 'Test2', email = 'test2@test.com', text_validation_complete = '0', record_id = '2'" in the logging table
    And I should see "ptname = 'Testing'" in the logging table
    And I should see "ptname = 'Test', email = 'test@test.com', text_validation_complete = '0', record_id = '1'" in the logging table

  Scenario: 26 - Logging: filter by event - Record locking & e-signatures
    Then I click on the link labeled "Logging"
    And I select the "Record locking & e-signatures" option identified by "lock_record" from the Filter by event dropdown field
    Then I should see 'Lock/Unlock Record' in the logging table
    And I should see 'E-signature' in the logging table
    And I should see 'Action: Lock instrument' in the logging table
    And I should see 'Action: Unlock instrument' in the logging table
    And I should see 'Action: Save e-signature' in the logging table
    And I should see 'Action: Negate e-signature' in the logging table

  Scenario: 27 - Logging: filter by event - Page Views
    Then I click on the link labeled "Logging"
    And I select the "Page Views" option identified by "page_view" from the Filter by event dropdown field
    Then I should see 'Page View' in the logging table
    And I should see '/Logging/index.php' in the logging table

  Scenario: 28 - Logging: filter by event - All event types (username) - by specific username
    Then I click on the link labeled "Logging"
    And I select the "test_admin" option from the Filter by username dropdown field
    And I select the "test_user" option from the Filter by username dropdown field
    And I select the "test_user2" option from the Filter by username dropdown field
    
  Scenario: 29 - Logging: filter by event - All event types (record) - by specific record
    Then I click on the link labeled "Logging"
    And I select the '2' option from the Filter by record dropdown field
    Then I should see 'Created Record' in the logging table
    And I should see "ptname = 'Test2', email = 'test2@test.com', text_validation_complete = '0', record_id = '2'" in the logging table

  Scenario: 30 - Download All logging and open file to verify

    Then I click on the link labeled "Logging"
    And I export all logging from the project and verify the result against expected logging results for this version of REDCap

  Scenario: 31 - Login as admin
    Given I am an "admin" user who logs into REDCap

  Scenario: 32 - Delete a record’s logging activity when deleting the records
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Edit a Project's Settings"
    And I select 'Logging_Feature' from the dropdown identified by 'select'
    #And I click on the dropdown identified by 'select' and select value '14' labelled by
    Then I should see "project settings"
    And I select "Yes, delete the record's logged events when deleting the record" on the dropdown field labeled "Delete a record's logging activity when deleting the record?"
    And I click on the button labeled "Save Changes"
    And I click on the link labeled "Logging"

  Scenario: 33 - Login as test_user
    Given I am a "standard" user who logs into REDCap

  Scenario: 34 - Delete Record
    Then I should see "My Projects"
    When I click on the link labeled "My Projects"
    Then I should see "Logging_Feature"
    When I click on the link labeled "Logging_Feature"
    Then I click on the link labeled "Record Status Dashboard"
    And I click on the bubble for the "Text Validation" data collection instrument for record ID "2"
    And I click on the link labeled "Record ID 2"
    And I click on the button labeled "Choose action for record"
    And I select the option labeled "Delete record (all forms)"
    Then I should see 'DELETE RECORD "2"'

    #Cannot complete the commented steps below. This is a known error in 11.1.5 and fixed in v11.1.11

    # And I check the checkbox identified by 'input[id="allow_delete_record_from_log"]'
    # Then I should see "Confirmation: Type 'DELETE'"
    # And I enter 'DELETE' into the field identified by 'input[type=text]'
    # And I click on the button labeled 'Confirm'

    And I click on the button labeled "DELETE RECORD"
    And I should see 'Record ID "2" was successfully deleted'
    Then I close the popup

  Scenario: 35 - Logging: filter by event - Record created-updated-deleted
    Then I click on the link labeled "Logging"
    And I select the "Record created-updated-deleted" option identified by "record" from the Filter by event dropdown field
    Then I should see 'Updated Record' in the logging table
    And I should see 'Created Record' in the logging table
    And I should see 'Deleted Record' in the logging table
    #And I should see '[*DATA REMOVED*]' in the logging table
    #And I should see '[All data values were removed from this record's logging activity.]' in the logging table

  Scenario: 36 - Login as admin
    Given I am an "admin" user who logs into REDCap

  Scenario: 37 - Enter Draft Mode and Enable Longitudinal Data Collection
    Then I should see "My Projects"
    When I click on the link labeled "My Projects"
    Then I should see "Logging_Feature"
    When I click on the link labeled "Logging_Feature"

    Then I click on the link labeled "Designer"
    And I enter draft mode
    And I click on the link labeled "Project Setup"
    And I enable longitudinal mode
    Then I should see that longitudinal mode is "enabled"

  Scenario: 37 - Submit changes for review

    Then I click on the link labeled "Designer"
    And I submit draft changes for review

  Scenario: 37 - Add Arm

    Then I click on the link labeled 'Project Setup'
    And I click on the button labeled "Define My Events"
    And I click on the link labeled "+Add New Arm"
    And I enter "Arm 2" into the Arm name field
    And I click on the button labeled "Save"
    Then I should see "No events have been defined for this Arm"
    And I add an event named "Event 1" into the currently selected arm
    Then I should see "Event 1"

  Scenario: 37 - Designate Instrument
    When I click on the link labeled "Designate Instruments for My Events"

    #Arm 1
    Then I should see "Arm name: "
    And I click on the link labeled "Arm 2"

    #Arm 2
    Then I should see "Arm name: "
    Given I enable the Data Collection Instrument named "Text Validation" for the Event named "Event 1"

  Scenario: 38 - Login as test_user
    Given I am a "standard" user who logs into REDCap

  Scenario: 39 - Add new record to an Arm
    Then I should see "My Projects"
    When I click on the link labeled "My Projects"
    Then I should see "Logging_Feature"
    When I click on the link labeled "Logging_Feature"
    And I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm 2"
    And I click on the button labeled "Add new record for this arm"
    And I enter "Arm2" into the data entry form field labeled "Name"
    Then I select the submit option labeled "Save & Exit Record" on the Data Collection Instrument

  Scenario: 40 - Logging: filter by event - Record created-updated-deleted
    Then I click on the link labeled "Logging"
    And I select the "Record created-updated-deleted" option identified by "record" from the Filter by event dropdown field
    #Then I should see '(Event 1 - (Arm 2: Arm 2))' in the logging table
    And I should see "ptname = 'Arm2', text_validation_complete = '0', record_id = '2'" in the logging table

  Scenario: 41 - Delete Record
    Then I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm 2"
    And I click on the link labeled exactly "2"
    And I should see "Choose action for record"
    And I click on the button labeled "Choose action for record"
    And I click on the link labeled "Delete record (all forms/events)"
    Then I should see "DELETE RECORD"
    # And I check the checkbox identified by 'input[id="allow_delete_record_from_log"]'
    # Then I should see "Confirmation: Type 'DELETE'"
    # And I enter 'DELETE' into the field identified by 'input[type=text]'
    # And I click on the button labeled 'Confirm'
    And I click on the button labeled "DELETE RECORD"
    Then I close the popup

  Scenario: 42 - Logging: filter by event - Record created-updated-deleted

    Then I click on the link labeled "Logging"
    And I select the "Record created-updated-deleted" option identified by "record" from the Filter by event dropdown field
    #Then I should see '[*DATA REMOVED*]' in the logging table
    #And I should see '[All data values were removed from this record's logging activity.]' in the logging table

  Scenario: 43 - Logout
    Given I logout