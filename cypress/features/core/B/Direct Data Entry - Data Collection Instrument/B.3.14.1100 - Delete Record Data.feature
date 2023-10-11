Feature: Deleting Data: The system shall allow users to delete all data in an event for a given record.

As a REDCap end user
I want to see that delete all data is functioning as expected

Scenario: B.3.14.1100.100 Delete all data in an event for a given record

#SETUP 
Given I login to REDCap with the user "Test_User1" 
And I create a new project named "B.3.14.1100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button
 
#SETUP_PRODUCTION 
When I click on the link labeled "Project Setup" 
And I click on the button labeled "Move project to production"  
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box 
Then I should see "Project status: Production" 
 
#SET UP_USER_RIGHTS 
When I click on the link labeled "User Rights" 
And I click on the link labeled "Test_User1" 
And I click on the button labeled "Assign to role" 
And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
And I click on the button labeled exactly "Assign" on the role selector dropdown
Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table 
 
#FUNCTIONAL_REQUIREMENT
When I click on the link labeled "Record Status Dashboard"
And I click on record "1"
##ACTION delete this event
And I click on the "delete this event" icon on the field labeled "Delete all data on event:" for event "Event 1"
And I click on the button labeled "Delete this event" in the dialog box
#VERIFY
Then I should see the "Incomplete (no data saved)" status icon for the "Text Validation" longitudinal instrument on event "Event 1" for record "1"
And I should see the "Incomplete (no data saved)" status icon for the "Data Types" longitudinal instrument on event "Event 1" for record "1"
And I should see the "Incomplete (no data saved)" status icon for the "Consent" longitudinal instrument on event "Event 1" for record "1"
 
#VERIFY_LOG:
When I click on the link labeled "Logging"
Then I should see table rows including the following values in the logging table: 
| Username  |           Action            | List of Data Changes OR Fields Exported|
| test_user1 | Update record 1     | calc_test = ''|
| test_user1 | Update record 1     |calculated_field = '' |
| test_user1 | Update record 1     |calculated_field_2 = ''|
| test_user1 | Update record 1     |data_types_complete = '' |
| test_user1 | Update record 1     |dob = '' |
| test_user1 | Update record 1     |email = '' |
| test_user1 | Update record 1     |email_consent = '' |
| test_user1 | Update record 1     |name_consent = '' |
| test_user1 | Update record 1     |text_validation_complete = '' |

##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats" 
Then I should see a table row containing the following values in the reports table: 
| A | All data (all records and fields) | 
 
When I click on the button labeled "View Report" 
Then I should NOT see data for event "Event 1" for record "1"

