Feature: Add / Manage Users

  As a REDCap end user
  I want to see that Add / Manage Users is functioning as expected

Scenario: 1- Login as admin1115
    Given I am an "admin" user who logs into REDCap

Scenario: 2- Visible Pages
    Given I click on the link labeled "Control Center"
    When I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"

Scenario: 3- Save User Settings System Configurations
    When I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    When I select "No, only Administrators can create new projects" on the dropdown field labeled "Allow normal users to create new projects?"
    And I select "No" on the dropdown field labeled "By default, allow new users to create projects"
    When I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 4- Display User Management for Table-based Authentication Page
    When I click on the link labeled "Add Users (Table-based Only)"
    Then I should see "User Management for Table-based Authentication"

Scenario: 5- Create a user
    When I click on the link labeled "Add Users (Table-based Only)"
    And I enter "user1115_1" into the input field labeled "Username:"
    And I enter "User1" into the input field labeled "First name:"
    And I enter "1115_1" into the input field labeled "Last name:"
    And I enter "user1115@redcap.edu" into the input field labeled "Primary email:"
    And I click on the input element labeled "Allow this user to request that projects be created for them by a REDCap administrator?"
    And I click on the button labeled "Save"
    Then I should see "User has been successfully saved."
    And I should see "An email with login information was sent to: user1115@redcap.edu"

Scenario: 6- Logout as admin1115

#Scenario: 7 - Reset password through email link
    #aldefouw will handle password change feature test

Scenario: 8- Login as admin1115

Scenario: 9- Bulk Create users 
    When I click on the link labeled "Add Users (Table-based Only" 
    And I click on the link labeled "Create users (bulk upload)"
    And I upload a "csv" format file located at "import_files/core/02_AddManageUsersv1115_userbulkupload.csv", by clicking the button near "Upload CSV file of new users:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    And I should see "User was successfully added, and an email with login info was sent to user"
    And I should see "user1115_2"
    And I should see "user1115_3"
    And I should see "user1115_4"

Scenario: 10- Display Create Single User Page 
    When I click on the link labeled "Add Users (Table-based Only"  
    Then I should see "To create a new user"

Scenario: 11- Prevent a Second User with the Same Username
    When I click on the link labeled "Add Users (Table-based Only)" 
    And I enter "user1115_1" into the input field labeled "Username:"
    And I enter "User12" into the input field labeled "First name:"
    And I enter "1115_12" into the input field labeled "Last name:"
    And I enter "user11115@redcap.edu" into the input field labeled "Primary email:"
    And I click on the button labeled "Save"
    Then I should see "ERROR: The user could not be added! A user already exists named" 

Scenario: 12- Find user1115_1 Under Browse Users Page 
    When I click on the link labeled "Browse Users"
    Then I should see "User Search: Search for user by username, first name, last name, or primary email"
    When I enter "user1115_1" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    Then I should see "User1"

Scenario: 13 - Cancel Suspend test_user Account
    Given for this scenario, I will cancel a confirmation window containing the text "Do you wish to suspend this user's REDCap account?"
    When I click on the link labeled "Browse Users"
    And I enter "test_user" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    And I should see "User information for"

    Then I click on the button labeled "Suspend user account"
    Then I should NOT see "Success! The user has now been suspended from REDCap"
    And I should NOT see "unsuspend user"

Scenario: 14 - Suspend test_user Account
    Given for this scenario, I will accept a confirmation window containing the text "Do you wish to suspend this user's REDCap account?"
    When I click on the link labeled "Browse Users"
    And I enter "test_user" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    And I should see "User information for"

    Then I click on the button labeled "Suspend user account"
    And I should see "Success! The user has now been suspended from REDCap"
    And I should see "unsuspend user"

Scenario: 15- Login with Suspended User Account
    When I click on the link labeled "Log out"
    And I enter "test_user" into the input field labeled "Username:"
    And I enter "Testing123" into the input field labeled "Password:"
    And I click on the button labeled "Log In"
    Then I should see "The following REDCap user account has been suspended:"

Scenario: 16- View test_user in Suspended Users List
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "Control Center"
    When I click on the link labeled "Browse Users"
    Then I should see "User Search: Search for user by username, first name, last name, or primary email"
    When I click on the link labeled "View User List By Criteria"
    And I select "Suspended users" on the dropdown field labeled "Display only:"
    And I click on the button labeled "Display User List"
    Then I should see "Loading..."
    And I should see "User List (1)"
    And I should see a link labeled "test_user"

Scenario: 17- Cancel Unsuspend test_user Account
    When I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    And I select "Suspended users" on the dropdown field labeled "Display only:"
    And I click on the button labeled "Display User List"
    Then I should see "Loading..."
    And I should see "User List (1)"
    And I check the checkbox labeled "test_user"
    And I click on the button labeled "Unsuspend user"
    Then I should see "Process sponsor request: Unsuspend user"
    When I click on the button labeled "Cancel"
    Then I should NOT see "The changes have been made successfully to the selected users!"

Scenario: 18- Unsuspend test_user Account
    When I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    And I select "Suspended users" on the dropdown field labeled "Display only:"
    And I click on the button labeled "Display User List"
    Then I should see "Loading..."
    And I should see "User List (1)"
    And I check the checkbox labeled "test_user"
    And I click on the button labeled "Unsuspend user"
    Then I should see "Process sponsor request: Unsuspend user"
    And I click on the button labeled "Unsuspend user" in the dialog box
    Then I should see "The changes have been made successfully to the selected users!"

Scenario: 19- Log out as admin1115

Scenario: 20- Confirm test_user can log in 
    When I click on the link labeled "Log out"
    And I enter "test_user" into the input field labeled "Username:"
    And I enter "Testing123" into the input field labeled "Password:"
    And I click on the button labeled "Log In"
    Then I should see a link labeled "My Projects"
    When I click on the link labeled "Log out"
    Then I should see "Please log in with your user name and password"

Scenario: 21- Find test_user2 Under Browse Users Page
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Users"
    And I enter "test_user2" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    Then I should see "Editable user attributes"
    And I should see a link labeled "test_user2"
    And I should see "Test User"
    And I should see "test_user2@example.com"

Scenario: 22- Find test_user2 Under Browse Users Page by email
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Users"
    And I enter "test_user2@example.com" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the input element labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the list item element labeled "test_user2@example.com"
    And I click on the button labeled "Search"
    Then I should see "Editable user attributes"
    And I should see a link labeled "test_user2"
    And I should see "Test User"
    And I should see "test_user2@example.com"

Scenario: 23 - Find test_user2 Under Browse Users Page by Last name and Cancel Delete User from System
    Given for this scenario, I will cancel a confirmation window containing the text "Are you sure you wish to delete the user from REDCap?"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Users"
    And I enter "test_user2" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    Then I should see "Editable user attributes"
    Then I should see "test_user2"
    When I click on the button labeled "Delete user from system"
    Then I should NOT see "The user 'test_user2' has now been removed and deleted from all REDCap projects"

Scenario: 24 - Find test_user2 Under Browse Users Page by Last name and Delete User from System
    Given for this scenario, I will accept a confirmation window containing the text "Are you sure you wish to delete the user from REDCap?"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Users"
    And I enter "test_user2" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    Then I should see "Editable user attributes"
    Then I should see "test_user2"
    And I click on the button labeled "Delete user from system"
    Then I should see "The user 'test_user2' has now been removed and deleted from all REDCap projects"

Scenario: 25- Confirm test_user2 Does Not Exist
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Users"
    And I enter "test_user2" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    Then I should see "User does not exist!"

Scenario: 26- Login with Deleted User Account
    When I click on the link labeled "Log out"
    And I enter "test_user2" into the input field labeled "Username:"
    And I enter "Testing123" into the input field labeled "Password:"
    And I click on the button labeled "Log In"
    Then I should see "ERROR: You entered an invalid user name or password!"

#Scenario: 27- Login user1115_3 from email
        #aldefouw will handle 

Scenario: 28- Confirm test_user Does Not Have Access to Control Center or Create a Project
    When I enter "test_user" into the input field labeled "Username:"
    And I enter "Testing123" into the input field labeled "Password:"
    And I click on the button labeled "Log In"
    Then I should see "Welcome to REDCap!"
    And I should NOT see "Control Center"
    And I should NOT see "Create New Project"
    Then I logout

Scenario: 29- Cancel Change password for user1115_4 through Browse Users
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "Control Center"
    When I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    And I click on the button labeled "Display User List"

    Then I should see "user1115_1"
    And I should see "user1115_2"
    And I should see "user1115_3"
    And I should see "user1115_4"

    When I check the checkbox labeled "user1115_4"
    And I click on the button labeled "Reset password"
    Then I should see "Process sponsor request"

    When I click on the button labeled "Cancel" in the dialog box
    Then I should NOT see "The changes have been made successfully to the selected users!"

Scenario: 30- Change password for user1115_4 through Browse Users
    When I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    And I click on the button labeled "Display User List"

    Then I should see "user1115_1"
    And I should see "user1115_2"
    And I should see "user1115_3"
    And I should see "user1115_4"

    When I check the checkbox labeled "user1115_4"
    And I click on the button labeled "Reset password"
    Then I should see "Process sponsor request:"

    When I click on the button labeled "Reset password" in the dialog box
    Then I should see "The changes have been made successfully to the selected users!"
    And I close the popup

#Scenario: 31- Log Into user1115_4 with Old Password
        #aldefouw will handle 

#Scenario: 32- Login to user1115_4 with New Password Email Link
        #aldefouw will handle 

Scenario: 33- Change primary Email for user1115_4 
    When I click on the link labeled "Browse Users"
    And I enter "user1115_4" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    Then I should see "User information for"
    When I click on the button labeled "Edit user info"
    And I enter "tester@test.edu" into the input field labeled "Primary email:"
    And I click on the button labeled "Save"
    Then I should see "The user's primary email was changed, and the user was notified about this change."
    And I should see "tester@test.edu"

Scenario: 34- Update User Settings 
    When I click on the link labeled "User Settings"
    And I select "Yes, normal users can create new projects" on the dropdown field labeled "Allow normal users to create new projects?"
    And I select "Yes" on the dropdown field labeled "By default, allow new users to create projects or request that projects be created for them?"
    When I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 35- Add user1115_5
    When I click on the link labeled "Add Users (Table-based Only)" 
    And I enter "user1115_5" into the input field labeled "Username:"
    And I enter "User5" into the input field labeled "First name:"
    And I enter "1115_5" into the input field labeled "Last name:"
    And I enter "user1115.5@redcap.edu" into the input field labeled "Primary email:"
    And I check the checkbox labeled "Allow this user to create or copy projects?"
    And I click on the button labeled "Save"
    Then I should see "User has been successfully saved."
    And I should see "An email with login information was sent to: user1115.5@redcap.edu"

#Scenario: 36- Change password for user 1115_5 from email link 
        #aldefouw will handle password change feature test

Scenario: 37- Edit Security & Authentication settings 
    When I click on the link labeled "Security & Authentication"
    Then I should see "Security & Authentication Configuration"
    When I clear the field labeled "Number of failed login attempts before user is locked out for a specified amount of time, which is set below."
    And I enter "1" into the input field labeled "Number of failed login attempts before user is locked out for a specified amount of time, which is set below."
    And I clear the field labeled "Amount of time user will be locked out after having failed login attempts exceeding the limit set above."
    And I enter "1" into the input field labeled "Amount of time user will be locked out after having failed login attempts exceeding the limit set above."
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    And I logout

#This scenario exists so that 39 is one too many attempts at logging in
Scenario: 38- Log in test_user with Old Password
    Then I should see "Log In"
    And I enter "test_user" into the input field labeled "Username:"
    And I enter "test" into the input field labeled "Password:" 
    And I click on the button labeled "Log In"
    Then I should see "ERROR: You entered an invalid user name or password!"

Scenario: 39- Log in test_user with Too Many Attempts
    Given I logout
    And I enter "test_user" into the input field labeled "Username:"
    And I enter "Testing123" into the input field labeled "Password:" 
    And I click on the button labeled "Log In"
    Then I should see "ACCESS DENIED!"
    And I should see "exceeded the maximum amount of failed login attempts"

    Scenario: 40- Log in test_user with Correct Password after Buffer Period
    Given I wait for one minute
    And I visit the REDCap login page
    And I enter "test_user" into the input field labeled "Username:"
    And I enter "Testing123" into the input field labeled "Password:" 
    And I click on the button labeled "Log In"
    Then I should see a link labeled "My Projects"










