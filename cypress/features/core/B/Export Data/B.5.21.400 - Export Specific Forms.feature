Feature: User Interface: The system shall support the ability to select specific forms to export.

As a REDCap end user
I want to see that export data is functioning as expected

#Scenario: B.5.21.400.100 Export select forms
#
##SETUP
#Given I login to REDCap with the user "Test_Admin"
#And I create a new project named "B.5.21.400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
##FUNCTIONAL_REQUIREMENT
###ACTION: export CSV and confirm column
#When I click on the link labeled "Data Exports, Reports, and Stats"
#Then I should see a table row containing the following values in the reports table:
#| A | All data (all records and fields) |
#
#Given I click on the "Make custom selections" button for "Selected instruments and/or events (all records)" report in the My Reports & Exports table
#When I select the dropdown option labeled "Text Validation" from the dropdown labeled "Instruments"
#And I select the dropdown option labeled "Event (Arm 1: Arm 1)" from the dropdown labeled "Events"
#And I click on the button labeled "Export Data"
#And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
#And I click on the button labeled "Export Data" in the dialog box
#Then I should see a dialog containing the following text: "Data export was successful!"
#
#
#Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
#Then I should have a "csv" file that contains the headings below
#| record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | name | email | text_validation_complete |
#
#And I click on the button labeled "Close" in the dialog box

