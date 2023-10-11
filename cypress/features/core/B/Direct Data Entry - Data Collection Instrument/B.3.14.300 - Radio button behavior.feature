Feature: Creating a Record and Entering Data: The system shall support the ability to reset a multiple choice-radio button selection.

As a REDCap end user
I want to see that field reset is functioning as expected

Scenario: B.3.14.300.100 Reset multiple choice-radio button selection

#SETUP
Given I login to REDCap with the user "Test_User1"
And I create a new project named "B.3.14.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button 

#SETUP_PRODUCTION
When I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production" 
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project status: Production"

##ACTION
Given I click the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click the bubble for the "Data Types" longitudinal instrument for event "Event 1" 
Then I should see "Adding new Record ID 7."

When I select the radio option "Choice99" for the field labeled "radio"
And I click on the button labeled "Save & Stay"
Then I should see "Record 7 successfully edited"

When I click on the link labeled "reset" for the field labeled "radio"
And I click on the button labeled "Save & Exit Form"
Then I should see "Record ID 7 successfully edited."

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see table rows including the following values in the logging table:
| Username | Action | List of Data Changes OR Fields Exported |
 
| test_user1 | Update record 7 | radio = '' |
| test_user1 | Create   record 7 | radio = '9..9' |

##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats" 
Then I should see a table row containing the following values in the reports table: 
| A | All data (all records and fields) | 
 
When I click on the button labeled "View Report" 
Then I should see a table header and rows including the following values in the report data table: 
| Record ID|   radio      |
| 7               |                   |
