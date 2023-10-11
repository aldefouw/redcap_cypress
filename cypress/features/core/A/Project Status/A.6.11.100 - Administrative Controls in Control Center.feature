Feature: Control Center: The system shall support limiting the ability to move projects to production to administrators.     

As a REDCap end user  
I want to see that My Project is functioning as expected    

Scenario: A.6.11.100.100 Production status setting in control center    
#SETUP  
Given I login to REDCap with the user "Test_Admin"  
And I create a new project named "A.6.11.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

##USER_RIGHTS  
When I click on the link labeled "User Rights"   
And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"   
And I click on the button labeled "Assign to role"   
And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown   
And I click on the button labeled exactly "Assign" on the role selector dropdown   
Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table     

#FUNCTIONAL REQUIREMENT  
##ACTION: Setup in control center - admin only  
When I click on the link labeled "Control Center"
  And I click on the link labeled "User Settings"  
Then I should see "System-level User Settings"     

When I select "No, only Administrators can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"  
 And I click on the button labeled "Save Changes"  
 ##VERIFY  
Then I should see "Your system configuration values have now been changed!"   
And I logout   
 #SETUP   
Given I login to REDCap with the user "Test_User1"  
When I click on the link labeled "My Projects"    
And I click on the link labeled "A.6.11.100.100"   
##ACTION: Test user requests move to production  
And I click on the link labeled "Project Setup"  
And I click on the button labeled "Move project to production"   
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "Yes, Request Admin to Move to Production Status" in the dialog box  
##VERIFY  
Then I should see "Success! Your request to move the project to production status has been sent to a REDCap administrator. "    

##VERIFY_LOG  
When I click on the button labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
  | Username   |  Action               | List of Data Changes OR Fields Exported          |
  | test_user1 |  Manage/Design        | Send request to move project to production status|

##ACTION: cancel request  
When I click on the link labeled "Project Setup"  
And I click on the button labeled "Cancel request"  
And I click on the button labeled "Submit" in the dialog box
Then I should see "Project status: Development"
And I logout    

#SETUP   
Given I login to REDCap with the user "Test_Admin" 
 When I click on the link labeled "Control Center"  
And I click on the link labeled "User Settings"  
Then I should see "System-level User Settings"     
When I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"   
And I click on the button labeled "Save Changes"
##VERIFY
Then I should see "Your system configuration values have now been changed!"
And I logout    

#SETUP   
Given I login to REDCap with the user "Test_User1" 
 When I click on the link labeled "My Projects"  
  And I click on the link labeled "A.6.11.100.100"  

 ##ACTION: Test user move to production  
And I click on the link labeled "Project Setup"  
And I click on the button labeled "Move project to production"   
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "Yes, Move to Production Status" in the dialog box  

##VERIFY  
Then I should see "Project status: Production"    

##VERIFY_LOG  
When I click on the button labeled "Logging"
And I should see a table header and rows containing the following values in the logging table:
 | Username   | Action           | List of Data Changes OR Fields Exported |
 | test_user1 | Manage/Design    | Move project to Production status       |

