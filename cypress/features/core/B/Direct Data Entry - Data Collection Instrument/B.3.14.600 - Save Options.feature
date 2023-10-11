Feature: Saving Data: The system shall support the ability to: (Save and stay | Save and exit | Cancel the data entered and leave the record without saving)

As a REDCap end user
I want to see that saving data is functioning as expected

#Scenario: B.3.14.600.100 Save data options from data entry page
#
##SETUP
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.3.14.600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION
#When I click on the link labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see "Project status: Production"
#
##SETUP create record
#Given I click the link labeled "Add/Edit Records"
#And I click on the button labeled "Add new record for the arm selected above"
#And I click the bubble for the "Text Validation" longitudinal instrument on event "Event 1"
#Then I should see "Adding new Record ID 7."
#
##FUNCTIONAL_REQUIREMENT:
###ACTION: cancel data
#Given I enter "CANCEL" in the field labeled "Name"
#And I click on the button labeled "Cancel"
#And I click on the button labeled "OK" in the pop-up box
###VERIFY
#Then I should see "Record ID 7" data entry cancelled - not saved."
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#Then I should NOT see table rows including the following values in the logging table:
#| Username | Action                  |
#| test_user1 | Create record 7 |
#
##FUNCTIONAL_REQUIREMENT:
###ACTION: SAVE & STAY
#Given I click the link labeled "Add/Edit Records"
#When I click on the button labeled "Add new record for the arm selected above"
#And I click the bubble for the "Text Validation" longitudinal instrument on event "Event 1"
#Then I should see "Adding new Record ID 7."
#
#And I enter "SAVE & STAY" in the field labeled "Name"
#And I click on the button labeled "Save & Stay"
###VERIFY
#Then I should see "Record ID 7 successfully edited."
#
##SETUP create record
#Given I click the link labeled "Add/Edit Records"
#And I click on the button labeled "Add new record for the arm selected above"
#And I click the bubble for the "Text Validation" longitudinal instrument on event "Event 1"
#Then I should see "Adding new Record ID 8."
#
##FUNCTIONAL_REQUIREMENT:
###ACTION  SAVE & Go To Next Form
#When I enter "SAVE & GO TO NEXT FORM" in the field labeled "Name"
#And I select the dropdown option labeled "Save & Go To Next Form" on the dropdown field labeled "Save & Stay"
###VERIFY
#Then I should see "Data Types"
#
##SETUP create record
#Given I click the link labeled "Add/Edit Records"
#And I click on the button labeled "Leave without saving changes" in the dialog box
#And I click on the button labeled "Add new record for the arm selected above"
#And I click the bubble for the "Text Validation" longitudinal instrument on event "Event 1"
#Then I should see "Adding new Record ID 9."
#
##FUNCTIONAL_REQUIREMENT:
###ACTION Save & Exit Record
#Given I enter "SAVE & EXIT RECORD" in the field labeled "Name"
#And I select the dropdown option labeled "Save & Exit Record" on the dropdown field labeled "Save & Go To Next Form"
###VERIFY
#Then I should see "Add / Edit Records"
#
##SETUP create record
#Given I click the link labeled "Add/Edit Records"
#And I click on the button labeled "Add new record for the arm selected above"
#And I click the bubble for the "Text Validation" longitudinal instrument on event "Event 1"
#Then I should see "Adding new Record ID 10."
#
##FUNCTIONAL_REQUIREMENT:
###ACTION Save & Go To Next Record
#Given I enter "SAVE & GO TO NEXT RECORD" in the field labeled "Name"
#And I click the link labeled "Add/Edit Records"
#And I click on the button labeled "Leave without saving changes" in the dialog box
#And I click on the button labeled "Add new record for the arm selected above"
#And I click the bubble for the "Text Validation" longitudinal instrument on event "Event 1"
#Then I should see "Adding new Record ID 11."
#
#When I enter "NEXT RECORD" in the field labeled "Name"
#And I click on the button labeled "Save & Stay"
###VERIFY
#Then I should see "Record ID 11 successfully edited."
#
#Given I click the link labeled "Record Status Dashboard"
#And I click the bubble for the "Text Validation" longitudinal instrument on event "Event 1" for record "10"
#And I verify I see "SAVE & GO TO NEXT RECORD" in the field labeled "Name"
#And I select the dropdown option labeled "Save & Go To Next Record" on the dropdown field labeled "Save & Exit Record"
#Then I should see "Now displaying the next record: Record ID 11"
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#Then I should see table rows including the following values in the logging table:
#| Username | Action                  | List of Data Changes OR Fields Exported |
#| test_user1 | Update record 10 |   name = 'SAVE & GO TO NEXT RECORD '|
#| test_user1 | Create record 9    |   name = 'SAVE & EXIT RECORD' |
#| test_user1 | Create record 8    |   name = 'SAVE & GO TO NEXT FORM' |
#| test_user1 | Create record 7    |   name = 'SAVE & STAY' |
#
###VERIFY_DE:
#When I click on the link labeled "Data Exports, Reports, and Stats"
#Then I should see a table row containing the following values in the reports table:
#| A | All data (all records and fields) |
#
#When I click on the button labeled "View Report"
#Then I should see a table header and rows including the following values in the report data table:
#| Record ID|           Event Name          |       Name      |
#|          7      | Event 1 (Arm 1: Arm 1) | SAVE & STAY|
#|          8      | Event 1 (Arm 1: Arm 1) | SAVE & GO TO NEXT FORM|
#|          9      | Event 1 (Arm 1: Arm 1) | SAVE AND EXIT RECORD|
#|         10     | Event 1 (Arm 1: Arm 1) | SAVE & GO TO NEXT RECORD|
