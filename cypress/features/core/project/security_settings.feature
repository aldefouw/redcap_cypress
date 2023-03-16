Feature: Security Settings

  As a REDCap end user
  I want to see that Security Settings is functioning as expected

  Scenario: Project Setup 1 - Create 12_SecuritySettings_v1115 and add admin as user to 
    Given I am an "standard" user who logs into REDCap
    And I create a project named "Security Settings Feature" with project purpose Operational Support via CDISC XML import from fixture location "cdisc_files/projects/DesignForms_v1115.xml"

    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Security Settings Feature"
    And I click on the link labeled "User Rights"

    And I enter "test_admin" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    Then I should see a dialog containing the following text: "Adding new user"

    Given I save changes within the context of User Rights
    Then I should see "test_admin (Test User)"

  Scenario: 1 - System Status
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "Server configuration settings"
    Then I should see "System Status"
    Then I should see the dropdown field labeled "System Status" with the option "SYSTEM ONLINE" selected

  Scenario: 2 - System Offline and Custom Message
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    And I select "SYSTEM OFFLINE" on the dropdown field labeled "System Status"
    And I enter "This is a test of Vanderbilt REDCap<br> System is offline and will be back on-line shortly." into the field identified by "textarea[name=system_offline_message]"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    And I logout

  Scenario: 3 - Check System Status as Standard User
    Given I am a "standard" user who logs into REDCap
    Then I should see "This is a test of Vanderbilt REDCap"
    Then I should see "System is offline and will be back on-line shortly."

  Scenario: 4 - Check System Status as Admin
    #Given I simulate re-launching the browser
    Given I am an "admin" user who logs into REDCap
    Then I should see "REDCap and all its projects are currently OFFLINE and are not accessible to normal users."
    Then I should see "You can return the REDCap system back to"
    Then I should see "ONLINE status in the"
    #not sure why i have to split it like this? invisible character?
				
  Scenario: 5 - System Online
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    And I select "SYSTEM ONLINE" on the dropdown field labeled "System Status"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    And I logout

  Scenario: 6 - Check System Status as User
    Given I am a "standard" user who logs into REDCap
    Then I should NOT see "This is a test of Vanderbilt REDCap"
    Then I should NOT see "System is offline and will be back on-line shortly."
    
  Scenario: 7 - Check System Status as Admin
    Given I am an "admin" user who logs into REDCap
    Then I should NOT see "REDCap and all its projects are currently OFFLINE and are not accessible to normal users."
    Then I should NOT see "You can return the REDCap system back to"
    Then I should NOT see "ONLINE status in the"
  
  Scenario: 8 - Project Offline
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "Edit a Project's Settings"
    Then I should see "Edit a Project's Settings"
    Then I should see "Choose an existing project to edit its settings:"
    And I select "Security Settings Feature" from the dropdown identified by "select"
    Then I should see "Security Settings Feature"
    And I select "OFFLINE" on the dropdown field labeled "Online Status of Project"
    And I click on the button labeled "Save Changes"
    Then I should see "Your changes have been saved!"
    And I logout

  Scenario: 9 - Check Project Status as Standard User
    Given I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    Then I should see "Security Settings Feature"
    Then I should see "OFFLINE"
    And I click on the link labeled "Security Settings Feature"
    Then I should see "This REDCap project is currently offline."
    Then I should see "Please return to this project at another time."
    Then I should see "We apologize for any inconvenience."
    Then I should see "You may click the REDCap logo above to return to the My Projects page."

  Scenario: 10 - Check Project Status as Admin User
    #Given I simulate re-launching the browser
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"

    And I click on the link labeled "Security Settings Feature"
    Then I should see "This project is currently OFFLINE and is not accessible to normal users. You can return it back to ONLINE status in the"
    Then I should see "This project is currently OFFLINE and is not accessible to normal users."
    Then I should see "You can return it back to"
    Then I should see "ONLINE status in the"

  Scenario: 11 - Set Project Online 
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "Edit a Project's Settings"
    Then I should see "Edit a Project's Settings"
    Then I should see "Choose an existing project to edit its settings:"
    And I select "Security Settings Feature" from the dropdown identified by "select"
    Then I should see "Security Settings Feature"
    And I select "ONLINE" on the dropdown field labeled "Online Status of Project"
    And I click on the button labeled "Save Changes"
    Then I should see "Your changes have been saved!"
    And I logout
  
  Scenario: 12 - Check Project Status as Admin
    Given I am an "admin" user who logs into REDCap
    Given I click on the link labeled "My Projects"
    Then I should NOT see "OFFLINE"
    And I click on the link labeled "Security Settings Feature"
    Then I should NOT see "This project is currently OFFLINE and is not accessible to normal users."
    Then I should NOT see "You can return it back to"
    Then I should NOT see "ONLINE status in the"
    And I click on the link labeled "My Projects"
    #Not sure why the test spec wants us to browse back to My Projects
    And I logout

Scenario: 13 - Check Project Status as Standard User
    Given I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    Then I should see "Security Settings Feature"
    Then I should NOT see "OFFLINE"
    And I click on the link labeled "Security Settings Feature"
    Then I should NOT see "This REDCap project is currently offline."
    Then I should NOT see "Please return to this project at another time."
    Then I should NOT see "We apologize for any inconvenience."
    Then I should NOT see "You may click the REDCap logo above to return to the My Projects page."
    And I logout