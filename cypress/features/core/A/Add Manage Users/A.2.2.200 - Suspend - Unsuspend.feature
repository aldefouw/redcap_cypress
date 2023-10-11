Feature: A.2.2.200 Add/Manage users

  As a REDCap end user
  I want to see that Suspend/Unsuspend Individual Users is functioning as expected

  Scenario: A.2.2.200.100 Account suspension
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Add Users (Table-based Only)"
    Then I should see "User Management for Table-based Authentication"

    #NOTE: We are testing Suspend / Unsuspend - NOT bulk upload feature
    # Bulk upload steps are concessions to make this functional if performed manually
    When I click on the link labeled "Create users (bulk upload)"
    And I upload a "csv" format file located at "import_files/testusers_bulkupload.csv", by clicking the button near "Upload CSV file of new users" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "User was successfully added, and an email with login info was sent to user"
    And I should see "Test_User1"
    And I should see "Test_User2"
    And I should see "Test_User3"
    And I should see "Test_User4"

    When I click on the link labeled "Browse Users"
    And I enter "Test_User1" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    Then I should see "Test_User1"

    When I click on the button labeled "Suspend user account" and cancel the confirmation window
    Then I should NOT see "Success! The user has now been suspended from REDCap"
    And I should NOT see "unsuspend user"

    Given I logout
    And I login to REDCap with the user "Test_User1"
    Then I should see "Home"
    And I logout

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Users"
    Then I should see "User Search: Search for user by username, first name, last name, or primary email"

    When I enter "Test_User1" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    Then I should see "Test_User1"

    When I click on the button labeled "Suspend user account" and accept the confirmation window
    Then I should see a dialog containing the following text: "Success! The user has now been suspended from REDCap"

    Given I click on the button labeled "Close" in the dialog box
    Then I should see "unsuspend user"

    When I click on the link labeled "View User List By Criteria"
    And I select "Suspended users" on the dropdown field labeled "Display only:"
    And I click on the button labeled "Display User List"
    Then I should see "Loading..."
    And I should see "User List"
    And I should see a link labeled "Test_User1"

    Given I logout
    And I login to REDCap with the user "Test_User1"
    Then I should see "The following REDCap user account has been suspended:"
    And I logout

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Users"
    Then I should see "User Search: Search for user by username, first name, last name, or primary email"

    When I enter "Test_User1" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    Then I should see "Test_User1"

    When I click on the link labeled "unsuspend user" and cancel the confirmation window
    Then I should see "unsuspend user"

    Given I logout
    And I login to REDCap with the user "Test_User1"
    Then I should see "The following REDCap user account has been suspended:"
    And I logout

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Users"
    Then I should see "User Search: Search for user by username, first name, last name, or primary email"

    When I enter "Test_User1" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    Then I should see "Test_User1"

    When I click on the link labeled "unsuspend user" and accept the confirmation window
    Then I should see a dialog containing the following text: "Success! The user has now been unsuspended and will now be able to access REDCap again"

    When I click on the button labeled "Close" in the dialog box
    And I should see a button labeled "Suspend user account"

    Given I logout
    And I login to REDCap with the user "Test_User1"
    Then I should see "Home"