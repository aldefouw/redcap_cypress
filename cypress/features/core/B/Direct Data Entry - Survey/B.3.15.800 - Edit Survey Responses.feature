Feature: User Interface: The system shall allow submitted survey responses to be changed by a user who has edit survey responses rights.

As a REDCap end user
I want to see that Survey Feature is functioning as expected

#Scenario: B.3.15.800.100 Edit survey response
##SETUP
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.3.15.800.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION
#When I click on the link labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see "Project status: Production"
#
###USER_RIGHTS - 1_FullRights
#When I click on the link labeled "User Rights"
#And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
#And I click on the button labeled "Assign to role"
#And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
#And I click on the button labeled exactly "Assign" on the role selector dropdown
#Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table
#
##SETUP_RECORD
#Given I click the link labeled "Add/Edit Records"
#And I click on the button labeled "Add new record for the arm selected above"
#And I click the bubble for the "Survey" longitudinal instrument on event "Event Three"
#And I click on the button labeled "Save & Stay"
#And I click on the button labeled "Survey options"
#And I select the option labeled "Open survey"
#Then I should see "Please complete the survey below"
#
#When I click on the button labeled "Submit"
#Then I should see "Thank you for taking this survey"
#
#When I click on the button labeled "Close survey"
#And I click on the button labeled "Leave without saving changes"
#Then I should see a Completed Survey Response icon for the data collection instrument labeled "Survey" on event "Event Three"
#
###VERIFY_LOG:
#When I click on the link labeled "Logging"
#Then I should see a table row containing the following values in in the logging table:
#| [survey respondent] | Update Response 5 | survey_complete= '2' |
#
##FUNCTIONAL_REQUIREMENT
###ACTION Edit survey response
#When I click on the link labeled "Record Status Dashboard"
#And I click on the link labeled "Arm 1"
#And I click the bubble for the data collection Instrument named "Survey" for record "5" for event "Event Three"
#Then I should see the button labeled "Edit response"
#
#When I click on button labeled "Edit response"
#And I enter "Name_EDITRESPONSE" in the field labeled "Name"
#And I click on the button labeled "Save & Exit Form"
#Then I should see "Record ID 5 successfully edited"
#
###VERIFY_LOG:
#When I click on the link labeled "Logging"
#Then I should see a table row containing the following values in in the logging table:
#| test_user1 | Update record 5 | name_survey = 'Name_EDITRESPONSE' |
#
##VERIFY_RSD
#When I click on the link labeled "Record Status Dashboard"
#And I click on the link labeled "Arm 1"
#And I click the bubble for the data collection Instrument named "Survey" for record "5" for event "Event Three"
#Then I should see the "Name_EDITRESPONSE" in the field labeled "Name"
#
###USER_RIGHTS - 3_ReadOnly_Deidentified
#When I click on the link labeled "User Rights"
#And I click on the link labeled "Test_User1"
#And I click on the button labeled "Re-assign to role"
#And I select "3_ReadOnly_Deidentified" on the dropdown field labeled "Select Role" on the role selector dropdown
#And I click on the button labeled exactly "Assign" on the role selector dropdown
#Then I should see "Test User1" within the "3_ReadOnly_Deidentified" row of the column labeled "Username" of the User Rights table
#
##FUNCTIONAL_REQUIREMENT
###ACTION Unable to edit survey response
#When I click on the link labeled "Record Status Dashboard"
#And I click on the link labeled "Arm 1"
#And I click the bubble for the data collection Instrument named "Survey" for record "5" for event "Event Three"
#Then I should NOT see the button labeled "Edit response"
