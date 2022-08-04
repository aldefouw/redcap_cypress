Feature: Manage Project

  As a REDCap end user
  I want to see that Manage Project is functioning as expected

Background: 
    Given I am an "admin" user who logs into REDCap
    And I visit the "Control Center" page

Scenario: Create a user - from add_manage_users
    When I click on the link labeled "Add Users (Table-based Only)" 
    And I enter "user1115_3" into the field labeled "Username:"
    And I enter "User3" into the field labeled "First name:"
    And I enter "1115_3" into the field labeled "Last name:"
    And I enter "user1115.3@redcap.edu" into the field labeled "Primary email:"
    And I click on the input button labeled "Save"
    Then I should see "User has been successfully saved."
    And I should see "An email with login information was sent to: user1115.3@redcap.edu"

Scenario: 2- User Settings Configuration - Create Projects 
    When I click on the link labeled "User Settings"
    And I select "Yes, normal users can create new projects" from the dropdown identified by "select[name=superusers_only_create_project]"
    And I select "No, only Administrators can create new projects" from the dropdown identified by "select[name=superusers_only_create_project]"
    And I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 3- User Settings Configuration - Move Projects to Production
    When I click on the link labeled "User Settings"
    And I select "Yes, normal users can move projects to production" from the dropdown identified by "select[name=superusers_only_move_to_prod]"
    And I select "No, only Administrators can move projects to production" from the dropdown identified by "select[name=superusers_only_move_to_prod]"
    And I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 4- User Settings Configuration - Edit Survey Responses
    When I click on the link labeled "User Settings"
    And I select "Enabled" from the dropdown identified by "select[name=enable_edit_survey_response]"
    And I select "Disabled" from the dropdown identified by "select[name=enable_edit_survey_response]"
    And I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 5- User Settings Configuration - Allow Production Draft Mode Changes
    When I click on the link labeled "User Settings"
    And I select "Yes, if no existing fields were modified" from the dropdown identified by "select[name=auto_prod_changes]"
    And I select "Yes, if project has no records OR if has records and no existing fields were modified" from the dropdown identified by "select[name=auto_prod_changes]"
    And I select "Yes, if no critical issues exist" from the dropdown identified by "select[name=auto_prod_changes]"
    And I select "Yes, if project has no records OR if has records and no critical issues exist" from the dropdown identified by "select[name=auto_prod_changes]"
    And I select "Never (always require an admin to approve changes)" from the dropdown identified by "select[name=auto_prod_changes]"
    And I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 6- User Settings Configuration - Modify Repeatable Instruments & Events
    When I click on the link labeled "User Settings"
    And I select "Yes, normal users can modify the repeatable instance setup in production" from the dropdown identified by "select[name=enable_edit_prod_repeating_setup]"
    And I select "No, only Administrators can modify the repeatable instance setup in production" from the dropdown identified by "select[name=enable_edit_prod_repeating_setup]"
    And I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 7- User Settings Configuration - Modify Events and Arms in Production Status
    When I click on the link labeled "User Settings"
    And I select "Yes, normal users can add/modify events in production" from the dropdown identified by "select[name=enable_edit_prod_events]"
    And I select "No, only Administrators can add/modify events in production" from the dropdown identified by "select[name=enable_edit_prod_events]"
    And I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 8- Verify user1115_3 can not Create or Copy Projects 
    When I click on the link labeled "Browse Users"
    And I enter "user1115_3" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    Then I should see "(NOTE: Currently normal users CANNOT create or copy projects. See the User Settings page in the Control Center to change this setting.)"











