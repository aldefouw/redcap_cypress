Feature: Field Validation

  As a REDCap end user
  I want to see that Field Validation is functioning as expected

  Scenario: Project Setup

    Given I am a "admin" user who logs into REDCap
    And I visit the "field validation" page
    # Then I should see that the "date_dmy" validation type is "disabled"
    # Then I should see that the "datetime_mdy" validation type is "disabled"
    # Then I should see that the "datetime_seconds_ymd" validation type is "disabled"
    # Then I should see that the "email" validation type is "disabled"
    # Then I should see that the "integer" validation type is "disabled"
    # Then I should see that the "number" validation type is "disabled"
    # Then I should see that the "number_1dp_comma_decimal" validation type is "disabled"
    # Then I should see that the "time" validation type is "disabled"

    When I visit Project ID 13
    And I click on the link labeled "Add / Edit Records"
    Then I should see "Total records: 0"

    When I click on the link labeled "Project Setup"
    # Then I should see that surveys are "disabled"
    # And I should see that longitudinal mode is "disabled"
    # And I should see that repeatable instruments are "disabled"
    And I should see that the optional module "auto-numbering" is "enabled"
