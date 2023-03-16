Feature: Configuration Check

  As a REDCap end user
  I want to see that Configuration Check is functioning as expected

  Scenario: 1 - Home Page - Visible Tabs
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "Control Center"
    Then I should see a link labeled "My Projects"
    And I should see a link labeled "New Project"
    And I should see a link labeled "Help & FAQ"
    And I should see a link labeled "Control Center"

  Scenario: 2a - Control Center Link Visibility for Projects
    Then I should be able to locate and visit the Control Center link labeled "Browse Projects"
    And I should be able to locate and visit the Control Center link labeled "Edit a Project's Settings"

  Scenario: 2b - Control Center Link Visibility for Users
    Then I should be able to locate and visit the Control Center link labeled "Browse Users"
    And I should be able to locate and visit the Control Center link labeled "Administrator Privileges"

  Scenario: 2c - Control Center Link Visibility for System Configuration
    Then I should be able to locate and visit the Control Center link labeled "Browse System Configuration"
    And I should be able to locate and visit the Control Center link labeled "Configuration Check"
    And I should be able to locate and visit the Control Center link labeled "General Configuration"
    And I should be able to locate and visit the Control Center link labeled "Security & Authentication"
    And I should be able to locate and visit the Control Center link labeled "User Settings"
    And I should be able to locate and visit the Control Center link labeled "File Upload Settings"
    And I should be able to locate and visit the Control Center link labeled "Field Validation Types"

  Scenario: 3 - Configuration Checklist Tests
    When I click on the link labeled "Configuration Check"
    Then I should see "Configuration Check"
    And I should see "TEST 1"
    And I should see "TEST 2"
    And I should see "TEST 3"
    And I should see "TEST 4"
    And I should see "TEST 5"
    And I should see "TEST 6"