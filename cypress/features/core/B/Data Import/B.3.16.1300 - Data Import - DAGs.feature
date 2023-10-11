Feature: User Interface: The system shall provide the ability to assign data instruments to a data access group with the Data Import Tool.

As a REDCap end user
I want to see that Data import is functioning as expected

Scenario: B.3.16.1300.100 Data import assigns DAG
#SETUP  
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "B.3.16.1300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.16.xml", and clicking the "Create Project" button 

When I click on the link labeled "DAGs"
And I enter "Test_Group1" into the field with the placeholder text "Enter new group name" 
And I click on the button labeled "Add Group"
Then I should see "Data Access Group "Test_Group1" has been created!"

When I click on the link labeled "User Rights" 
And I enter "Test_User1" into the field with the placeholder text of "Add new user" 
And I click on the button labeled "Add with custom rights" 
And I click on the checkbox labeled "Data Import Tool"
And I select the dropdown option labeled "Test_Group1" on the dropdown field with the placeholder text "[No Assignment]"
And I click on the button labeled "Add user"
Then I should see a table header and rows containing the following values in the table:  
| Username or users assigned to a role|       Data Access Group   | 
|                    test_user 1                          |           Test_Group1           | 

#SETUP_PRODUCTION 
Given I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production"  
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box 
Then I should see "Project status: Production" 

Given I click on the link labeled "Data Import Tool" 
When I click on the button labeled "Choose File" 
And I upload the file labeled "B.3.16.1300_DataImport_Rows.csv" 
And I click on the button labeled "Upload File" 
Then I should see "Your document was uploaded successfully and is ready for review" 

When I click on the button labeled "Import Data" 
Then I should see "Import Successful!" 
And I logout

Given I login to REDCap with the user "Test_User1"
And I click on the link labeled "Data Import Tool" 
And I click on the button labeled "Choose File" 
And I upload the file labeled "B.3.16.1300_DataImport_Dag.csv" 
And I click on the button labeled "Upload File"
Then I should see "ERROR: Illegal use of 'redcap_data_access_group' field!"
And I log out

Given I login to REDCap with the user "Test_Admin"
And I click the link labeled "Data Import Tool" 
And I click on the button labeled "Choose File" 
And I upload the file labeled "B.3.16.1300_DataImport_Dag.csv" 
And I click on the button labeled "Upload File"
Then I should see a header and rows containing the following values in the ERROR DISPLAY table:
| record_id | redcap_data_access_group | name |
| 100 | test_group1 | Rob |
| 200 | test_group1 | Brenda |
| 300 | test_group1 | Paul |
And I click the button labeled "Import Data"
Then I should see "Import Successful!" 

#VERIFY_DE 
When I click the link labeled "Data Exports, Reports and Stats"
And I click the button labeled "View Report"
Then I should see a table row including the following values in in the logging table:
|record_id|redcap_data_access_group|name|
|100| test_group1|Rob|
|200| test_group1|Brenda|
|300| test_group1|Paul|
