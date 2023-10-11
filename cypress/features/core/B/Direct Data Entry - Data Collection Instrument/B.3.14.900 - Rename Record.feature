Feature: Renaming a Record: The system shall allow users to rename a record.

As a REDCap end user
I want to see that rename record is functioning as expected

#Scenario: B.3.14.900.100 Rename record
##SETUP
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.3.14.900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button
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
##FUNCTIONAL REQUIREMENT
#When I click on the link labeled "Record Status Dashboard"
#And I click on the link labeled "1"
###ACTION Rename record
#And I click on the dropdown option labeled "Rename record" on the dropdown button labeled "Choose action for record"
#And I enter "1.A" into the field labeled "Rename record "1" to the following record name:"
#And I click on the button labeled "Rename record" in the dialog box
#Then I should see "Record ID 1.A was successfully renamed!"
#
##VERIFY_RSD: Record 1 is now 1.A
#When I click on the link labeled "Record Status Dashboard"
#Then I should see the linked labeled "1.A"
#AND I should NOT see the linked labeled "1"
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#Then I should see table rows including the following values in the logging table:
#| Username  |           Action            | List of Data Changes OR Fields Exported|
#| test_user1 | Update record 1.A |                      record_id = '1.A'                    |
#
###VERIFY_DE
#When I click on the link labeled "Data Exports, Reports, and Stats"
#Then I should see a table row containing the following values in the reports table:
#| A | All data (all records and fields) |
#
#When I click on the button labeled "View Report"
#Then I should see a table header and rows including the following values in the report data table:
#|Record ID  |
#|       1.A      |

