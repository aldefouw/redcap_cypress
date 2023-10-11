Feature: Project Level:  The system shall allow data entry form user access to be (No Access / Read Only / View & Edit / Edit survey responses)

As a REDCap end user
I want to see that data entry rights is functioning as expected

Scenario: B.2.6.200.100 Data Viewing Rights

#SETUP
Given I login to REDCap with the user "Test_Admin"  
And I create a new project named "B.2.6.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 

When I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production" 
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project status: Production"

When I click on the link labeled "User Rights" 
And I click on the button labeled "Upload or download users, roles, and assignments"
Then I should see "Upload users (CSV)"
Then I should see a dialog containing the following text: "Upload users (CSV)"


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

When I click on the link labeled "test_user1" 
And I click on the button labeled "Edit user privileges" 
Then I should see a dialog containing the following text: "Editing existing user" 

#FUNCTIONAL REQUIREMENT
##ACTION: Set user access to No Access

When I set Data Viewing Rights to No Access for the instrument "Text Validation" 
And I save changes within the context of User Rights 
##VERIFY_LOG: Verify Update user rights
And I click on the button labeled "Logging" 
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action    | List of Data Changes OR Fields Exported |
| test_admin | Add user       | user = 'test_user1'                           |


##ACTION #CROSS-FEATURE B.2.23.100: Verify Logging Filter by user name
When I select the "test_admin" option from the Filter by username dropdown field
##VERIFY_LOG #CROSS-FEATURE: Verify Logging Filter by user name
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action    | List of Data Changes OR Fields Exported |
| test_admin | Update user       | user = 'test_user1'                           |
And I logout 

Given I login to REDCap with the user "Test_User1" 
And I click on the link labeled "My Projects" 
And I click on the link labeled "B.2.6.200.100" 
##VERIFY: No access to Instrument
And I click on the link labeled "Record Status Dashboard" 
Then I should NOT see "Text Validation" 

Given I click on the link labeled "User Rights" 
And I click on the link labeled "test_user1" 
And I click on the button labeled "Edit user privileges" 
Then I should see a dialog containing the following text: "Editing existing user" 

##ACTION: Set user access to Read Only

When I set Data Viewing Rights to Read Only for the instrument "Text Validation" 
And I save changes within the context of User Rights 
Then I should see " User "test_user1" was successfully edited"

Given I click on the link labeled "Add / Edit Records" 
And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page 
Then I should see "Record Home Page" 

##VERIFY: Read Only for the instrument
When I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1" 
Then I should see "Text Validation" 
And I should NOT see a button labeled "Save & Exit Form" 

Given I click on the link labeled "User Rights" 
And I click on the link labeled "Test User1" 
And I click on the button labeled "Edit user privileges" 
Then I should see a dialog containing the following text: "Editing existing user" 

##ACTION: Set user access to View & Edit
When I set Data Viewing Rights to View & Edit for the instrument "Text Validation" 
##ACTION: Set user access to Edit survey responses
When I select Data Viewing Rights to View & Edit for the instrument "Text Validation"
And I verify Data Viewing Rights to View & Edit with Edit survey responses is checked for the instrument "Survey"
And I save changes within the context of User Rights
Then I should see "User "test_user1" was successfully edited" 

Given I click on the link labeled "Add / Edit Records" 
And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page 
Then I should see "Record Home Page" 

##VERIFY: View & Edit for the instrument
When I click the bubble for the "Text Validation" longitudinal instrument on event "Event 1" 
Then I should see "Text Validation" 
And I should see a button labeled "Save & Exit Form" 

When I click on the link labeled "Record ID" 
Then I should see "Record Home Page" 

##VERIFY: Edit survey responses for the instrument
When I click the bubble for the "Survey" longitudinal instrument on event "Event 3" 
And I click on the button labeled "Save & Stay"
And I select the dropdown option labeled "Open survey"
And I click on the button labeled "Submit"
And I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
Then I should see a Completed Survey Response icon for the instrument labeled "Survey" for event "Event Three"

When I click the bubble for the "Survey" longitudinal instrument on event "Event 3"
Then I should see "Survey response is editable" 
When I click the button "Edit response" 
Then I should see "now editing" 

Given I click on the link labeled "User Rights" 
And I click on the link labeled "Test_User1" 
And I click on the button labeled "Edit user privileges" 
Then I should see a dialog containing the following text: "Editing existing user" 

##ACTION: Remove user access to Edit survey responses
When I remove Data Viewing Rights to edit survey responses for the instrument "Survey" 
And I save changes within the context of User Rights 
Then I should see " User "test_user1" was successfully edited" 

##VERIFY: Not able to edit survey responses for the instrument
Given I click on the link labeled "Add / Edit Records" 
And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page 
Then I should see "Record Home Page" 
When I click the bubble to select a record for the "Survey" longitudinal instrument on event "Event 1" 
Then I should see "Survey response is read-only" 
