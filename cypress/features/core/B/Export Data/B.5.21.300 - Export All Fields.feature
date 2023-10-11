Feature: User Interface: The system shall allow for exporting every field in a database.

As a REDCap end user
I want to see that export data is functioning as expected

Scenario: B.5.21.300.100 Export all fields
#SETUP 
Given I login to REDCap with the user "Test_Admin" 
And I create a new project named "B.5.21.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_5.21.xml", and clicking the "Create Project" button

#FUNCTIONAL_REQUIREMENT
##ACTION: export CSV and confirm column
When I click on the link labeled "Data Exports, Reports, and Stats" 
Then I should see a table row containing the following values in the reports table: 
| A | All data (all records and fields) | 

Given I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
And I click on the button labeled "Export Data" in the dialog box
Then I should see a dialog containing the following text: "Data export was successful!"

Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box

##VERIFY: 
Then I should have a "csv" file that contains the headings below
| record_id | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | data_types_timestamp | pt_name | textbox | radio | notesbox | identifier | identifier_2 | date_ymd | datetime_ymd_hmss | date_types_complete |
#M: Close the report

And I click on the button labeled "Close" in the dialog box
