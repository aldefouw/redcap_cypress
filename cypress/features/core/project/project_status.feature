Feature: Project Status

  As a REDCap end user
  I want to see that Project Status is functioning as expected

  Scenario: 0 - Project Setup
    Given I am an "admin" user who logs into REDCap
    And I create a project named "11_ProjectStatus_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
    When I click on the link labeled "User Rights"
    And I enter "test_user" into the username input field
    And I click on the button labeled "Add with custom rights"
    And I check the User Right named 'Project Setup & Design'
    And I check the User Right named 'User Rights'
    And I check the User Right named 'Data Access Groups'
    And I save changes within the context of User Rights

  Scenario: 1 -  Login as test user
    Given I am an "standard" user who logs into REDCap

  Scenario: 2 - Go to My Projects Page
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115" 

  Scenario: 3 - Move project to Production
    When I click on the button labeled "Move project to production"
    Then I should see "Request Admin to Move to Production Status?" 
    And I should see a button labeled "Yes, Request Admin to Move to Production Status"
    Then I click on the button labeled "Cancel"

  Scenario: 4 - Login as test admin
    Given I logout
    And I am an "admin" user who logs into REDCap

  Scenario: 5 - Allow Normal Users to Move Project to Production
    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    And I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

  Scenario: 6  - Login as test user
    Given I logout
    And I am a "standard" user who logs into REDCap

  Scenario: 7 - Open 11_ProjectStatus_v1115
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115" 

  Scenario: 8 - Move Project to Production
    When I click on the button labeled "Move project to production"
    And I move the project to production by selection option "Keep ALL data saved so far"
    When I click on the link labeled "Add / Edit Records"
    Then I should see the dropdown field labeled "Choose an existing Record ID" with the options below
    | 1 |

  Scenario: 9 - Other Functionality Tab 
    When I click on the link labeled "Project Setup"
    And I click on the link labeled "Other Functionality"
    Then I should NOT see "Move back to Development status"

  Scenario: 10 - Login as test admin
    Given I logout
    And I am an "admin" user who logs into REDCap

  Scenario: 11 - Move Back to Development
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115" 
    And I click on the link labeled "Other Functionality"
    And I move the project back to development mode via the Other Functionality page
    Then I should see "The project is now back in development status."

  Scenario: 12 - Login as test user
    Given I logout
    And I am a "standard" user who logs into REDCap

  Scenario: 13 -  Move Project to Production
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115"
    When I click on the button labeled "Move project to production"
    And I move the project to production by selection option "Delete ALL data"
    When I click on the link labeled "Add / Edit Records"

    Then I should see the dropdown field labeled "Choose an existing Record ID" with the options below
    | |
    When I click on the link labeled "Record Status Dashboard"
    Then I should see "No records exist yet"

  Scenario: 14 - Login as test admin
    Given I logout
    And I am an "admin" user who logs into REDCap

  Scenario: 15 - Move Back to Development
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115" 
    And I click on the link labeled "Other Functionality"
    And I move the project back to development mode via the Other Functionality page
    Then I should see "The project is now back in development status."

  Scenario: 16 - Login as test user
    Given I logout
    And I am a "standard" user who logs into REDCap

  Scenario: 17 - Mark Project as Completed
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115" 
    And I click on the link labeled "Other Functionality"
    When I click on the button labeled "Mark project as Completed"
    When I click on the button labeled "Mark project as Completed" in the dialog box
    Then I should see "My Projects"
    Then I should see 0 rows displayed in the projects table

  Scenario: 18 - Show Completed Projects
    When I click on the link labeled "Show Completed Projects"
    Then I should see 1 row displayed in the projects table
    And I should see a link labeled "11_ProjectStatus_v1115"

    When I click on the link labeled "11_ProjectStatus_v1115"
    Then I should see "NOTICE: Project was marked as Completed" 
    Then I should NOT see "Restore Project"

  Scenario: 19 - Return to My Projects Page
    Given I click on the button labeled "Return to My Projects page"

  Scenario: 20 - Login as test admin
    Given I logout
    And I am an "admin" user who logs into REDCap

  Scenario: 21 - Restore Project
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Show Completed Projects"
    And I click on the link labeled "11_ProjectStatus_v1115"
    Then I should see "NOTICE: Project was marked as Completed"
    When I click on the button labeled "Restore Project"
    Then I should see "PROJECT RESTORED!"
    And I close the popup

  Scenario: 22 - Login as test user
    Given I logout
    And I am a "standard" user who logs into REDCap

  Scenario: 23 - Move Project to Production
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115"
    When I click on the button labeled "Move project to production"
    And I move the project to production by selection option "Keep ALL data saved so far"

  Scenario: 24 - Move Project to Analysis/Cleanup Status
    When I click on the link labeled "Other Functionality"
    And I click on the button labeled "Move to Analysis/Cleanup status"
    And I click on the button labeled "YES, Move to Analysis/Cleanup Status" in the project status dialog box
    Then I should see "Project status:  Analysis/Cleanup"

  Scenario: 25 - Lock Entire Record
    When I click on the link labeled "Other Functionality"
    And I click on the button labeled "Modify"
    And I click on the button labeled "Set all project data as Read-only / Locked" in the project status dialog box
    Then I should see "The data in this project is currently:"
    And I should see "Read-only / Locked"

  Scenario: 26 - Set to Editable
    Given I should see a button labeled "Modify"
    And I click on the button labeled "Modify"
    And I click on the button labeled "Set to Editable (existing records only)" in the project status dialog box
    Then I should see "Editable (existing records only)"

  Scenario: 27 - Move Back to Production Status
    When I click on the button labeled "Move back to Production status"
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should NOT see "Move back to Development status"

  Scenario: 28 - Login as test admin
    Given I logout
    And I am an "admin" user who logs into REDCap

  Scenario: 29 - Move Project to Analysis/Cleanup Status
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "11_ProjectStatus_v1115" 
    When I click on the link labeled "Other Functionality"
    And I click on the button labeled "Move to Analysis/Cleanup status"
    And I click on the button labeled "YES, Move to Analysis/Cleanup Status" in the dialog box
    Then I should see "This project is currently in Analysis/Cleanup status"

  Scenario: 30 - Move Project to Production
    Given I click on the link labeled "Other Functionality"
    When I click on the button labeled "Move back to Production status"
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project status:  Production"

  Scenario: 31 -  Mark Project as Completed
    Given I should see a button labeled "Mark project as Completed"
    When I click on the button labeled "Mark project as Completed"
    And I click on the button labeled "Mark project as Completed" in the dialog box
    Then I should see 0 rows displayed in the projects table

  Scenario: 32 - Show Completed Projects
    When I click on the link labeled "Show Completed Projects"
    Then I should see a link labeled "11_ProjectStatus_v1115"
    When I click on the link labeled "11_ProjectStatus_v1115"
    Then I should see "NOTICE: Project was marked as Completed" 
    When I click on the button labeled "Restore Project"
    Then I should see "PROJECT RESTORED!"
    And I close the popup


