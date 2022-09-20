Feature: Reporting

  As a REDCap end user
  I want to see that Reporting is functioning as expected

  Scenario: 1 - The project exists and was created from copy of pre req 7

  Scenario: 2 - Upload the data dictionary
    Given I create a project named "22Reportingv913" with project purpose Operational Support via CDISC XML import from fixture location "core/post-production/reporting/22Reportingv913.xml"
    Given I visit Project ID 14
    Then I should see "22Reportingv913" in the title

  Scenario: 3 - Project Setup

  Scenario: A standard user creates, views, and adds report to navigation panel
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Create New Report"
    And I enter "Report 1" into the field labeled "Name of Report"
    And I click on the button labeled "Quick Add"

    And I click on the checkbox identified by "input[name=fname]"
    And I click on the checkbox identified by "input[name=lname]"
    And I click on the checkbox identified by "input[name=reminder]"
    And I click on the checkbox identified by "input[name=description]"
    And I click on the button labeled "Close"
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    Given I click on the button labeled "View report"
    Then I should see the report with 27 rows
    # 27 rows

    When I click on the link labeled "Project Home"
    Then I should see "Report 1"

  Scenario: A standard user edits a report
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Edit"
    And I click on the button labeled "Quick Add"
    And I click on the checkbox identified by "input[name=description]"
    Then I should see the checkbox identified by "input[name=description]", unchecked
    And I click on the button labeled "Close"
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should NOT see "description"
    Then I should see the report with 16 rows
    # 16 Rows

  Scenario: A standard user copies a report
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Copy"
    
    And I click on the button labeled "Copy" in the dialog box
    #reload the page instead of waiting for UI change
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should see "Report 1 (copy)"

  Scenario: A standard user deletes a report
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Delete" for the report named "Report 1 (copy)"

    And I click on the button labeled "Delete" in the dialog box
    #reload the page instead of waiting for UI change
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should NOT see "Report 1 (copy)"

  Scenario: A standard user reviews all records/events/repeating events data
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    
    When I click on the button labeled "View Report"
    Then I should see the report with 27 rows
    # 27 Rows

  Scenario: A standard user disables report privileges
    Given I visit Project ID 14
    And I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I click on the checkbox identified by "input[name=reports]"
    And I click on the button labeled "Save Changes"

    And I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should NOT see the buttons labeled Edit, Copy, and Delete

    Given I visit Project ID 14
    And I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I click on the checkbox identified by "input[name=reports]"
    And I click on the button labeled "Save Changes"

  Scenario: A standard user filters events and sorts a report
    # Eventually split up this Scenario, long runtime causes unexpected crashes
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I click on the button labeled "Quick Add"
    And I click on the checkbox identified by "input[name=dob]"
    And I click on the button labeled "Close"
    And I select "Event 1" from the dropdown identified by "select[id=filter_events]" for the "Filter by event" category
    And I select "dob" from the dropdown identified by "select[name='sort[]']" for the "First by" category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 8 rows
    # 8 rows
    # dob ascending

    And I click on the button labeled "Edit Report"
    And I select "Descending order" from the dropdown identified by "select[name='sortascdesc[]']" for the "First by" category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 8 rows
    # 8 rows
    # dob descending

Scenario: A standard user filters a report using a greater than criterion
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I click on the button titled "View full list of fields" for the "Filter 1" category
    And I select "dob" from the dropdown identified by "select[name='limiter[]']" for the "Filter 1" category
    And I select ">" from the dropdown identified by "select[name='limiter_operator[]']" for the "Filter 1" category
    And I enter "6/20/19" into the field labeled "M-D-Y"
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 4 rows
    # 4 rows
    
Scenario: A standard user filters a report by text
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I select "fname" from the dropdown identified by "select[name='limiter[]']" for the "Filter 1" category
    And I select "contains" from the dropdown identified by "select[name='limiter_operator[]']" for the "Filter 1" category
    And I enter "o" into the input field named "limiter_value[]" for the "Filter 1" category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 3 rows
    # 3 rows

Scenario: A standard user filters a report using text or a less than criterion
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
    Then I should see the report with 8 rows
    # 8 rows

Scenario: A standard user filters a report using text and a less than criterion
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I select "AND" from the dropdown identified by "select[name='limiter_group_operator[]']" for the "Filter 2" category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 2 rows
    # 2 rows

Scenario: A standard user filters a report using text with a not equals criterion
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I select "lname" from the dropdown identified by "select[name='limiter[]']" for the "Filter 1" category
    And I select "not =" from the dropdown identified by "select[name='limiter_operator[]']" for the "Filter 1" category
    And I enter "Test" into the input field named "limiter_value[]" for the "Filter 1" category
    And I click on the Delete image for the "Filter 2" filter category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 8 rows
    #Then I should see "No results were returned"

Scenario: A standard user exports data for a report
    Given I visit Project ID 14
    Given I export data for the report named "All data" in "csvraw" format
    Then I should receive a download to a "csv" file

    And I click on the button labeled "Close"

    When I export data for the report named "All data" in "spss" format
    Then I should receive a download to a "sps" file
    
    And I click on the button labeled "Close"

    When I export data for the report named "All data" in "sas" format
    Then I should receive a download to a "sas" file

    And I click on the button labeled "Close"

    When I export data for the report named "All data" in "r" format
    Then I should receive a download to a "r" file

    And I click on the button labeled "Close"

    When I export data for the report named "All data" in "stata" format
    Then I should receive a download to a "do" file

    And I click on the button labeled "Close"

    When I export data for the report named "All data" in "odm" format
    Then I should receive a download to a "odm" file