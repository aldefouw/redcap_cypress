Feature: Creating a Record and Entering Data: The system shall support the ability to create a record

As a REDCap end user
I want to see that record creation is functioning as expected

Scenario: B.3.14.100.100 Create new record
#SETUP_PRODUCTION
Given I login to REDCap with the user "Test_Admin"   
And I create a new project named " B.3.14.100.100 " by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button 

When I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production" 
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I see "Project status:  Production"

##SETUP_USER_RIGHTS 
When I click on the link labeled "User Rights" 
And I enter "Test_User1" into the field with the placeholder text of "Add new user" 
And I click on the button labeled "+ Add with custom rights"
And I uncheck the User Right named "Create Records"
And I check the User Right named "Logging"
And I click on the button labeled "Add user"
Then I should see "Test User1"

#FUNCTIONAL REQUIREMENT
##ACTION: create record
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Text Validation for event "Event 1" 
And I click the button labeled "Save and Exit Form"
##VERIFY
Then I should see "Record ID 7 successfully added"

##VERIFY_LOG:
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action           | 
| test_admin | Create record 7 | 

##VERIFY_RSD:
When I click the link labeled "Record Status Dashboard"
And I click the record labeled "7"
Then I should see "Record ID 7"

##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:  
| A | All data (all records and fields) |  
  
When I click on the button labeled "View Report"  
Then I should see a table header and rows including the following values in the report data table:  
| Record ID|
| 7               |

And I logout

##ACTION: login as user without create record access - but can edit record
Given I login to REDCap with the user "Test_User1"   
When I click on the link labeled "My Projects"  
And I click on the link labeled "B.3.14.100.100"  
And click on the link labeled "View / Edit Records"
##VERIFY: Cannot add record 
Then I should NOT see the button labeled "Add new record for the arm selected above"

##VERIFY Can edit existing record
When I click on the dropdown field with the placeholder text of "select record"
And I select the dropdown option labeled "1"
And I click the bubble labeled "Text Validation for event "Event 1"
And I enter "Edit" on the field labeled "Name"
And I click on the button labeled "Save & Exit Form"
Then I should see "Record ID 1 successfully edited"

##VERIFY_LOG: Existing record updated
And I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action           | List of Data Changes OR Fields Exported |
| test_user1  | Update record 1| name = 'EDIT' | 
