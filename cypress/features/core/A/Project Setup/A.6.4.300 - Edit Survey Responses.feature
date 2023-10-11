Feature: A.6.4.300 Manage project creation, deletion, and settings

  Manage project creation, deletion, and settings
  Control Center: The system shall support enabling users to edit survey responses.

  Scenario: A.6.4.300.100 User's ability to edit survey responses

    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.6.4.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.300.100"

    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    And I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    When I select "Enabled" on the dropdown field labeled "Allow users to edit survey responses?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.300.100"
    And I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Survey" instrument on event "Event 1" for record ID "1" and click on the bubble
    #Then I should see "Survey response is editable"
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    When I select "Disabled" on the dropdown field labeled "Allow users to edit survey responses?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.300.100"
    And I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Survey" instrument on event "Event 1" for record ID "1" and click on the bubble
    #Then I should see "Survey response is read-only"
    
