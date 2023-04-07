Feature: Reporting

  As a REDCap end user
  I want to see that Reporting is functioning as expected

  Scenario: Project Setup - 1
    Given I am a "standard" user who logs into REDCap
    Then I create a project named "Reporting Feature" with project purpose Operational Support via CDISC XML import from fixture location "cdisc_files/projects/DesignForms_v1115.xml"

  Scenario: Project Setup - 2
    Given I should see a link labeled "My Projects"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "Reporting Feature"

    When I click on the button labeled "Data Dictionary"
    And I upload the data dictionary located at "core/22_Reporting_DD.csv"
    Then I should see "Changes Made Successfully!"

  Scenario: Project Setup - 3
    When I click on the link labeled "Project Setup"
    And I should see that surveys are disabled
    And I should see that longitudinal mode is "enabled"

    Then I should see that auto-numbering is "enabled"
    Then I should see that the scheduling module is "disabled"
    Then I should see that the randomization module is "disabled"
    Then I should see that the designate an email field for communications setting is "disabled"

    And I click on the button labeled "Designate Instruments for My Events"

    And I enable the Data Collection Instrument named "Export" for the Event named "Event 1"
    And I disable the Data Collection Instrument named "Export" for the Event named "Event 2"
    And I enable the Data Collection Instrument named "Repeating" for the Event named "Event 1"
    And I enable the Data Collection Instrument named "Repeating" for the Event named "Event 2"

    When I click on the link labeled "Project Setup"

    And I open the dialog box for the Repeatable Instruments and Events module
    And I select "-- not repeating --" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)"
    And I select "Repeat Instruments (repeat independently of each other)" on the dropdown field labeled "Event 2 (Arm 1: Arm 1)"
    And I click on the button labeled "Save" on the dialog box for the Repeatable Instruments and Events module

    And I close the popup

    And I click on the button labeled "Define My Events"
    And I delete the Event Name of "Event Three"

    And I click on the link labeled "Arm 2:"
    And I click on the link labeled "Delete Arm 2"

  Scenario: Project Setup - 4
    Given I click on the link labeled "Data Import Tool"
    And I upload a "csv" format file located at "/import_files/core/22_Reporting_IMP.csv", by clicking the button near "Upload your CSV file:" to browse for the file, and clicking the button labeled "Upload File" to upload the file
    Then I should see "DATA DISPLAY TABLE"
    And I should see "(new record)"
    And I should see a button labeled "Import Data"

    When I click on the button labeled "Import Data"
    Then I should see "Import Successful!"
    And I should see "8"
    And I should see "records were created"

  Scenario: 1 - Navigate to the validation website's REDCap login page; Login as test_user
    Given I am a "standard" user who logs into REDCap

  Scenario: 2 - Verify project complies with all setup steps in Test Requirements
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Reporting Feature"
    Then I should see "Reporting Feature" in the title
    #Verification done in Project Setup - 3

  Scenario: 3 - Create new report
    When I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Create New Report"
    And I enter "Report 1" into the input field labeled "Name of Report"

    And I click on the button labeled "Quick Add"
    Then I should see a dialog containing the following text: "Quick Add"
    And I check the checkbox labeled "First name"
    And I check the checkbox labeled "Last name"
    And I check the checkbox labeled "Reminder"
    And I check the checkbox labeled "Description"
    And I click on the button labeled "Close" in the dialog box

    Then I should see "Additional report options"
    And I should see a checkbox labeled "Show data for all events" that is checked

    When I click on the button labeled "Save Report"
    Then I should see a dialog containing the following text: 'Your report has been saved!'

    Given I click on the button labeled "View report"
    Then I should see the report with a column labeled "Record ID"
    Then I should see the report with a column labeled "First name"
    Then I should see the report with a column labeled "Last name"
    Then I should see the report with a column labeled "Reminder"
    Then I should see the report with a column labeled "Description"
    Then I should see the report with 8 distinct records
    Then I should see the report with 19 rows
    Then I should see the report with 11 repeating instrument rows

    When I click on the link labeled "Project Home"
    Then I should see "Report 1"

  Scenario: 4 - Verify Data in the report matches instrument data for Record 1, Event 1
    Given I click on the link labeled "Report 1"
    And I click on the record "1" link for the row containing "Event 1"
    Then I should see "Record Home Page"
    Then I should see "Record ID 1"
    Given I click on the image "circle_green" link for the row containing "Export"
    Then I should see "Test" in the data entry form field labeled "Last name"
    And I should see "One" in the data entry form field labeled "First name"
    And I should see "06-17-2019" in the data entry form field labeled "DOB"
    And I should see "reminder 1" in the data entry form field labeled "Reminder"

  Scenario: 5 - Verify Data in the report matches instrument data for Record 2, Event 2
    Given I click on the link labeled "Report 1"
    And I click on the record "2" link for the row containing "Repeating"
    Then I should see "Repeating"
    Then I should see "Editing existing Record ID 2"
    And I should see "record 2 event 2 a" in the data entry form field labeled "Description"

  Scenario: 6 - Export Report and verify CSV data
    Given I click on the link labeled "Report 1"
    Then I should see "CSV / Microsoft Excel (raw data)"
    Then I should see "CSV / Microsoft Excel (labels)"
    Then I should see "SPSS Statistical Software"
    Then I should see "SAS Statistical Software"
    Then I should see "R Statistical Software"
    Then I should see "Stata Statistical Software"
    Then I should see "CDISC ODM (XML)"

    When I export data for the report named "Report 1" in "csvraw" format
    When I should see "Data export was successful!"
    Given I should receive a download to a "csv" file

    And I click on the button labeled "Close" in the dialog box

    Then I should have a "csv" file that contains the headings below
    | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | fname | lname | reminder | description |
    Then I should have a "csv" file that contains 8 distinct records
    Then I should have a "csv" file that contains 19 rows
    Then I should have a "csv" file that contains 11 repeating instrument rows

  Scenario: 7 - Edit Report: Remove Description, Don't show all events or repeating instruments
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Edit"

    And I click on the button labeled "Quick Add"
    Then I should see a dialog containing the following text: "Quick Add"
    And I uncheck the checkbox labeled "Description"
    #Then I should see the element identified by "input[name='field[]']" have length 5
    #check hidden element count, because the onclick function takes too long to finish. count includes itself
    And I click on the button labeled "Close"

    Given I see "Additional report options"
    And I uncheck the checkbox labeled "Show data for all events or repeating instruments for each record returned"
    And I click on the button labeled "Save Report"
    Then I should see a dialog containing the following text: 'Your report has been saved!'

    When I click on the button labeled "View report"
    Then I should NOT see "description"
    Then I should see the report with 8 distinct records
    Then I should see the report with 16 rows
    #Then I should see the report with 1 repeating instrument rows
    #above statement might be incorrect, says "only the first repeating event" in spec
    Then I should see the report with 0 repeating instrument rows
    Then I should see the report with a column labeled "Record ID"
    Then I should see the report with a column labeled "First name"
    Then I should see the report with a column labeled "Last name"
    Then I should see the report with a column labeled "Reminder"

  Scenario: 8 - Edit Report: DOB, Event 1, DOB Ascending
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Edit"
    And I click on the button labeled "Quick Add"
    Then I should see a dialog containing the following text: "Quick Add"
    And I check the checkbox labeled "DOB"
    And I click on the button labeled "Close"
    And I select "Event 1" on the multiselect field labeled "Filter by event"
    And I select "dob" on the dropdown field labeled "First by"
    And I click on the button labeled "Save Report"
    Then I should see a dialog containing the following text: 'Your report has been saved!'

    When I click on the button labeled "View report"
    Then I should see the report with 8 rows
    Then I should see the report with 8 distinct records
    Then I should see the report with the column named "DOB" ascending
  
  Scenario: 9 - Edit Report: DOB Descending
    Given I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I select "Descending order" on the dropdown field labeled "First by"
    And I click on the button labeled "Save Report"
    Then I should see a dialog containing the following text: 'Your report has been saved!'

    When I click on the button labeled "View report"
    Then I should see the report with 8 rows
    Then I should see the report with 8 distinct records
    Then I should see the report with the column named "DOB" descending

  Scenario: 10 - Edit Report: Filter DOB > 6/20/19
    Given I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I click on the button labeled "View full list of fields" for the row labeled "Filter 1"
    And I select "dob" on the dropdown field labeled "Filter 1"
    And I should see the dropdown field labeled "Filter 1" with the options below
    | = | not = | <  | < = | > | > = |
    And I select ">" on the dropdown field labeled "Filter 1"
    And I enter "6/20/19" into the input field labeled "M-D-Y"
    And I click on the button labeled "Save Report"
    Then I should see a dialog containing the following text: 'Your report has been saved!'

    When I click on the button labeled "View report"
    Then I should see the report with 4 rows
    Then I should see the report with 4 distinct records

  Scenario: 11 - Edit Report: Filter First name contains o
    Given I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I select "fname" on the dropdown field labeled "Filter 1"
    And I should see the dropdown field labeled "Filter 1" with the options below
    | = | not = | contains | does not contain | starts with | ends with |
    And I select "contains" on the dropdown field labeled "Filter 1"
    And I enter "o" into the input field labeled "Filter 1"
    And I click on the button labeled "Save Report"
    Then I should see a dialog containing the following text: 'Your report has been saved!'

    When I click on the button labeled "View report"
    Then I should see the report with 3 rows
    Then I should see the report with 3 distinct records

  Scenario: 12 - Edit Report: Filter First name OR DOB < 6/20/19
    Given I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I click on the button labeled "View full list of fields" for the row labeled "Filter 2"
    And I should see "Filter 2"
    And I select "dob" on the dropdown field labeled "Filter 2"
    And I select "<" on the dropdown field labeled "Filter 2"
    And I enter "6/20/19" into the input field labeled "Filter 2"
    And I select "OR" from the dropdown identified by "select[name='limiter_group_operator[]']" labeled "Filter 2"
    And I click on the button labeled "Save Report"
    Then I should see a dialog containing the following text: 'Your report has been saved!'

    When I click on the button labeled "View report"
    Then I should see the report with 4 rows
    Then I should see the report with 4 distinct records

  Scenario: 13 - Edit Report: Filter First name AND DOB < 6/20/19
    Given I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I select "AND" from the dropdown identified by "select[name='limiter_group_operator[]']" labeled "Filter 2"
    And I click on the button labeled "Save Report"
    Then I should see a dialog containing the following text: 'Your report has been saved!'

    When I click on the button labeled "View report"
    Then I should see the report with 2 rows
    Then I should see the report with 2 distinct records

  Scenario: 14 - Copy Report, cancel
    Given I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Copy"
    
    And I click on the button labeled "Cancel" in the dialog box
    #reload the page instead of waiting for UI change
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should NOT see "Report 1 (copy)"

  Scenario: 15 - Copy Report, confirm
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Copy"
    
    And I click on the button labeled "Copy" in the dialog box
    #reload the page instead of waiting for UI change
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should see "Report 1 (copy)"

  Scenario: 16 - Delete Report, cancel
    Given I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Delete" for the report named "Report 1 (copy)"

    And I click on the button labeled "Cancel" in the dialog box
    #reload the page instead of waiting for UI change
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should see "Report 1 (copy)"

  Scenario: 17 - Delete Report, confirm
    Given I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Delete" for the report named "Report 1 (copy)"

    And I click on the button labeled "Delete" in the dialog box
    #reload the page instead of waiting for UI change
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should NOT see "Report 1 (copy)"

  Scenario: 18 - All data: View Report
    Given I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "View Report" for the report named "All data"
    Then I should see the report with 19 rows
    Then I should see the report with a column labeled "First name"
    Then I should see the report with a column labeled "Last name"
    Then I should see the report with a column labeled "Reminder"
    Then I should see the report with a column labeled "Description"

  Scenario: 19 - Edit User Privileges
    Given I click on the link labeled "User Rights"
    And I remove the "Add/Edit/Organize Reports" user right to the user named "Test User" with the username of "test_user"
    Then I should see 'User "test_user" was successfully edited'

  Scenario: 20 - Verify Privileges
    Given I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should NOT see the buttons labeled Edit, Copy, and Delete

  Scenario: 21 - Logout
    Given I logout
    