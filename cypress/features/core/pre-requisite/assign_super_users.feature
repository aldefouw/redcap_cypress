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
   
Scenario: Create a user- from add_manage_users
        #scenario 4 wont run without this here
    When I click on the link labeled "Add Users (Table-based Only)" 
    And I enter "user1115_1" into the field labeled "Username:"
    And I enter "User1" into the field labeled "First name:"
    And I enter "1115_1" into the field labeled "Last name:"
    And I enter "user1115@redcap.edu" into the field labeled "Primary email:"
        #checkbox for "Allow this user to request that projects be created for them by a REDCap administrator?" is already checked
    And I click on the input button labeled "Save"
    Then I should see "User has been successfully saved."
    And I should see "An email with login information was sent to: user1115@redcap.edu"

Scenario: 4 & 5- Add user1115_1 to Administrator List
    When I click on the link labeled "Administrator Privileges"
    And I enter "user1115_1" into the field identified by "[id=user_search]"
    And I click on the checkbox identified by "[id=0-admin_rights]"
    And I click on the button labeled "Add"
    Then I should see "The user user1115_1 has now been granted one or more administrator privileges"
        #program doesnt detect message or ok button in popup screen
    When I click on the button labeled "OK"
    Then I should see "user1115_1"

Scenario: 6- Verify user1115_1 Administrator Priveledges 
    When I click on the link labeled "Log out"
    And I enter "user1115_1" into the field labeled "Username:"
    And I enter "1115_1Pswd" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
        #password was never reset, login is invalid
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Users"
    And I should see "Administrator Privileges"
        #come back to this once password is reset

Scenario: 7, 8, and 9- Grant user1115_3 Administrator Privileges
    When I click on the link labeled "Administrator Privileges"
    And I enter "user1115_3" into the field identified by "[id=user_search]"
    And I click on the checkbox identified by "[id=0-account_manager]"
    And I click on the button labeled "Add"
        #user1115_3 does not exist (file in add manage users not uploaded)
    Then I should see "The user user1115_3 has now been granted one or more administrator privileges"
        #program doesnt detect message or ok button in popup screen
    When I click on the button labeled "OK"
    Then I should see "user1115_3"

Scenario: 10- Verify user1115_3 Account Manager Priveledges 
    When I click on the link labeled "Log out"
    And I enter "user1115_3" into the field labeled "Username:"
    And I enter "PASSWORD HERE" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
        #password was never reset, login is invalid
    And I click on the link labeled "Control Center"
    Then I should see a Control Center link labeled "Browse Users"
    And I should see a Control Center link labeled "Add Users (Table-based Only)"
    #not sure how to ensure a link is read only (and I should see?)
        #come back to this once password is reset

Scenario: 11- Switch user1115_3 to Maximum User Privileges
    When I click on the link labeled "Administrator Privileges"
    And I enter "user1115_3" into the field identified by "[id=user_search]"
    And I click on the checkbox identified by "[id=0-super_user]"
    And I click on the checkbox identified by "[id=0-account_manager]"
    And I click on the button labeled "Add"
        #user1115_3 does not exist (file in add manage users not uploaded)
    Then I should see "The user user1115_3 has now been granted one or more administrator privileges"
        #program doesnt detect message or ok button in popup screen
    When I click on the button labeled "OK"
    Then I should see "user1115_3"

Scenario: 12- Verify user1115_3 Maximum User Privileges Priveledges 
    When I click on the link labeled "Log out"
    And I enter "user1115_3" into the field labeled "Username:"
    And I enter "PASSWORD HERE" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
        #password was never reset, login is invalid
    And I click on the link labeled "Control Center"
    Then I should see a Control Center link labeled "Browse Users"
    And I should see a Control Center link labeled "Edit a Project's Settings"
    And I should see a Control Center link labeled "Survey Link Lookup"
    #not sure how to ensure a link is read only (and I should see?)
        #come back to this once password is reset





