Feature: User Interface: Survey Distribution: The system shall provide a survey to be generated from within a participant record using these survey options: (Log out + Open survey | Open Survey link)

As a REDCap end user
I want to see that Survey Distribution is functioning as expected

#Scenario: B.3.15.400.100 Open survey mode
##SETUP
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.3.15.400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION
#When I click on the link labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see "Project status: Production"
#
##FUNCTIONAL REQUIREMENT
###ACTION - Open survey
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
#And I click on the button labeled "Close survey"
#
#Given I click on the button labeled "Leave without saving changes"
##FUNCTIONAL REQUIREMENT
###ACTION - Log out + Open survey
#When I click the link labeled "Add/Edit Records"
#And I click on the button labeled "Add new record for the arm selected above"
#And I click the bubble for the "Survey" longitudinal instrument on event "Event Three"
#And I click on the button labeled "Save & Stay"
#And I click on the button labeled "Survey options"
#And I select the option labeled "Log out + Open survey"
#Then I should see "Please complete the survey below"
#
#When I click on the button labeled "Submit"
#Then I should see "Thank you for taking this survey"
#And I click on the button labeled "Close survey"
#
###VERIFY_LOG:
#Given I login to REDCap with the user "Test_User1"
#When I click on the link labeled "My Projects"
#And I click on the link labeled "B.3.15.400.100"
#And I click on the link labeled "Logging"
#Then I should see a table header and rows including the following values in the logging table:
#| Username                     |        Action                 | List of Data Changes OR Fields Exported |
#| [survey respondent] | Update Response 6 | survey_complete= '2' |
#| [survey respondent] | Update Response 5 | survey_complete= '2' |
