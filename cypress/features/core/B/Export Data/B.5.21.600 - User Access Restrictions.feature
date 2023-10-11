Feature: User Interface: The system shall support the ability to restrict users from exporting data.

As a REDCap end user
I want to see that export data is functioning as expected

Scenario: B.5.21.600.100 Restrict users from exporting data

#SETUP 
Given I login to REDCap with the user "Test_User1" 
And I create a new project named "B.5.21.600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_5.21.xml", and clicking the "Create Project" button

#FUNCTIONAL_REQUIREMENT
##ACTION: export CSV and confirm can export
When I click on the link labeled "Data Exports, Reports, and Stats" 
Then I should see a table row containing the following values in the reports table: 
| A | All data (all records and fields) | 

#VERIFY: can export
Given I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
And I click on the button labeled "Export Data" in the dialog box
Then I should see a dialog containing the following text: "Data export was successful!"

Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
Then I should have a "csv" file that contains the headings below
| record_id | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | data_types_timestamp | ptname | textbox | radio | notesbox | identifier | identifier_2 | date_ymd | datetime_ymd_hmss | date_types_complete |

#USER_RIGHTS
And I click on the link labeled "User Rights" 
And I click on the link labeled "Test_User1"
And I click on the button labeled "Assign to role" 
And I select "4_NoAccess_Noexport" on the dropdown field labeled "Select Role" on the role selector dropdown 
And I click on the button labeled exactly "Assign" on the role selector dropdown 
Then I should see "Test User1" within the "4_NoAccess_Noexport" row of the column labeled "Username" of the User Rights table 

#FUNCTIONAL_REQUIREMENT
##ACTION: export CSV and confirm can export
When I click on the link labeled "Data Exports, Reports, and Stats" 
Then I should see a table row containing the following values in the reports table: 
| A | All data (all records and fields) | 

#VERIFY: cannot see export
And I should NOT see a button labeled "Export data"
