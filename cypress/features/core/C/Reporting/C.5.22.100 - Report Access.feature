Feature: User Interface: The system shall support the ability to assign the User Access to View Access and Edit Access in the Reporting module

As a REDCap end user
I want to see that Reporting is functioning as expected

Scenario: C.5.22.100.100 - MISSING SCENARIO TITLE

#SETUP
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "C.5.22.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

#SETUP_PRODUCTION
When I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project status: Production"

#SETUP: Assign record 1 to DAG1
When I click on the link labeled "Record Status Dashboard"
And I click on record "1"
And I select the dropdown option labeled "Assign to Data Access Group" from the dropdown button with the placeholder text of "Choose action for record"
And I select the dropdown option labeled "TestGroup1" from the dropdown button with the placeholder text of "[No Assignment]" in the dialog box
And I click on the button labeled "Assign to Data Access Group" in the dialog box
Then I should see "Record ID 1 was successfully assigned to a Data Access Group1"

#SETUP: Assign record 1 to DAG1
When I click on the link labeled "Record Status Dashboard"
And I click on record "2"
And I select the dropdown option labeled "Assign to Data Access Group" from the dropdown button with the placeholder text of "Choose action for record"
And I select the dropdown option labeled "TestGroup1" from the dropdown button with the placeholder text of "[No Assignment]" in the dialog box
And I click on the button labeled "Assign to Data Access Group" in the dialog box
Then I should see "Record ID 2 was successfully assigned to a Data Access Group1"

#USER_RIGHTS
When I click on the link labeled "User Rights"
And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
And I click on the button labeled "Assign to role"
And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
And I select "TestGroup1" on the dropdown field with the placeholder text "[No Assignment]" on the DAG dropdown
And I click on the button labeled exactly "Assign" on the role selector dropdown
Then I should see "Test User 1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table
And I should see "Test User 1" assigned to the DAG labeled "TestGroup1"

When I enter "Test_User2" into the field with the placeholder text of "Assign new user to role"
And I click on the button labeled "Assign to role"
And I select "2_Edit_RemoveID" on the dropdown field labeled "Select Role" on the role selector dropdown
And I select "TestGroup2" on the dropdown field with the placeholder text "[No Assignment]" on the DAG dropdown
And I click on the button labeled exactly "Assign" on the role selector dropdown
Then I should see "Test User 2" within the "2_Edit_RemoveID" row of the column labeled "Username" of the User Rights table
And I should see "Test User 2" assigned to the DAG labeled "TestGroup2"

When I enter "Test_User3" into the input field labeled "Add with custom rights"
And I click on the button labeled "Add with custom rights"
And I uncheck the checkbox on the field labeled "Add/Edit/Organize Reports"
And I click on the button labeled "Add user"
Then I should see User "test_user3" was successfully added
#SETUP: Create report
When I click on the link labeled "Data Exports, Reports, and Stats"
And I click on the button labeled "Create New Report"
And I enter "C.5.22.100.100 REPORT" in the field labeled "Name of Report:"
#FUNCTIONAL_REQUIREMENT
##ACTION
And I verify the radio button labeled "All users" is selected for the field labeled "View Access"
And I verify the radio button labeled "All users" is selected for the field labeled "Edit Access"
And I click on the button labeled "Save Report"
Then I should see "Your report has been saved!" in the dialog box
And I click on the button labeled "Return to My Reports & Exports"
And I logout

##VERIFY: USER 1
Given I login to REDCap with the user "Test_User1"
And I click on the link labeled "My Projects"
And I click on the link labeled "C.5.22.100.100"
Then I should see the link labeled "C.5.22.100.100 REPORT" under the header labeled "Reports"

When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| 1 | C.5.22.100.100 REPORT |

When I click on the button labeled "View Report" for the report labeled "C.5.22.100.100 REPORT"
Then I should see record "1"
And I should NOT see record "2"
And I should NOT see record "3"
And I should NOT see record "4"
##VERIFY: Edit Report button
And I should see a button labeled "Edit Report"
And I logout

##VERIFY: USER 2
Given I login to REDCap with the user "Test_User2"
And I click on the link labeled "My Projects"
And I click on the link labeled "C.5.22.100.100"
Then I should see the link labeled "C.5.22.100.100 REPORT" under the header labeled "Reports"

When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| 1 | C.5.22.100.100 REPORT |

When I click on the button labeled "View Report"
Then I should see record "2"
And I should NOT see record "1"
And I should NOT see record "3"
And I should NOT see record "4"
##VERIFY: Edit Report button
And I should see a button labeled "Edit Report"
And I logout

##VERIFY: USER 3
Given I login to REDCap with the user "Test_User3"
And I click on the link labeled "My Projects"
And I click on the link labeled "C.5.22.100.100"
Then I should see the link labeled "C.5.22.100.100 REPORT" under the header labeled "Reports"

When I click on the link labeled "Data Exports, Reports, and Stats"
##VERIFY: cannot create report, edit, delete or copy report
Then I should NOT see a button labeled "Edit"
And I should NOT see a button labeled "Copy"
And I should NOT see a button labeled "Delete"
And I should see a table row containing the following values in the reports table:
| 1 | C.5.22.100.100 REPORT |

When I click on the button labeled "View Report"
Then I should see record "1"
And I should see record "2"
And I should see record "3"
And I should see record "4"

##VERIFY: Edit Report button
And I should NOT see a button labeled "Edit Report"
And I logout

Given I login to REDCap with the user "Test_Admin"
When I click on the link labeled "My Projects"
And I click on the link labeled "C.5.22.100.100"
And I click on the link labeled "Data Exports, Reports, and Stats"
And I click on the button labeled "Edit" for the field labeled "C.5.22.100.100 REPORT"
Then I should see "Edit Existing Report: "C.5.22.100.100 REPORT"

#FUNCTIONAL_REQUIREMENT
##ACTION
When I click on the radio button labeled "Custom user access" for the field labeled "View Access"
And I select "test_user1" from the dropdown field labeled "Selected users"
And I select "test_user2" from the dropdown field labeled "Selected users"
And I click on the radio labeled "Custom user access" for the field labeled "Edit Access"
And I select "test_user1" from the dropdown field labeled "Selected users"
And I click on the button labeled "Save Report"
Then I should see "Your report has been saved!" in the dialog box
And I click on the button labeled "Return to My Reports & Exports"
And I logout

##VERIFY: USER 3
Given I login to REDCap with the user "Test_User3"
And I click on the link labeled "My Projects"
And I click on the link labeled "C.5.22.100.100"
Then I should NOT see the link labeled "C.5.22.100.100 REPORT" under the header labeled "Reports"

When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should NOT see "C.5.22.100.100 REPORT"
And I logout

##VERIFY: USER 2
Given I login to REDCap with the user "Test_User2"
And I click on the link labeled "My Projects"
And I click on the link labeled "C.5.22.100.100"
Then I should see the link labeled "C.5.22.100.100 REPORT" under the header labeled "Reports"

When I click on the link labeled "C.5.22.100.100 REPORT" under the header labeled "Reports"
Then I should see "C.5.22.100.100 REPORT"

When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| 2 | C.5.22.100.100 REPORT |
And I should NOT see a button labeled "Edit"
And I should NOT see a button labeled "Copy"
And I should NOT see a button labeled "Delete"

When I click on the button labeled "View Report" for the link labeled "C.5.22.100.100 REPORT"
Then I should see record "2"
And I should NOT see record "1"
And I should NOT see record "3"
And I should NOT see record "4"
##VERIFY: Edit Report button
And I should NOT see a button labeled "Edit Report"
And I logout

##VERIFY: USER 1
Given I login to REDCap with the user "Test_User1"
And I click on the link labeled "My Projects"
And I click on the link labeled "C.5.22.100.100"
Then I should see the link labeled "C.5.22.100.100 REPORT" under the header labeled "Reports"

When I click on the link labeled "C.5.22.100.100 REPORT" under the header labeled "Reports"
Then I should see "C.5.22.100.100 REPORT"

When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| 2 | C.5.22.100.100 REPORT |
Then I should see a button labeled "Edit"
And I should see a button labeled "Copy"
And I should see a button labeled "Delete"

When I click on the button labeled "View Report" for the link labeled "C.5.22.100.100 REPORT"
Then I should see record "1"
And I should NOT see record "2"
And I should NOT see record "3"
And I should NOT see record "4"
##VERIFY: Edit Report button
And I should see a button labeled "Edit Report"
And I logout