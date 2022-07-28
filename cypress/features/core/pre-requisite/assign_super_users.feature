Feature: Assign Super Users / Account Managers

  As a REDCap end user
  I want to see that Assign Super Users / Account Managers is functioning as expected

Background: 
    Given I am an "admin" user who logs into REDCap
    And I visit the "Control Center" page

Scenario: 2- Control Center Links Visible
    Then I should see "Control Center Home"
    And I should see "Projects"
    And I should see "Users"
    And I should see "System Configuration"

Scenario: 3- Administrator Privileges Page Visible
    When I click on the link labeled "Administrator Privileges"
    Then I should see "Set REDCap Administrator Privileges"
   
Scenario: Create a user - from add_manage_users
        #scenario 4 wont run without this here
    When I click on the link labeled "Add Users (Table-based Only)" 
    And I enter "user1115_1" into the field labeled "Username:"
    And I enter "User1" into the field labeled "First name:"
    And I enter "1115_1" into the field labeled "Last name:"
    And I enter "user1115@redcap.edu" into the field labeled "Primary email:"
    #And I click on the checkbox identified by "select[name=     ?????     ]"
        #checkbox needs step definition
    And I click on the input button labeled "Save"
    Then I should see "User has been successfully saved."
    And I should see "An email with login information was sent to: user1115@redcap.edu"

Scenario: 4 & 5- Add user1115_1 to Administrator List
    When I click on the link labeled "Administrator Privileges"
    And I enter "user1115_1" into the field labeled "select[placeholder=Search users to add as admin]"
    And I click on the checkbox identified by "input"
    And I click on the button labeled "Add"
    Then I should see "The user "user1115_1" has now been granted one or more administrator privileges"
    When I click on the button labeled "OK"
    Then I should see "user1115_1"




