Feature: User Interface: The system shall support the ability to limit access to the Record Locking Customization module through user rights.

As a REDCap end user
I want to see that Record locking and E-signatures is functioning as expected

Scenario: C.2.19.900.100 Enable user rights for Record Locking Customization module 

#SETUP 
Given I login to REDCap with the user "Test_User1" 
And I create a new project named "C.2.19.900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

#USER_RIGHTS
When I click on the link labeled "User Rights"  
And I click on the link labeled "Test_User1" 
And I click on the button labeled "Edit user privileges" 
Then I should see "Editing existing user "test_user1"" 

When I click on the checkbox for the field labeled "Record Locking Customization"
And I click on the radio labeled "Locking / Unlocking with E-signature authority" for the field labeled "Lock / Unlock Records (instrument level)"
And I click on the button labeled "Close" in the dialog box
And I click on the checkbox for the field labeled "Lock/Unlock *Entire* Records (record level)"
And I click on the button labeled "Save changes" 
 Then I should see "User "test_user1" was successfully edited"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action                       | List of Data Changes OR Fields Exported |
| test_user1 | Update user test_user1 | user = 'test_user1'|

And I should see the link labeled "Customize and Manage the Record Locking and E-signature Functionality"

##ACTION verify Record Locking Customization module enabled in Dev
Open Customize & Manage Locking/E-signatures
##VERIFY
When I click on the link labeled "Customize and Manage the Record Locking and E-signature Functionality"
Then I should see "Customize and Manage the Record Locking and E-signature Functionality"

##USER_RIGHTS
Check Record Locking Customization module disabled
When I click on the link labeled "User Rights"  
And I click on the link labeled "Test_User1" 
And I click on the button labeled "Edit user privileges" 
Then I should see "Editing existing user "test_user1"" 

When I deselect the checkbox for the field labeled "Record Locking Customization"
And I click on the radio labeled "Disabled" for the field labeled "Lock / Unlock Records (instrument level)"
And I verify the checkbox for the field labeled "Lock/Unlock *Entire* Records (record level)" is not checked
And I click on the button labeled "Save Changes" 
Then I should see "User "test_user1" was successfully edited"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action                       | List of Data Changes OR Fields Exported |
| test_user1 | Update user test_user1 | user = 'test_user1'|

##VERIFY
And I should NOT see the link labeled "Customize and Manage the Record Locking and E-signature Functionality"

##SETUP_PRODUCTION
When I click on the link labeled "Project Setup" 
And I click on the button labeled "Move project to production"  
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box 
Then I should see "Project status: Production" 

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action              | List of Data Changes OR Fields Exported |
| test_user1 | Manage/Design | Move project to Production status|

##VERIFY: Look for Record Locking Customization module (not there)
And I should NOT see the link labeled "Customize and Manage the Record Locking and E-signature Functionality"

#FUNCTIONAL REQUIREMENT
##USER_RIGHTS
Check Record Locking Customization module disabled
When I click on the link labeled "User Rights"  
And I click on the link labeled "Test_User1" 
And I click on the button labeled "Edit user privileges" 
Then I should see "Editing existing user "test_user1"" 
And I verify the checkbox for the field labeled "Record Locking Customization" is not checked
And I verify the radio button labeled "Disabled" is selected for the field labeled "Lock / Unlock Records (instrument level)"
And I verify the checkbox for the field labeled "Lock/Unlock *Entire* Records (record level)" is not checked

##USER_RIGHTS
When I click on the checkbox for the field labeled "Record Locking Customization"
And I click on the radio labeled "Locking / Unlocking with E-signature authority" for the field labeled "Lock / Unlock Records (instrument level)"
And I click on the button labeled "Close" in the dialog box
And I click on the checkbox for the field labeled "Lock/Unlock *Entire* Records (record level)"
And I click on the button labeled "Save Changes" 
 Then I should see "User "test_user1" was successfully edited"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action                       | List of Data Changes OR Fields Exported |
| test_user1 | Update user test_user1 | user = 'test_user1'|

##ACTION verify Record Locking Customization module enabled in prod
Open Customize & Manage Locking/E-signatures
And I should see the link labeled "Customize and Manage the Record Locking and E-signature Functionality"
