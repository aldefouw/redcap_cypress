Feature: User Interface: Survey Project Settings: The system shall support enabling and disabling each data collection instrument in a project as a survey.

As a REDCap end user
I want to see that Manage project user access is functioning as expected

Scenario: B.3.15.100.100 Enable/Disable survey in Online Designer
#SETUP
Given I login to REDCap with the user "Test_User1"
And I create a new project named "B.3.15.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

When I click on the link labeled "Project Setup"
#PARENT #B.6.4.1300.100
Then I should see a button labeled "Disable" on the field labeled "Use surveys in this project?"

#SETUP_PRODUCTION
When I click on the button labeled "Move project to production" 
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I see "Project status:  Production"

#FUNCTIONAL REQUIREMENT
##ACTION Enable survey in Online Designer #B.3.15.100.100
Given I click on the link labeled "Designer"
And I enable surveys for the data instrument named "Text Validation"
And I click on the button labeled "Save Changes"
##VERIFY
Then I should see "Your survey settings were successfully saved!"

##ACTION Verify survey function in record
When I click on the link labeled "Record Status Dashboard"
And I click on the bubble for the instrument labeled "Text Validation" for event "Event 1" for record "1" 
And I click on the dropdown option labeled "Open Survey" on the dropdown button labeled "Survey options"
And I enter "Name_B.3.15.100.100" into the field labeled "Name"
And I click on the button labeled "Submit"
Then I should see "Thank you for taking the survey"
And I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box

##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:  
| A | All data (all records and fields) |  
  
When I click on the button labeled "View Report"  
Then I should see a table header and rows including the following values in the report data table:  
| Record ID|     Name                           | 
|         1       |   Name_B.3.15.100.100| 

##VERIFY_LOG
When I click on the button labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username                   |        Action         | List of Data Changes OR Fields Exported |
|[ survey_respondent]| Update Response 1 | name = 'Name_B.3.15.100.100' |

#FUNCTIONAL REQUIREMENT
##ACTION Survey Offline 
#B.3.15.200.100
Given I click on the link labeled "Designer"
And I click on the link labeled "Survey settings" for the instrument labeled "Text Validation"
And I select the dropdown option labeled "Survey Offline" on the dropdown field labeled "Survey Status"
And I click on the button labeled "Save Changes"
##VERIFY
Then I should see "Your survey settings were successfully saved!"
And I should see " Survey settings"

##ACTION Verify no survey function in record
When I click on the link labeled "Record Status Dashboard"
And I click on the bubble for the instrument labeled "Text Validation" for event "Event 1" for record "1"
#VERIFY
Then I should NOT see "Survey options"

#VERIFY_LOG
When I click on the button labeled "Logging"
Then I should see a table row containing the following values in the logging table:
| test_admin| Manage/design | Modify survey info

#FUNCTIONAL REQUIREMENT
##ACTION Disable survey in Online Designer
Given I click on the link labeled "Online Designer"
And I click on the link labeled "Survey settings" for the data instrument named "Text Validation"
And I click on the button labeled "Delete Survey Settings"
And I click on the button labeled "Delete Survey Settings "
And I click on the button "Close"
##VERIFY
Then I should see "Enable" for the data instrument named "Text Validation"
