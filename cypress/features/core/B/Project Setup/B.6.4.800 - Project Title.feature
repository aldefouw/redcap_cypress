Feature: User Interface: General: The system shall support customization of project titles.

  As a REDCap end user
  I want to see that Project Setup is functioning as expected

  Scenario: B.6.4.800.100 Customize project title
    #SETUP
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "B.6.4.800.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.4.800.100"
    And I click on the link labeled "Project Setup"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Modify title
    And I click on the button labeled "Modify project title, purpose, etc."
    And I enter "B.6.4.800.MODIFY" into the input field labeled "Project title:"
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Success! Your changes have been saved."

    ##VERIFY
    When I click on the link labeled "My Projects"
    And I should see "B.6.4.800.MODIFY"