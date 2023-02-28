Feature: Data Entry through the Data Collection Instrument

  As a REDCap end user
  I want to see that Data Entry through the Data Collection Instruments is functioning as expected

  Scenario: 0 - Create the Project
    Given I am an "admin" user who logs into REDCap
    And I create a project named "Entry Via Instrument" with project purpose Operational Support via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"

  Scenario: 0 - Add user
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Entry Via Instrument"
    And I click on the link labeled "User Rights"
    And I enter "test_user" into the username input field
    And I click on the button labeled "Add with custom rights"
    And I check the User Right named 'Project Setup & Design'
    And I select the User Right named 'Data Exports' and choose "Full Data Set"
    And I check the User Right named 'Logging'
    And I check the User Right named 'Delete Records'
    And I check the User Right named "Create Records"
    And I check the User Right named "Rename Records"
    And I save changes within the context of User Rights

  Scenario: 0 - Instrument setup
    Given I click on the link labeled "Designer"
    And I create a new data collection instrument called "Data Dictionary"
    And I click on the link labeled "Designer"
    And I click on the link labeled "Data Dictionary"
    And I add a new field of type "yesno" and enter "Yes - No" into the field labeled "yesno"
    And  I click on the link labeled "Designer"
    Then I should see "Data Collection Instruments"

  Scenario: 0 - Project Setup - Define Events
    When I click on the link labeled 'Project Setup'
    And I click on the button labeled 'Define My Events'
    And I click on the link labeled "Arm 2:"
    And I enter "Event 2" into the input field labeled "Descriptive name for this event"
    And I click on the input button labeled "Add new event"
    Then I should see "Event 2"
    When I enter "Event 3" into the input field labeled "Descriptive name for this event"
    And I click on the input button labeled "Add new event"
    Then I should see "Event 3"

  Scenario: 0 - Project Setup - Designate Instruments to Events
    When I click on the link labeled 'Project Setup'
    And I click on the button labeled "Designate Instruments for My Events"

    #Arm 1
    Then I should see "Arm name: "

    Given I verify the Data Collection Instrument named "Text Validation" is enabled for the Event named "Event 1"
    And I enable the Data Collection Instrument named "Data Dictionary" for the Event named "Event 1"
    And I verify the Data Collection Instrument named "Data Types" is enabled for the Event named "Event 1"
    And I enable the Data Collection Instrument named "Text Validation" for the Event named "Event 2"
    And I enable the Data Collection Instrument named "Data Dictionary" for the Event named "Event 2"
    And I enable the Data Collection Instrument named "Data Types" for the Event named "Event 2"

    #Arm 2
    And I click on the link labeled "Arm Two"
    Then I should see "Arm name: "

    Given I enable the Data Collection Instrument named "Text Validation" for the Event named "Event 1"
    And I enable the Data Collection Instrument named "Data Dictionary" for the Event named "Event 1"
    And I enable the Data Collection Instrument named "Data Dictionary" for the Event named "Event 2"
    And I enable the Data Collection Instrument named "Data Dictionary" for the Event named "Event 3"
    And I enable the Data Collection Instrument named "Data Types" for the Event named "Event 1"
    And I enable the Data Collection Instrument named "Data Types" for the Event named "Event 2"
    And I enable the Data Collection Instrument named "Data Types" for the Event named "Event 3"

  Scenario: 0 - Project Setup - Enable repeatable instruments and events
    Given I click on the link labeled 'Project Setup'
    And I should see that repeatable instruments are modifiable
    And I open the dialog box for the Repeatable Instruments and Events module
    And I select "Repeat Instruments (repeat independently of each other)" on the dropdown table field labeled "Event 1 (Arm 1: Arm 1)"
    And I check the checkbox labeled "Data Dictionary"
    And I uncheck the checkbox labeled "Data Types"
    And I select "-- not repeating --" on the dropdown table field labeled "Event 2 (Arm 1: Arm 1)"
    And I select "Repeat Entire Event (repeat all instruments together)" on the dropdown table field labeled "Event 1 (Arm 2: Arm Two)"
    And I click on the button labeled "Save"
    Then I should see a dialog containing the following text: "Successfully saved"
    And I click on the button labeled "Close" in the dialog box

  Scenario: 0 - Erase data
    Given I should see a link labeled "Other Functionality"
    When I click on the link labeled "Other Functionality"
    And I click on the button labeled "Erase all data"
    And I click on the button labeled "Erase all data" in the dialog box
    Then I should see "All data has now been deleted from the project!"

    When I close popup
    Then I should see "Data Management"

  Scenario: 0 - Project modifications to the Data Types form
    Given I click on the link labeled 'Designer'
    And I click on the link labeled 'Data Types'
    And I add a new field of type "text" and enter "Value" into the field labeled "value", validated by label "Integer"
    And I add a new field of type "text" and enter "Date Picker" into the field labeled "date_picker", validated by label "Date (M-D-Y)"
    And I add a new field of type "text" and enter "Date Picker - Now" into the field labeled "date_picker_now", validated by label "Datetime (M-D-Y H:M)"
    And I edit the field labeled "Calculated Field"
    And I enter the equation "[value]*2" into Calculation Equation of the open "Edit Field" dialog box
    And I save the field

  Scenario: 1 to 4 - Add/Edit Records
    Given I am a "standard" user who logs into REDCap
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Entry Via Instrument"
    And I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
    And I enter "John" into the data entry form field labeled "Name"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I click on the button labeled "Ignore and leave record" in the dialog box
    Then I should see "Record Home Page"

  Scenario: 5 - Edit field
    Given I click on the link labeled "Designer"
    And I click on the link labeled "Data Types"
    And I edit the field labeled "Required"
    And I mark the field as not required
    And I save the field

  Scenario: 6 to 7 - Edit record
    Given I click on the link labeled "Record Status Dashboard"

    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I should see "Editing existing Record ID 1"
    And I enter "This is a notes box.{enter}This is a notes box." into the data entry form field labeled "Notes"
    And I enter "5" into the data entry form field labeled "Value"

    #Need to Verify that Calculated Field displays accurate result (5 * 2)

    And I select the dropdown option "DDChoice1" for the Data Collection Instrument field labeled "Multiple Choice Dropdown Auto"
    And I select the radio option "Choice100" for the field labeled "Radio Button Manual"

    #And I reset the options for field labeled "Radio Button Manual"

    And I select the checkbox option "Checkbox" for the field labeled "Checkbox"
    And I select the checkbox option "Checkbox2" for the field labeled "Checkbox"

    #Add signature
    #Upload document (word doc) in file upload field
    #Open image file in descriptive text with file
    # And I click the input element identified by "ui-datepicker-trigger"
    # And I select '2' from the dropdown identified by 'select[data-handler="selectMonth"]'
    # And I select '2020' from the dropdown identified by 'select[data-handler="selectYear"]'
    And I click on the button labeled "Today"
    And I click on the button labeled "Now"
    And I select the submit option labeled "Save & Exit Record" on the Data Collection Instrument

  Scenario: 8 - Edit record & Leave without saving changes
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble

    And I select the radio option "Choice99" for the field labeled "Radio Button Manual"
    #Cypress moves too fast for REDCap ... the pop up alert does not have a chance to trigger, let's give it a chance!
    And I enter "Another changed value" into the data entry form field labeled "Text2"

    #By clicking on this button, here is our alert trigger
    When I click on the link labeled "Select other record"

    #Pop up dialog triggered by clicking on any link that would navigate us away
    Then I should see "Leave without saving changes"

    When I click on the button labeled "Leave without saving changes" in the dialog box
    Then I should see "Add / Edit Records"

    Given I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
    Then I should see the radio labeled "Radio Button Manual" with option "Choice100" selected

  Scenario: 9 to 10 - Edit record & Save and Stay
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble

    And I select the radio option "Choice99" for the field labeled "Radio Button Manual"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

    And I click on the link labeled "Select other record"
    Then I should see "Add / Edit Records"

    Given I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"

    And I select the radio option "Choice100" for the field labeled "Radio Button Manual"
    And I click on the link labeled "Select other record"

    #Pop up dialog triggered by clicking on any link that would navigate us away
    Then I should see "Save your changes?"
    And I should see "Stay on page"
    When I click on the button labeled "Stay on page" in the dialog box

    Then I should see "Record ID 1"

    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    And I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble

  Scenario: 11 - Edit record
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I enter "John Smith" into the data entry form field labeled "Name"
    And I select the submit option labeled "Save & Go To Next Record" on the Data Collection Instrument
    #unable to find field "Name" that contains John Smith
    #And I should see that the "Name" field contains the value of "John Smith"

  Scenario: 12 to 13 - Add data to the data dictionary instrument
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Dictionary" instrument on event "Event 1" for record ID "1" and click on the bubble
    And I select the radio option "Yes" for the field labeled "Yes - No"
    And I click on the button labeled "Cancel"
    Then I should see "Record Home Page"
    And I should see "not saved"

    Given I click the bubble to select a record for the "Data Dictionary" longitudinal instrument on event "Event 1"
    And I select the radio option "Yes" for the field labeled "Yes - No"
    And I select the submit option labeled "Save & Go To Next Instance" on the Data Collection Instrument
    And I select the radio option "Yes" for the field labeled "Yes - No"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

  Scenario: 14 to 16 - Change form status
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Dictionary" instrument on event "Event 1" for record ID "1" and click the repeating instrument bubble for the first instance
    And I select the dropdown option "Unverified" for the Data Collection Instrument field labeled "Complete?"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I select the dropdown option "Complete" for the Data Collection Instrument field labeled "Complete?"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

  Scenario: 17 - Add new record to Arm 1
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I click the bubble to add a record for the "Data Types" longitudinal instrument on event "Event 1"
    And I enter "Jane" into the data entry form field labeled "Name"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Arm 1:"

  Scenario: 18 to 20 - Rename record
    Given I click on the link labeled "Add / Edit Records"
    And I select record ID "2" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    And I click on the button labeled "Choose action for record"
    And I select the option labeled "Rename record"
    And I should see 'Rename record "2"'
    And I clear field and enter "3" into the input field labeled 'to the following record name'
    And I click on the button labeled "Rename record" in the dialog box
    Then I should see "Record ID 3 was successfully renamed!"
    When I click on the link labeled "Record Status Dashboard"
    Then I should see a link labeled "3"

  Scenario: 21 to 22 - Delete data for form only
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "3" and click on the bubble
    And I click on the button labeled "Delete data for THIS FORM only"
    Then I should see 'DELETE ALL DATA ON THIS FORM FOR RECORD "3"?'

    Given I click on the button labeled "Cancel" in the dialog box
    And I click on the button labeled "Delete data for THIS FORM only"
    And I click on the button labeled "Delete data for THIS FORM only" in the dialog box

  Scenario: 23 to 24 - Delete record
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "3"
    And I click on the button labeled "Choose action for record"
    And I select the option labeled "Delete record (all forms/events)"
    And I click on the button labeled "Cancel" in the dialog box
    And I click on the button labeled "Choose action for record"
    And I select the option labeled "Delete record (all forms/events)"
    And I click on the button labeled "DELETE RECORD" in the dialog box
    And I close popup
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Arm 1:"

  Scenario: 25 to 26 - Add new record for Arm 2
    Given I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm 2"
    And I click on the button labeled "Add new record for this arm"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Event 1"
    And I enter "Mary" into the data entry form field labeled "Name"
    And I select the dropdown option "Unverified" for the Data Collection Instrument field labeled "Complete?"
    Then I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

  Scenario: 27 - Add new event
    Given I see "Add new"
    And I click on the button labeled "Add new"
    Then I should see "#2"

    #Note we can select the Event name as "(#2)" after we click on the "Add new" button
    When I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "(#2)"
    Then I should see "Instance #2"

    Given I enter "Josh" into the data entry form field labeled "Name"
    And I enter "josh@noreply.com" into the data entry form field labeled "Email"
    And I select the submit option labeled "Save & Go To Next Form" on the Data Collection Instrument
    And I select the radio option "Yes" for the field labeled "Yes - No"
    And I select the submit option labeled "Save & Go To Next Form" on the Data Collection Instrument
    And I enter "June" into the data entry form field labeled "Name"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument

  Scenario: 28 - Edit record
    Given I click on the link labeled "Record Status Dashboard"
    And I locate the bubble for the "Data Types" instrument on event "Event 1" for record ID "3" and click on the bubble
    And I enter "Mary" into the data entry form field labeled "Name"
    And I select the dropdown option "Complete" for the Data Collection Instrument field labeled "Complete?"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "Record Home Page"

    Given I click the bubble to select a record for the "Data Types" longitudinal instrument on event "(#2)"
    And I enter "Mary" into the data entry form field labeled "Name"
    And I select the dropdown option "Incomplete" for the Data Collection Instrument field labeled "Complete?"
    And I select the submit option labeled "Save & Exit Form" on the Data Collection Instrument
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Arm 2:"

  Scenario: 29 to 31 - Delete Event
    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "3"
    Then I should see "Record Home Page"

    When I click the X to delete all data related to the event named "Event 1"
    And I click on the button labeled "Cancel" in the dialog box
    Then I should see "Record Home Page"

    When I click the X to delete all data related to the event named "Event 1"
    When I click on the button labeled "Delete this instance of this event" in the dialog box
    Then I should see "successfully deleted entire event of data"

    When I click on the button labeled "Choose action for record"
    And I select the option labeled "Delete record (all forms/events)"
    And I click on the button labeled "DELETE RECORD" in the dialog box
    Then I should see 'Record ID "3" was successfully deleted.'

    When I close popup
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Arm 2:"
    And I should see "No records exist yet"