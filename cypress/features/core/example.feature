Feature: Configuration

  As an administrator
  I want to see that appropriate configurations are available to me

  Background:
    Given I am an "admin" user who logs into REDCap
    And I visit the "Control Center"

  Scenario Outline: Control Center contains the appropriate links under "Control Center Home" heading
    Then I should be able to locate and visit the Control Center link labeled "<link>" and see the title "<title>"

    Examples:
      |link|title|
      |Notifications & Reporting||
      |Notifications & Reporting|Notifications|
      |To-Do List||

  Scenario Outline: Control Center contains the appropriate links under "Dashboard" heading
    Then I should be able to locate and visit the Control Center link labeled "<link>" and see the title "<title>"

    Examples:
      |link|title|
      |System Statistics||
      |Activity Log||
      |Activity Graphs|View graphs for:|
      |Map of Users||

  Scenario Outline: Control Center contains the appropriate links under "Projects" heading
    Then I should be able to locate and visit the Control Center link labeled "<link>" and see the title "<title>"

    Examples:
      |link|title|
      |Browse Projects||
      |Edit a Project's Settings||

  Scenario Outline: Control Center contains the appropriate links under "Users" heading
    Then I should be able to locate and visit the Control Center link labeled "<link>" and see the title "<title>"

    Examples:
      |link|title|
      |Browse Users||
      |Add Users|   |
      |User Whitelist||
      |Email Users||
      |API Tokens||
      |Administrators & Acct Managers|Designating REDCap Administrators and Account Managers|

  Scenario Outline: Control Center contains the appropriate links under "Miscellaneous Modules" heading
    Then I should be able to locate and visit the Control Center link labeled "<link>" and see the title "<title>"

    Examples:
      |link|title|
      |Custom Application Links||
      |Publication Matching||
      |Dynamic Data Pull||
      |Find Calculation Errors in Projects||

  Scenario Outline: Control Center contains the appropriate links under "Technical / Developer Tools" heading
    Then I should be able to locate and visit the Control Center link labeled "<link>" and see the title "<title>"

    Examples:
      |link|title|
      |MySQL Dashboard||
      |API Documentation||
      |Plugin & Hook Documentation||

  Scenario Outline: Control Center contains the appropriate links under "System Configuration" heading
    Then I should be able to locate and visit the Control Center link labeled "<link>" and see the title "<title>"

    Examples:
      |link|title|
      |Configuration Check||
      |General Configuration||
      |Security & Authentication||
      |User Settings||
      |File Upload Settings||
      |Modules Configuration||
      |Field Validation Types||
      |Home Page Settings|Home Page Configuration|
      |Project Templates||
      |Default Project Settings||
      |Footer Settings||
      |Cron Jobs||