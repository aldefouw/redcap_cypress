Feature: A.2.2.300 Add/Manage users Control Center - Users: The system shall support the ability to search for individual users and view/edit user information for username, first name, last name and/or primary email.

  As a REDCap end user
  I want to see that Search Users is functioning as expected.

  Scenario: A.2.2.300.100 Search by username, first name, last name and/or primary email

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Users"
    And I click on the link labeled "View User List By Criteria"
    Then I should see "View User List By Criteria"

    #FUNCTIONAL REQUIREMENT
    ##ACTION Search by username with "Keyword search"
    #Username is Test_Admin
    When I enter "Test_Admin" into the field with the placeholder text of "Keyword search"
    And I click on the button labeled "Display User List"
    #VERIFY_SEARCH
    Then I should see a table header and rows containing the following values in the browse users table:
      | Username   | First Name   | Last Name  | Email                |
      | test_admin | Admin        | User       | test_admin@test.edu |


    #FUNCTIONAL REQUIREMENT
    ##ACTION Search by First Name with "Keyword search"
    When I click on the link labeled "View User List By Criteria"
    And I enter "Admin" into the field with the placeholder text of "Keyword search"
    And I click on the button labeled "Display User List"
    Then I should see a table header and rows containing the following values in the browse users table:
      | Username   | First Name   | Last Name  | Email                |
      | test_admin | Admin        | User       | test_admin@test.edu |

    #FUNCTIONAL REQUIREMENT
    ##ACTION Search by Last Name with "Keyword search"
    When I click on the link labeled "View User List By Criteria"
    And I enter "Test" into the field with the placeholder text of "Keyword search"
    And I click on the button labeled "Display User List"
    Then I should see a table header and rows containing the following values in the browse users table:
      | Username   | First Name   | Last Name  | Email                |
      | test_admin | Admin        | User       | test_admin@test.edu |

    #FUNCTIONAL REQUIREMENT
    ##ACTION Search by Email with "Keyword search"
    When I click on the link labeled "View User List By Criteria"
    And I enter "test_admin@test.edu" into the field with the placeholder text of "Keyword search"
    And I click on the button labeled "Display User List"
    Then I should see a table header and rows containing the following values in the browse users table:
      | Username   | First Name   | Last Name  | Email                |
      | test_admin | Admin        | User       | test_admin@test.edu |