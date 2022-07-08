Feature: Configuration Checklist

  As a REDCap end user
  I want to see that Configuration Checklist is functioning as expected

Background:
    Given I am an "admin" user who logs into REDCap
    And I visit the "Control Center" page
    And I click on the link labeled "Configuration Check"

Scenario: Configuration Checklist Tests
  Then I should see "Configuration Check"
  And I should see "TEST 1"
  And I should see "TEST 2"
  And I should see "TEST 3"
  And I should see "TEST 4"
  And I should see "TEST 5"
  And I should see "TEST 6"