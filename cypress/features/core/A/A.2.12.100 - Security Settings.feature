Feature: A.2.12.100 Security Settings

  As a REDCap end user
  I want to see that system status is functioning as expected

  Scenario: A.2.12.100.100 System Status Online/Offline
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Server configuration settings"
    Then I should see "System Status"
    Then I should see the dropdown field labeled "System Status" with the option "SYSTEM ONLINE" selected
    When select "SYSTEM OFFLINE" on the dropdown field labeled "System Status"
    And I see "This is a test.  The Vanderbilt REDCap System is offline and will be back online shortly." into the field identified by "textarea[name=system_offline_message]"

    # Field may be identified by “Custom message to display to users when system is offline:”
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    When I logout 

    #Test REDCap offline for Standard User
    Given I login to REDCap with the user “Test_User1”
    Then I should see " This is a test.  The Vanderbilt REDCap System is offline and will be back online shortly."
    When I logout

    #Test REDCap offline for Admin User
    #Given I simulate re-launching the browser
    Given I login to REDCap with the user "Test_Admin"
    Then I should see "REDCap and all its projects are currently OFFLINE and are not accessible to normal users."
    And I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Server configuration settings"
    Then I should see "System Status"
    When select "SYSTEM ONLINE" on the dropdown field labeled "System Status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    #Test REDCap online for “Test_User1”
    Given I login to REDCap with the user “Test_User1”
    Then I should see “My Projects”