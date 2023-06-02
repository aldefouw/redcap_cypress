Feature: A.2.3.300 Assign administrators and account managers

  As a REDCap end user
  I want to see that Assign Super Users / Account Managers is functioning as expected

  Scenario: A.2.3.300.100 Modify and Revoke Admin’s User Rights
    Given I login to REDCap with the user "Test_Admin"
    And I visit the "Control Center" page
    And I visit the "Administrator Privileges"
    Then I should see "Set administrator privileges"

    When I enter "Test_User1" into the field with the placeholder text of "Search users to add as admin"
    And I enable the Administrator Privilege "Set administrator privileges" for a new administrator
    And I click on the button labeled "Add"
    Then I should see 'The user "Test_User1" has now been granted one or more administrator privileges'
    And I click on the button labeled "OK"
    And I should see "Test_User1"

    When I visit the "Control Center" page
    And I visit the "Administrator Privileges"
    Then I should see "Set administrator privileges"
    And I enable the Administrator Privilege "Manage user accounts" for the administrator "Test_User1"
    And I enable the Administrator Privilege "Modify system configuration pages" for the administrator "Test_User1"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I visit the "Control Center" page
    Then I should see "Control Center Home"
    And I should see a link labeled "Browse Projects"
    And I should see a link labeled "Browse Users"
    And I should see a link labeled "Multi-Language Management "
    And I should see a link labeled "General Configuration"
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    And I visit the "Control Center" page
    And I visit the "Administrator Privileges"
    Then I should see "Set administrator privileges"

    When I disable the Administrator Privilege "Set administrator privileges" for the administrator "Test_User1"
    And I disable the Administrator Privilege "Access to all projects and data" for the administrator "Test_User1"
    And I disable the Administrator Privilege "Manage user accounts" for the administrator "Test_User1"
    And I disable the Administrator Privilege "Perform REDCap upgrades" for the administrator "Test_User1"
    And I disable the Administrator Privilege "Install, upgrade, and configure" for the administrator "Test_User1"
    And I disable the Administrator Privilege "Modify system configuration pages" for the administrator "Test_User1"
    And I enable the Administrator Privilege "Access to Control Center dashboards" for the administrator "Test_User1"
    Then I should see a dialog containing the following text: "NOTICE"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    Then I should see "Control Center Home"