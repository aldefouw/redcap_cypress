Feature: Logging

  As a REDCap end user
  I want to see that Logging is functioning as expected

  # Background: 
  #   Given I am a "admin" user who logs into REDCap
    
  Scenario: 0 - Project Setup
    When I am a "admin" user who logs into REDCap
    Then I create a project named "23_Logging_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/logging.xml"
    And I click on the link labeled "User Rights"    
    #Add user 1
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
   
  # Scenario: 4 - Add new record
  #   When I visit Project ID 14
  #   Then I click on the link labeled "Add / Edit Records"
  #   And I click on the button labeled "Add new record"
  #   And I enter "Test2" into the "ptname" text input field
  #   And I enter "test@test.com" into the "email" text input field
  #   Then I click on the button labeled "Save & Exit"

  # Scenario: 5 - Add new record
  #   When I visit Project ID 14
  #   Then I click on the link labeled "Add / Edit Records"
  #   And I click on the button labeled "Add new record"
  #   And I enter "Delete" into the "ptname" text input field
  #   And I enter "delete@test.com" into the "email" text input field
  #   Then I click on the button labeled "Save & Exit"

  # Scenario: 6 - Delete record
  #   When I visit Project ID 14
  #   Then I click on the link labeled "Record Status Dashboard"
  #   And I click on the link labeled "3"
  #   And I click on the button labeled "Choose action for record"
  #   And I select the option labeled "Delete record (all forms)"
  #   And I click on the button labeled "DELETE RECORD"
  #  Then I close popup

  # Scenario: 7 - Add new role
  #   When I visit Project ID 14 
  #   Then I click on the link labeled "User Rights"
  #   And I enter "Data" into the rolename input field
  #   And I click on the button labeled "Create role" and I create role
  #   Then I should see a link labeled "Data"

  # Scenario: 8 - Edit role
  #   When I visit Project ID 14
  #   Then I click on the link labeled "User Rights" 
  #   And I click to edit role name "Data"
  #   And I check the user right identified by "input[name="design"]"
  #   Then I click on the button labeled "Save Changes"

  # Scenario: 9 - Delete role
  #   When I visit Project ID 14 
  #   Then I click on the link labeled "User Rights" 
  #   And I delete role name "Data"
  
  # Scenario: 10 - add user (completed in project setup)
  
  # Scenario: 11 - edit user (completed in project setup)

  # Scenario: 12 - Remove user
  #   When I visit Project ID 14
  #   Then I click on the link labeled "test_user"
  #   And I click on the button labeled "Edit user privileges"
  #   Then I click on the button labeled "Remove user"
  
  # # Scenario: 13 - Login as test_user2
  # #   When I am a "test_user2" user who logs into REDCap

  # Scenario: 14 - Data Exports, Reports, and Stats
  #   When I visit Project ID 14
  #   Then I click on the link labeled "Data Exports, Reports, and Stats"
  #   And I export all data in "csvraw" format

  # Scenario: 15 - Edit user privileges for test_user
  #   When I visit Project ID 14 
  #   Then I click on the link labeled "User Rights"
  #   And I click to edit username "test_user (Test User)"
  #   And I click on the button labeled "Edit user privileges"
  #   #need a better solution to scroll page to bottom
  #   And I scroll the user rights page to the bottom 
  #   And I check the user right identified by 'input[name="lock_record_customize"]'
  #   And I click the user right identified by 'input[name="lock_record"][value="2"]'
  #   Then I should see "NOTICE" 
  #   And I close popup
  #   And I add user|save changes

  # Scenario: 16 - Edit record (Lock Record)
  #   When I visit Project ID 14 
  #   #Then I click on the link labeled "Add / Edit Records"
  #   #And I click on the dropdown identified by 'select[id="record"]' and select record labelled by '1'
  #   #And I click on the bubble for the instrument identified by 'text_validation'
  #   Then I click on the link labeled "Record Status Dashboard"
  #   And I click on the bubble for the "Text Validation" data collection instrument instrument for record ID "1"
  #   And I check the checkbox identified by 'input[id="__LOCKRECORD__"]'
  #   Then I click on the button labeled "Save & Stay"
  
  # Scenario: 17 - Edit record (E-signature)
  #   When I visit Project ID 14 
  #   Then I click on the link labeled "Record Status Dashboard"
  #   And I click on the bubble for the "Text Validation" data collection instrument instrument for record ID "1"
  #   And I check the checkbox identified by 'input[id="__ESIGNATURE__"]'
  #   And I click on the button labeled "Save and Stay"
  #   Then I should see "Username/password verification"
  #   And I enter the Username: "test_user2" and password "Testing123" for e-signature
  #   And I click on the button labeled "Save"
  #   Then I should see "E-signed by test_user"
  
  # Scenario: 18 - Unlock form
  #   When I visit Project ID 14 
  #   Then I click on the link labeled "Record Status Dashboard"
  #   And I click on the bubble for the "Text Validation" data collection instrument instrument for record ID "1"
  #   And I click on the button labeled "Unlock form"
  #   Then I should see "UNLOCK FORM?"
  #   And I click on the button labeled "Unlock"
  #   Then I should see "UNLOCK SUCCESSFUL!"
  #   And I click on the button labeled "Close"
  #   And I click on the button labeled "Save and Exit Form"
  #   Then I should see "Record Home Page"
  
  Scenario: 19 - Enter draft mode and edit instrument
    When I visit Project ID 14
    Then I click on the link labeled "Designer"
    And I enter draft mode
    And I click on the link labeled "Text Validation"
    And I add a new field of type "text" and enter "textbox" into the field labeled "textbox"
    And I click on the button labeled "Save"
    Then I should see "textbox"
    And I click on the button labeled " Return to the list of instruments"
    Then I should see "Data Collection Instruments"
  
  Scenario: 20 - Create a new instrument
    When I visit Project ID 14
    Then I click on the link labeled "Designer"
    And I create a new instrument from scratch
    And I click on the button labeled "Add instrument here" 
    And I enter name "Form 2" and create instrument
    Then I should see "Form 2"
    And I click on the button labeled "Close"
  
  Scenario: 20 - Submit changes for review
    When I visit Project ID 14
    Then I click on the link labeled "Designer"
    And I submit draft changes for review

  # Scenario: 21 - Logging Page



 