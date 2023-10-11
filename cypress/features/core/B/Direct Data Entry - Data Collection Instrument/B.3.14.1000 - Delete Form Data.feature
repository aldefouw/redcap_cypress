Feature: Deleting Data: The system shall allow users to delete all data on the current form of a given record.

As a REDCap end user
I want to see that delete record is functioning as expected

#Scenario: B.3.14.1000.100 Delete all data in a form for a record form
#
##SETUP
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.3.14.000.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION
#When I click on the link labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see "Project status: Production"
#
##SET UP_USER_RIGHTS
#When I click on the link labeled "User Rights"
#And I click on the link labeled "Test_User1"
#And I click on the button labeled "Assign to role"
#And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
#And I click on the button labeled exactly "Assign" on the role selector dropdown
#Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table
#
###ACTION
#When I click the link labeled "Record Status Dashboard"
#And I click the bubble for the "Survey" instrument on event "Event Three" for record "1"
#Then I should see "Name" in the field labeled "Name"
#And I should see a button labeled "Delete data for THIS FORM only"
#
##FUNCTIONAL_REQUIREMENT
#When I click on the button labeled "Delete data for THIS FORM only"
#And I click on the button labeled "Delete data for THIS FORM only" in the dialog box
#Then I should see "Record ID 1 successfully edited."
#And I should see an Incomplete (no data saved) status icon for the "Survey" instrument on event "Event Three" for record "1"
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#Then I should see table rows including the following values in the logging table:
#| Username  |           Action            | List of Data Changes OR Fields Exported|
#| test_user1 | Update record 1 | "email_survey = '' |
#| test_user1 | Update record 1 | name_survey = '' |
#| test_user1 | Update record 1 | survey_complete = '' |
#
###VERIFY_DE
#When I click on the link labeled "Data Exports, Reports, and Stats"
#Then I should see a table row containing the following values in the reports table:
#| A | All data (all records and fields) |
#
#When I click on the button labeled "View Report"
#Then I should see a table header and rows including the following values in the report data table:
#| Record ID|     email_survey  |      name_survey  | survey_complete |
#|         1       |                               |                                | Incomplete (0)      |
