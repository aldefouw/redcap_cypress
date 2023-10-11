Feature: Design forms Using Data Dictionary and Online Designer
Form Creation: The system shall support the ability to copy data collection instruments and add a suffix to each variable name in the new instrument.

As a REDCap end user
I want to see that project Designer is functioning as expected

Scenario: B.6.7.400.100 Copy instrument

##SETUP
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "B.6.7.400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

##SETUP_PRODUCTION
When I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far." in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
Then I should see Project status: "Production"

When I click on the button labeled "Online Designer"
And I click on the button labeled "Enter Draft Mode"
Then I should see "The project is now in Draft Mode"

Then I should see a table header and rows containing the following values in a table:
  | Instrument name   | Fields |
  | Text Validation   | 3      |
  | Data Types        | 21     |
  | Survey            | 2      |
  | Consent           | 4      |

#FUNCTIONAL_REQUIREMENT
##ACTION
Given I click on the first button labeled "Choose action"
And I click on the link labeled "Copy" in the action popup
Then I should see a dialog containing the following text: "Copy instrument"
And I click on the button labeled "Copy instrument" in the dialog box

##VERIFY
Then I should see "SUCCESS! The instrument was successfully copied."
#We need this line so that we know the page has refreshed
And I should see "Text Validation 2"
And I should see a table header and rows containing the following values in a table:
  | Instrument name   | Fields |
  | Text Validation   | 3      |
  | Data Types        | 21     |
  | Survey            | 2      |
  | Consent           | 4      |
  | Text Validation 2 | 2      |

##VERIFY INSTRUMENT
When I click on the link labeled "Text Validation 2"
Then I should see "Text Validation 2"
And I should see "Variable: name_v2"
And I should see "Variable: email_v2"

When I click on the button labeled "Return to list of instruments"
And I should see "Data Collection Instruments"

Given I click on the button labeled "Submit Changes for Review"
And I click on the button labeled "Submit" in the dialog box
Then I should see "Changes Were Made Automatically"
And I click on the button labeled "Close" in the dialog box

##VERIFY_CODEBOOK
When I click on the link labeled "Codebook"
Then I should see "Instrument:Text Validation 2(text_validation_2)"

#VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
  | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported    |
  | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Copy data collection instrument           |