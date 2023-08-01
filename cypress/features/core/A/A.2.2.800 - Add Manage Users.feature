Feature: A.2.2.800 Add/Manage users

  As a REDCap end user
  I want to see that amount of inactivity time before auto logout time is functioning as expected.

  Scenario: A.2.2.800.100 User account locked time

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see "Security & Authentication Configuration"

    When I clear the field labeled "Auto logout time"
    And I enter "4" into the input field labeled "Auto logout time"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    And I see "My Projects"

    Given I wait for 2 minutes
    Then I should see a dialog containing the following text: "REDCap Auto Logout Warning"

    Given I wait for another 2 minutes
    Then I should see a dialog containing the following text: "Due to inactivity, your REDCap session has expired"

    Given I click on the button labeled "Log In" in the dialog box
    Then I should see "Please log in with your user name and password."

    Given I login to REDCap with the user "Test_User1"
    And I see "My Projects"
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see "Security & Authentication Configuration"

    When I clear the field labeled "Auto logout time"
    And I enter "3" into the input field labeled "Auto logout time"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    Given I wait for 2 minutes
    Then I should see a dialog containing the following text: "REDCap Auto Logout Warning"

    Given I wait for 1 minute
    Then I should see a dialog containing the following text: "Due to inactivity, your REDCap session has expired"

    Given I click on the button labeled "Log In" in the dialog box
    Then I should see "Please log in with your user name and password."

    Given I login to REDCap with the user "Test_User1"
    And I see "My Projects"
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see "Security & Authentication Configuration"

    When I clear the field labeled "Auto logout time"
    And I enter "20" into the input field labeled "Auto logout time"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout