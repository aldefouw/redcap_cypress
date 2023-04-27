Feature: A.2.2.500 Add/Manage users

  As a REDCap end user
  I want to see that Users in tabular form is functioning as expected

  Scenario: A.2.2.500.100 Users in tabular form
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Users"
    Then I should see "User Search: Search for user by username, first name, last name, or primary email"

    When I click on the link labeled "View User List By Criteria"
    And I select "All users" on the dropdown field labeled "Display only:"
    And I click on the button labeled "Display User List"
    Then I should see "Loading..."
    And I should see "Test_Admin" in the browse users table