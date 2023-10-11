Feature: A.2.2.600 Add/Manage users

  As a REDCap end user
  I want to see that Users failed login lockout is functioning as expected.

  Scenario: A.2.2.600.100 User account locked out after too many attempts
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see "Security & Authentication Configuration"

    When I clear the field labeled "Number of failed login attempts before user is locked out for a specified amount of time, which is set below."
    And I enter "1" into the input field labeled "Number of failed login attempts before user is locked out for a specified amount of time, which is set below."
    And I clear the field labeled "Amount of time user will be locked out after having failed login attempts exceeding the limit set above."
    And I enter "2" into the input field labeled "Amount of time user will be locked out after having failed login attempts exceeding the limit set above."
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I enter "Test_User1" into the input field labeled "Username:"
    And I enter "test" into the input field labeled "Password:"
    And I click on the button labeled "Log In"
    Then I should see "ERROR: You entered an invalid user name or password!"

    Given I enter "Test_User1" into the input field labeled "Username:"
    And I enter "test" into the input field labeled "Password:"
    And I click on the button labeled "Log In"
    Then I should see "ACCESS DENIED!"

    Given I wait for 2 minutes

    Given I login to REDCap with the user "Test_User1"
    And I see "My Projects"
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Security & Authentication"
    Then I should see "Security & Authentication Configuration"

    When I clear the field labeled "Number of failed login attempts before user is locked out for a specified amount of time, which is set below."
    And I enter "2" into the input field labeled "Number of failed login attempts before user is locked out for a specified amount of time, which is set below."
    And I clear the field labeled "Amount of time user will be locked out after having failed login attempts exceeding the limit set above."
    And I enter "1" into the input field labeled "Amount of time user will be locked out after having failed login attempts exceeding the limit set above."
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I enter "Test_User1" into the input field labeled "Username:"
    And I enter "test" into the input field labeled "Password:"
    And I click on the button labeled "Log In"
    Then I should see "ERROR"

    Given I enter "Test_User1" into the input field labeled "Username:"
    And I enter "test" into the input field labeled "Password:"
    And I click on the button labeled "Log In"
    Then I should see "ERROR"

    Given I enter "Test_User1" into the input field labeled "Username:"
    And I enter "test" into the input field labeled "Password:"
    And I click on the button labeled "Log In"
    Then I should see "ACCESS DENIED!"

    Given I wait for 1 minute

    Given I login to REDCap with the user "Test_User1"
    And I see "My Projects"
    Given I logout
    
