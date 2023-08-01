Feature: A.2.2.800 Add/Manage users

  As a REDCap end user
  I want to see that amount of inactivity time before auto logout time is functioning as expected.

  Scenario: A.2.2.800.100 User account locked time

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see "Security & Authentication Configuration"

    When I clear the field labeled "Auto logout time"
    And I enter "2" into the input field labeled "Auto logout time"
    And I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    And I see "My Projects"
    Given I wait for 2 minutes
    Then I should see "REDCap Auto Logout Warning"

    Given I login to REDCap with the user "Test_User1"
    And I see "My Projects"
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see "Security & Authentication Configuration"

    When I clear the field labeled "Auto logout time"
    And I enter "1" into the input field labeled "Auto logout time"
    And I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    And I see "My Projects"
    Given I wait for 1 minutes
    Then I should see "REDCap Auto Logout Warning"

    Given I login to REDCap with the user "Test_User1"
    And I see "My Projects"
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see "Security & Authentication Configuration"

    When I clear the field labeled "Auto logout time"
    And I enter "20" into the input field labeled "Auto logout time"
    And I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout