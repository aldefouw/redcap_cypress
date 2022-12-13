Feature: Draft Mode

  As a REDCap end user
  I want to see that Draft Mode is functioning as expected

 Scenario: Add from Email Address
        Given I am an "admin" user who logs into REDCap
        And I visit the "Control Center" page
        And I click on the link labeled "General Configuration"
        And I enter "no-reply@test.com" into the field identified by "[name=from_email]"
        And I click on the input button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"
 
 Scenario: Project Setup - 1 
    Given I am an "admin" user who logs into REDCap
    And I create a project named "20_DraftMode_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
    And I click on the button labeled exactly "Move project to production"
    And I click the input element identified by "[id=keep_data]"
    And I click on the button labeled exactly "YES, Move to Production Status"
    And I assign the "Project Design and Setup" user right to the user named "Test User" with the username of "test_user" on project ID 14

Scenario: 2 - Control Center 
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    # We should check for all options to exist (might not be a step definition yet)
    And I select "Yes, if project has no records OR if has records and no critical issues exist" from the dropdown identified by "select[name=auto_prod_changes]"
    
Scenario: 3- Save settings 
    And I select "No, only Administrators can add/modify events in production" from the dropdown identified by "select[name=enable_edit_prod_events]"
    And I click on the input button labeled "Save Changes"
    And I should see "Your system configuration values have now been changed!"

Scenario: 4 - Verify Project is in Production 
    And I logout
    Given I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I see "20_DraftMode_v1115"
    And I click on the link labeled "20_DraftMode_v1115"
    And I click on the link labeled "Designer"
    And I click on the element identified by ":nth-child(1) > :nth-child(2) > [style='width:510px;'] > div"
    Then I should see "Can only modify instrument in Draft Mode"

Scenario: 5 - Enter Draft Mode 
    Given I click on the button labeled "Close"
    And I click on the input button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode."

Scenario: 6 - Draft Changes
    When I click on the link labeled "Text Validation"
    And I click on the Delete Field image for the field named "Name"
    
    When I add a new field of type "Text Box (Short Text, Number, Date/Time, ...)" and enter "First Name" into the field labeled "first_name"
    When I add a new field of type "Text Box (Short Text, Number, Date/Time, ...)" and enter "Last Name" into the field labeled "last_name"

    When I click on the button labeled "Return to list of instruments"
    And I click on the link labeled "Data Types"
    And I click on the Edit image for the field named "Radio Button Manual"
    Given I clear the field identified by "[id=element_enum]"
    And I enter "1, Choice99{enter}100, Choice100{enter}101, Choice101" into the field identified by "[id=element_enum]"
    And I click on the button labeled "Save"

    Then I should see "Since this project is currently in PRODUCTION, changes will not be made in real time."
    When I click on the link labeled "View detailed summary of all drafted changes"
    Then I should see "Details regarding all changes made in Draft Mode"
        #And I should see "Records in project: ..."
    And I should see "Will these changes be automatically approved?"
    And I should see "Yes"

Scenario: 7 - Submit changes
    When I click on the button labeled "RETURN TO PREVIOUS PAGE"
    And I click on the input button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit"
    Then I should see "SUCCESS! The changes you just submitted were made"
    And I should see "AUTOMATICALLY"
    When I click on the link labeled "Why were my changes made automatically?"
    Then I should see "Your changes were made automatically either because your project currently contains no records OR because it was found that the"
    When I click on the button labeled "Close"
    Then I should see "Would you like to enter DRAFT MODE to begin drafting changes to the project?"
        #asks to check for an input button

Scenario: 8 - Draft Changes 
    Given I logout
    And I am an "admin" user who logs into REDCap
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    And I select "Never (always require an admin to approve changes)" from the dropdown identified by "select[name=auto_prod_changes]"
    And I click on the input button labeled "Save Changes"
    Given I logout
    And I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I see "20_DraftMode_v1115"
    And I click on the link labeled "20_DraftMode_v1115"
    And I click on the link labeled "Designer"
    And I click on the input button labeled "Enter Draft Mode"
    When I click on the link labeled "Text Validation"
    And I click on the Add Field input button below the field named "Email"
    When I select "Text Box (Short Text, Number, Date/Time, ...)" from the dropdown identified by "[id=field_type]"
    When I enter "Parent Contact" into the field identified by "[id=field_label]"
    And I enter "contact" into the field identified by "[id=field_name]"
    And I click on the button labeled "Save"
    When I click on the link labeled "View detailed summary of all drafted changes"
    Then I should see "Details regarding all changes made in Draft Mode"
    When I click on the button labeled "RETURN TO PREVIOUS PAGE"
    And I click on the input button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit"

    Then I should see "Your assistance is required to review the drafted changes for the production project"
    When I click on the link labeled 'Review & approve changes for "20_DraftMode_v1115"'
    And I click on the link labeled "Designer"
    Then I should see "Awaiting review of project changes"

    Then I logout

Scenario: 9 - Reject changes
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "20_DraftMode_v1115"
    And I click on the link labeled "Designer"
    And I click on the button labeled "Project Modification Module"
    Then I should see "Details regarding all changes made in Draft Mode"
    And I should see "ADMINISTRATOR ACTIONS:" 
    And I should see a button labeled "Compose confirmation email"
    And I should see a button labeled "COMMIT CHANGES"
    And I should see a button labeled "Reject Changes"
    And I should see a button labeled "Remove All Drafted Changes"
    When I click on the button labeled "Reject Changes"
    And I click on the element identified by "button:contains('Reject Changes'):last"
    Then I should see "Project Changes Rejected / User Notified"

    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    And I select "Yes, if project has no records OR if has records and no critical issues exist" from the dropdown identified by "select[name=auto_prod_changes]"
    And I click on the input button labeled "Save Changes"
    Given I logout

Scenario: 10 - Draft Changes
    Given I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "20_DraftMode_v1115"
    And I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click on the element identified by ".odd > :nth-child(2) > a > img"
        #When I click on the bubble for the "Text Validation" data collection instrument 
    And I enter "testemail@example.com" into the field identified by "[name=email_v2]"
    And I enter "firstname" into the field identified by "[name=first_name]"
    And I enter "lastname" into the field identified by "[name=last_name]"
    And I click on the dropdown and select the button identified by "[id=submit-btn-savenextform]"
    
    And I select "DDChoice1" from the dropdown identified by "[name=multiple_dropdown_auto]"
    And I click on the element identified by "[id=opt-radio_button_auto_1]"
    And I click on the element identified by "[id=opt-radio_button_manual_1]"
    And I click on the checkbox identified by "[id=id-__chk__checkbox_RC_1]"
    And I click on the button labeled "Save & Exit Form"

    When I click on the link labeled "Designer"
    And I click on the link labeled "Remove all drafted changes"
    And I click on the button labeled "Remove all drafted changes"
    And I click on the input button labeled "Enter Draft Mode"
    And I click on the link labeled "Text Validation"

    And I click on the Edit image for the field named "Email"
    And I clear the field identified by "[id=field_label]"
    And I enter "Primary Contact Email" into the field identified by "[id=field_label]"
    And I click on the button labeled "Save"

    And I click on the button labeled "Return to list of instruments"
    And I click on the link labeled "Data Types"
    And I click on the Delete Field image for the field named "Multiple Choice Dropdown Auto"
    And I click on the Edit image for the field named "Radio Button Manual"
    Given I clear the field identified by "[id=element_enum]"
    And I enter "99, Choice99{enter}100, Choice100{enter}101, Choice101" into the field identified by "[id=element_enum]"
    And I click on the button labeled "Save"

    And I click on the Edit image for the field named "Radio Button Auto"
    Given I clear the field identified by "[id=element_enum]"
    And I enter "1, Choice 10{enter}2, Choice 2{enter}3, Choice 3" into the field identified by "[id=element_enum]"
    And I click on the button labeled "Save"

    And I click on the Edit image for the field named "Checkbox"
    And I select "Multiple Choice - Drop-down List (Single Answer)" from the dropdown identified by "[id=field_type]"
    Then I should see "Edit Field"
And I want to pause
    And I click on the button labeled "Save"

    Given I click on the link labeled "View detailed summary of all drafted changes"

    #Then I should see ... 2 records in project 
    #And I should see ... 4 fields being modified 
    #And I should see ... 1 field being deleted 
    And I should see "No, an admin will have to review these changes."
    #Then I should see ... 1 deleted field with data 
    #And I should see ... 3 potential critical issues in modified fields with data 
    #And I should see ... table changes 

Scenario: 11 - Submit Changes 
    When I click on the button labeled "RETURN TO PREVIOUS PAGE"
    And I click on the input button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit"
    
    Then I should see "Your assistance is required to review the drafted changes for the production project"
    When I click on the link labeled 'Review & approve changes for "20_DraftMode_v1115"'
    And I click on the link labeled "Designer"
    Then I should see "Awaiting review of project changes"
    When I click on the link labeled "Why weren't my changes made automatically?"
    Then I should see "Your changes were not made automatically because your project currently contains one or more records AND"

    Given I logout

Scenario: 12 - Remove Drafted Changes 
    Given I am an "admin" user who logs into REDCap 
    And I click on the link labeled "My Projects"
    And I click on the link labeled "20_DraftMode_v1115"
    And I click on the link labeled "Designer"
    And I click on the button labeled "Project Modification Module"
    When I click on the button labeled "Remove All Drafted Changes"
    And I click on the element identified by "button:contains('Remove All Drafted Changes'):last"
    Then I should see "Project Changes Removed / User Notified"
    Given I logout

Scenario: 13 - Create Record
    Given I am a "standard" user who logs into REDCap 
    And I click on the link labeled "My Projects"
    And I click on the link labeled "20_DraftMode_v1115"
    And I click on the link labeled "Designer"
    Then I should see "Would you like to enter DRAFT MODE to begin drafting changes to the project?"
    
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click on the element identified by ".odd > :nth-child(2) > a"
        #When I click on the bubble for the "Text Validation" data collection instrument 
    And I enter "testemail@example.com" into the field identified by "[name=email_v2]"
    And I enter "firstname" into the field identified by "[name=first_name]"
    And I enter "lastname" into the field identified by "[name=last_name]"
    And I click on the dropdown and select the button identified by "[id=submit-btn-savenextform]"
    
    And I click on the element identified by "[id=opt-radio_button_manual_1]"
    And I click on the button labeled "Save & Exit Form"
