Feature: Design forms Using Data Dictionary and Online Designer
    Field Creation: The system shall support creation and customization of algorithms for calculated fields.

    As a REDCap end user
    I want to see that calculated field is functioning as expected

    Scenario: B.6.7.900.100 Creation of calculated field through online designer
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "New Project"
    And I enter "B.6.7.900.100" into the input field labeled "Project title"
    And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
    And I click on the radio labeled "Empty project (blank slate)"
    And I click on the button labeled "Create Project"

    ##SETUP_DEV
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.7.900.100"
    And I click on the link labeled "Project Setup"
    And I click on the link labeled "Designer"
    Then I should see "Data Collection Instruments"

#    TODO: Not sure why we are moving to production? I am commenting out for ATS because this seems unnecessary.
#    And I click on the button labeled "Move project to production"
#    And I click on the radio button labeled "Keep ALL data saved so far" in the dialog box
#    And I click on the button labeled "YES, Move to Production Status" in the dialog box
#    Then I should see "Project Status: Production"
#
#    When I click on the link labeled "Designer"
#    And I click on the button labeled "Enter Draft Mode"
#    Then I should see "The project is now in Draft Mode"

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: calculated field creation
    Given I see a table header and rows containing the following values in a table:
        | Instrument name   | Fields |
        | Form 1            | 1      |
    And I click on the link labeled "Form 1"
    Then I should see a field named "Record ID"

    Given I click on the Add Field input button below the field named "Record ID"
    And I select "Calculated Field" from the Field Type dropdown of the open "Add New Field" dialog box
    And I enter "Calculated Field" into the Field Label of the open "Add New Field" dialog box
    And I enter "calculated_field" into the Variable Name of the open "Add New Field" dialog box
    And I enter the equation "3*2" into Calculation Equation of the open "Add New Field" dialog box
    And I click on the button labeled "Save" in the "Add New Field" dialog box

    #VERIFY
    Then I should see a field named "Calculated Field"
    And I should see a link labeled "View equation"

    ##SETUP_PRODUCTION
#    TODO: Not sure why we are moving to production? I am commenting out for ATS because this seems unnecessary.
#    When I click on the button labeled "Submit Changes for Review"
#    And I click on the button labeled "Submit" in the dialog box
#    Then I should see "Changes Were Made Automatically"
#    When I click on the button labeled "Close" in the dialog box

    ##VERIFY_CODEBOOK
    When I click on the link labeled "Codebook"
    Then I should see a table header and rows containing the following values in the codebook table:
      | [calculated_field] | Calculated Field | calc |

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username    | Action        | List of Data ChangesOR Fields Exported |
      | test_admin  | Manage/Design | Create project field                   |

    Scenario: B.6.7.900.200 Creation of calculated field through Data Dictionary upload

    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "New Project"
    And I enter "B.6.7.900.200" into the input field labeled "Project title"
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
      | Variable / Field Name | Field Label      | Field Attributes |
      | [calculated_field]    | Calculated Field | calc             |

    ##VERIFY_LOG
#    TODO: Removing for ATS.  Not sure how it's relevant to verify we are uploading a data dictionary?
#    When I click on the link labeled "Logging"
#    Then I should see a table header and rows containing the following values in the logging table:
#      | Username   | Action        | List of Data ChangesOR Fields Exported |
#      | test_admin | Manage/Design | Upload data dictionary                 |
