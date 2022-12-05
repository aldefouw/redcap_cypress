Feature: Draft Mode

  As a REDCap end user
  I want to see that Draft Mode is functioning as expected

 Scenario: Project Setup - 1 
    Given I am an "admin" user who logs into REDCap
    And I create a project named "20_DraftMode_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
    And I click on the button labeled exactly "Move project to production"
    And I click the input element identified by "[id=keep_data]"
    And I click on the button labeled exactly "YES, Move to Production Status"
    And I assign the "Project Design and Setup" user right to the user named "Test User" with the username of "test_user" on project ID 14


Scenario: Control Center - 2

    Given I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    # We should check for all options to exist (might not be a step definition yet)
    And I select "Yes, if project has no records OR if has records and no critical issues exist" from the dropdown identified by "select[name=auto_prod_changes]"
    And I select "No, only Administrators can add/modify events in production" from the dropdown identified by "select[name=enable_edit_prod_events]"
        
    And I click on the input button labeled "Save Changes"
    And I should see "Your system configuration values have now been changed!"

    And I logout

    Given I am a "standard" user who logs into REDCap

    And I click on the link labeled "My Projects"
    And I see "20_DraftMode_v1115"
    And I click on the link labeled "20_DraftMode_v1115"



    #Navigate to the project
