Feature: Add / Manage Users

  As a REDCap end user
  I want to see that Add / Manage Users is functioning as expected

Background: 
    Given I am an "admin" user who logs into REDCap
    And I visit the "Control Center" page

Scenario: 2- Visible Pages
    When I click on the link labeled "User Settings"
    Then I should see "System-level User Settings" 

Scenario: 3- Save User Settings System Configurations 
    When I click on the link labeled "User Settings"
    Then I should see "System-level User Settings" 
    When I select "No, only Administrators can create new projects" from the dropdown identified by "select[name=superusers_only_create_project]"
    Then I should see "No, only Administrators can move projects to production"
    When I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 4- Display User Management for Table-based Authentication Page 
    When I click on the link labeled "Add Users (Table-based Only" 
    Then I should see "User Management for Table-based Authentication"

Scenario: 5- Create a user 
    When I click on the link labeled "Add Users (Table-based Only)" 
    And I enter "user1115_1" into the field labeled "Username:"
    And I enter "User1" into the field labeled "First name:"
    And I enter "1115_1" into the field labeled "Last name:"
    And I enter "user1115@redcap.edu" into the field labeled "Primary email:"
    #And I should see "Allow this user to request that projects be created for them by a REDCap administrator’"
    And I click on the input button labeled "Save"
    Then I should see "User has been successfully saved."
    And I should see "An email with login information was sent to: user1115@redcap.edu"
    
Scenario: 6- Log out as admin1115
    When I click on the link labeled "Log out"
    Then I should see "Please log in with your user name and password"

#Scenario: 7- Change password for user 1115_1
    #aldefouw will handle password change feature test

Scenario: 8- Login as admin1115

Scenario: 9- Bulk Create users 
    When I click on the link labeled "Add Users (Table-based Only)" 
    Then I should see "User Management for Table-based Authentication"
    When I click on the link labeled "Create users (bulk upload)"
    Then I should see "In order to perform a bulk upload to create new users"
    #When I click on the input button labeled "Choose File"
#NOT COMPLETE 
    


Scenario: 10- Display Create Single User Page 
    When I click on the link labeled "Add Users (Table-based Only)" 
    Then I should see "To create a new user (Table-based authentication ONLY)"


Scenario: 11- Prevent a Second User with the Same Username
    When I click on the link labeled "Add Users (Table-based Only)" 
    And I enter "user1115_1" into the field labeled "Username:"
    And I enter "User12" into the field labeled "First name:"
    And I enter "1115_12" into the field labeled "Last name:"
    And I enter "user11115@redcap.edu" into the field labeled "Primary email:"
    And I click on the input button labeled "Save"
    Then I should see "ERROR: The user could not be added! A user already exists named" 

Scenario: 12- Find user1115_1 Under Browse Users Page 
    When I click on the link labeled "Browse Users"
    Then I should see "User Search: Search for user by username, first name, last name, or primary email"
    When I enter "user1115_1" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    #Then I should see "Username"

Scenario: 13- Cancel Suspend user1115_1 Account
    When I click on the link labeled "Browse Users"
    And I enter "user1115_1" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    #And I click on the input button labeled "Suspend user account"
    #Then I should see "Do you wish to suspend this user’s REDCap account?"
    #When I click on the button labeled "Cancel"
    #Then I should not see "Success! The user has now been suspended from REDCap."


Scenario: 14- Suspend user1115_1 Account
    When I click on the link labeled "Browse Users"
    And I enter "user1115_1" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    And I click on the input button labeled "Suspend user account"
    Then I should see "Alert"
    #Then I should see time of suspension field updated to current day and time


#Scenario: 15- Login with Suspended User Account
    #When I click on the link labeled "Log out"
    #And I enter "user1115_1" into the field labeled "Username:"
    #And I enter "1115_1Pswd" into the field labeled "Password:" 
    #And I click on the button labeled "Log In"
    #Then I should see "The following REDCap user account has been suspended"

Scenario: 16- View user1115_1 in Suspended Users List
    When I click on the link labeled "Browse Users"
    Then I should see "User Search: Search for user by username, first name, last name, or primary email"
    When I click on the link labeled "View User List By Criteria"
    And I select "Suspended users" from the dropdown identified by "select[name=activity_level]"
    And I click on the button labeled "Display User List"
    #Then I should see a link labeled "user1115_1"

Scenario: 17- Cancel Unsuspend user1115_1 Account
    When I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    And I select "Suspended users" from the dropdown identified by "select[name=activity_level]"
    And I click on the button labeled "Display User List"
    #And I click on the checkbox identified by "select[name=uiid_7]"
    #And I click on the button labeled "Unsuspend user"
    #Then I should see "Process sponsor request: Unsuspend user"
    #When I click on the button labeled "Cancel"
    #Then I should see a link labeled "user1115_1"

Scenario: 18- Unsuspend user1115_1 Account
    When I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    And I select "Suspended users" from the dropdown identified by "select[name=activity_level]"
    And I click on the button labeled "Display User List"
    #And I click on the checkbox identified by "select[name=uiid_7]"
    #And I click on the button labeled "Unsuspend user"
    #Then I should see "Process sponsor request: Unsuspend user"
    #When I click on the button labeled "Unsuspend user"
    #Then I should see "The changes have been made successfully to the selected users!"

Scenario: 19- Log out as admin1115
    When I click on the link labeled "Log out"
    Then I should see "Please log in with your user name and password"

#Scenario: 20- Log in and out as user1115_1
    #When I click on the link labeled "Log out"
    #And I enter "user1115_1" into the field labeled "Username:"
    #And I enter "1115_1Pswd" into the field labeled "Password:" 
    #And I click on the button labeled "Log In"
    #Then I should see a link labeled "Control Center"
    #When I click on the link labeled "Log out"
    #Then I should see "Please log in with your user name and password"







