Feature: Logging

  As a REDCap end user
  I want to see that Logging is functioning as expected

  # Background: 
  #   Given I am a "admin" user who logs into REDCap
    
  Scenario: 0 - Project Setup
    When I am a "admin" user who logs into REDCap
    Then I create a project named "23_Logging_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/logging.xml"
    And I click on the link labeled "User Rights"
    And I click to edit username "test_admin (Test User)"

    #test as admin until, login is fixed for testuser 1 and 2
    And I click on the button labeled "Edit user privileges"
    And I scroll the user rights page to the bottom 
    And I check the user right identified by 'input[name="lock_record_customize"]'
    And I click the user right identified by 'input[name="lock_record"][value="2"]'
    Then I should see "NOTICE"
    And I close popup
    And I add user|save changes

    #Add user 1
    And I click on the link labeled "User Rights"
    Then I enter "test_user" into the username input field
    And I click on the button labeled "Add with custom rights"
    And I check the user right identified by 'input[name="design"]'
    And I check the user right identified by 'input[name="user_rights"]'
    And I check the user right identified by 'input[name="data_export_tool"]' and select option "1"
    And I check the user right identified by 'input[name="data_logging"]'
    And I check the user right identified by 'input[name="record_delete"]'
    And the user right identified by 'input[name="lock_record_customize"]' should not be checked
    And the user right identified by 'input[name="lock_record"][value="2"]' should not be checked
    And the user right identified by 'input[name="record_create"]' should be checked
    And I add user|save changes
    #Add user 2
    And I click on the link labeled "User Rights"   
    And I enter "test_user2" into the username input field
    Then I click on the button labeled "Add with custom rights"
    And I check the user right identified by 'input[name="design"]'
    Then I add user|save changes
    #enable e-sig
    And I click on the link labeled "Customize & Manage Locking/E-signatures"
    Then I select the option to display E-signature option for the instrument identified by '#savedEsign-text_validation'
    #move to prod
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    Then I move the project to production by selection option 'input#keep_data'

  # Scenario: 1 - Login as test_user
  #   When I am a "test_user" user who logs into REDCap

  Scenario: 2 - Go to my projects and open 23_Logging_v1115
    When I visit Project ID 14
    Then I should see "23_Logging_v1115"

  Scenario: 3 - Add new record
    When I visit Project ID 14
    Then I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I enter "Test" into the "ptname" text input field
    And I enter "test@test.com" into the "email" text input field
    Then I click on the dropdown and select the button identified by 'a#submit-btn-savecontinue'
    And I clear the field and enter "Testing" into the "ptname" text input field
    Then I click on the button labeled "Save & Exit"
   
  Scenario: 4 - Add new record
    When I visit Project ID 14
    Then I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I enter "Test2" into the "ptname" text input field
    And I enter "test2@test.com" into the "email" text input field
    Then I click on the button labeled "Save & Exit"

  Scenario: 5 - Add new record
    When I visit Project ID 14
    Then I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I enter "Delete" into the "ptname" text input field
    And I enter "delete@test.com" into the "email" text input field
    Then I click on the button labeled "Save & Exit"

  Scenario: 6 - Delete record
    When I visit Project ID 14
    Then I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "3"
    And I click on the button labeled "Choose action for record"
    And I select the option labeled "Delete record (all forms)"
    And I click on the button labeled "DELETE RECORD"
   Then I close popup

  Scenario: 7 - Add new role
    When I visit Project ID 14 
    Then I click on the link labeled "User Rights"
    And I enter "Data" into the rolename input field
    And I click on the button labeled "Create role" and I create role
    Then I should see a link labeled "Data"

  Scenario: 8 - Edit role
    When I visit Project ID 14
    Then I click on the link labeled "User Rights" 
    And I click to edit role name "Data"
    And I check the user right identified by 'input[name="design"]'
    Then I click on the button labeled "Save Changes"

  Scenario: 9 - Delete role
    When I visit Project ID 14 
    Then I click on the link labeled "User Rights" 
    And I delete role name "Data"
  
  Scenario: 10 - add user (completed in project setup)
  
  Scenario: 11 - edit user (completed in project setup)

  Scenario: 12 - Remove user
    When I visit Project ID 14
    Then I click on the link labeled "User Rights"
    And I click to edit username "test_user2 (Test User)"
    And I click on the button labeled "Edit user privileges"
    Then I click on the button labeled Remove User

  #Add testuser2 again since we only have 2 standard users
  Scenario: Add user
    When I visit Project ID 14
    Then I click on the link labeled "User Rights"
    And I enter "test_user2" into the username input field
    And I click on the button labeled "Add with custom rights"
    And I check the user right identified by 'input[name="design"]'
    And I check the user right identified by 'input[name="user_rights"]'
    And I check the user right identified by 'input[name="data_export_tool"]' and select option "1"
    And I check the user right identified by 'input[name="data_logging"]'
    And I check the user right identified by 'input[name="record_delete"]'
    And I check the user right identified by 'input[name="lock_record_customize"]'
    And I click the user right identified by 'input[name="lock_record"][value="2"]'
    Then I should see "NOTICE"
    And I close popup
    And I click the user right identified by 'input[name="record_create"]'
    And I add user|save changes
  
  # Scenario: 13 - Login as test_user2
  #   When I am a "test_user2" user who logs into REDCap

  Scenario: 14 - Data Exports, Reports, and Stats
    When I visit Project ID 14
    Then I click on the link labeled "Data Exports, Reports, and Stats"
    And I export all data in "csvraw" format and expect 2 record

  Scenario: 15 - Edit user privileges for test_user
    When I visit Project ID 14 
    Then I click on the link labeled "User Rights"
    And I click to edit username "test_user (Test User)"
    And I click on the button labeled "Edit user privileges"
    #need a better solution to scroll page to bottom
    And I scroll the user rights page to the bottom 
    And I check the user right identified by 'input[name="lock_record_customize"]'
    And I click the user right identified by 'input[name="lock_record"][value="2"]'
    Then I should see "NOTICE" 
    And I close popup
    And I add user|save changes

  Scenario: 16 - Edit record (Lock Record & E-Signature)
    When I visit Project ID 14 
    #Then I click on the link labeled "Add / Edit Records"
    #And I click on the dropdown identified by 'select[id="record"]' and select record labelled by '1'
    #And I click on the bubble for the instrument identified by 'text_validation'
    Then I click on the link labeled "Record Status Dashboard"
    And I click on the bubble for the "Text Validation" data collection instrument instrument for record ID "1"
    And I check the checkbox identified by 'input[id="__LOCKRECORD__"]'
    Then I click on the button labeled "Save & Stay"
  # Scenario: 17 - Edit record (E-signature)
  #   And I check the checkbox identified by 'input[id="__ESIGNATURE__"]'
  #   Then I click on the button labeled "Save & Stay"
  #   Then I should see "Username/password verification"
  #   And I enter the Username: "test_admin" and password "Testing123" for e-signature
  #   And I click on the button labeled "Save"
  #   Then I should see that the checkbox identified by 'input[id="__ESIGNATURE__"]' should be checked
  
  Scenario: 18 - Unlock form
    When I visit Project ID 14 
    Then I click on the link labeled "Record Status Dashboard"
    And I click on the bubble for the "Text Validation" data collection instrument instrument for record ID "1"
    And I click on the input button labeled "Unlock form"
    Then I should see "UNLOCK FORM?"
    And I click on the button labeled "Unlock"
    Then I should see "UNLOCK SUCCESSFUL!"
    And I click on the button labeled "Close"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"
  
  Scenario: 19 - Enter draft mode and edit instrument
    When I visit Project ID 14
    Then I click on the link labeled "Designer"
    And I enter draft mode
    And I click on the link labeled "Text Validation"
    And I add a new field of type "text" and enter "textbox" into the field labeled "textbox"
    Then I should see "textbox"
    And I click on the link labeled "Designer"
    Then I should see "Data Collection Instruments"
  
  Scenario: 20 - Create a new instrument
    When I visit Project ID 14
    Then I click on the link labeled "Designer"
    And I create a new instrument from scratch
    And I click on the button labeled "Add instrument here" 
    And I enter name "Form 2" and create instrument
    Then I should see "Form 2"
    #And I click on the button labeled "Close"
  
  Scenario: 20 - Submit changes for review
    When I visit Project ID 14
    Then I click on the link labeled "Designer"
    And I submit draft changes for review

  Scenario: 21 - Logging Page
    When I visit Project ID 14
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
    When I visit Project ID 14
    Then I click on the link labeled "Logging"
    And I select the "Data export" option identified by "export" from the Filter by event dropdown field
    Then I should see 'Download exported data file (CSV raw)' in the logging table
    And I should see 'report_id: ALL, export_format: CSV, rawOrLabel: raw, fields: "record_id, ptname, email, text_validation_complete"' in the logging table

  Scenario: 23 - Logging: filter by event - Manage/Design
    When I visit Project ID 14
    Then I click on the link labeled "Logging"
    And I select the "Manage/Design" option identified by "manage" from the Filter by event dropdown field
    Then I should see 'Approve production project modifications (automatic)' in the logging table
    And I should see 'Create data collection instrument' in the logging table
    And I should see 'Create project field' in the logging table
    And I should see 'Enter draft mode' in the logging table
  
  Scenario: 24 - Logging: filter by event - User or role
    When I visit Project ID 14
    Then I click on the link labeled "Logging"
    And I select the "User or role created-updated-deleted" option identified by "user" from the Filter by event dropdown field
    Then I should see 'Updated User' in the logging table
    And I should see 'Created User' in the logging table
    And I should see 'Deleted User' in the logging table
    #And I should see 'user = \'test_user\'' in the logging table
    #And I should see 'user = \'test_user2\'' in the logging table
    And I should see 'role = \'Data\'' in the logging table

  Scenario: 25 - Logging: filter by event - Record created-updated-deleted
    When I visit Project ID 14
    Then I click on the link labeled "Logging"
    And I select the "Record created-updated-deleted" option identified by "record" from the Filter by event dropdown field
    Then I should see 'Updated Record' in the logging table
    And I should see 'Created Record' in the logging table
    And I should see 'Deleted Record' in the logging table
    And I should see 'record_id = \'3\'' in the logging table
    And I should see 'ptname = \'Delete\', email = \'delete@test.com\', text_validation_complete = \'0\', record_id = \'3\'' in the logging table
    And I should see 'ptname = \'Test2\', email = \'test2@test.com\', text_validation_complete = \'0\', record_id = \'2\'' in the logging table
    And I should see 'ptname = \'Testing\'' in the logging table
    And I should see 'ptname = \'Test\', email = \'test@test.com\', text_validation_complete = \'0\', record_id = \'1\'' in the logging table

  Scenario: 26 - Logging: filter by event - Record locking & e-signatures
    When I visit Project ID 14
    Then I click on the link labeled "Logging"
    And I select the "Record locking & e-signatures" option identified by "lock_record" from the Filter by event dropdown field
    Then I should see 'Lock/Unlock Record' in the logging table
    #And I should see 'E-signature' in the logging table
    And I should see 'Action: Lock instrument' in the logging table
    And I should see 'Action: Unlock instrument' in the logging table
    #And I should see 'Action: Save e-signature' in the logging table
    #And I should see 'Action: Negate e-signature' in the logging table

  Scenario: 27 - Logging: filter by event - Page Views
    When I visit Project ID 14
    Then I click on the link labeled "Logging"
    And I select the "Page Views" option identified by "page_view" from the Filter by event dropdown field
    Then I should see 'Page View' in the logging table
    And I should see '/redcap_v11.1.5/Logging/index.php?pid=14' in the logging table

  Scenario: 28 - Logging: filter by event - All event types (username) - by specific username
    When I visit Project ID 14
    Then I click on the link labeled "Logging"
    And I select the "test_admin" option from the Filter by username dropdown field
    #And I select the "test_user" option from the Filter by username dropdown field
    #And I select the "test_user2" option from the Filter by username dropdown field
    
  Scenario: 29 - Logging: filter by event - All event types (record) - by specific record
    When I visit Project ID 14
    Then I click on the link labeled "Logging"
    And I select the '2' option from the Filter by record dropdown field
    Then I should see 'Created Record' in the logging table
    And I should see 'ptname = \'Test2\', email = \'test2@test.com\', text_validation_complete = \'0\', record_id = \'2\'' in the logging table
  
  # Scenario: 30 - Download All logging
  #   When I am on the Logging page
  #   And I click on the button labelled "All logging"
  #   Then I should see a file downloaded814137