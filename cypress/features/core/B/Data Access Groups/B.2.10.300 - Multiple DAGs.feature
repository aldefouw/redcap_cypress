Feature: User Interface: The system shall allow a user to be added to more than one DAG.

As a REDCap end user
I want to see that Data Access Groups is functioning as expected

Scenario: B.2.10.300.100 Assign user multiple DAGs and DAG Switcher 
#SETUP 
Given I login to REDCap with the user "Test_Admin" 
And I create a new project named "B.2.10.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

#SETUP_RECORD_DAG_ASSIGN
When I click on "Record Status Dashboard"
And I click on the link labeled "3"
And I select the dropdown option labeled "Assign to Data Access Group" from the dropdown field labeled "Choose action for record"
And I select the dropdown option labeled "TestGroup1" from the dropdown field with the placeholder text of "[No Assignment]" in the dialog box
And I click on the button labeled "Assign to Data Access Group" in the dialog box
Then I should see "Record ID 3 was successfully assigned to a Data Access Group!"

When I click on "Record Status Dashboard"
And I click on the link labeled "4"
And I select the dropdown option labeled "Assign to Data Access Group" from the dropdown field labeled "Choose action for record"
And I select the dropdown option labeled "TestGroup2" from the dropdown field with the placeholder text of "[No Assignment]" in the dialog box
And I click on the button labeled "Assign to Data Access Group" in the dialog box
Then I should see "Record ID 4 was successfully assigned to a Data Access Group!"

#SETUP_USER_RIGHTS
When I click on the link labeled "User Rights" 
And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role" 
And I click on the button labeled "Assign to role" 
And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown 
And I click on the button labeled exactly "Assign" on the role selector dropdown 
Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table 

When I click on the link labeled "DAGs" 
Then I should see "Assign user to a group" 

#FUNCTIONAL REQUIREMENT
##ACTION: Assign DAG
When I select "Test_User1" from "Assign User" dropdown  
And I select "TestGroup1" from "DAG" dropdown  
And I click on the link labeled "Assign"  
##VERIFY 
Then I should see "TestGroup1" assigned to "Test_User1" user 
##ACTION: Assign DAG
When I select "Test_User1" from "Assign User" dropdown  
And I select "TestGroup2" from "DAG" dropdown  
And I click on the link labeled "Assign"  
##VERIFY 
Then I should see "TestGroup2" assigned to "Test_User1" user 
##ACTION: Assign DAG Switcher
When I select "TestGroup1" for user "Test_User1" in the DAG Switcher 
And I select "TestGroup2" for user "Test_User1" in the DAG Switcher 
Then I should see a checkbox labeled "TestGroup1" that is checked for user "Test_User1"
And I should see a checkbox labeled "TestGroup2" that is checked for user "Test_User1"
And I logout 

Given I login to REDCap with the use "Test_User1" 
When I click on the link labeled "My Projects" 
And I click on the link labeled "B.2.10.300.100" 
##VERIFY 
Then I should see "Current Data Access Group" 

##ACTION: Switch DAG
When I click on the button labeled "Switch" 
And I select "TestGroup1" from the Switch dropdown of the open "Switch Data Access Group " in the dialog box 
And I click on the button labeled "Switch" in the dialog box
##VERIFY 
Then I should see "TestGroup1" 
##VERIFY_RSD:
When I click the link labeled "Record Status Dashboard" 
Then I should see record "3" 
##VERIFY 
When I click on the button labeled "Switch"
And I select "TestGroup2" from the Switch dropdown of the open "Switch Data Access Group" in the dialog box
And I click on the button labeled "Switch" in the dialog box
Then I should see "TestGroup2" 
##VERIFY_RSD:
When I click the link labeled "Record Status Dashboard" 
Then I should see record "4" 
