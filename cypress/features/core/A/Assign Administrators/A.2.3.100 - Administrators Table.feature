Feature: A.2.3.100 Assign administrators and account managers

  As a REDCap end user
  I want to see that Control Center is functioning as expected

  Scenario: A.2.3.100.100 View administrator accounts
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Administrator Privileges"
    Then I should see "Set administrator privileges"
    And I should see a table header and rows containing the following values in the administrators table:
      | Administrators          |
      | Test_Admin (Admin User) |
