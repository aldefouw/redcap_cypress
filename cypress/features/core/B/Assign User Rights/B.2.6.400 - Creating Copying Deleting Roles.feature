Feature: Project Level:  The system shall allow for the creation, copying and deletion of user roles.

As a REDCap end user
I want to see that assign user rights is functioning as expected

Scenario: B.2.6.400.100 Create, Copy, & Delete User Roles
#SETUP 
Given I login to REDCap with the user "Test_Admin"    
And I create a new project named "B.2.6.400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

#FUNCTIONAL REQUIREMENT: 
##ACTION: User Rights Create role
When I click on the link labeled "User Rights"   
And I enter "TestRole2" into the rolename input field 
And I click on the button labeled "Create role"
And I click on the button labeled "Create role" within User Rights
##VERIFY_UR
Then I should see "TestRole2" 

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action           | List of Data Changes OR Fields Exported |
| test_admin | Create user role | role = 'TestRole2'|

When I click on the link labeled "User Rights"   
And I click on the link labeled "TestRole2" 
##ACTION: User Rights Copy role
And I click on the button labeled "Copy role" 
And I enter "CopyRole" into the data entry form field labeled "New role name" 
And I click on the button labeled "Copy role" 
And I click on the button labeled "Save Changes" 
##VERIFY
Then I should see "CopyRole" 

When I click on the link labeled "TestRole2"
##ACTION: User Rights delete role
And I click on the button labeled "Delete role" 
And I click on the button labeled "Delete role" in the dialog box
##VERIFY
Then I should NOT see "TestRole2"
