Feature: B.2.6.100 Assign user rights Project Level:  The system shall allow the ability to add, edit or delete user access to application tools for "Basic Privileges" and expiration date.

  As a REDCap end user
  I want to see that project level user access is functioning as expected

  Scenario: B.2.6.100.100 Project level User Rights functions (Add, Edit, Expire, Remove)

    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.6.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    And I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.100.100"
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Add User with Basic custom rights

    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    Then I should see a dialog containing the following text: "Adding new user"

    When I remove all Basic Rights within the open User Rights dialog box
    And I save changes within the context of User Rights

    ##VERIFY_LOG: Verify Update user rights
    And I click on the link labeled "Logging"
    Then I should see table rows containing the following values in the logging table:
      | test_admin | Add user | Test_User1 |

    ##ACTION #CROSS-FEATURE B.2.23.100: Verify Logging Filter by user name
    When I select "test_admin" on the dropdown field labeled "Filter by user name"

    ##VERIFY_LOG #CROSS-FEATURE: Verify Logging Filter by user name
    Then I should see table rows containing the following values in the logging table:
      | test_admin | Add user | Test_User1 |
    And I logout
  
    ##VERIFY: Verify User with Basic custom rights
    Given I login to REDCap with the user "Test_User1"
    Then I should see "Logged in as"

    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.100.100"
    Then I should see a link labeled "Project Home"
    And I should NOT see a link labeled "Project Setup"
    And I should NOT see a link labeled "Designer"
    And I should NOT see a link labeled "Dictionary"
    And I should see a link labeled "Codebook"
    And I should NOT see a link labeled "Survey Distribution Tools"
    And I should see a link labeled "Record Status Dashboard"
    And I should see a link labeled "View / Edit Records"
    And I should see "Applications"
    And I should NOT see a link labeled "Project Dashboards"
    And I should NOT see a link labeled "Alerts & Notifications"
    And I should NOT see a link labeled "Multi-Language Management"
    And I should NOT see a link labeled "Calendar"
    And I should NOT see a link labeled "Data Import Tool"
    And I should NOT see a link labeled "Logging and Email Logging"
    And I should see a link labeled "Field Comment Log"
    And I should NOT see a link labeled "File Repository"
    And I should NOT see a link labeled "Data Comparison Tool"
    And I should NOT see a link labeled "User Rights and DAGs"
    And I should NOT see a link labeled "Customize & Manage Locking/E-signatures"
    And I should NOT see a link labeled "Data Quality"
    And I should NOT see a link labeled "API and API Playground"
    And I should NOT see a link labeled "REDCap Mobile App"
    And I logout

    ##ACTION: Edit User to full custom rights
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.100.100"
    And I click on the link labeled "User Rights"
    And I click on the link labeled "Test User1"
    And I click on the button labeled "Edit user privileges" on the tooltip
    Then I should see a dialog containing the following text: "Editing existing user"

    When I check the User Right named "Project Setup & Design"
    And I check the User Right named "User Rights"
    And I check the User Right named "Data Access Groups"
    And I check the User Right named "Survey Distribution Tools"
    And I check the User Right named "Alerts & Notifications"
    And I check the User Right named "Calendar"
    And I check the User Right named "Add/Edit/Organize Reports"
    And I check the User Right named "Stats & Charts"
    And I check the User Right named "Data Import Tool"
    And I check the User Right named "Data Comparison Tool"
    And I check the User Right named "Logging"
    And I check the User Right named "File Repository"
    And I check the User Right named "Data Quality - Create & edit rules"
    And I check the User Right named "Data Quality - Execute rules"
    And I check the User Right named "API Export"
    And I check the User Right named "API Import/Update"
    And I check the User Right named "Create Records"
    And I check the User Right named "Rename Records"
    And I check the User Right named "Delete Records"
    And I check the User Right named "Record Locking Customization"

    And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking"
    And I check the User Right named "Lock/Unlock *Entire* Records (record level)"

    And I check the User Right named "REDCap Mobile App - Allow users to collect data offline in the mobile app"
    Then I should see a dialog containing the following text: "Confirm Mobile App Privileges"
    And I click on the button labeled "Yes, I understand"

    And I check the User Right named "REDCap Mobile App - Allow user to download data for all records to the app?"
    And I save changes within the context of User Rights

    ##VERIFY_LOG: Verify Update user rights
    And I click on the link labeled "Logging"
    Then I should see table rows containing the following values in the logging table:
      | test_admin | Update user | test_user1 |
    And I logout

    ##VERIFY: Verify User with full custom rights
    Given I login to REDCap with the user "Test_User1"
    Then I should see "Logged in as"

    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.100.100"
    Then I should see a link labeled "Project Home"
    And I should see a link labeled "Project Setup"
    And I should see a link labeled "Designer"
    And I should see a link labeled "Dictionary"
    And I should see a link labeled "Codebook"
    And I should see a link labeled "Survey Distribution Tools"
    And I should see a link labeled "Record Status Dashboard"
    And I should see a link labeled "Add / Edit Records"
    And I should see "Applications"
    And I should see a link labeled "Project Dashboards"
    And I should see a link labeled "Alerts & Notifications"
    And I should see a link labeled "Multi-Language Management"
    And I should see a link labeled "Calendar"
    And I should see a link labeled "Data Import Tool"
    And I should see a link labeled "Logging"
    And I should see a link labeled "Email Logging"
    And I should see a link labeled "Field Comment Log"
    And I should see a link labeled "File Repository"
    And I should see a link labeled "Data Comparison Tool"
    And I should see a link labeled "User Rights"
    And I should see a link labeled "DAGs"
    And I should see a link labeled "Customize & Manage Locking/E-signatures"
    And I should see a link labeled "Data Quality"
    And I should see a link labeled "API"
    And I should see a link labeled "API Playground"
    And I should see a link labeled "REDCap Mobile App"
    And I logout

    ##ACTION: Expire User
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.100.100"
    And I click on the link labeled "User Rights"
    And I assign an expired expiration date to user "Test User1" with username of "test_user1"

    ##VERIFY_LOG: Verify Expire User
    And I click on the link labeled "Logging"
    #ATS: There is ZERO mention in the logs of anything related to expiration.  It just says Update user in the logs.
    Then I should see table rows containing the following values in the logging table:
      | test_admin | Update user | test_user1 |
    And I logout

    ##VERIFY: Verify User access to project
    Given I login to REDCap with the user "Test_User1"
    Then I should see "Logged in as"
    And I click on the link labeled "My Projects"
    Then I should see a link labeled "B.2.6.100.100"

    ##ACTION: Remove expiration for User
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.100.100"
    And I click on the link labeled "User Rights"
    And I remove the expiration date to user "Test User1" with username of "test_user1"
    #The Expiration column shows 'never' for "Test_User1"

    ##VERIFY_LOG: Verify Update user Expiration
    And I click on the link labeled "Logging"

    #ATS: ZERO mention in the logs of anything related to expiration.  It just says 'Update user' in the logs.
    Then I should see table rows containing the following values in the logging table:
      | test_admin | Update user | test_user1 |
    And I logout

    ##VERIFY: Verify User access to project
    Given I login to REDCap with the user "Test_User1"
    Then I should see "Logged in as"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.100.100"
    Then I should see a link labeled "Project Home"
    And I logout
  
    ##ACTION: Remove User from project
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.100.100"
    And I click on the link labeled "User Rights"
    And I click on the link labeled "Test User1"
    And I click on the button labeled "Edit user privileges" on the tooltip
    Then I should see a dialog containing the following text: "Editing existing user"

    When I click on the button labeled "Remove user"
    Then I should see a dialog containing the following text: "Remove user?"
    And I click on the button labeled "Remove user" in the dialog box

    ##VERIFY_LOG: Verify Logging of Delete user
    And I click on the link labeled "Logging"
    Then I should see table rows containing the following values in the logging table:
      | test_admin | Delete user | test_user1 |
      | test_admin | Update user | test_user1 |
    And I logout
  
    ##VERIFY: Verify User has no access to project
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    Then I should NOT see a link labeled "B.2.6.100.100"