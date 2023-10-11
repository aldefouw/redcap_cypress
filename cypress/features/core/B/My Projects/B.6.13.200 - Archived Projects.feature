Feature: User Interface: The system shall support the ability to show or hide archived projects on the My Projects page.

  As a REDCap end user
  I want to see that My Project is functioning as expected

  Scenario: B.6.13.200.100 Hide archived projects
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.6.13.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "Other Functionality"
    And I click on the button labeled "Mark project as Completed"
    And I click on the button labeled "Mark project as Completed" in the dialog box
    #And I click on the button "OK" in the pop-up box
    Then I should see "My Projects"
    And I should NOT see "B.6.13.200.100"

    When I click on the link labeled "Show Completed Projects"
    Then I should see "B.6.13.200.100"

    When I click on the link labeled "B.6.13.200.100"
    And I click on the button labeled "Restore Project" in the dialog box
    Then I should see a dialog containing the following text: "PROJECT RESTORED"

    When I click on the button labeled "Close" in the dialog box
    Then I should see Project status: "Development"