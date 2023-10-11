Feature: User Interface: The system shall support adding and removing users from DAGs.

As a REDCap end user
I want to see that Data Access Groups is functioning as expected

Scenario: B.2.10.200.100 Assign & Remove User to DAG
#SETUP 
Given I login to REDCap with the user "Test_Admin" 
And I create a new project named "B.2.10.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

#SETUP_RECORD_DAG_ASSIGN
When I click on "Record Status Dashboard"
And I click on the link labeled "3"
And I select the dropdown option labeled "Assign to Data Access Group" from the dropdown field labeled "Choose action for record"
And I select the dropdown option labeled "TestGroup1" from the dropdown field with the placeholder text of "[No Assignment]" in the dialog box
And I click on the button labeled "Assign to Data Access Group" in the dialog box
Then I should see "Record ID 3 was successfully assigned to a Data Access Group!"

#SETUP_USER_RIGHTS
When I click on the link labeled "User Rights"   
Given I upload a "csv" format file located at "import_files/user list for project 1.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
Then I should see a dialog containing the following text: "Upload users (CSV) - Confirm"
And I should see a table header and rows containing the following values in the table:
| username   |
| test_user1 |
| test_user2 |
| test_user3 |
| test_user4 |

Given I click on the button labeled "Upload"
Then I should see a dialog containing the following text: "SUCCESS!"
And I close the popup
And I should see a table header and rows including the following values in the table:
|Role name                            | Username   |
|                      		      | test_admin |
|                        		      | test_user1 |
|                      		      | test_user2 |
|                       	             	      | test_user3 |
|                        		      | test_user4 |
| 1_FullRights  |                     |		|
| 2_Edit_RemoveID|             |		|
| 3_ReadOnly_Deidentified |                    |
| 4_NoAccess_Noexport     |                     |

#FUNCTIONAL REQUIREMENT
##ACTION: Assign User to DAG
When I click on the link labeled "DAGs"
And I select "Test_User1" from "Assign User" dropdown  
And I select "TestGroup1" from "DAG" dropdown  
And I click on the button labeled "Assign"  
##VERIFY: DAG assignment
Then I should see "TestGroup1" assigned to "Test_User1" user 

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action           | List of Data Changes OR Fields Exported |
| test_admin | Manage/Design  | Assign user to data access group user = 'test_user1'
And I logout 

Given I login to REDCap with the user "Test_User1"
When I click on the link labeled "My Projects" 
And I click on the link labeled "B.2.10.200.100" 
##VERIFY: Access to DAG Module restricted
And I click on the link labeled "DAGs" 
Then I should see "RESTRICTED:" 

##VERIFY_UR: DAG assignment
When I click on the link labeled "User Rights"
Then I should see "TestGroup1" assigned to "Test_User1"user 
##VERIFY_RSD:
When I click on "Record Status Dashboard"  
Then I should see record "3" 
And I should NOT see record "1" 
And I logout 

#SETUP 
Given I login to REDCap with the user "Test_Admin" 
When I click on the link labeled "My Projects" 
And I click on the link labeled "B.2.10.200.100" 
And I click on the link labeled "DAGs" 
Then I should see "Assign user to a group" 
##ACTION: Remove DAG
When I select "Test_User1" from "Assign User" dropdown  
And I select "[No Assignment]" from "DAG" dropdown  
And I click on the link labeled "Assign"  
##VERIFY 
Then I should see "[Not assigned to a group]" assigned to "Test_User1" user 
And I logout 

Given I login to REDCap with the user "Test_User1"
When I click on the link labeled "My Projects" 
And I click on the link labeled "B.2.10.200.100" 
##VERIFY: Access to DAG Module 
And I click on the link labeled "Data Access Group" 
Then I should see "Assign user to a group" 
##VERIFY_UR
When I click on the link labeled "User Rights"
Then I should see "-" assigned to "Test_User1"user 
##VERIFY_RSD:
When I click on "Record Status Dashboard"  
Then I should see record "3" 
And I should see record "1" 
