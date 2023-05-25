Feature: A.2.3.400 Assign administrators and account managers

  As a REDCap end user
  I want to see that Assign Super Users / Account Managers is functioning as expected

  Scenario: A.2.3.400.100 Give and remove user maximum user privileges
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Administrator Privileges"
    Then I should see "Set administrator privileges"

    When I enter "test_user1_cypress" into the field with the placeholder text of "Search users to add as admin"
    And I enable the Administrator Privilege "Set administrator privileges" for a new administrator
    And I enable the Administrator Privilege "Access to all projects and data" for a new administrator
    And I enable the Administrator Privilege "Manage user accounts" for a new administrator
    And I enable the Administrator Privilege "Perform REDCap upgrades" for a new administrator
    And I enable the Administrator Privilege "Install, upgrade, and configure" for a new administrator
    And I enable the Administrator Privilege "Modify system configuration pages" for a new administrator
    And I enable the Administrator Privilege "Access to Control Center dashboards" for a new administrator
    And I click on the button labeled "Add"
    Then I should see 'The user "test_user1_cypress" has now been granted one or more administrator privileges'
    And I click on the button labeled "OK" in the dialog box

    Given I logout
    And I login to REDCap with the user "Test_User1"
    And I click on the link labeled "Control Center"
    Then I should see "Control Center Home"
    And I should see a link labeled "Browse Projects"
    And I should see a link labeled "Browse Users"
    And I should see a link labeled "General Configuration"

    Given I logout
    And I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Administrator Privilege"
    Then I should see "Set administrator privileges"
    When I disable the Administrator Privilege "Set administrator privileges" for the administrator "test_user1_cypress"
    And I disable the Administrator Privilege "Access to all projects and data" for the administrator "test_user1_cypress"
    And I disable the Administrator Privilege "Manage user accounts" for the administrator "test_user1_cypress"
    And I disable the Administrator Privilege "Perform REDCap upgrades" for the administrator "test_user1_cypress"
    And I disable the Administrator Privilege "Install, upgrade, and configure" for the administrator "test_user1_cypress"
    And I disable the Administrator Privilege "Modify system configuration pages" for the administrator "test_user1_cypress"
    And I disable the Administrator Privilege "Access to Control Center dashboards" for the administrator "test_user1_cypress"
    Then I should see a dialog containing the following text: "NOTICE"
    And I should see a dialog containing the following text: "Please be aware that you have unchecked ALL the administrator privileges for this user"
    And I click on the button labeled "Close" in the dialog box

    Given I logout
    And I login to REDCap with the user "Test_User1"
    Then I should NOT see "Control Panel"
    And I logout