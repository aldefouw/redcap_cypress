Feature: User Interface: Survey Project Settings: The system shall support the ability to create repeating surveys.

As a REDCap end user
I want to see that Manage project user access is functioning as expected

Scenario: B.6.4.1400.100 Ability to create repeating surveys
#SETUP
Given I login to REDCap with the user "Test_User1"
And I create a new project named "B.6.4.1400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#VERIFY_SETUP repeat instrument
When I click on the link labeled "Project Setup"
Then I should see a button labeled "Modify" on the field labeled "Repeating instruments and events"

#SETUP_PRODUCTION
When I click on the button labeled "Move project to production" 
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I see " Project status:  Production"

#VERIFY_DESIGNER
When I click on the link labeled "Designer"
Then I should see an enabled icon for the instrument labeled "Survey"

#FUNCTIONAL REQUIREMENT
Given I click on the link labeled "Record Status Dashboard"
And I click the bubble to select a record for the "Survey" longitudinal instrument for event "Event Three" for record "1"
##ACTION open survey
And I click on the dropdown option labeled "Open survey" on the dropdown button labeled "Survey options"
Then I should see a button labeled "Submit"

#VERIFY - only submit button and hit submit, no take again
When I click on the button labeled "Submit"
Then I should see "Thank you for taking the survey"
And I should NOT see "Take this survey again"

#VERIFY - no repeatable button 
Given I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" on the dialog box
Then I should NOT see the button labeled "+" for the data collection instrument labeled "Survey" for event "Event Three" for record "1"

#SETUP modify repeat instrument
Given I click on the link labeled "Project Setup"
When I click on the button labeled "Modify" on the field labeled "Repeating instruments and events"
And I click on the button labeled "Close" in the dialog box
And I select "Repeat Instruments (repeat independently of each other)" on the dropdown field labeled "Event Three (Arm 1: Arm 1)"
And I check the checkbox labeled "Survey"
And I click on the button labeled "Save"
#VERIFY 
Then I should see "Successfully saved"
And I click on the button labeled "Close" in the dialog box

##ACTION - Create repeatable survey
Given I click on the link labeled "Designer"
And I click on the button labeled "Survey settings" for the instrument labeled "Survey"
And I click on the checkbox labeled "(Optional) Repeat the survey"
And I click on the button labeled "Save Changes"
#VERIFY 
Then I should see "Your survey settings were successfully saved"

##ACTION - Create repeatable survey in record
When I click on the link labeled "Record Status Dashboard"
And I click on the bubble for the instrument labeled "Survey" for event "Event Three" for record "4" 
And I click on the button labeled "Save & Stay"
And I click on the dropdown option labeled "Open Survey" on the dropdown button labeled "Survey options"
And I enter "Name" into the field labeled "Name_survey"
And I click on the button labeled "Take this survey again"
And I enter "Name" into the field labeled "Name_survey2"
And I click on the button labeled "Submit"
And I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY 2 instances
Then I should see "+" for the data collection instrument labeled "Survey" for event "Event Three" for record "4"

##VERIFY_LOG
When I click on the button labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username                  |        Action             | List of Data Changes OR Fields Exported |
| [survey respondent]| Update Response| [instance = 2], name_survey = 'Name_survey2' |
| [survey respondent]| Update Response| name_survey = 'Name_survey' |
