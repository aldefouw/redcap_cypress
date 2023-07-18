Feature: A.6.4.100 Manage project creation, deletion, and settings

  Manage project creation, deletion, and settings
  Control Center: The system shall support the option to limit the creation of new projects to administrators.

  Scenario: A.6.4.100.100 User’s ability to create new projects

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"

    When I select "No, only Administrators can create new projects" on the dropdown field labeled "Allow normal users to create new projects?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "A.6.4.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml" and clicking the "Send Request" button
    And I click on the button labeled "I Agree" in the dialog box
    Then I should see "Request Sent!"
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"

    When I select "Yes, normal users can create new projects" on the dropdown field labeled "Allow normal users to create new projects?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "A.6.4.100.101" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml" and clicking the "Create Project" button
    And I click on the button labeled "I Agree" in the dialog box
    Then I should see "Your new REDCap project has been created"