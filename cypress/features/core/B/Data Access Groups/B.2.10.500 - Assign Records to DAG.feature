Feature: User Interface: The system shall provide the ability to assign records to a DAG from the Record Home page

As a REDCap end user
I want to see that Data Access Groups is functioning as expected

Scenario: B.2.10.500.100 Assign DAG to record
#SETUP 
Given I login to REDCap with the user "Test_Admin"  
And I create a new project named "B.2.10.500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

When I click on the link labeled "Record Status Dashboard" 
And I click on the link labeled "2" 
Then I should see the "Record Home Page" 

#FUNCTIONAL REQUIREMENT
##ACTION: Assign Record DAG
When I select the dropdown option labeled "Assign to Data Access Group" from the dropdown "Choose action for record" 
And I select the dropdown option labeled "TestGroup1" from the dropdown with the placeholder text of "[No Assignment]" in the dialog box
And I click on the button labeled "Assign to Data Access Group" in the dialog box

##VERIFY 
Then I should see "Record ID 2 was successfully assigned to a Data Access Group!"
And I should see "Arm 1: Arm 1 - TestGroup1" 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action           | List of Data Changes OR Fields Exported |
| test_admin | Update record 2 | Assign record to Data Access Group (redcap_data_access_group = 'testgroup1') |
