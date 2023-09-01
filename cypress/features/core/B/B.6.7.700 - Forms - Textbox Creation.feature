Feature: Design forms Using Data Dictionary and Online Designer
    Field Creation: The system shall support the creation of Text box (Short Text).

    As a REDCap end user
    I want to see that Online Designer is functioning as expected

    Scenario: B.6.7.700.100 Text box field creation in Online Designer

    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "New Project"
    And I enter "B.6.7.700.100" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"

    ##SETUP_DEV
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.7.700.100"
    And I click on the link labeled "Project Setup"
    And I click on the link labeled "Designer"
    Then I should see "Data Collection Instruments"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: Text box field creation
    Given I see a table header and rows containing the following values in a table:
        | Instrument name   | Fields |
        | Form 1            | 1      |
    And I click on the link labeled "Form 1"
    Then I should see a field named "Record ID"

    Given I click on the Add Field input button below the field named "Record ID"
    And I select "Text Box (Short Text, Number, Date/Time, ...)" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "Text Box" into the Field Label of the open "Add New Field" dialog box
    And I enter "textbox" into the Variable Name of the open "Add New Field" dialog box
    And I click on the button labeled "Save" in the "Add New Field" dialog box

    #VERIFY
    Then I should see a field named "Text Box"

    ##ACTION: Edit variable name – numeric (unable)
    Given I click on the Edit image for the field named "Text Box"
    And I enter "2" into the Variable Name of the open "Edit Field" dialog box
    #Because we cannot ACTUALLY save due to the alert window that pops up, do NOT add "Edit Field" before dialog box in the step below - will not work!
    And I click on the button labeled "Save" in the dialog box
    Then I should see a dialog containing the following text: "Please enter a value for the variable name"

    Given I click on the button labeled "Close" in the dialog box
    And I enter "2ABC" into the Variable Name of the open "Edit Field" dialog box
    And I click on the button labeled "Save" in the "Edit Field" dialog box

    #VERIFY
    Then I should see "Variable: abc"
    ##ACTION: Add variable name – Alpha numeric

    Given I click on the Add Field input button below the field named "Text Box"
    And I select "Text Box (Short Text, Number, Date/Time, ...)" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "ABC#2" into the Field Label of the open "Add New Field" dialog box
    And I enter "ABC#2" into the Variable Name of the open "Add New Field" dialog box
    And I click on the button labeled "Save" in the "Add New Field" dialog box

    #VERIFY
    Then I should see "Variable: abc_2"

    ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    Then I should see a table header and rows containing the following values in the codebook table:
        | Variable / Field Name | Field Label | Field Attributes |
        | [abc_2]               | ABC#2       | text             |

    #VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username    | Action        | List of Data ChangesOR Fields Exported |
      | test_admin  | Manage/Design | Edit project field                     |

    Scenario: B.6.7.700.200 Text box field creation in Data Dictionary
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "New Project"
    And I enter "B.6.7.700.200" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: Upload data dictionary
    When I click on the link labeled "Dictionary"
    And I upload a "csv" format file located at "dictionaries/Project1xml_DataDictionary.csv", by clicking the button near "Choose File" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "Your document was uploaded successfully and awaits your confirmation below."

    When I click on the button labeled "Commit Changes"
    Then I should see "Changes Made Successfully!"

    ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    Then I should see a table header and rows containing the following values in the codebook table:
      | Variable / Field Name | Field Label | Field Attributes |
      | [name]                | Name        | text             |
