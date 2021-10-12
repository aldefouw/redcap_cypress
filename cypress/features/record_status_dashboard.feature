Feature: Record Status Dashboard

  As a user
  I want to see that the Record Status Dashboard functions correctly

  Scenario: A standard user visits a project with no records
    Given I am a "standard" user who logs into REDCap
    And I visit Project ID 1

    When I click on the link labeled "Add / Edit Records"
    Then I should see "Total records: 0"

    When I click on the link labeled "Record Status Dashboard"
    Then I should see "No records exist yet"

  Scenario: A standard user visits a project with a record

    Given I am a "standard" user who logs into REDCap
    And I visit Project ID 1

    When I click on the link labeled "Record Status Dashboard"
    And I click on the button labeled "Add new record"
    And I click on the bubble for the "Demographics" data collection instrument
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Study ID 1 successfully added"

    When I click on the link labeled "Add / Edit Records"
    And I should see "Total records: 1"

    When I click on the link labeled "Record Status Dashboard"
    Then I should NOT see "No records exist yet"