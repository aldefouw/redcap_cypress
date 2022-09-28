Feature: Reporting

  As a REDCap end user
  I want to see that Reporting is functioning as expected

  Scenario: 1 - Navigate to the validation website's REDCap login page; Login as test_user

  Scenario: 1.5 - Upload the data dictionary
    Given I create a project named "22Reportingv913" with project purpose Operational Support via CDISC XML import from fixture location "core/post-production/reporting/22Reportingv913.xml"
    Given I visit Project ID 14
    Then I should see "22Reportingv913" in the title

  Scenario: 2 - Verify project complies with all setup steps in Test Requirements
    Given I visit Project ID 14

  Scenario: 3 - Create new report
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Create New Report"
    And I enter "Report 1" into the field labeled "Name of Report"
    And I click on the button labeled "Quick Add"
    And I click on the checkbox identified by "input[name=fname]"
    And I click on the checkbox identified by "input[name=lname]"
    And I click on the checkbox identified by "input[name=reminder]"
    And I click on the checkbox identified by "input[name=description]"
    And I should see the checkbox identified by "input[name=filter_type]", checked
    And I click on the button labeled "Close"
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    Given I click on the button labeled "View report"
    Then I should see the report with a column labeled "Record ID"
    Then I should see the report with a column labeled "First name"
    Then I should see the report with a column labeled "Last name"
    Then I should see the report with a column labeled "Reminder"
    Then I should see the report with a column labeled "Description"
    # verify 8 records
    Then I should see the report with 27 rows
    # Only 27 rows, should be 30 in the validation scenario (not sure)
    # verify 11 repeating rows

    # Validation Spec:
    # 8 columns with 5 report fields
    # 8 records
    # 19 rows
    # 11 Repeating Instrument rows
    When I click on the link labeled "Project Home"
    Then I should see "Report 1"

  Scenario: 4 - Verify Data in the report matches instrument data for Record 1, Event 1
    Given I visit Project ID 14
    And I click on the link labeled "Report 1"
    And I click on the record "1" link for the row containing "Event 1"
    Then I should see "Record Home Page"
    Then I should see "Record ID 1"
    Given I click on the image "circle_green" link for the row containing "Export"
    Then I should see the input field identified by "input[name=lname]" with the value "Test"
    Then I should see the input field identified by "input[name=fname]" with the value "One"
    Then I should see the input field identified by "input[name=dob]" with the value "06-17-2019"
    Then I should see the input field identified by "input[name=reminder]" with the value "reminder 1"

  Scenario: 5 - Verify Data in the report matches instrument data for Record 2, Event 2
    Given I visit Project ID 14
    And I click on the link labeled "Report 1"
    And I click on the record "2" link for the row containing "Repeating"
    Then I should see "Repeating"
    Then I should see "Editing existing Record ID 2"
    Then I should see the input field identified by "textarea[name=description]" with the value "record 2 event 2 a"
    And I click on the link labeled "Export"
    Then I should see the input field identified by "input[name=lname]" with the value ""
    Then I should see the input field identified by "input[name=fname]" with the value ""
    Then I should see the input field identified by "input[name=dob]" with the value ""
    Then I should see the input field identified by "input[name=reminder]" with the value ""

  Scenario: 6 - Export Report and verify CSV data
    Given I visit Project ID 14
    When I click on the link labeled "Report 1"
    Then I should see "CSV / Microsoft Excel (raw data)"
    Then I should see "CSV / Microsoft Excel (labels)"
    Then I should see "SPSS Statistical Software"
    Then I should see "SAS Statistical Software"
    Then I should see "R Statistical Software"
    Then I should see "Stata Statistical Software"
    Then I should see "CDISC ODM (XML)"

    Given I export data for the report named "Report 1" in "csvraw" format
    Then I should see "Data export was successful!"
    Then I should receive a download to a "csv" file
    Then I should have a "csv" file that contains the headings below
    | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | fname | lname | reminder | description |
    # verify 8 records
    Then I should have a "csv" file that contains 27 rows
    # verify 11 repeating rows
    # Validation Spec:
    # 8 records
    # 19 rows all repeating events
    # 11 Repeating Instrument rows
    
  Scenario: 7 - Edit Report: Remove Description, Don't show all events or repeating instruments
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Edit"
    And I click on the button labeled "Quick Add"
    And I click on the checkbox identified by "input[name=description]"
    Then I should see the checkbox identified by "input[name=description]", unchecked
    And I click on the button labeled "Close"
    And I click on the checkbox identified by "input[name=filter_type]"
    Then I should see the checkbox identified by "input[name=filter_type]", unchecked
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should NOT see "description"
    # verify 8 records
    Then I should see the report with 16 rows
    # verify 1 repeating row
    Then I should see the report with a column labeled "Record ID"
    Then I should see the report with a column labeled "First name"
    Then I should see the report with a column labeled "Last name"
    Then I should see the report with a column labeled "Reminder"
    # Validation Spec:
    # 7 columns with the 4 report fields
    # 8 records
    # 16 Rows, one repeating event

  Scenario: 8 - Edit Report: DOB, Event 1, DOB Ascending
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Edit"
    And I click on the button labeled "Quick Add"
    And I click on the checkbox identified by "input[name=dob]"
    And I click on the button labeled "Close"
    And I select "Event 1" from the dropdown identified by "select[id=filter_events]" for the "Filter by event" category
    And I select "dob" from the dropdown identified by "select[name='sort[]']" for the "First by" category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 8 rows
    # verify ascending dob
    # Validation Spec:
    # 8 records appear in ascending DOB order
  
  Scenario: 9 - Edit Report: DOB Descending
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I select "Descending order" from the dropdown identified by "select[name='sortascdesc[]']" for the "First by" category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 8 rows
    # verify descending dob
    # Validation Spec:
    # 8 records appear in descending DOB order

  Scenario: 10 - Edit Report: Filter DOB > 6/20/19
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I click on the button titled "View full list of fields" for the "Filter 1" category
    And I select "dob" from the dropdown identified by "select[name='limiter[]']" for the "Filter 1" category
    Then I should see the dropdown identified by "select[name='limiter_operator[]']" with the options below for the "Filter 1" category
    | = | not = | <  | < = | > | > = |
    And I select ">" from the dropdown identified by "select[name='limiter_operator[]']" for the "Filter 1" category
    And I enter "6/20/19" into the field labeled "M-D-Y"
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 4 rows
    # Validation Spec:
    # 4 records

  Scenario: 11 - Edit Report: Filter First name contains o
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I select "fname" from the dropdown identified by "select[name='limiter[]']" for the "Filter 1" category
    Then I should see the dropdown identified by "select[name='limiter_operator[]']" with the options below for the "Filter 1" category
    | = | not = | contains | does not contain | starts with | ends with |
    And I select "contains" from the dropdown identified by "select[name='limiter_operator[]']" for the "Filter 1" category
    And I enter "o" into the input field named "limiter_value[]" for the "Filter 1" category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 3 rows
    # Validation Spec:
    # 3 records

  Scenario: 12 - Edit Report: Filter First name OR DOB < 6/20/19
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I click on the button titled "View full list of fields" for the "Filter 2" category
    And I should see "Filter 2"
    And I select "dob" from the dropdown identified by "select[name='limiter[]']" for the "Filter 2" category
    And I select "<" from the dropdown identified by "select[name='limiter_operator[]']" for the "Filter 2" category
    And I enter "6/20/19" into the input field named "limiter_value[]" for the "Filter 2" category
    And I select "OR" from the dropdown identified by "select[name='limiter_group_operator[]']" for the "Filter 2" category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 4 rows
    # Validation Spec:
    # 4 records

  Scenario: 13 - Edit Report: Filter First name AND DOB < 6/20/19
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I select "AND" from the dropdown identified by "select[name='limiter_group_operator[]']" for the "Filter 2" category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 2 rows
    # Validation Spec:
    # 2 records

  Scenario: 14 - Copy Report, cancel
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Copy"
    
    And I click on the button labeled "Cancel" in the dialog box
    #reload the page instead of waiting for UI change
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should NOT see "Report 1 (copy)"

  Scenario: 15 - Copy Report, confirm
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Copy"
    
    And I click on the button labeled "Copy" in the dialog box
    #reload the page instead of waiting for UI change
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should see "Report 1 (copy)"

  Scenario: 16 - Delete Report, cancel
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Delete" for the report named "Report 1 (copy)"

    And I click on the button labeled "Cancel" in the dialog box
    #reload the page instead of waiting for UI change
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should see "Report 1 (copy)"

  Scenario: 17 - Delete Report, confirm
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Delete" for the report named "Report 1 (copy)"

    And I click on the button labeled "Delete" in the dialog box
    #reload the page instead of waiting for UI change
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should NOT see "Report 1 (copy)"

  Scenario: 18 - All data: View Report
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "View Report" for the report named "All data"
    Then I should see the report with 27 rows
    Then I should see the report with a column labeled "First name"
    Then I should see the report with a column labeled "Last name"
    Then I should see the report with a column labeled "Reminder"
    Then I should see the report with a column labeled "Description"

  Scenario: 19 - Edit User Privileges
    Given I visit Project ID 14
    And I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I click on the checkbox identified by "input[name=reports]"
    And I click on the button labeled "Save Changes"
    Then I should see "User \"test_user\" was successfully edited"

  Scenario: 20 - Verify Privileges
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should NOT see the buttons labeled Edit, Copy, and Delete

  Scenario: 21 - Logout