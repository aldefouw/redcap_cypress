Feature: User Interface: The system shall provide the DAG unique group names in the data export raw CSV file and the label in the CSV labels data file.

As a REDCap end user
I want to see that Data Access Groups is functioning as expected

Scenario: B.2.10.600.100 Unique DAGs

#SETUP 
Given I login to REDCap with the user "Test_Admin" 
And I create a new project named "B.2.10.600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

When I click on the link labeled "Record Status Dashboard" 
And I click on the link labeled "3" 
Then I should see the "Record Home Page" 

#FUNCTIONAL REQUIREMENT
##ACTION: Assign Record DAG_testgroup1
When I select the dropdown option labeled "Assign to Data Access Group" from the dropdown "Choose action for record" 
And I select the dropdown option labeled "TestGroup1" from the dropdown with the placeholder text of "[No Assignment]" in the dialog box
And I click on the button labeled "Assign to Data Access Group" in the dialog box

##VERIFY 
Then I should see "Record ID 3 was successfully assigned to a Data Access Group!"
And I should see "Arm 1: Arm 1 - TestGroup1" 

When I click on the link labeled "Record Status Dashboard" 
And I click on the link labeled "4" 
Then I should see the "Record Home Page" 

#FUNCTIONAL REQUIREMENT
##ACTION: Assign Record DAG_testgroup2
When I select the dropdown option labeled "Assign to Data Access Group" from the dropdown "Choose action for record" 
And I select the dropdown option labeled "TestGroup2" from the dropdown with the placeholder text of "[No Assignment]" in the dialog box
And I click on the button labeled "Assign to Data Access Group" in the dialog box

##VERIFY 
Then I should see "Record ID 4 was successfully assigned to a Data Access Group!"
And I should see "Arm 1: Arm 1 - TestGroup2" 

##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats" 
Then I should see a table row containing the following values in the reports table: 
| A | All data (all records and fields) | 
 
When I click on the button labeled "View Report" 
Then I should see a table header and rows including the following values in the report data table: 
| Record ID| Data Access Group |
| 3               |   TestGroup1            |
| 4               |   TestGroup2            |
