Feature: A.2.3.200 Assign administrators and account managers

  As a REDCap end user
  I want to see that Assign Super Users / Account Managers is functioning as expected

  Scenario: A.2.3.200.100 Give/remove user admin user rights
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
    And I should see "Test_User1"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    Then I do see the "Control Center" page
    Logout as "Test_User1" user

    Given I login to REDCap with the user "Test_Admin"
    And I visit the "Control Center" page
    And I visit the "Administrator Privileges"
    Then I should see "Set administrator privileges"

    When I enable the Administrator Privilege "Modify system configuration pages" for the administrator "Test_User1"
    And I disable the Administrator Privilege "Access to all projects and data with maximum user privileges" for the administrator "Test_User1"
    Then I should see a dialog containing the following text: "NOTICE"
    And I should see a dialog containing the following text: "Please be aware that you have unchecked ALL the administrator privileges for this user"
    And I click on the button labeled "Close" in the dialog box

    When I visit the "Administrator Privileges"
    Then I should see "Set administrator privileges"
    And I should NOT see "Test_User1"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    Then I do NOT see the "Control Center" page
