Feature: Design forms Using Data Dictionary and Online Designer
  Form Creation: The system shall support the ability to rename data collection instruments.

As a REDCap end user
I want to see that Project Designer is functioning as expected

Scenario: B.6.7.300.100 Unique instrument name

##SETUP_DEV
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "B.6.7.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

When I click on the link labeled "My Projects"
And I click on the link labeled "B.6.7.300.100"
#FUNCTIONAL_REQUIREMENT
##ACTION: Verify unique instrument variable name
When I click on the link labeled "Codebook"
##VERIFY_CODEBOOK
Then I should see "Instrument:Text Validation(text_validation)"

##ACTION: Rename instrument and instrument variable name
When I click on the link labeled "Online Designer"
Then I should see a table header and rows containing the following values in a table:
  | Instrument name  | Fields |
  | Text Validation  | 3      |
  | Data Types       | 21     |
  | Survey           | 2      |
  | Consent          | 4      |

Given I click on the first button labeled "Choose action"
And I click on the link labeled "Rename" in the action popup
And I clear field and enter "Text Validation Rename" into the field with the placeholder text of "Text Validation"
And I click on the button labeled "Save" to rename an instrument

#VERIFY
Then I should see a table header and rows containing the following values in a table:
  | Instrument name        | Fields |
  | Text Validation Rename | 3      |
  | Data Types             | 21     |
  | Survey                 | 2      |
  | Consent                | 4      |

##VERIFY_CODEBOOK
When I click on the link labeled "Codebook"
Then I should see "Instrument:Text Validation Rename(text_validation_rename)"

#VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
  | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported    |
  | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Rename data collection instrument         |

##SETUP_PRODUCTION
When I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far." in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
Then I should see Project status: "Production"

#FUNCTIONAL REQUIREMENT
When I click on the button labeled "Online Designer"
And I click on the button labeled "Enter Draft Mode"
Then I should see "The project is now in Draft Mode"

Given I see a table header and rows containing the following values in a table:
  | Instrument name        | Fields |
  | Text Validation Rename | 3      |
  | Data Types             | 21     |
  | Survey                 | 2      |
  | Consent                | 4      |

##ACTION: Rename instrument and Keep old instrument variable name
Given I click on the first button labeled "Choose action"
And I click on the link labeled "Rename" in the action popup
And I clear field and enter "Text Validation Rename 2" into the field with the placeholder text of "Text Validation Rename"
And I click on the button labeled "Save" to rename an instrument

#VERIFY
Then I should see a table header and rows containing the following values in a table:
  | Instrument name          |  Fields |
  | Text Validation Rename 2 | 3       |
  | Data Types               | 21      |
  | Survey                   | 2       |
  | Consent                  | 4       |

When I click on the button labeled "Submit Changes for Review"
And I click on the button labeled "Submit" in the dialog box
Then I should see "Changes Were Made Automatically"
When I click on the button labeled "Close" in the dialog box

##VERIFY_CODEBOOK
When I click on the link labeled "Codebook"
Then I should see "Instrument:Text Validation Rename 2(text_validation_rename)"

#VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
  | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported    |
  | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Rename data collection instrument         |

