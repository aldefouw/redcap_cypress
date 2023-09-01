Design forms Using Data Dictionary and Online Designer
    Field Creation: The system shall support the creation of Text box (Short Text).

    As a REDCap end user
    I want to see that Online Designer is functioning as expected

    Scenario: B.6.7.700.100 Text box field creation in Online Designer

    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named " B.6.7.700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing "Empty project", and clicking the "Create Project" button

    ##SETUP_DEV
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.7.700.100"
    And I click on the link labeled "Project Setup"
    And I click on the link labeled "Designer"
    Then I should see "Data Collection Instruments"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: Text box field creation
    When I click on the instrument labeled "Form 1"
    And I add a new Text Box field labeled "Text Box" with the variable name "textbox "
    And I click on the button labeled "Save" in the dialog box
    #VERIFY
    Then I should see the field labeled "Text Box"

    ##ACTION: Edit variable name – numeric (unable)
    Given I click on the Edit image for the field labeled "Text Box"
    And I clear the field labeled "Variable Name"
    And I enter "2" into the field labeled "Variable Name"
    And I click on the button labeled "Save"
    Then I should see "Alert"
    And I should see "Please enter a value for the variable name"
    And I click on the button labeled "Close" in the dialog box

    When I clear the field labeled "Variable Name"
    And I enter "2ABC" into the field labeled "Variable Name"
    And I click on the button labeled "Save"
    #VERIFY
    Then I should see the variable labeled "abc"

    ##ACTION: Add variable name – Alpha numeric
    And I add a new Text Box field labeled "ABC#2" with the variable name "ABC#2"
    And I click on the button labeled "Save" in the dialog box
    #VERIFY
    Then I should see the variable labeled "abc_2"

    ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    Then I should see a table header and rows containing the following values in the codebook table:
        | Variable / Field Name | Field Label | Field Attributes |
        | [abc_2]               | ABC#2       | text             |

    #VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows including the following values in the logging table:
    | Username   |        Action           | List of Data Changes OR Fields Exported |
    | test_admin  | Manage/Design | Edit project field|

    Scenario: B.6.7.700.200 Text box field creation in Data Dictionary
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.6.7.700.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing "Empty project", and clicking the "Create Project" button

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
    | [name] | Name| text |
