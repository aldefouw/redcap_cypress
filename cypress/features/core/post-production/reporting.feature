Feature: Reporting

  As a REDCap end user
  I want to see that Reporting is functioning as expected

  Scenario: 1 - The project exists and was created from copy of pre req 7

  Scenario: 2 - Upload the data dictionary
    Given I upload the Data Dictionary for the project "22Reportingv913"
    Then I should see "22Reportingv913" in the title
"""
  Scenario: 3 - Project Setup

  Scenario: A standard user creates, views, and adds report to navigation panel
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Create New Report"
    And I enter "Report 1" into the field labeled "Name of Report"
    And I click on the button labeled "Quick Add"
    #Then I should see a new dialog box named "quickAddField_dialog"

    And I click on the input checkbox labeled "fname"
    And I click on the input checkbox labeled "lname"
    And I click on the input checkbox labeled "reminder"
    And I click on the input checkbox labeled "description"
    And I click on the button labeled "Close"
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    Given I click on the button labeled "View report"
    Then I should see the report with 27 rows

    When I click on the link labeled "Project Home"
    Then I should see "Report 1"

  Scenario: A standard user edits a report
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Edit"
    And I click on the button labeled "Quick Add"
    And I click on the input checkbox labeled "description"
    And I click on the button labeled "Close"
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 16 rows
    # 8 Records
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
    And I click on the button labeled "Delete" for the report named "Report 1"

    And I click on the button labeled "Delete" in the dialog box
    #reload the page instead of waiting for UI change
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should NOT see "Report 1 (copy)"


  Scenario: A standard user reviews all records/events/repeating events data
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    
    When I click on the button labeled "View Report"
    Then I should see the report with 27 rows
    # 8 Records
    # 27 Rows

  Scenario: A standard user disables report privileges
    Given I visit Project ID 14
    And I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I click on the input checkbox labeled "reports"
    And I click on the button labeled "Save Changes"

    And I click on the link labeled "Data Exports, Reports, and Stats" 
    Then I should NOT see the buttons labeled Edit, Copy, and Delete

    Given I visit Project ID 14
    And I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I click on the input checkbox labeled "reports"
    And I click on the button labeled "Save Changes"

  Scenario: A standard user filters and sorts a report
    # Eventually split up this Scenario, long runtime causes unexpected crashes
    Given I visit Project ID 14
    And I click on the link labeled "Data Exports, Reports, and Stats" 
    And I click on the button labeled "Edit" for the report named "Report 1"
    And I click on the button labeled "Quick Add"
    And I click on the input checkbox labeled "dob"
    And I click on the button labeled "Close"
    And I select the option labeled "Event 1" for the "Filter by event" category
    And I select the option labeled "dob" for the "First by" category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 8 rows
    # 8 rows
    # dob ascending


    And I click on the button labeled "Edit Report"
    And I select the option labeled "Descending order" for the "First by" category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 8 rows
    # 8 rows
    # dob descending

    And I click on the button labeled "Edit Report"
    And I click on the button titled "View full list of fields" for the "Filter 1" category
    And I select the option labeled "dob" for the "Filter 1" category
    And I select the option labeled ">" for the "Filter 1" category
    And I enter "6/20/19" into the field labeled "M-D-Y"
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 4 rows
    # 4 rows

    And I click on the button labeled "Edit Report"
    And I select the option labeled "fname" for the "Filter 1" category
    And I select the option labeled "contains" for the "Filter 1" category
    And I enter "o" into the input field named "limiter_value[]" for the "Filter 1" category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 3 rows
    # 3 rows

    And I click on the button labeled "Edit Report"
    And I click on the button titled "View full list of fields" for the "Filter 2" category
    And I should see "Filter 2"
    And I select the option labeled "dob" for the "Filter 2" category
    And I select the option labeled "<" for the "Filter 2" category
    And I enter "6/20/19" into the input field named "limiter_value[]" for the "Filter 2" category
    And I select the option labeled "OR" for the "Filter 2" category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 8 rows
    # 8 rows

    And I click on the button labeled "Edit Report"
    And I select the option labeled "AND" for the "Filter 2" category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see the report with 2 rows
    # 2 rows

    And I click on the button labeled "Edit Report"
    And I select the option labeled "lname" for the "Filter 1" category
    And I select the option labeled "not =" for the "Filter 1" category
    And I enter "Test" into the input field named "limiter_value[]" for the "Filter 1" category
    And I click on the Delete image for the "Filter 2" filter category
    And I click on the button labeled "Save Report"
    Then I should see a new dialog box named "report_saved_success_dialog"

    When I click on the button labeled "View report"
    Then I should see "No results were returned"
"""

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
