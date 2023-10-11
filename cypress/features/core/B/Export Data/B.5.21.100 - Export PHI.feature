Feature: User Interface: The system shall support the ability to identify data as containing a protected health information identifier.

As a REDCap end user
I want to see that export data is functioning as expected

#Scenario: B.5.21.100.100 Limit identified data export
##SETUP
#Given I login to REDCap with the user "Test_Admin"
#And I create a new project named "B.5.21.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_5.21.xml", and clicking the "Create Project" button
#
##SETUP_USER_RIGHTS
#When I click on the link labeled "User Rights"
#And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
#And I click on the button labeled "Assign to role"
#And I select "4_NoAccess_Noexport" on the dropdown field labeled "Select Role" on the role selector dropdown
#And I click on the button labeled exactly "Assign" on the role selector dropdown
#Then I should see "Test User1" within the "3_ReadOnly_Deidentified" row of the column labeled "Username" of the User Rights table
#
###VERIFY_CODEBOOK
#When I click on the link labeled "Codebook"
#Then I should see a table header and rows containing the following values in the codebook table:
#| Variable/Field Name | Field Label| Field Attributes (Field/Type, Validation, Choices, Calculations, etc. |
#| [identifier]                   | Identifier    |text, Identifier                                                                                             |
#| [identifier_2]              | Identifier 2  |text, Identifier                                                                                             |
#| [ptname]                     | Name          |text                                                                                                                |
#| [radio ]                         | radio           | radio, Identifier                                                                                          |
#
#
###ACTION: change identifier status
#When I click on the link labeled "Project Setup"
#And I click on the link labeled "Check for identifiers"
#Then I should see a table header and rows containing the following values in the codebook table:
#| Variable Name | Field Label| Identifier?|
#| identifier        | Identifier   |check icon |
#|  identifier_2  | Identifier  2|check icon |
#| ptname          | Name         |                   |
#| radio              | radio           | check icon|
#
#When I deselect the checkbox labeled "Identifier?" for the variable labeled "identifier_2"
#And I select the checkbox labeled "Identifier?" for the variable labeled "ptname"
#And I click on the button labeled "Update Identifiers"
#Then I should see a table header and rows containing the following values in the codebook table:
#| Variable Name | Field Label| Identifier?|
#| identifier        | Identifier   |check icon |
#|  identifier_2  | Identifier 2 |                    |
#| ptname          | Name         | check icon|
#| radio              | radio           | check icon|
#
###VERIFY_CODEBOOK
#When I click on the link labeled "Codebook"
#Then I should see a table header and rows containing the following values in the codebook table:
#| Variable/Field Name | Field Label| Field Attributes (Field/Type, Validation, Choices, Calculations, etc. |
#| [identifier]                   | Identifier   |text, Identifier                                                                                             |
#| [identifier_2]              | Identifier 2  |text                                                                                                               |
#| [ptname]                     | Name          | text, Identifier                                                                                            |
#| [radio ]                         | radio           | radio, Identifier                                                                                          |
#
#
###VERIFY_DE
#When I click on the link labeled "Data Exports, Reports, and Stats"
#Then I should see a table row containing the following values in the reports table:
#| A | All data (all records and fields) |
#
###ACTION: export all
#Given I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
#And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
#And I click on the button labeled "Export Data" in the dialog box
#Then I should see a dialog containing the following text: "Data export was successful!"
#
#Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
#
###VERIFY: User can see all variables, including identifier, identifier_2 and name, survey_timestamp, radio button
#Then I should have a "csv" file that contains the headings below
#| record_id | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | data_types_timestamp | pt_name | textbox | radio | notesbox | identifier | identifier_2 | date_ymd | datetime_ymd_hmss | date_types_complete |
##M: Close the report
#
#And I click on the button labeled "Close" in the dialog box
#
##FUNCTIONAL_REQUIREMENT
###ACTION: remove identifiers from export
#When I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
#And I click on the checkbox button labeled "Remove All Identifier Fields (tagged in Data Dictionary)"
#And I click on the checkbox button labeled "Hash the Record ID field (converts record name to an unrecognizable value)"
#And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
#And I click on the button labeled "Export Data" in the dialog box
#Then I should see a dialog containing the following text: "Data export was successful!"
#
#Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
#
###VERIFY: User can see all variables except for [identifier], [ptname], [radio], [redcap_survey_identifer] and check record id #ed
#Then I should have a "csv" file that contains the headings below
#| record_id | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | data_types_timestamp | textbox | notesbox | identifier_2 | date_ymd | datetime_ymd_hmss | date_types_complete |
#
##M: Close the report & refresh page
#
#And I click on the button labeled "Close" in the dialog box
#
##FUNCTIONAL_REQUIREMENT
###ACTION: add identifiers back and remove unvalidated texts fields and notesbox fields
#When I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
#And I deselect the checkbox button labeled "Remove All Identifier Fields (tagged in Data Dictionary)"
#And I deselect the checkbox button labeled "Hash the Record ID field (converts record name to an unrecognizable value)"
#And I click on the checkbox button labeled "Remove unvalidated Text fields (i.e. Text fields other than dates, numbers, etc.)"
#And I click on the checkbox button labeled "Remove Notes/Essay box fields"
#And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
#And I click on the button labeled "Export Data" in the dialog box
#Then I should see a dialog containing the following text: "Data export was successful!"
#
#Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
###VERIFY: User can see all variables except for unvalidated fields and notes fields
#Then I should have a "csv" file that contains the headings below
#| record_id | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | data_types_timestamp | radio | date_ymd | datetime_ymd_hmss | date_types_complete |
#
##M: Close the report & refresh page
#
#And I click on the button labeled "Close" in the dialog box
#
#FUNCTIONAL_REQUIREMENT
###ACTION: remove date, datetime fields
#When I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
#And I click on the checkbox button labeled "Remove all date and datetime fields"
#And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
#And I click on the button labeled "Export Data" in the dialog box
#Then I should see a dialog containing the following text: "Data export was successful!"
#
#Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
###VERIFY: User can see all variables except for date and datetime fields
#Then I should have a "csv" file that contains the headings below
#| record_id | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | data_types_timestamp | pt_name | textbox | radio | notesbox | identifier | identifier_2 | date_types_complete |
#
##M: Close the report & refresh page
#
#And I click on the button labeled "Close" in the dialog box
#
###ACTION: create record and enter dates in survey mode
#When I click the link labeled "Add/Edit Records"
#And I click the button labeled "Add new record "
#Then I should see "Adding new Record ID 5"
#
#When I click on the button labeled "Save & Stay"
#And I select the dropdown option labeled "Open survey" on the dropdown button labeled "Survey Options"
#Then I should see "Please complete the survey below"
#And I should see "2023-08-22" for the field labeled "date YMD"
#And I should see "2023-08-22 10:50:40" for the field labeled "datetime YMD HMSS"
#
#When I click on the button labeled "Submit"
#And I click on the button labeled "Close Survey"
#And I click on the button labeled "Leave without saving changes" in the dialog box
#Then I should see "Record Home Page"
#And I should see a Completed Survey Response Icon for the field the instrument labeled "Data Types"
#FUNCTIONAL_REQUIREMENT
###ACTION: shift all dates
#Given I click on the link labeled "Data Exports, Reports, and Stats"
#When I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
#And I click on the checkbox button labeled "Shift all dates by value between 0 and 364 days"
#And I click on the checkbox button labeled "Also shift all survey completion timestamps by value between 0 and 364 days"
#And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
#And I click on the button labeled "Export Data" in the dialog box
#Then I should see a dialog containing the following text: "Data export was successful!"
#And I should see "All dates within your data have been DATE SHIFTED to an unknown value between 0 and 364 days."
#
#Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
###VERIFY:
##MUser can see all variables with dates shifted ([date_ymd]=! 2023-08-22) AND ([date_ymd_hmss]=! 2023-08-23 11:48:01)
#
#Then I should have a "csv" file
#And I verify that the timestamp in the column labeled "data_types_timestamp" for record 5 has shifted
#And I verify that the date in the column labeled "date_ymd" for record 5 has shifted
#And I verify that the datetime in the column labeled "date_ymd_hmss" for record 5 has shifted
#
##M: Close the report & refresh page
#
#And I click on the button labeled "Close" in the dialog box
#And I logout
#Given I login to REDCap with the user "Test_User1"
#When I click on the link labeled "B.5.21.100.100"
#When I click on the link labeled "Data Exports, Reports, and Stats"
##FUNCTIONAL_REQUIREMENT
###ACTION: limited access
#Then I should see a table row containing the following values in the reports table:
#| A | All data (all records and fields) |
#
#And I should NOT see a button labeled "Export Data" for "All data (all records and fields)" report in the My Reports & Exports table

