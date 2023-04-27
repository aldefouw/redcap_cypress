Feature: A.2.2.300 Add/Manage users

  As a REDCap end user
  I want to see that Search Users is functioning as expected.

  Scenario: A.2.2.300.100 Search by username, first name, last name and/or primary email

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link "Control Center"
    And I click on the link "Browse Users"
    And I click on the link “View User List by Criteria”
    Then I should see "View User List By Criteria"

    #Username is Test_Admin
    When I enter "Test_Admin" into the input field labeled "Keyword Search"
    And I click on the button labeled “Display User List”
    Then I should see a row labeled "Test_Admin" in the browse users table

    #First Name is Admin
    When I click on the link “View User List by Criteria”
    And I enter "Admin" into the input field labeled "Keyword Search"
    And I click on the button labeled “Display User List”
    Then I should see a row labeled "Admin" in the browse users table

    #Last Name is Test
    When I click on the link “View User List by Criteria”
    And I enter "Test" into the input field labeled "Keyword Search"
    And I click on the button labeled “Display User List”
    Then I should see a row labeled "Test" in the browse users table

    #Email is test_admin@test.edu
    When I click on the link “View User List by Criteria”
    And I enter "test_admin@test.edu" into the input field labeled "Keyword Search"
    And I click on the button labeled “Display User List”
    Then I should see a row labeled "test_admin@test.edu" in the browse users table