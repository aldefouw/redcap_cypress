Feature: Design forms Using Data Dictionary and Online Designer
    Field Creation: The system shall support the creation of Notes Box (Paragraph Text).

    As a REDCap end user
    I want to see that Project Designer is functioning as expected

    Scenario: B.6.7.800.100 Note box field creation in Online Designer

    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "New Project"
    And I enter "B.6.7.800.100" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"

    ##SETUP_DEV
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.7.800.100"
    And I click on the link labeled "Project Setup"
    And I click on the link labeled "Designer"
    Then I should see "Data Collection Instruments"

#    Not sure why we are moving to production? I am commenting out for ATS because this seems unnecessary.
#    And I click on the button labeled "Move project to production"
#    And I click on the radio button labeled "Keep ALL data saved so far" in the dialog box
#    And I click on the button labeled "YES, Move to Production Status" in the dialog box
#    Then I should see "Project Status: Production"
#
#    When I click on the link labeled "Designer"
#    And I click on the button labeled "Enter Draft Mode"
#    Then I should see "The project is now in Draft Mode"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: Note box field creation
    Given I see a table header and rows containing the following values in a table:
        | Instrument name   | Fields |
        | Form 1            | 1      |
    And I click on the link labeled "Form 1"
    Then I should see a field named "Record ID"

    Given I click on the Add Field input button below the field named "Record ID"
    And I select "Notes Box (Paragraph Text)" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "Notes Box" into the Field Label of the open "Add New Field" dialog box
    And I enter "notesbox" into the Variable Name of the open "Add New Field" dialog box
    And I click on the button labeled "Save" in the "Add New Field" dialog box

    #VERIFY
    Then I should see a field named "Notes Box"

#    Not sure why we are moving to production? I am commenting out for ATS because this seems unnecessary.
#    When I click on the button labeled "Submit Changes for Review"
#    And I click on the button labeled "Submit" in the dialog box
#    Then I should see "Changes Were Made Automatically"
#    When I click on the button labeled "Close" in the dialog box

    ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    Then I should see a table header and rows containing the following values in the codebook table:
        | Variable / Field Name | Field Label | Field Attributes |
        | [notesbox]            | Notes Box   | notes            |

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
        | Username    | Action        | List of Data ChangesOR Fields Exported |
        | test_admin  | Manage/Design | Create project field                   |

    Scenario: B.6.7.800.200 Note box field creation in Data Dictionary
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "New Project"
    And I enter "B.6.7.800.200" into the input field labeled "Project title"
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
        | [notesbox2]           | Notes box 2 | notes            |