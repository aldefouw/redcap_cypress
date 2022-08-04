Feature: Assign Super Users / Account Managers

  As a REDCap end user
  I want to see that Assign Super Users / Account Managers is functioning as expected

Background: 
    Given I am an "admin" user who logs into REDCap
    And I visit the "Control Center" page

Scenario: Create a user- from add_manage_users
    When I click on the link labeled "Add Users (Table-based Only)" 
    And I enter "user1115_1" into the field labeled "Username:"
    And I enter "User1" into the field labeled "First name:"
    And I enter "1115_1" into the field labeled "Last name:"
    And I enter "user1115@redcap.edu" into the field labeled "Primary email:"
    And I click on the input button labeled "Save"
    Then I should see "User has been successfully saved."
    And I should see "An email with login information was sent to: user1115@redcap.edu"

Scenario: Create a user - from add_manage_users
    When I click on the link labeled "Add Users (Table-based Only)" 
    And I enter "user1115_3" into the field labeled "Username:"
    And I enter "User3" into the field labeled "First name:"
    And I enter "1115_3" into the field labeled "Last name:"
    And I enter "user1115.3@redcap.edu" into the field labeled "Primary email:"
    And I click on the input button labeled "Save"
    Then I should see "User has been successfully saved."
    And I should see "An email with login information was sent to: user1115.3@redcap.edu"


Scenario: 2- Control Center Links Visible
    Then I should see "Control Center Home"
    And I should see "Projects"
    And I should see "Users"
    And I should see "System Configuration"

Scenario: 3- Administrator Privileges Page Visible
    When I click on the link labeled "Administrator Privileges"
    Then I should see "Set Administrator Privileges"
    And I should see "Access to all projects and data with maximum user privileges"
        #doesnt detect these in the table
    And I should see "Manage user accounts"
    And I should see "Modify system configuration pages"
    And I should see "Perform REDCap upgrades"
    And I should see "Install, upgrade, and configure External Modules"
    And I should see "Access to Control Center dashboards"

Scenario: 4 & 5- Add user1115_1 to Administrator List
    When I click on the link labeled "Administrator Privileges"
    And I enter "user1115_1" into the field identified by "[id=user_search]"
    And I click on the checkbox identified by "[id=0-admin_rights]"
    And I click on the button labeled "Add"
    Then I should see "The user user1115_1 has now been granted one or more administrator privileges"
        #doesnt detect messge in popup screen 
    When I click on the button labeled "OK"
    Then I should see "user1115_1"

Scenario: 6- Verify user1115_1 Administrator Priveledges 
    When I click on the link labeled "Log out"
    And I enter "user1115_1" into the field labeled "Username:"
    And I enter "1115_1Pswd" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
        #password was never reset, login is invalid
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Users"
    And I should see "Administrator Privileges"
        #come back to this once password is reset

Scenario: 7, 8, and 9- Grant user1115_3 Administrator Privileges
    When I click on the link labeled "Administrator Privileges"
    And I enter "user1115_3" into the field identified by "[id=user_search]"
    And I click on the checkbox identified by "[id=0-account_manager]"
    And I click on the button labeled "Add"
    Then I should see "The user user1115_3 has now been granted one or more administrator privileges"
        #doesnt detect message or ok button in popup screen
    When I click on the button labeled "OK"
    Then I should see "user1115_3"

Scenario: 10- Verify user1115_3 Account Manager Priveledges 
    When I click on the link labeled "Log out"
    And I enter "user1115_3" into the field labeled "Username:"
    And I enter "PASSWORD HERE" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
        #password was never reset, login is invalid
    And I click on the link labeled "Control Center"
    Then I should see a Control Center link labeled "Browse Users"
    And I should see a Control Center link labeled "Add Users (Table-based Only)"
    And I should see "Administrator Privileges"
    And I should see "External Modules"
        #no longer a heading - is now a link
    And I should see "Miscellaneous Modules"
    And I should see "System Configuration"
        #not sure how to ensure a link is read only 
        #come back to this once password is reset

Scenario: 11- Switch user1115_3 to Maximum User Privileges
    When I click on the link labeled "Administrator Privileges"
    And I click on the checkbox identified by "[id=8-super_user]"
    And I click on the checkbox identified by "[id=8-account_manager]"

Scenario: 12- Verify user1115_3 Maximum User Privileges Priveledges 
    When I click on the link labeled "Log out"
    And I enter "user1115_3" into the field labeled "Username:"
    And I enter "PASSWORD HERE" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
        #password was never reset, login is invalid
    And I click on the link labeled "Control Center"
    Then I should see a Control Center link labeled "Browse Users"
    And I should see a Control Center link labeled "Edit a Project's Settings"
    And I should see a Control Center link labeled "Survey Link Lookup"
    And I should see "Administrator Privileges"
    And I should see "External Modules"
        #no longer a heading - is now a link
    And I should see "Miscellaneous Modules"
    And I should see "System Configuration"
        #not sure how to ensure a link is read only 
        #come back to this once password is reset

Scenario: 13- View All Projects Page
    When I click on the link labeled "Log out"
    And I enter "user1115_3" into the field labeled "Username:"
    And I enter "PASSWORD HERE" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
        #password was never reset, login is invalid
    And I click on the link labeled "Browse Projects"
    Then I should see "Viewing projects accessible by user:"
    And I click on the input button labeled "View all Projects"
    Then I should see a link labeled "Classic Database"

Scenario: 14 - View and Edit Project Settings Page 
    When I click on the link labeled "Log out"
    And I enter "user1115_3" into the field labeled "Username:"
    And I enter "PASSWORD HERE" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
        #password was never reset, login is invalid
    When I click on the link labeled "Edit a Project's Settings"
    Then I should see "You may modify the governing settings for any REDCap project on this page."
    And I select "Classic Database" from the dropdown identified by "select[onchange=window.location.href='/redcap_v11.1.5/ControlCenter/edit_project.php?project=' + this.value]"
        #I have no idea if that will work
    Then I should see "Navigate to project Classic Database"

Scenario: 15- Switch user1115_3 to System Configuration Modifier
    When I click on the link labeled "Administrator Privileges"
    And I click on the checkbox identified by "[id=8-access_system_config]"
    And I click on the checkbox identified by "[id=8-super_user]"
    
Scenario: 16- Verify user1115_3 System Configuration Access 
    When I click on the link labeled "Log out"
    And I enter "user1115_3" into the field labeled "Username:"
    And I enter "PASSWORD HERE" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
        #password was never reset, login is invalid
    And I click on the link labeled "Control Center"
    Then I should see a Control Center link labeled "Configuration Check"
    And I should see a Control Center link labeled "General Configuration"
    And I should see a Control Center link labeled "Security & Authentication"
    And I should see a Control Center link labeled "User Settings"
    And I should see a Control Center link labeled "File Upload Settings"
    And I should see a Control Center link labeled "Modules/Services Configuration"
    And I should see a Control Center link labeled "Field Validation Types"
    And I should see a Control Center link labeled "Home Page Settings"
    And I should see a Control Center link labeled "Project Templates"
    And I should see a Control Center link labeled "Default Project Settings"
    And I should see a Control Center link labeled "Footer Settings (All Projects)"
    And I should see a Control Center link labeled "Cron Jobs"
    And I should NOT see "Users"
    And I should NOT see "Dashboard"
        #come back to this once password is reset
    When I click on the link labeled "Configuration Check"
    Then I should see "Basic tests"
    And I should see "Secondary tests"

Scenario: 17- Switch user1115_3 to have access to Control Center Dashboards 
    When I click on the link labeled "Administrator Privileges"
    And I click on the checkbox identified by "[id=8-access_admin_dashboards]"
    And I click on the checkbox identified by "[id=8-access_system_config]"

Scenario: 18- Verify user1115_3 Maximum User Privileges Priveledges 
    When I click on the link labeled "Log out"
    And I enter "user1115_3" into the field labeled "Username:"
    And I enter "PASSWORD HERE" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
        #password was never reset, login is invalid
    And I click on the link labeled "Control Center"
    Then I should see "Dashboard"
    And I should see a Control Center link labeled "System Statistics"
    And I should see a Control Center link labeled "Activity Log"
    And I should see a Control Center link labeled "Activity Graphs"
    And I should see a Control Center link labeled "Map of Users"
    And I should see "Administrator Privileges"
    And I should see "External Modules"
        #no longer a heading - is now a link
    And I should see "Miscellaneous Modules"
    And I should see "System Configuration"
        #not sure how to ensure a link is read only 
        #come back to this once password is reset - Something like ‘I should see an element identified by “[readonly=‘readonly’]” containing the text “foo”’

Scenario: 19- Switch user1115_1 and user1115_3 to no admin privileges
    When I click on the link labeled "Administrator Privileges"
    And I click on the checkbox identified by "[id=8-access_admin_dashboards]"
    And I click on the checkbox identified by "[id=7-admin_rights]"
    And I click on the link labeled "Log out"
    Then I enter "test_admin" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "Administrator Privileges"
    Then I should NOT see "user1115_1"
    And I should NOT see "user1115_1"

Scenario: 20- Check Audit Log of User Actions
    When I click on the link labeled "Activity Log"
    And I should see "All User Activity for Today"
    And I should see "(12 events)"
    And I should see "Time"
    And I should see "User"
    And I should see "Event"

Scenario: 21- Confirm user1115_1 does not have Admin Rights 
    When I click on the link labeled "Log out"
    And I enter "user1115_1" into the field labeled "Username:"
    And I enter "PASSWORD HERE" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
        #password was never reset, login is invalid
    #And I should not have access to Control Center

Scenario: 22- Confirm user1115_3 does not have Admin Rights 
     When I click on the link labeled "Log out"
    And I enter "user1115_3" into the field labeled "Username:"
    And I enter "PASSWORD HERE" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
        #password was never reset, login is invalid
    #And I should not have access to Control Center






