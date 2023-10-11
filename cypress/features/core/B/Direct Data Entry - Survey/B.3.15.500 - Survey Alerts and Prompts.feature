Feature: User Interface: Survey Distribution: The system shall prompt the user to leave the survey to avoid overwriting survey responses when opening surveys from a data entry form when using Open Survey link.

As a REDCap end user
I want to see that Survey Feature is functioning as expected

#Scenario: B.3.15.500.100 Data form overwrite function post survey entry
##SETUP
#Given I login to REDCap with the user "Test_Admin"
#And I create a new project named "B.3.15.500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION
#When I click on the link labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see "Project status: Production"
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
##FUNCTIONAL REQUIREMENT
###ACTION Verify Leave this page while survey is in session
#
#When I click on the button labeled "Submit"
#Then I should see "Thank you for taking this survey"
#And I click on the button labeled "Close survey"
#Then I should see "Recommended: Leave this page while survey is in session"
#And I click on the button labeled "Leave without saving changes"
#
###VERIFY_LOG:
#Given I click on the link labeled "Logging"
#Then I should see a table header and rows including the following values in the logging table:
#| Username                     |        Action                 | List of Data Changes OR Fields Exported |
#| [survey respondent] | Update Response 5 | survey_complete= '2' |
#
##FUNCTIONAL REQUIREMENT
###ACTION Verify Leave this page while survey is in session
#Given I click the link labeled "Add/Edit Records"
#And I click on the button labeled "Add new record for the arm selected above"
#And I click the bubble for the "Survey" longitudinal instrument on event "Event Three"
#And I click on the button labeled "Save & Stay"
#And I click on the button labeled "Survey options"
#And I select the option labeled "Open survey"
#Then I should see "Please complete the survey below"
#
##FUNCTIONAL REQUIREMENT
###ACTION Verify stay on page and edit survey
#When I click on the button labeled "Submit"
#Then I should see "Thank you for taking this survey"
#
#When I click on the button labeled "Close survey"
#And I click on the button labeled "Stay on this page"
#And I enter "Overwrite Name" in the field labeled "Name"
#And I click on the button labeled "Save & Exit Form"
#Then I should see "Record ID 6 successfully edited."
#
###VERIFY_LOG:
#When I click on the link labeled "Logging"
#Then I should see a table row including the following values in in the logging table:
#| test_admin | Update record 6 | name_survey = 'Overwrite Name' |
#| [survey respondent] | Update Response 6 | survey_complete= '2' |
