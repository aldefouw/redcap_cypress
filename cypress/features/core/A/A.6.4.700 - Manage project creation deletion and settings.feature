Feature: A.6.4.700 Manage project creation, deletion, and settings

  Manage project creation, deletion, and settings
  User Interface – General: The system shall support the ability to create new projects from a blank slate.

  Scenario: A.6.4.700.100 Create blank new project
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "A.6.4.700.100" by clicking on "New Project" in the menu bar
    And I select "Practice / Just for fun" for Project’s purpose
    And I select "Empty project (blank slate)"
    And I click on the button labeled "Create Project"
    Then I should see "You are now creating a test project"
    And I click on the button labeled "I Agree" in the dialog box
    Then I should see "A.6.4.700"