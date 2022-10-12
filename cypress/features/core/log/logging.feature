Feature: Logging

  As a REDCap end user
  I want to see that Logging is functioning as expected

  Background: 
    Given I am a "admin" user who logs into REDCap
    
  Scenario: 0 - Project Setup
    When I create a project named "23_Logging_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/logging.xml"

  Scenario: 1 - Login as test_user

  Scenario: 2 - Go to my projects and open 23_Logging_v1115
    When I visit Project ID 14
    Then I should see "23_Logging_v1115"

  # Scenario: 3 - Add new record
  #   When I visit Project ID 14
  #   Then I click on the link labeled "Add / Edit Records"
  #   And I click on the button labeled "Add new record"
  #   And I enter "Test" into the "ptname" text input field
  #   And I enter "test@test.com" into the "email" text input field
  #   Then I click on the button labeled Save & Stay
  #   And I clear the field and enter "Testing" into the "ptname" text input field
  #   Then I click on the button labeled "Save & Exit"
    
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
  
  Scenario: 10 - Add new user
    When I visit Project ID 14 
    Then I click on the link labeled "User Rights"    
    And I add a new user named "standard" to the project
    And I click on the button labeled "Add with custom rights"
    Then I should see a link labeled "Test User"
  
  # Scenario: 11 - Edit user
  #   When I click on the link labeled "User Rights"    
  #   And I select the user "user1115_3"
  # Add project design and setup
  # save 

  # Scenario: 12 - Remove user
  #   When I click on the link labeled "user1115_3"
  #   And I click on the button labeled "Edit user privileges"
  #   Then I should see get warning "Remove user?" when I click on the button labeled "Remove user"
  #   And I click on the button labeled "Remove user"
  
  # Scenario: 13 - Login as test_user2
  #   When I click on the button labeled "Log out"
  #   Then I should see the login page
  #   And I login as test_user2
  #   Then I should see the text "Logged in as test_user2"

  # Scenario: 14 - Data Exports, Reports, and Stats
  #   When I visit Project ID 14
  #   Then I click on the link labeled "Data Exports, Reports, and Stats"
  #   And I export all data in "csvraw" format

  # Scenario: 15 - Edit user privileges for test_user1
  #   When I visit Project ID 14 
  #   Then I click on the link labeled "User Rights"
  #   And I click on the link labeled "test_user"
  #   And I check the user right identified by "input[name="lock_record_customize"]"
  #   And I click the user right identified by "input[name="lock_record"][value="2"]"
  #   #Then I should see a popup with "NOTICE" and I close popup
  #   And I click on the button labeled "Saved Changes"
  #   #Then I should see a green checkmark for "Record Locking Customization" and a green shield for "Lock/Unlock Records"

 