Design forms Using Data Dictionary and Online Designer
    Field Creation: The system shall support creation and customization of algorithms for calculated fields.

    As a REDCap end user
    I want to see that calculated field is functioning as expected

    Scenario: B.6.7.900.100 Creation of calculated field through online designer
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.6.7.900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing "Empty project", and clicking the "Create Project" button

    ##SETUP_PRODUCTION
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.7.900.100"
    When I click on the button labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio button labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project Status: Production"

    When I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: calculated field creation
    When I click on the link labeled "Form 1"
    And I click on the button labeled "Add Field" at the bottom of the instrument
    And I click on the dropdown field labeled "Select a Type of Field"
    And I add a new Calculated Field field labeled "Calculated Field" with the variable name "calculated_field"
    And I enter the equation "3*2" in the Calculation Equation field of the open "Logic Editor" dialog box
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And I click on the button labeled "Save"
    Then I should see the field labeled "Calculated Field"
    And I should see the link "View equation"

    ##SETUP_PRODUCTION
    When I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box
    Then I should see "Changes Were Made Automatically"
    When I click on the button labeled "Close" in the dialog box

    ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    Then I should see a table row containing the following values in the codebook table:
    | [calculated_field] | Calculated Field | calc |

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows including the following values in the logging table:
    | Username   |        Action           | List of Data Changes OR Fields Exported |
    | test_user1  | Manage/Design | Create project field |

    . Scenario: B.6.7.900.200 Creation of calculated field through Data Dictionary upload

    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.6.7.900.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing "Empty project", and clicking the "Create Project" button

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: Upload data dictionary
    When I click on the link labeled "Dictionary"
    And I click on the button labeled "Choose File"
    And I select the file labeled "Project1xml_DataDictionary.csv"
    And I click on the button labeled "Upload File"
    Then I should see "Your document was uploaded successfully and awaits your confirmation below."

    When I click on the button labeled "Commit Changes"
    Then I should see "Changes Made Successfully!"

    ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    Then I should see a table row containing the following values in the codebook table:
    | [calculated_field] | Calculated Field | calc |

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows including the following values in the logging table:
    | Username   |        Action           | List of Data Changes OR Fields Exported |
    | test_admin | Manage/Design | Create project field |
