Design forms Using Data Dictionary and Online Designer
Form Creation: The system shall support the ability to delete data collection instruments.

    As a REDCap end user
    I want to see that Project Designer is functioning as expected

    Scenario: B.6.7.500.100 Delete instrument from online designer

    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.6.7.500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    ##SETUP_PRODUCTION
    When I click on the button labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio button labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project Status: Production"

    When I click on the link labeled " Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION
    When I select the dropdown option labeled "Delete" from the dropdown labeled "Choose action" for the instrument labeled "Text Validation"
    And I click on the button labeled "Yes, delete it" in the dialog box
    Then I should see "Deleted!"
    And I should NOT see the instrument labeled "Text Validation"

    When I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box
    Then I should see "Changes Were Made Automatically"

    AS ADMIN > GO TO PROJECT MODIFICATION MODULE > COMMIT CHANGES

    When I click on the button labeled "Close" in the dialog box

    #VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows including the following values in the logging table:
    | Username   |        Action           | List of Data Changes OR Fields Exported |
    | test_admin| Manage/Design | Delete data collection instrument |