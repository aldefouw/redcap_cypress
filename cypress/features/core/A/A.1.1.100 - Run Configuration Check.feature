Feature: A.1.1.100 Run Configuration Check test page

  As a REDCap end user
  I want to see that Configuration Checklist is functioning as expected

  Scenario: A.1.1.100.100 Configuration Checklist Tests

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    Then I should be able to locate and visit the Control Center link labeled "Browse Projects"
    And I should be able to locate and visit the Control Center link labeled "Edit a Project's Settings"
    And I should be able to locate and visit the Control Center link labeled "Configuration Check"
    And I should be able to locate and visit the Control Center link labeled "General Configuration"
    And I should be able to locate and visit the Control Center link labeled "Security & Authentication"
    And I should be able to locate and visit the Control Center link labeled "User Settings"
    And I should be able to locate and visit the Control Center link labeled "File Upload Settings"
    And I should be able to locate and visit the Control Center link labeled "Field Validation Types"

    When I click on the link labeled "Configuration Check"
    Then I should see "Configuration Check"
    And I should see "TEST 1"
    And I should see "TEST 2"
    And I should see "TEST 3"
    And I should see "TEST 4"
    And I should see "TEST 5"
    And I should see "TEST 6"