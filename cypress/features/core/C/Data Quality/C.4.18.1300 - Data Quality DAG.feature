Feature: User Interface: The system shall support limiting rule viewing to a Data Access Group.

As a REDCap end user
I want to see that Data Quality Module is functioning as expected

Scenario: C.4.18.1300.100 DAG limits rule viewing


#SETUP 
Given I login to REDCap with the user "Test_Admin" 
And I create a new project named "C.4.18.1300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_418.xml", and clicking the "Create Project" button

#SETUP_PRODUCTION 
When I click on the link labeled "Project Setup" 
And I click on the button labeled "Move project to production"  
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box 
Then I should see "Project status: Production" 

#USER_RIGHTS
When I click on the link labeled "User Rights" 
And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role" 
And I click on the button labeled "Assign to role" 
And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown 
And I select "TestGroup1" on the dropdown field labeled "[No Assignment]" on the role selector dropdown 
And I click on the button labeled exactly "Assign" on the role selector dropdown 
Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table 
And I should see "Test User1" assigned to "TestGroup1"

When I enter "Test_User2" into the field with the placeholder text of "Assign new user to role" 
And I click on the button labeled "Assign to role" 
And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown 
And I select "TestGroup2" on the dropdown field labeled "[No Assignment]" on the role selector dropdown 
And I click on the button labeled exactly "Assign" on the role selector dropdown 
Then I should see "Test User2" within the "1_FullRights" row of the column labeled "Username" of the User Rights table 
And I should see "Test User2" assigned to "TestGroup2"

#SETUP: Create Data Quality Rule
When I click on the link labeled "Data Quality"
And I enter "TestGroup1" for the field labeled "Rule Name"
And I enter "([ptname]<>[name]) AND ([user-dag-name]="testgroup1")" for the field labeled "Logic Editor"
And I click on the button labeled "Update & Close Editor" in the dialog box
And I click on the button labeled "Add"
Then I should see a table header and rows including the following values in the Data Quality Rules table: 
| Rule # | Rule Name   | Rule Logic (Show discrepancy only if...) |        
|      3     |  TestGroup1 | ([ptname]<>[name]) AND ([user-dag-name]="testgroup1")|
And I logout

#FUNCTIONAL_REQUIREMENT
##ACTION: testuser1 can see results within DAG
Given I login to REDCap with the user "Test_User1" 
And I click on the link labeled "Data Quality"
Then I should see "Data Quality Rules"

When I click on the button labeled "All"
##VERIFY
Then I should see a table header and rows including the following values in the Data Quality Rules table: 
| Rule # | Rule Name   | Rule Logic (Show discrepancy only if...)                                                    | Total Discrepancies |
|      3     |  TestGroup1 | ([ptname]<>[name]) AND ([user-dag-name]="testgroup1")|     2 export|view   |
And I logout

#FUNCTIONAL_REQUIREMENT
##ACTION: testuser2 cannot see results within DAG
Given I login to REDCap with the user "Test_User2" 
And I click on the link labeled "Data Quality"
Then I should see "Data Quality Rules"

When I click on the button labeled "All"
##VERIFY
Then I should see a table header and rows including the following values in the Data Quality Rules table: 
| Rule # | Rule Name   | Rule Logic (Show discrepancy only if...)                                    | Total Discrepancies |
|      3     |  TestGroup1 | ([ptname]<>[name]) AND ([user-dag-name]="testgroup1")|      0     |
