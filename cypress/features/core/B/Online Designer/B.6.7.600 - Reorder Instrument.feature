Feature: Design forms Using Data Dictionary and Online Designer
Form Creation: The system shall support the ability to re-order data collection instruments.

As a REDCap end user
I want to see that Project Designer is functioning as expected

Scenario: B.6.7.600.100 Reorder instrument from online designer

#SETUP
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "B.6.7.600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

When I click on the link labeled "My Projects"
And I click on the link labeled "B.6.7.600.100"

##SETUP_PRODUCTION
When I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far." in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
Then I should see Project status: "Production"

When I click on the button labeled "Online Designer"
And I click on the button labeled "Enter Draft Mode"
Then I should see "The project is now in Draft Mode"

#This establishes what instruments are here initially
Then I should see a table header and rows containing the following values in a table:
  | Instrument name   | Fields |
  | Text Validation   | 3      |
  | Data Types        | 21     |
  | Survey            | 2      |
  | Consent           | 4      |

#FUNCTIONAL_REQUIREMENT
##ACTION
When I drag the instrument named "Data Types" to the first row
Then I should see "Saved!" in the data collection instruments table
And I should see the instrument named "Data Types" in the first row
And I should see the instrument named "Text Validation" in the second row

When I click on the button labeled "Submit Changes for Review"
And I click on the button labeled "Submit" in the dialog box
Then I should see "Changes Were Made Automatically"
And I click on the button labeled "Close" in the dialog box

#VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
  | Username   | Action        | List of Data ChangesOR Fields Exported |
  | test_admin | Manage/Design | Reorder data collection instruments    |
