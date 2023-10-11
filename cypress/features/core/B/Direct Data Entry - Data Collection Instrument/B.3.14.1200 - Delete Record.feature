Feature: Deleting Data: The system shall allow users to delete a record

As a REDCap end user
I want to see that user rights to delete data is functioning as expected

#Scenario: B.3.14.1200.100 Delete record
#
##SETUP
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.3.14.1200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION
#When click on the link labeled "Project Setup"
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
#And I click on the link labeled "1"
#Then I should see "Record Home Page"
#And I should see "Record ID 1"
#
##FUNCTIONAL_REQUIREMENT
###ACTION Delete record
#When I select the dropdown option labeled "Delete record (all forms)" on the dropdown field labeled "Choose action for record"
#And I click on the button labeled "DELETE RECORD" in the dialog box
###VERIFY
#Then I should see "Record deleted!"
#And I click on the button labeled "Close" in the dialog box
#
###VERIFY_LOG
#When I click the link labeled "Logging"
#Then I should see table rows including the following values in the logging table:
#| Username  |           Action            | List of Data Changes OR Fields Exported|
#| test_user1 | Delete record 1 | record_id = '1'|
#
###VERIFY_DE
#When I click on the link labeled "Data Exports, Reports, and Stats"
#Then I should see a table row containing the following values in the reports table:
#| A | All data (all records and fields) |
#
#When I click on the button labeled "View Report"
#Then I should NOT see record "1"
