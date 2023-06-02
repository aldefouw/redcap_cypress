Feature: A.6.4.200 Manage project creation, deletion, and settings

  As a REDCap end user
  I want to see that project management features are functioning as expected

  Scenario: A.6.4.200.100 User requests admin move project to production
    Given I login to REDCap with the user "Test_Admin"
    And I create a "New Project" named "A.6.4.200.100", select "Practice / Just for Fun" from the dropdown, choose file "Project_1" and click on the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.200.100"
    And I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Assign to role"
    And I should see the dropdown field labeled "Select Role"
    When I assign "1_FullRights" on dropdown field labeled "Select Role"
    And I click on the button labeled "Assign"
    Then I should see "Test_User1" user assigned "1_FullRights" role

    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    When I select "No, only Administrators can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.200.100"
    And I click on the link labeled "Project Setup"
    Then I should see the button labeled "Move project to production"

    When I click on the button labeled "Move project to production"
    And I click on the radio button labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "Yes, Request Admin to Move to Production Status" in the dialog box
    Then I should see "Request pending"
    And I click on the button labeled “Logging”
    Then I see “Request approval for production project modifications”
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.200.100"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "To-Do List()"

    Then I should see "Pending Requests"
    And I should see request type "Move to prod"

    When I click on the "Get More Information" icon for the " Move to Prod" request created for the project "A.6.4.200.100" within the " Pending Requests" table
    And I click on the button labeled "process request" in the dialog box
    And I click on the radio labeled "Keep ALL data saved so far."
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "The user request for their REDCap project to move to production status has been approved."

    When I click on the button labeled "Close" on the dialog box
    And I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.200.100"
    Then I should see " Project status: Production"
    And I click on the button labeled “Logging”
    Then I should see “Move project to Production status”

  Scenario: A.6.4.200.200 User moves project to production
    Given I login to REDCap with the user "Test_Admin"
    And I create a "New Project" named "A.6.4.200.200", select "Practice / Just for Fun" from the dropdown, choose file "Project_1" and click on the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.200.200"
    And I click on the link labeled "User Rights"
    And I enter "Test_User2" into the input field labeled "Assign to role"
    Then I should see the dropdown field labeled "Select Role"

    When I assign "1_FullRights" on dropdown field labeled "Select Role"
    And I click on the button labeled "Assign"
    Then I should see "Test_User1" user assigned "1_FullRights" role

    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    When I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.200.200"
    And I click on the link "Project Setup"
    Then I should see the button labeled "Move project to production"

    When I click on the button labeled "Move project to production"
    And I click on the radio button labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I see " Project status:  Production"
    And I click on the button labeled “Logging”
    Then I should see “Move project to Production status”
