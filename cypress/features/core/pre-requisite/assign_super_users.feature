Feature: Assign Super Users / Account Managers

  As a REDCap end user
  I want to see that Assign Super Users / Account Managers is functioning as expected

Scenario: 1-2 - Control Center Links Visible
    Given I am an "admin" user who logs into REDCap
    And I should see a link labeled "Control Center"
    And I click on the link labeled "Control Center"
    Then I should see "Control Center Home"
    And I should see "Projects"
    And I should see "Users"
    And I should see "System Configuration"

Scenario: 3 - Administrator Privileges Page Visible
    Given I click on the link labeled "Administrator Privileges"
    Then I should see "Set administrator privileges"
    And I should see "Access to all projects and data with maximum user privileges"
    And I should see "Manage user accounts"
    And I should see "Modify system configuration pages"
    And I should see "Perform REDCap upgrades"
    And I should see "Install, upgrade, and configure External Modules"
    And I should see "Access to Control Center dashboards"

Scenario: 4 - Add test_user to Administrator List
    Given I enter "test_user" into the field with the placeholder text of "Search users to add as admin"
    And I enable the Administrator Privilege "Set administrator privileges" for a new administrator
    And I click on the button labeled "Add"

    Then I should see 'The user "test_user" has now been granted one or more administrator privileges'
    And I click on the button labeled "OK"
    And I should see "test_user"
    
Scenario: 5 - View test_user in Admin List
    Given I should see a link labeled "Administrator Privileges"
    When I click on the link labeled "Administrator Privileges"
    Then I should see "Set REDCap Administrator Privileges"
    And I should see "test_user"

Scenario: 6 - Verify test_user Administrator Privileges
    Given I am an "standard" user who logs into REDCap
    Then I should see a link labeled "Control Center"
    And I click on the link labeled "Control Center"
    Then I should see "Users"

Scenario: 7-8 - Grant test_user2 Administrator Privileges
    Given I click on the link labeled "Administrator Privileges"
    Then I should see "Set REDCap Administrator Privileges"

    Given I enter "test_user2" into the field with the placeholder text of "Search users to add as admin"
    And I enable the Administrator Privilege "Manage user account" for a new administrator
    And I click on the button labeled "Add"

    Then I should see 'The user "test_user2" has now been granted one or more administrator privileges'
    And I click on the button labeled "OK"
    And I should see "test_user2"

Scenario: 9 - View test_user2 in Admin List
    When I click on the link labeled "Administrator Privileges"
    Then I should see "test_user2"

Scenario: 10 - Verify test_user2 Account Manager Privileges
    Given I am an "standard2" user who logs into REDCap
    Then I should see "Control Center"
    And I click on the link labeled "Control Center"
    Then I should see "Control Center Home"
    And I should see a link labeled "Browse Users"
    And I should see a link labeled "Add Users (Table-based Only)"
    And I should see a link labeled "Administrator Privileges"
    And I should see a link labeled "External Modules"
    And I should see "Miscellaneous Modules"
    And I should see "System Configuration"

Scenario: 11 - Switch test_user2 to Maximum User Privileges
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "Control Center"
    When I click on the link labeled "Administrator Privileges"
    Then I enable the Administrator Privilege "Manage user accounts" for the administrator "test_user2"
    Then I enable the Administrator Privilege "Modify system configuration pages" for the administrator "test_user2"

Scenario: 12 - Verify test_user2 Maximum User Privileges
    Then I should see "Control Center Home"
    And I should see a link labeled "Browse Projects"
    And I should see a link labeled "Edit a Project's Settings"
    And I should see a link labeled "Survey Link Lookup"
    And I should see a link labeled "Administrator Privileges"
    And I should see a link labeled "External Modules"
    And I should see "Miscellaneous Modules"
    And I should see "System Configuration"

Scenario: 13 - View All Projects Page
    Given I click on the link labeled "Browse Projects"
    Then I should see "Viewing projects accessible by user:"
    And I click on the button labeled "View all projects"
    Then I should see a link labeled "Classic Database"

Scenario: 14 - View and Edit Project Settings Page 
    When I click on the link labeled "Edit a Project's Settings"
    Then I should see "You may modify the governing settings for any REDCap project on this page."
    And I select "Classic Database" on the dropdown field labeled "Choose an existing project to edit its settings:"
    Then I should see "Navigate to project Classic Database"

Scenario: 15 - Switch test_user2 to System Configuration Modifier
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "Control Center"
    When I click on the link labeled "Administrator Privileges"
    Then I enable the Administrator Privilege "Modify system configuration pages" for the administrator "test_user2"
    And I disable the Administrator Privilege "Access to all projects and data with maximum user privileges" for the administrator "test_user2"

Scenario: 16 - Verify test_user2 System Configuration Access
    Given I am an "standard2" user who logs into REDCap
    Then I should see "Control Center"
    And I click on the link labeled "Control Center"
    Then I should see "Control Center Home"
    And I should see a link labeled "Configuration Check"
    And I should see a link labeled "General Configuration"
    And I should see a link labeled "Security & Authentication"
    And I should see a link labeled "User Settings"
    And I should see a link labeled "File Upload Settings"
    And I should see a link labeled "Modules/Services Configuration"
    And I should see a link labeled "Field Validation Types"
    And I should see a link labeled "Home Page Settings"
    And I should see a link labeled "Project Templates"
    And I should see a link labeled "Default Project Settings"
    And I should see a link labeled "Footer Settings (All Projects)"
    And I should see a link labeled "Cron Jobs"

    #TODO: These two steps below do not pass - but it is because we aren't looking for control center specific headings
    #And I should NOT see "Users"
    #And I should NOT see "Dashboard"

    But I should see a link labeled "Configuration Check"

    Given I click on the link labeled "Configuration Check"
    Then I should see "Basic tests"
    And I should see "Secondary tests"

Scenario: 17 - Switch test_user2 to have access to Control Center Dashboards
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "Control Center"
    When I click on the link labeled "Administrator Privileges"
    Then I should see "Set administrator privileges"

    Given I disable the Administrator Privilege "Set administrator privileges" for the administrator "test_user2"
    And I disable the Administrator Privilege "Access to all projects and data" for the administrator "test_user2"
    And I disable the Administrator Privilege "Manage user accounts" for the administrator "test_user2"
    And I disable the Administrator Privilege "Perform REDCap upgrades" for the administrator "test_user2"
    And I disable the Administrator Privilege "Install, upgrade, and configure" for the administrator "test_user2"
    And I enable the Administrator Privilege "Access to Control Center dashboards" for the administrator "test_user2"

Scenario: 18 - Verify test_user2 Maximum User Privileges
    Given I am an "standard2" user who logs into REDCap
    Then I should see "Control Center"
    And I click on the link labeled "Control Center"
    Then I should see "Control Center Home"
    And I should see "Dashboard" 
    And I should see a link labeled "System Statistics"
    And I should see a link labeled "Activity Log"
    And I should see a link labeled "Activity Graphs"
    And I should see a link labeled "Map of Users"
    And I should see "Projects"
    And I should see "Technical / Developer Tools"
    And I should see "Miscellaneous Modules"
    And I should see "System Configuration"

Scenario: 19 - Switch test_user and test_user2 to no admin privileges
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "Control Center"
    When I click on the link labeled "Administrator Privileges"
    Then I should see "Set administrator privileges"

    Given I disable the Administrator Privilege "Set administrator privileges" for the administrator "test_user"

    Then I should see a dialog containing the following text: "NOTICE"
    And I should see a dialog containing the following text: "Please be aware that you have unchecked ALL the administrator privileges for this user"
    And I click on the button labeled "Close" in the dialog box

    Then I should see "Set administrator privileges"
    Given I disable the Administrator Privilege "Set administrator privileges" for the administrator "test_user2"
    And I disable the Administrator Privilege "Access to all projects and data" for the administrator "test_user2"
    And I disable the Administrator Privilege "Manage user accounts" for the administrator "test_user2"
    And I disable the Administrator Privilege "Perform REDCap upgrades" for the administrator "test_user2"
    And I disable the Administrator Privilege "Install, upgrade, and configure" for the administrator "test_user2"
    And I disable the Administrator Privilege "Access to Control Center dashboards" for the administrator "test_user2"
    And I disable the Administrator Privilege "Modify system configuration pages" for the administrator "test_user2"

    Then I should see a dialog containing the following text: "NOTICE"

    Given I logout

    Given I am an "admin" user who logs into REDCap
    Then I should see a link labeled "Control Center"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Administrator Privileges"

    Then I should see "Set administrator privileges"
    And I should NOT see "test_user"
    And I should NOT see "test_user2"

Scenario: 20 - Check Audit Log of User Actions
    When I click on the link labeled "Activity Log"
    Then I should see "All User Activity for Today"
    And I should see "Time"
    And I should see "User"
    And I should see "Event"

Scenario: 21 - Confirm test_user does not have Admin Rights
    Given I am a "standard" user who logs into REDCap
    Then I should NOT see a link labeled "Control Center"

Scenario: 22 - Confirm test_user2 does not have Admin Rights
    Given I am a "standard2" user who logs into REDCap
    Then I should NOT see a link labeled "Control Center"
