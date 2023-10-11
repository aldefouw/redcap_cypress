Feature: User Interface: Survey Project Settings: The system shall delete all survey-related information and functions including survey link, return codes and date/time stamp when disabling survey functionality. Saved data will remain unaffected.

As a REDCap end user
I want to see that Survey Feature is functioning as expected

#Scenario: B.3.15.1200.100 Deletion of meta data includes deletion of survey information and function
#
##SETUP
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.3.15.1200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION
#When I click on the link labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see "Project status: Production"
#
##SETUP: DESIGNER
#Given I click on the link labeled "Designer"
#And I click on the button labeled "Enable" for the instrument labeled "Text Validation"
#And I click on the button labeled "Save Changes"
#Then I should see the enabled icon for the instrument labeled "Text Validation"
#
#Given I click on the button labeled "Survey Settings" for the instrument labeled "Text Validation"
#When I select the dropdown option labeled "Yes" for the field labeled "Allow 'Save & Return Later' option for respondents?"
# And I click on the button labeled "Save Changes"
#Then I should see "Your survey settings were successfully saved"
#
###VERIFY_SDT: verifying survey link and return codes are available
#Given I click on the link labeled "Survey Distribution Tools"
#And I click on the button labeled "Participant List"
#Then I should see "Text Validation" on the dropdown labeled "Participant List belonging to"
#And I should see a link icon for record "1"
#And I should see a survey access code icon for record "1"
#
#
###ACTION
#When I click on the link labeled "Record Status Dashboard"
#And I click on the bubble for the instrument labeled "Text Validation" for record "1" for event "Event 1"
#And I click on the dropdown option labeled "Open Survey" on the dropdown button labeled "Survey options"
#And I enter "B.3.15.1200.100" for the field labeled "Name"
#And I click on the button labeled "Submit"
#Then I should see "Thank you for taking the survey"
#
#Given I click on the button labeled "Close survey"
#And I click on the button labeled "Leave without saving changes" in the dialog box
###VERIFY_DE
#When I click on the link labeled "Data Exports, Reports, and Stats"
#Then I should see a table row containing the following values in the reports table:
#| A | All data (all records and fields) |
#
#When I click on the button labeled "View Report"
#Then I should see a table header and rows containing the following values in the report data table:
#| Record ID |          Name          | Survey Timestamp           |
#|          1       | B.3.15.1200.100 |      mm/dd/yyyy HH:MM |
#
##FUNCTIONAL REQUIREMENT
###ACTION
#When I click on the link labeled "Designer"
#And I click on the button labeled "Survey settings" for the instrument labeled "Text Validation"
#And I click on the button labeled "Delete Survey Settings"
#And I click on the button labeled "Delete Survey Settings" in the dialog box
#Then I should see "Survey successfully deleted!"
#And I click on the button labeled "Close" in the dialog box
#
###VERIFY_DE: confirm
#When I click on the link labeled "Data Exports, Reports, and Stats"
#Then I should see a table row containing the following values in the reports table:
#| A | All data (all records and fields) |
#
#When I click on the button labeled "View Report"
#Then I should see a table header and rows containing the following values in the report data table:
#| Record ID |          Name          |
#|          1       | B.3.15.1200.100 |
#
#And I should NOT see "Survey Timestamp"
#
###VERIFY_SDT: verifying survey link and return codes are NOT available
#Given I click on the link labeled "Survey Distribution Tools"
#And I click on the button labeled "Participant List"
#Then I should NOT see "Text Validation" on the dropdown labeled "Participant List belonging to"
