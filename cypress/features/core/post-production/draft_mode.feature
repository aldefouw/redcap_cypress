Feature: Draft Mode

  As a REDCap end user
  I want to see that Draft Mode is functioning as expected

Scenario: 0 - Project Setup - 1
    Given I am an "admin" user who logs into REDCap
    And I create a project named "20_DraftMode_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
    
Scenario: 0 - Project Setup - 2, 3
    And I should see a link labeled "User Rights"
    And I click on the link labeled "User Rights"
    And I enter "test_user" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    And I check the User Right named 'Project Setup & Design'
    And I save changes within the context of User Rights

    And I should see a link labeled "Designer"
    And I click on the link labeled "Designer"

    And I should see a link labeled "Data Types"
    And I click on the link labeled "Data Types"

    And I delete the field named "Required"

    And I should see a link labeled "Project Setup"
    And I click on the link labeled "Project Setup"

    And I click on the button labeled exactly "Move project to production"
    And I move the project to production by selection option "Keep ALL data saved so far"

Scenario: 0 - Project Setup - 4
    And I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    And I enter "no-reply@test.com" into the input field labeled "Set a Universal FROM Email address"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 1 - Log into Project
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "20_DraftMode_v1115"

Scenario: 2 - Control Center
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    # We should check for all options to exist (might not be a step definition yet)
    And I select "Yes, if project has no records OR if has records and no critical issues exist" on the dropdown field labeled "Allow production Draft Mode changes to be approved automatically"

Scenario: 3- Save settings
    And I select "No, only Administrators can add/modify events in production" on the dropdown field labeled "Allow normal users to add or modify events and arms on the Define My Events page"
    And I click on the button labeled "Save Changes"
    And I should see "Your system configuration values have now been changed!"

Scenario: 4 - Verify Project is in Production
    And I logout
    Given I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I see "20_DraftMode_v1115"
    And I click on the link labeled "20_DraftMode_v1115"
    And I click on the link labeled "Designer"
    And I click the element containing the following text: "Text Validation"
    Then I should see "Can only modify instrument in Draft Mode"

Scenario: 5 - Enter Draft Mode
    Given I click on the button labeled "Close"
    And I enter draft mode
    Then I should see "The project is now in Draft Mode."

Scenario: 6 - Draft Changes
    When I click on the link labeled "Text Validation"
    And I delete the field named "Name"
    When I add a new Text Box field labeled "Last Name" with variable name "last_name"
    When I add a new Text Box field labeled "First Name" with variable name "first_name"
    And I move the field named "Last Name" after the field named "First Name"

    When I click on the button labeled "Return to list of instruments"
    And I click on the link labeled "Data Types"

    Given I edit the Data Collection Instrument field labeled "Radio Button Manual"
    And I enter Choices of "1, Choice99{enter}100, Choice100{enter}101, Choice101" into the open "Edit Field" dialog box
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Since this project is currently in PRODUCTION, changes will not be made in real time."

    When I click on the link labeled "View detailed summary of all drafted changes"
    Then I should see "Details regarding all changes made in Draft Mode"
    And I should see "Records in project: 1"
    And I should see "Will these changes be automatically approved?"
    And I should see "Yes"

Scenario: 7 - Submit changes
    When I click on the button labeled "RETURN TO PREVIOUS PAGE"
    And I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit"
    Then I should see "SUCCESS! The changes you just submitted were made"
    And I should see "AUTOMATICALLY"
    When I click on the link labeled "Why were my changes made automatically?"
    Then I should see "Your changes were made automatically either because your project currently contains no records OR because it was found that the"
    When I click on the button labeled "Close"
    Then I should see "Would you like to enter DRAFT MODE to begin drafting changes to the project?"

Scenario: 8 - Draft Changes
    Given I logout
    And I am an "admin" user who logs into REDCap
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    And I select "Never (always require an admin to approve changes)" on the dropdown field labeled "Allow production Draft Mode changes to be approved automatically"
    And I click on the button labeled "Save Changes"
    Given I logout
    And I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I see "20_DraftMode_v1115"
    And I click on the link labeled "20_DraftMode_v1115"
    And I click on the link labeled "Designer"
    And I enter draft mode
    When I click on the link labeled "Text Validation"

    When I add a new Text Box field labeled "Parent Contact" with variable name "contact"

    When I click on the link labeled "View detailed summary of all drafted changes"
    Then I should see "Details regarding all changes made in Draft Mode"
    When I click on the button labeled "RETURN TO PREVIOUS PAGE"
    And I click on the button labeled "Submit Changes for Review"
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
    And I click on the button labeled "Reject Changes" in the dialog box
    Then I should see "Project Changes Rejected / User Notified"

    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    And I select "Yes, if project has no records OR if has records and no critical issues exist" on the dropdown field labeled "Allow production Draft Mode changes to be approved automatically"
    And I click on the button labeled "Save Changes"
    Given I logout

Scenario: 10 - Draft Changes
    Given I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "20_DraftMode_v1115"
    And I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"

    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"

    And I enter "testemail@example.com" into the data entry form field labeled "Email"
    And I enter "firstname" into the data entry form field labeled "First Name"
    And I enter "lastname" into the data entry form field labeled "Last Name"

    And I select the submit option labeled "Save & Go To Next Form" on the Data Collection Instrument

    And I select the dropdown option "DDChoice1" for the Data Collection Instrument field labeled "Multiple Choice Dropdown Auto"
    And I select the radio option "Choice1" for the field labeled "Radio Button Auto"
    And I select the radio option "Choice99" for the field labeled "Radio Button Manual"
    And I select the checkbox option "Checkbox" for the field labeled "Checkbox"

    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

    When I click on the link labeled "Designer"
    And I click on the link labeled "Remove all drafted changes"
    And I click on the button labeled "Remove all drafted changes"
    And I enter draft mode
    And I click on the link labeled "Text Validation"

    And I edit the Data Collection Instrument field labeled "Email"
    And I enter "Primary Contact Email" into the Field Label of the open "Edit Field" dialog box
    And I click on the button labeled "Save" in the dialog box

    And I click on the button labeled "Return to list of instruments"
    And I click on the link labeled "Data Types"
    And I delete the field named "Multiple Choice Dropdown Auto"

    Given I edit the Data Collection Instrument field labeled "Radio Button Manual"
    And I enter Choices of "99, Choice99{enter}100, Choice100{enter}101, Choice101" into the open "Edit Field" dialog box
    And I click on the button labeled "Save" in the dialog box

    And I edit the Data Collection Instrument field labeled "Radio Button Auto"
    And I enter Choices of "1, Choice 10{enter}2, Choice 2{enter}3, Choice 3" into the open "Edit Field" dialog box
    And I click on the button labeled "Save" in the dialog box

    And I edit the Data Collection Instrument field labeled "Checkbox"
    And I select "Multiple Choice - Drop-down List (Single Answer)" from the Field Type dropdown of the open "Edit Field" dialog box
    And I click on the button labeled "Save" in the dialog box

    Given I click on the link labeled "View detailed summary of all drafted changes"

    Then I should see "Records in project: 2"
    And I should see "Fields to be modified: 4"
    And I should see "No, an admin will have to review these changes."
    And I should see "Deleted fields that contain data: 1"
    And I should see "Potentially critical issues in modified fields that contain data: 3"

    And I should see "*Possible label mismatch because of label changes. Check if okay."
    And I should see "*Data MIGHT be lost due to deleted choice(s)"
    And I should see "*Possible data loss if field type changes. Check if okay."

Scenario: 11 - Submit Changes 
    When I click on the button labeled "RETURN TO PREVIOUS PAGE"
    And I click on the button labeled "Submit Changes for Review"
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
    And I click on the button labeled "Remove All Drafted Changes" in the dialog box
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
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"

    And I enter "testemail@example.com" into the data entry form field labeled "Email"
    And I enter "firstname" into the data entry form field labeled "First Name"
    And I enter "lastname" into the data entry form field labeled "Last Name"

    And I select the submit option labeled "Save & Go To Next Form" on the Data Collection Instrument

    And I select the radio option "Choice99" for the field labeled "Radio Button Manual"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

Scenario: 14 - Download and Edit Data Dictionary 
    When I click on the link labeled "Project Home"
    And I click on the link labeled "Project Revision History"
    #Note date and time of most recent data dictionary
    And I download a file by clicking on the link labeled "Download data dictionary"

    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Data Dictionary"
    Then I should see "The project must first be in Draft Mode before you can upload your Data Dictionary."

Scenario: 15 - Upload Revised Data Dictionary
    When I click on the link labeled "Designer"
    And I click on the link labeled "Dictionary"
    And I enter draft mode
    And I upload the data dictionary located at "core/20_DraftMode_DD_Modified.csv"

    Then I should see "Since the project is still in Draft Mode, these changes will not officially take effect until the drafted changes are submitted for review."
    And I should see a link labeled "Remove all drafted changes"
    And I should see a link labeled "view a detailed summary of all drafted changes"

Scenario: 16 - Send Confirmation Email 
    When I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box

    Given I logout
    And I am an "admin" user who logs into REDCap

    And I click on the link labeled "My Projects"
    And I click on the link labeled "20_DraftMode_v1115"
    And I click on the link labeled "Designer"
    And I click on the button labeled "Project Modification Module"

    Then I should see "Data MIGHT be lost due to deleted choice(s)"

    When I click on the button labeled "Compose confirmation email"
    And I click on the button labeled "Send Email" in the dialog box
    Then I should see "EMAIL SENT!"
    When I click on the button labeled "Close" in the dialog box
    
Scenario: 17 - Commit Changes
    When I click on the button labeled "COMMIT CHANGES"
    Then I should see "Are you sure you wish to commit these changes to the project?"
    And I should see "These changes will be permanent."
    When I click on the button labeled "COMMIT CHANGES" in the dialog box
    Then I should see "Project Changes Committed / User Notified"

    Given I logout

Scenario: 18 - Project Revision History
    Given I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "20_DraftMode_v1115"
    And I click on the link labeled "Project Revision History"
    Then I should see "Production revision #1"
    And I should see "Production revision #2 (current)"
    #with the date and time it was implemented
    #as well as the person who requested the change(s) and the one who approved the request

Scenario: 19 - Define My Events
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    Then I should see "Events cannot be modified in production status except by a REDCap administrator."

    Given I logout

Scenario: 20 - Draft Changes
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "20_DraftMode_v1115"
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    Then I should see "Deleting any events below will result in data loss. Please proceed with caution."

    Given I change the current Event Name from "Event 2" to "Event B"
    And I click on the link labeled "Designate Instruments for My Events"
    And I enable the Data Collection Instrument named "Text Validation" for the Event named "Event B"
    And I verify the Data Collection Instrument named "Text Validation" is enabled for the Event named "Event B"
    And I verify the Data Collection Instrument named "Data Types" is enabled for the Event named "Event 1"
    And I verify the Data Collection Instrument named "Data Types" is disabled for the Event named "Event B"

    Then I logout


Scenario: 21 - Review Events and Form Designations
    Given I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "20_DraftMode_v1115"
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    Then I should see "Event B"
    And I should NOT see "Event 2"
    When I click on the link labeled "Designate Instruments for My Events"

    Then I verify the Data Collection Instrument named "Text Validation" is enabled for the Event named "Event 1"
    And I verify the Data Collection Instrument named "Text Validation" is enabled for the Event named "Event B"
    And I verify the Data Collection Instrument named "Data Types" is enabled for the Event named "Event 1"
    And I verify the Data Collection Instrument named "Data Types" is disabled for the Event named "Event B"
    
    




