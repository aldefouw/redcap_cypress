Feature: Configuration

  As an administrator
  I want to see that appropriate configurations are available to me

  Background:
    Given I am an "admin" user who logs into REDCap
    And I visit the "Control Center"
    And I

  Scenario: Control Center contains the appropriate links under "Control Center Home" heading
    Then I should be able to locate and visit the Control Center link labeled "Notifications & Reporting" and see the title "Notifications"
    And I should be able to locate and visit the Control Center link labeled "To-Do List"

  Scenario: Control Center contains the appropriate links under "Dashboard" heading
    Then I should be able to locate and visit the Control Center link labeled "System Statistics"
    And I should be able to locate and visit the Control Center link labeled "Activity Graphs" and see the title "View graphs for:"
    And I should be able to locate and visit the Control Center link labeled "Map of Users"

  Scenario: Control Center contains the appropriate links under "Projects" heading
    Then I should be able to locate and visit the Control Center link labeled "Browse Projects"
    And I should be able to locate and visit the Control Center link labeled "Edit a Project's Settings"

  Scenario: Control Center contains the appropriate links under "Users" heading
    Then I should be able to locate and visit the Control Center link labeled "Browse Users"
    And I should be able to locate and visit the Control Center link labeled "Add Users (Table-based Only)" and see the title "User Managment for Table-based Authentication"

  Scenario: Control Center contains the appropriate links under "Miscellaneous Modules" heading
    Then I should be able to locate and visit the Control Center link labeled "Clinical Data Interoperability Services" and see the title "Clinical Data Interoperability Services"

  Scenario: Control Center contains the appropriate links under "Technical / Developer Tools" heading

  Scenario: Control Center contains the appropriate links under "System Configuration" heading