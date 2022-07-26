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
    #And I click on the checkbox identified by "select[name=     ?????     ]"
    And I click on the input button labeled "Save"
    Then I should see "User has been successfully saved."
    And I should see "An email with login information was sent to: user1115@redcap.edu"
    
Scenario: 6- Log out as admin1115
    When I click on the link labeled "Log out"
    Then I should see "Please log in with your user name and password"

#Scenario: 7- Change password for user 1115_1 from email link
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
    #Then I should not see "The changes have been made successfully to the selected users!"

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

Scenario: 21- Find user1115_2 Under Browse Users Page 
    When I click on the link labeled "Browse Users"
    And I enter "user1115_2" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    #Then I should see "Username"

Scenario: 22- Find user1115_2 Under Browse Users Page by email
    When I click on the link labeled "Browse Users"
    And I enter "user1115.2@redcap.edu" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    #Then I should see "Username"

Scenario: 23- Find user1115_2 Under Browse Users Page by Last name and Cancel Delete User from System
    When I click on the link labeled "Browse Users"
    And I enter "1115_2" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    #Then I should see "Username"
    #When I click on the button labeled "Delete user from system"
    #Then I should see "Do you wish to delete this user’s REDCap account?"
    #When I click on the button labeled "Cancel"
    #Then I should not see "The user 'user1115_2' has now been removed and deleted from all REDCap projects"

Scenario: 24- Delete User user1115_2 from System
    When I click on the link labeled "Browse Users"
    And I enter "user1115_2" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    #Then I should see "Username"
    #When I click on the button labeled "Delete user from system"
    #Then I should see "Do you wish to delete this user’s REDCap account?"
    #When I click on the button labeled "Delete user"
    #Then I should see "The user 'user1115_2' has now been removed and deleted from all REDCap projects"

Scenario: 25- Confirm user1115_2 Does Not Exist 
    When I click on the link labeled "Browse Users"
    And I enter "user1115_2" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    #Then I should see "User does not exist!"

Scenario: 26- Login with Deleted User Account
    When I click on the link labeled "Log out"
    And I enter "user1115_2" into the field labeled "Username:"
    And I enter "            ???????????           " into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    Then I should see "ERROR: You entered an invalid user name or password!"

#Scenario: 27- Login user user1115_3 from email
        #aldefouw will handle 

#Scenario: 28- Change password for user 1115_3 and log out 
        #aldefouw will handle password change 

Scenario: 29- Cancel Change password for user 1115_4 through Browse Users 
    When I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    And I click on the button labeled "Display User List"
    #Then I should see "User1"
    #And I should see "User2"
    #And I should see "User3"
    #And I should see "User4"
    #When I click on the checkbox identified by "select[name=     ?????     ]"
    #And I click on the button labeled "Reset password"
    #Then I should see "RESET PASSWORD FOR USER"
    #When I click on the button labeled "Cancel"
    #Then I should not see "An email has been sent to user1115.4@redcap.edu with a new temporary password"

Scenario: 30- Change password for user 1115_4 through Browse Users
    When I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    And I click on the button labeled "Display User List"
    #And I click on the checkbox identified by "select[name=     ?????     ]"
    #And I click on the button labeled "Reset password"
    #Then I should see "RESET PASSWORD FOR USER"
    #When I click on the button labeled "Reset password"
    #Then I should see "An email has been sent to user1115.4@redcap.edu with a new temporary password"

Scenario: 31- Log Into user1115_4 with Old Password
    When I click on the link labeled "Log out"
    And I enter "user1115_4" into the field labeled "Username:"
    And I enter "1115_4Pswd" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    Then I should see "ERROR: You entered an invalid user name or password!"

Scenario: 32- Login to user1115_4 with New Password Email Link
        #aldefouw will handle 
    #And I should not see a link labeled "Control Center"
    #And I should not see a link labeled "Create New Project"

Scenario: 33- Change primary Email for user1115_4 
    When I click on the link labeled "Browse Users"
    And I enter "user1115_4" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    #And I click on the button labeled "Edit user info"
        #doesnt find the button
    #And I enter "tester@test.edu" into the field labeled "Primary email:"
    #And I click on the button labeled "Save"
    #Then I should see "User has been successfully saved"
    #And I should see "tester@test.edu" 

Scenario: 34- Update User Settings 
    When I click on the link labeled "User Settings"
    And I select "Yes, normal users can create new projects" from the dropdown identified by "select[name=superusers_only_create_project]"
    And I select "Yes, normal users can move projects to production" from the dropdown identified by "select[name=superusers_only_move_to_prod]"
    #Then I should see "Yes, normal users can move projects to production"
        #is not "By default, allow new users to create projects or request that projects be created for them?"
    When I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 35- Add user1115_5
    When I click on the link labeled "Add Users (Table-based Only)" 
    And I enter "uuser1115_5" into the field labeled "Username:"
    And I enter "User5" into the field labeled "First name:"
    And I enter "1115_5" into the field labeled "Last name:"
    And I enter "user1115.5@redcap.edu" into the field labeled "Primary email:"
    #And I click on the checkbox identified by "select[name=     ?????     ]"
        #needs step definition
    And I click on the input button labeled "Save"
    Then I should see "User has been successfully saved."
    And I should see "An email with login information was sent to: user1115.5@redcap.edu"

#Scenario: 36- Change password for user 1115_1 from email link 
        #aldefouw will handle password change feature test
    #And I should not see a link labeled "Control Center"
    #And I should not see a link labeled "Create New Project"

Scenario: 37- Edit Security & Authentication settings 
    When I click on the link labeled "Security & Authentication"
    Then I should see "Security & Authentication Configuration"
    When I enter "1" into the field labeled "Number of failed login attempts before user is locked out for a specified amount of time, which is set below."
        #check that this deletes and is 1 not 51
    And I enter "1" into the field labeled "Amount of time user will be locked out after having failed login attempts exceeding the limit set above."
    #And I click on the input button labeled "Save Changes"
    #Then I should see "Your system configuration values have now been changed!"

Scenario: 38- Log in user1115_5 with Incorrect Password
    When I click on the link labeled "Log out"
    And I enter "user1115_5" into the field labeled "Username:"
    And I enter "test" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    Then I should see "ERROR: You entered an invalid user name or password!"

Scenario: 39- Log in user1115_5 with Incorrect Password
        #wont run until password is changed- user doesnt exist
    When I click on the link labeled "Log out"
    And I enter "user1115_5" into the field labeled "Username:"
    And I enter "1115_5Pswd" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    Then I should see "ERROR: You entered an invalid user name or password!"

Scenario: 40- Log in user1115_5 with Correct Password after Buffer Period
        #wait 1 minute 
        #user does not exist
    When I click on the link labeled "Log out"
    And I enter "user1115_5" into the field labeled "Username:"
    And I enter "1115_5Pswd" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    Then I should see a link labeled "User Settings"











