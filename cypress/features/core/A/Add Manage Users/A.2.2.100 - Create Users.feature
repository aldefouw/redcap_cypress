Feature: A.2.2.100 Add/Manage users

 As a REDCap end user
 I want to see that Add / Manage Users is functioning as expected

 Scenario: A.2.2.100.100 System-level User Settings
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"

    When I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"

    When I select "No, only Administrators can create new projects" on the dropdown field labeled "Allow normal users to create new projects?"
    And I select "No" on the dropdown field labeled "By default, allow new users to create projects"

    When I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

 Scenario: A.2.2.100.200 Create a Table-based user
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Add Users (Table-based Only)"
    Then I should see "User Management for Table-based Authentication"

    When I enter "Test_User1_Cypress" into the input field labeled "Username:"
    And I enter "User1" into the input field labeled "First name:"
    And I enter "Test" into the input field labeled "Last name:"
    And I enter "Test_User1@redcap.edu" into the input field labeled "Primary email:"
    And I check the checkbox labeled "Allow this user to request that projects be created for them by a REDCap administrator?"
    And I click on the button labeled "Save"
    Then I should see "User has been successfully saved."
    And I should see "An email with login information was sent to: Test_User1@redcap.edu"
    And I logout
    # Reset password through email link
    # leader will handle password change feature test

 Scenario: A.2.2.100.300 Create Table-based users via bulk upload
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Add Users (Table-based Only)"
    Then I should see "User Management for Table-based Authentication"

    When I click on the link labeled "Create users (bulk upload)"
    And I upload a "csv" format file located at "import_files/testusers_bulkupload.csv", by clicking the button near "Upload CSV file of new users" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "User was successfully added, and an email with login info was sent to user"
    And I should see "Test_User2"
    And I should see "Test_User3"
    And I should see "Test_User4"

 Scenario: A.2.2.100.400 Prevent a Second User with the Same Username
   Given I login to REDCap with the user "Test_Admin"
   And I click on the link labeled "Control Center"
   And I click on the link labeled "Add Users (Table-based Only)"
   Then I should see "User Management for Table-based Authentication"

   When I click on the link labeled "Add Users (Table-based Only)"
   And I enter "Test_User1" into the input field labeled "Username:"
   And I enter "User1" into the input field labeled "First name:"
   And I enter "Test" into the input field labeled "Last name:"
   And I enter "Test_User1@redcap.edu" into the input field labeled "Primary email:"
   And I click on the button labeled "Save"
   Then I should see "ERROR: The user could not be added!"

 Scenario: A.2.2.100.500 Search a Table-based user
   Given I login to REDCap with the user "Test_Admin"
   And I click on the link labeled "Control Center"
   And I click on the link labeled "Browse Users"
   Then I should see "User Search: Search for user by username, first name, last name, or primary email"

   When I enter "Test_User1" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
   And I click on the button labeled "Search"
   Then I should see "Test_User1"

  Scenario: A.2.2.100.600 User has no control center access
   Given I login to REDCap with the user "Test_User1"
   Then I should NOT see "Control Center"