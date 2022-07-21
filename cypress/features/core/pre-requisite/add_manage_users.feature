Feature: Add / Manage Users

  As a REDCap end user
  I want to see that Add / Manage Users is functioning as expected

Background: 
    Given I am an "admin" user who logs into REDCap
    And I visit the "Control Center" page

Scenario: Visible Pages
    When I click on the link labeled "User Settings"
    Then I should see "System-level User Settings" 

Scenario: Save User Settings System Configurations 
    When I click on the link labeled "User Settings"
    Then I should see "System-level User Settings" 
    And I select "No, only Administrators can create new projects" from the dropdown identified by "select[name=superusers_only_create_project]"
    Then I should see "No, only Administrators can move projects to production"
    And I should see "Save Changes"
    When I click on the input button labeled "Save Changes"

Scenario: Display User Management for Table-based Authentication Page 
    When I click on the link labeled "Add Users (Table-based Only" 
    Then I should see "User Management for Table-based Authentication"

Scenario: Create a user 
    When I click on the link labeled "Add Users (Table-based Only" 
    And I enter "user1115_1" into the field labeled "Username:"
    And I enter "User1" into the field labeled "First name:"
    And I enter "1115_1" into the field labeled "Last name:"
    And I enter "mmpeterson24@wisc.edu" into the field labeled "Primary email:"
    And I click on the input button labeled "Save"
    Then I should see "User has been successfully saved."
    And I should see "An email with login information was sent to:"
    #log out as admin1115

#Scenario: Change password for user 1115_1
    #aldefouw will handle password change feature test

Scenario: Bulk Create users 
    When I click on the link labeled "Add Users (Table-based Only" 
    And I click on the link labeled "Create users (bulk upload)"
    And I click on the button labeled "Choose File"
#NOT COMPLETE 
    And I click on the link labeled "Create single user "
    Then  I should see "To create a new user (Table-based authentication ONLY), provide the new user name along"



Scenario: Prevent a Second User with the Same Username
    When I click on the link labeled "Add Users (Table-based Only" 
    And I enter "user1115_1" into the field labeled "Username:"
    And I enter "User12" into the field labeled "First name:"
    And I enter "1115_12" into the field labeled "Last name:"
    And I enter "mmpeterson2224@wisc.edu" into the field labeled "Primary email:"
    And I click on the input button labeled "Save"
    Then I should see "ERROR: The user could not be added! A user already exists named"

    




















