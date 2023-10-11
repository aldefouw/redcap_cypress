Feature: Design forms Using Data Dictionary and Online Designer
  Field Creation: The system shall support the creation and manual coding for multiple choice dropdown list (single answer).

  As a REDCap end user
  I want to see that Project Designer is functioning as expected

  Scenario: B.6.7.1000.100 Creation of multiple choice dropdown list (single answer) through the Online Designer

    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "New Project"
    And I enter "B.6.7.1000.100" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"

    ##SETUP_DEV
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.7.1000.100"
    And I click on the link labeled "Project Setup"
    And I click on the link labeled "Designer"
    Then I should see "Data Collection Instruments"

    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project Status: Production"

    When I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: dropdown field creation
    Given I see a table header and rows containing the following values in a table:
      | Instrument name   | Fields |
      | Form 1            | 1      |
    And I click on the link labeled "Form 1"
    Then I should see a field named "Record ID"

    Given I click on the Add Field input button below the field named "Record ID"
    And I select "Multiple Choice - Drop-down List (Single Answer)" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "Multiple Choice Dropdown Manual" into the Field Label of the open "Add New Field" dialog box
    And I enter "multiple_dropdown_manual" into the Variable Name of the open "Add New Field" dialog box
    And I enter Choices of "5, DDChoice5" into the open "Add New Field" dialog box
    And I enter Choices of "7, DDChoice7" into the open "Add New Field" dialog box
    And I enter Choices of "6, DDChoice6" into the open "Add New Field" dialog box
    And I click on the button labeled "Save" in the "Add New Field" dialog box

    #VERIFY
    Then I should see a field named "Multiple Choice Dropdown Manual"
    And I should see the following dropdown options for the Data Collection Instrument field labeled "Multiple Choice Dropdown Manual"
      |DDChoice5|
      |DDChoice7|
      |DDChoice6|

#    TODO: Not sure why we are moving to production? I am commenting out for ATS because this seems unnecessary.
#    ##SETUP_PRODUCTION
#    When I click on the button labeled "Submit Changes for Review"
#    And I click on the button labeled "Submit" in the dialog box
#    Then I should see "Changes Were Made Automatically"
#    When I click on the button labeled "Close" in the dialog box

    ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    Then I should see a table header and rows containing the following values in the codebook table:
      | Variable / Field Name      | Field Label                     | Field Attributes |
      | [multiple_dropdown_manual] | Multiple Choice Dropdown Manual | dropdown         |

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data ChangesOR Fields Exported |
      | test_admin | Manage/Design | Create project field                   |

  Scenario: B.6.7.1000.200 Creation of multiple choice dropdown list (single answer) through Data Dictionary upload (#CROSSFUNCTIONAL – B.6.7.100.100)

    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "New Project"
    And I enter "B.6.7.1000.200" into the input field labeled "Project title"
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
      | Variable / Field Name      | Field Label                     | Field Attributes |
      | [multiple_dropdown_manual] | Multiple Choice Dropdown Manual | dropdown         |