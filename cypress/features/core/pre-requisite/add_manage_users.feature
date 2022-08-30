Feature: Add / Manage Users

  As a REDCap end user
  I want to see that Add / Manage Users is functioning as expected

Background: 
    Given I am an "admin" user who logs into REDCap
    And I visit the "Control Center" page

Scenario: 1- Login as admin1115

Scenario: 2- Visible Pages
    When I click on the link labeled "User Settings"
    Then I should see "System-level User Settings" 

Scenario: 3- Save User Settings System Configurations 
    When I click on the link labeled "User Settings"
    Then I should see "System-level User Settings" 
    When I select "No, only Administrators can create new projects" from the dropdown identified by "select[name=superusers_only_create_project]"
    And I select "No" from the dropdown identified by "select[name=allow_create_db_default]"
    When I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 4- Display User Management for Table-based Authentication Page 
    When I click on the link labeled "Add Users (Table-based Only)" 
    Then I should see "User Management for Table-based Authentication"

Scenario: 5- Create a user 
    When I click on the link labeled "Add Users (Table-based Only)" 
    And I enter "user1115_1" into the field labeled "Username:"
    And I enter "User1" into the field labeled "First name:"
    And I enter "1115_1" into the field labeled "Last name:"
    And I enter "user1115@redcap.edu" into the field labeled "Primary email:"
    And I click on the checkbox identified by "[name=allow_create_db]"
    And I click on the input button labeled "Save"
    Then I should see "User has been successfully saved."
    And I should see "An email with login information was sent to: user1115@redcap.edu"

Scenario: 6- Logout as admin1115

#Scenario: 7 - Reset password through email link 
    #aldefouw will handle password change feature test

Scenario: 8- Login as admin1115

Scenario: 9- Bulk Create users 
    When I click on the link labeled "Add Users (Table-based Only" 
    And I click on the link labeled "Create users (bulk upload)"
    And I upload a "csv" format file located at "import_files/core/02_AddManageUsersv1115_userbulkupload.csv", by clicking "input[name=fname]" to select the file, and clicking "input[name=submit]" to upload the file
    And I should see "User was successfully added, and an email with login info was sent to user"
    And I should see "user1115_2"
    And I should see "user1115_3"
    And I should see "user1115_4"

Scenario: 10- Display Create Single User Page 
    When I click on the link labeled "Add Users (Table-based Only"  
    Then I should see "To create a new user"

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
    And I want to pause   
    Then I should see "User1"

Scenario: 13- Cancel Suspend test_user Account
    When I click on the link labeled "Browse Users"
    And I enter "test_user" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    And I click on the input button labeled "Suspend user account"
    And I want to pause
    Then I should see "Do you wish to suspend this user’s REDCap account?"
    When I click on the button labeled "Cancel"
    Then I should NOT see "Success! The user has now been suspended from REDCap."

Scenario: 14- Suspend test_user Account
    When I click on the link labeled "Browse Users"
    And I enter "test_user" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    And I click on the input button labeled "Suspend user account"
    Then I should see "Success! The user has now been suspended from REDCap"

Scenario: 15- Login with Suspended User Account
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:"
    And I click on the button labeled "Log In"
    Then I should see "The following REDCap user account has been suspended:"

Scenario: 16- View test_user in Suspended Users List
    When I click on the link labeled "Browse Users"
    Then I should see "User Search: Search for user by username, first name, last name, or primary email"
    When I click on the link labeled "View User List By Criteria"
    And I select "Suspended users" from the dropdown identified by "select[name=activity_level]"
    And I click on the button labeled "Display User List"
    And I want to pause
    Then I should see a link labeled "test_user"       

Scenario: 17- Cancel Unsuspend test_user Account
    When I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    And I select "Suspended users" from the dropdown identified by "select[name=activity_level]"
    And I click on the button labeled "Display User List"
    And I want to pause
    And I click on the checkbox identified by "[name=uiid_2]"
    And I click on the button labeled "Unsuspend user"
    Then I should see "Process sponsor request: Unsuspend user"
    When I click on the button labeled "Cancel"
    Then I should NOT see "The changes have been made successfully to the selected users!"

Scenario: 18- Unsuspend test_user Account
    When I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    And I select "Suspended users" from the dropdown identified by "select[name=activity_level]"
    And I click on the button labeled "Display User List"
    And I want to pause
    And I click on the link labeled "test_user"
    And I click on the link labeled "unsuspend user"
    And I want to pause
    Then I should see "Success! The user has now been unsuspended and will now be able to access REDCap again." 

Scenario: 19- Log out as admin1115

Scenario: 20- Confirm test_user can log in 
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:"
    And I click on the button labeled "Log In"
    Then I should see a link labeled "My Projects"
    When I click on the link labeled "Log out"
    Then I should see "Please log in with your user name and password"

Scenario: 21- Find test_user2 Under Browse Users Page 
    When I click on the link labeled "Browse Users"
    And I enter "test_user2" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    And I want to pause
    Then I should see a link labeled "test_user2"

Scenario: 22- Find test_user2 Under Browse Users Page by email
    When I click on the link labeled "Browse Users"
    And I enter "test_user2@example.com" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    And I want to pause
    Then I should see a link labeled "test_user2"

Scenario: 23- Find test_user2 Under Browse Users Page by Last name and Cancel Delete User from System
    When I click on the link labeled "Browse Users"
    And I enter "User" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    And I want to pause
    Then I should see "test_user2"
    When I click on the button labeled "Delete user from system"
    Then I should see "Do you wish to delete this user’s REDCap account?"
    When I click on the button labeled "Cancel"
    Then I should NOT see "The user 'test_user2' has now been removed and deleted from all REDCap projects"

Scenario: 24- Delete User test_user2 from System
    When I click on the link labeled "Browse Users"
    And I enter "test_user2" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    And I want to pause
    And I click on the button labeled "Delete user from system"
    Then I should see "Do you wish to delete this user’s REDCap account?"
    When I click on the button labeled "Delete user"
    Then I should see "The user 'user1115_2' has now been removed and deleted from all REDCap projects"

Scenario: 25- Confirm test_user2 Does Not Exist 
    When I click on the link labeled "Browse Users"
    And I enter "test_user2" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    And I want to pause
    Then I should see "User does not exist!"

Scenario: 26- Login with Deleted User Account
    When I click on the link labeled "Log out"
    And I enter "test_user2" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:"
    And I click on the button labeled "Log In"
    Then I should see "ERROR: You entered an invalid user name or password!"

#Scenario: 27- Login user1115_3 from email
        #aldefouw will handle 

Scenario: 28- Confirm test_user Does Not Have Access to Control Center or Create a Project
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:"
    And I click on the button labeled "Log In"
    Then I should NOT see "Control Center"
    And I should NOT see "Create New Project"

Scenario: 29- Cancel Change password for user1115_4 through Browse Users 
    When I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    And I click on the button labeled "Display User List"
    And I want to pause
    Then I should see "user1115_1" 
    Then I should see "user1115_2" 
    Then I should see "user1115_3"
    Then I should see "user1115_4"
    When I click on the checkbox identified by "[name=uiid_10]"
    And I click on the button labeled "Reset password"
    And I click on the button labeled "Cancel"
    Then I should NOT see "An email has been sent to user1115.4@redcap.edu with a new temporary password"

Scenario: 30- Change password for user1115_4 through Browse Users
    When I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    And I click on the button labeled "Display User List"
    And I click on the checkbox identified by "[name=uiid_10]"
    And I click on the button labeled "Reset password"
    And I click on the button labeled "Reset password"
    Then I should see "An email has been sent to user1115.4@redcap.edu with a new temporary password"

#Scenario: 31- Log Into user1115_4 with Old Password
        #aldefouw will handle 

#Scenario: 32- Login to user1115_4 with New Password Email Link
        #aldefouw will handle 

Scenario: 33- Change primary Email for user1115_4 
    When I click on the link labeled "Browse Users"
    And I enter "user1115_4" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    And I want to pause
    And I click on the button labeled "Edit user info"
    And I enter "tester@test.edu" into the field labeled "Primary email:"
    And I click on the input button labeled "Save"
    Then I should see "User has been successfully saved"
    And I should see "tester@test.edu" 

Scenario: 34- Update User Settings 
    When I click on the link labeled "User Settings"
    And I select "Yes, normal users can create new projects" from the dropdown identified by "select[name=superusers_only_create_project]"
    And I select "Yes" from the dropdown identified by "select[name=allow_create_db_default]"
    When I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 35- Add user1115_5
    When I click on the link labeled "Add Users (Table-based Only)" 
    And I enter "user1115_5" into the field labeled "Username:"
    And I enter "User5" into the field labeled "First name:"
    And I enter "1115_5" into the field labeled "Last name:"
    And I enter "user1115.5@redcap.edu" into the field labeled "Primary email:"
    And I click on the checkbox identified by "[name=allow_create_db]"
    And I click on the input button labeled "Save"
    Then I should see "User has been successfully saved."
    And I should see "An email with login information was sent to: user1115.5@redcap.edu"

#Scenario: 36- Change password for user 1115_5 from email link 
        #aldefouw will handle password change feature test

Scenario: 37- Edit Security & Authentication settings 
    When I click on the link labeled "Security & Authentication"
    Then I should see "Security & Authentication Configuration"
    When I clear the field labeled "Number of failed login attempts before user is locked out for a specified amount of time, which is set below."
    And I enter "1" into the field labeled "Number of failed login attempts before user is locked out for a specified amount of time, which is set below."
    And I clear the field labeled "Amount of time user will be locked out after having failed login attempts exceeding the limit set above."
    And I enter "1" into the field labeled "Amount of time user will be locked out after having failed login attempts exceeding the limit set above."
    And I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 38- Log in test_user with Old Password
        #here so that 39 will pass
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "test" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    Then I should see "ACCESS DENIED!"

Scenario: 39- Log in test_user with Too Many Attempts
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    Then I should see "ACCESS DENIED!"

Scenario: 40- Log in test_user with Correct Password after Buffer Period
    When I click on the link labeled "Log out"
    And I want to pause
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    Then I should see a link labeled "My Projects"
    When I click on the link labeled "Log out"
    Then I should see "Please log in with your user name and password"











