Feature: A.2.3.200 Assign administrators and account managers

  As a REDCap end user
  I want to see that Assign Super Users / Account Managers is functioning as expected

  Scenario: A.2.3.200.100 Give/remove user admin user rights
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    Then I click on the link labeled "Administrator Privileges"
    And I should see "Set administrator privileges"

    Given I enter "Test_User1" into the field with the placeholder text of "Search users to add as admin"
    When I enable the Administrator Privilege "Set administrator privileges" for a new administrator
    And I click on the button labeled "Add"
    Then I should see 'The user "Test_User1" has now been granted one or more administrator privileges'
    And I click on the button labeled "OK"
    And I should see "Test_User1"

    Given I click on the link labeled "Control Center"
    When I click on the link labeled "Administrator Privileges"
    Then I should see "Set administrator privileges"
    And I should see "Test_User1"

    Given I logout
    When I login to REDCap with the user "Test_User1"
    Then I should see a link labeled "Control Center"

    Given I logout
    When I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Administrator Privileges"
    Then I should see "Set administrator privileges"

    Given I disable the Administrator Privilege "Set administrator privileges" for the administrator "Test_User1"
    Then I should see a dialog containing the following text: "Please be aware that you have unchecked ALL the administrator privileges for this user"

    Given I click on the button labeled "Close" in the dialog box
    When I click on the link labeled "Administrator Privileges"
    Then I should see "Set administrator privileges"
    And I should NOT see "Test_User1"

    Given I logout
    When I login to REDCap with the user "Test_User1"
    Then I should NOT see "Control Center"
