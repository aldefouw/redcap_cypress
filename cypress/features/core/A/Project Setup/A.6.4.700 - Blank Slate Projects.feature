Feature: A.6.4.700 Manage project creation, deletion, and settings

  Manage project creation, deletion, and settings
  User Interface – General: The system shall support the ability to create new projects from a blank slate.

  Scenario: A.6.4.700.100 Create blank new project
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "New Project"
    And I enter "A.6.4.700.100" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"
    # #############################################################################################################
    # ATS Note: Below steps do not appear unless custom message is configured in Control Center so leaving them out
    # Then I should see "You are now creating a test project"
    # And I click on the button labeled "I Agree" in the dialog box
    # #############################################################################################################
    Then I should see "A.6.4.700.100"
    And I should see "Project Home"
