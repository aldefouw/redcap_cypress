Feature: Data Entry through the Data Collection Instrument

  As a REDCap end user
  I want to see that Data Entry through the Data Collection Instruments is functioning as expected

  Scenario: 0 - Create the Project
    Given I am an "admin" user who logs into REDCap
    And I create a project named "14_DirectDataEntrywithDataCollectionInstrument_v1115" with project purpose Operational Support via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
  
  Scenario: 0 -  Add user
    When I visit Project ID 14
    Then I click on the link labeled "User Rights"
    And I enter "test_user" into the username input field
    And I click on the button labeled "Add with custom rights"
    And I check the user right identified by 'input[name="design"]'
    And I check the user right identified by 'input[name="data_export_tool"]' and select option "1"
    And I check the user right identified by 'input[name="data_logging"]'
    And I check the user right identified by 'input[name="record_delete"]'
    And I check the user right identified by 'input[name="record_create"]'
    And I click the user right identified by 'input[name="record_rename"]'
    And I save changes within the context of User Rights

  Scenario: 0 - Instrument setup
    When I visit Project ID 14
    Then I click on the link labeled "Designer"
    And I create a new instrument from scratch
    And I click on the button labeled "Add instrument here"
    And I enter name "Data Dictionary" and create instrument
    Then I click on the link labeled "Designer"
    And I click on the link labeled "Data Dictionary"
    And I add a new field of type "yesno" and enter "Yes - No" into the field labeled "yesno"
    Then I should see "test"
    And I click on the link labeled "Designer"
    Then I should see "Data Collection Instruments"

  Scenario: 0 - Project Setup - Define Events
    When I visit Project ID 14
    Then I click on the link labeled 'Project Setup'
    And I click on the button labeled 'Define My Events'
    And I click on the link labeled "Arm 2:"
    And I enter "Event 2" into the field identified by "[id=descrip]"
    And I click on the input button labeled "Add new event"
    Then I should see "Event 2"
    And I enter "Event 3" into the field identified by "[id=descrip]"
    And I click on the input button labeled "Add new event"
    Then I should see "Event 3"
  
  Scenario: 0 - Project Setup - Designate Instruments to Events
    When I visit Project ID 14
    Then I click on the link labeled 'Project Setup'
    And I click on the button labeled "Designate Instruments for My Events"
    And I visit the version URL "Design/designate_forms.php?pid=14&arm=1"
    Then I should see "Arm 1"
    And I click on the button labeled "Begin Editing"
    And I click on the element identified by "[id=data_dictionary--41]"
    And I click on the button labeled "Save"
    And I visit the version URL "Design/designate_forms.php?pid=14&arm=2"
    Then I should see "Arm 2"
    And I click on the button labeled "Begin Editing"
    And I click on the element identified by "[id=text_validation--44]"
    And I click on the element identified by "[id=data_types--45]"
    And I click on the element identified by "[id=data_types--46]"
    And I click on the button labeled "Save"

  Scenario: 0 - Project Setup - Enable repeatable instruments and events
    When I visit Project ID 14
    Then I click on the link labeled 'Project Setup'
    And I click the input element identified by '[id=enableRepeatingFormsEventsBtn]'
    And I select 'Repeat Instruments (repeat independently of each other)' from the dropdown identified by 'select[name="repeat_whole_event-41"]'
    And I uncheck the checkbox identified by 'input[name="repeat_form-41-data_types"]'
    And I check the checkbox identified by 'input[name="repeat_form-41-data_dictionary"]'
    And I select '-- not repeating --' from the dropdown identified by 'select[name="repeat_whole_event-42"]'
    And I select 'Repeat Entire Event (repeat all instruments together)' from the dropdown identified by 'select[name="repeat_whole_event-44"]'
    And I click on the button labeled "Save"

  Scenario: 0 - Erase data
    When I visit Project ID 14
    Then I click on the link labeled 'Other Functionality'
    And I click on the button labeled "Erase all data"
    And I click on the button labeled "Erase all data" in the dialog box

  Scenario: 0 - Project modifications to the Data Types form
    When I visit Project ID 14
    Then I click on the link labeled 'Designer'
    And I click on the link labeled 'Data Types'
    And I add a new field of type "text" and enter "Value" into the field labeled "value", validated by label "Integer"
    And I add a new field of type "text" and enter "Date Picker" into the field labeled "date_picker", validated by label "Date (M-D-Y)"
    And I add a new field of type "text" and enter "Date Picker - Now" into the field labeled "date_picker_now", validated by label "Datetime (M-D-Y H:M)"
    #And I edit the field labeled "Calculated Field"
    #add value*2 calculated equation
  
  Scenario: 1 to 4 - Add/Edit Records
    Given I am a "standard" user who logs into REDCap
    And I visit Project ID 14
    Then I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    #And I click on the bubble for the "Data Types" data collection instrument for record ID "1"
    And I visit the version URL "DataEntry/index.php?pid=14&id=1&event_id=41&page=data_types&auto=1"
    #And I visit the version URL "DataEntry/index.php?pid=14&id=1&page=data_types&auto=1"
    And I enter "John" into the "ptname" text input field
    And I click on the element identified by 'button[id="submit-btn-dropdown"]:first'
    And I should see "Save & Stay"
    And I click on the link labeled "Save & Stay"
    And I click on the button labeled "Ignore and leave record" in the dialog box

  Scenario: 5 - Edit field
    When I visit Project ID 14
    Then I click on the link labeled "Designer"
    And I click on the link labeled "Data Types"
    And I edit the field labeled "Required"
    And I click the input element identified by 'input#field_req0'
    And I click on the button labeled "Save"

  Scenario: 6 to 7 - Edit record
    When I visit Project ID 14
    And I click on the link labeled "Record Status Dashboard"
    #And I click on the bubble for the "Data Types" data collection instrument for record ID "1"
    Then I visit the version URL "DataEntry/index.php?pid=14&id=1&event_id=41&page=data_types&instance=1"
    #And I visit the version URL "DataEntry/index.php?pid=14&id=1&page=data_types&auto=1"
    #not puting text in the notes box, instead edits the ptname field??
    And I enter "This is a notes box." into the field identified by 'textarea[name="notesbox"]' 
    And I enter "5" into the field identified by "input[name='value']"
    And I select 'DDChoice5' from the dropdown identified by 'select[name="multiple_dropdown_manual"]'
    And I click the input element identified by 'input#opt-radio_button_manual_100'
    And I reset the options for field labeled 'Radio Button Manual'
    And I check the checkbox identified by 'input[id="id-__chk__checkbox_RC_1"]'
    And I check the checkbox identified by 'input[id="id-__chk__checkbox_RC_2"]'
    #Add signature
    #Upload document (word doc) in file upload field
    #Open image file in descriptive text with file 
    # And I click the input element identified by "ui-datepicker-trigger"
    # And I select '2' from the dropdown identified by 'select[data-handler="selectMonth"]'
    # And I select '2020' from the dropdown identified by 'select[data-handler="selectYear"]'
    And I click on the button labeled "Today"
    And I click on the button labeled "Now"
    And I click on the element identified by 'button[id="submit-btn-dropdown"]:first'
    And I should see "Save & Exit Record"
    And I click on the link labeled "Save & Exit Record"
  
  Scenario: 8 - Edit record & Leave without saving changes
    When I visit Project ID 14
    And I click on the link labeled "Record Status Dashboard"
    Then I visit the version URL "DataEntry/index.php?pid=14&id=1&event_id=41&page=data_types&instance=1"
    And I click the input element identified by 'input#opt-radio_button_manual_100'
    And I click on the link labeled "Select other record"
    And I click on the button labeled "Leave without saving changes" in the dialog box
    Then I visit the version URL "DataEntry/index.php?pid=14&id=1&event_id=41&page=data_types&instance=1"
  
  Scenario: 9 to 10 - Edit record & Save and Stay
    When I visit Project ID 14
    And I click on the link labeled "Record Status Dashboard"
    Then I visit the version URL "DataEntry/index.php?pid=14&id=1&event_id=41&page=data_types&instance=1"
    And I click the input element identified by 'input#opt-radio_button_manual_100'
    And I click on the element identified by 'button[id="submit-btn-dropdown"]:first'
    And I should see "Save & Stay"
    And I click on the link labeled "Save & Stay"
    And I click on the link labeled "Select other record"
    And I select '1' from the dropdown identified by 'select[id="record"]'
    And I visit the version URL "DataEntry/index.php?pid=14&id=1&event_id=41&page=data_types&instance=1"
    And I select 'DDChoice1' from the dropdown identified by 'select[name="multiple_dropdown_auto"]'
    And I click on the link labeled "Select other record"
    And I click on the button labeled "Stay on page" in the dialog box
    And I click on the button labeled "Save & Exit Form"
  
  Scenario: 11 - Edit record
    When I visit Project ID 14
    And I click on the link labeled "Record Status Dashboard"
    Then I visit the version URL "DataEntry/index.php?pid=14&id=1&event_id=41&page=data_types&instance=1"
    And I clear the field and enter "John Smith" into the "ptname" text input field
    And I click on the element identified by 'button[id="submit-btn-dropdown"]:first'
    And I should see "Save & Go To Next Record"
    And I click on the link labeled "Save & Go To Next Record"
    Then I visit the version URL "DataEntry/index.php?pid=14&id=1&event_id=41&page=data_types&instance=1"
    #unable to find field "Name" that contains John Smith 
    #And I should see that the "Name" field contains the value of "John Smith"
  
  Scenario: 12 to 13 - Add data to the data dictionary instrument
    When I visit Project ID 14
    And I click on the link labeled "Record Status Dashboard"
    Then I visit the version URL "DataEntry/index.php?pid=14&id=1&event_id=41&page=data_dictionary&instance=1"
    And I click the input element identified by 'input#opt-yesno_1'
    And I click on the button labeled "Cancel"
    Then I visit the version URL "DataEntry/index.php?pid=14&id=1&event_id=41&page=data_dictionary&instance=1"
    And I click the input element identified by 'input#opt-yesno_1'
    And I click on the element identified by 'button[id="submit-btn-dropdown"]:first'
    And I should see "Save & Go To Next Instance"
    And I click on the link labeled "Save & Go To Next Instance"
    And I click the input element identified by 'input#opt-yesno_0'
    Then I click on the button labeled "Save & Exit Form"
  
  Scenario: 14 to 16 - Change form status
    When I visit Project ID 14
    And I click on the link labeled "Designer"
    Then I visit the version URL "DataEntry/index.php?pid=14&id=1&event_id=41&page=data_dictionary&instance=1"
    And I select 'Unverified' from the dropdown identified by 'select[name="data_dictionary_complete"]'
    And I click on the element identified by 'button[id="submit-btn-dropdown"]:first'
    And I should see "Save & Stay"
    And I click on the link labeled "Save & Stay"
    And I select 'Complete' from the dropdown identified by 'select[name="data_dictionary_complete"]'
    Then I click on the button labeled "Save & Stay"
    Then I click on the button labeled "Save & Exit Form"
  
  Scenario: 17 - Add new record to Arm 1
    When I visit Project ID 14
    And I click on the link labeled "Add / Edit Records"
    Then I click on the button labeled "Add new record"
    And I visit the version URL "DataEntry/index.php?pid=14&id=2&event_id=41&page=data_types&auto=1"
    And I enter "Jane" into the "ptname" text input field
    Then I click on the button labeled "Save & Exit Form"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Arm 1:"
  
  Scenario: 18 to 20 - Rename record
    When I visit Project ID 14
    And I click on the link labeled "Record Status Dashboard"
    #Then I click on the element identified by 'tr.odd > td > a:contains("2")'
    Then I visit the version URL "DataEntry/record_home.php?pid=14&arm=1&id=2"
    And I click on the button labeled "Choose action for record"
    And I select the option labeled "Rename record"
    And I clear the field identified by 'input[id="new-record-name"]'
    And I enter "3" into the field identified by 'input[id="new-record-name"]'
    And I click on the button labeled "Rename record" in the dialog box
    And I click on the link labeled "Record Status Dashboard"
    Then I should see a link labeled "3"
  
  Scenario: 21 to 22 - Delete data for form only
    When I visit Project ID 14
    And I click on the link labeled "Record Status Dashboard"
    Then I visit the version URL "DataEntry/index.php?pid=14&id=3&page=data_types&event_id=41&instance=1"
    And I click on the button labeled "Delete data for THIS FORM only"
    Then I should see 'DELETE ALL DATA ON THIS FORM FOR RECORD "3"?'
    And I click on the button labeled "Cancel" in the dialog box
    And I click on the button labeled "Delete data for THIS FORM only"
    And I click on the button labeled "Delete data for THIS FORM only" in the dialog box
  
  Scenario: 23 to 24 - Delete record
    When I visit Project ID 14
    And I click on the link labeled "Record Status Dashboard"
    Then I click on the link labeled "3"
    And I click on the button labeled "Choose action for record"
    And I select the option labeled "Delete record (all forms/events)"
    And I click on the button labeled "Cancel" in the dialog box
    Then I click on the button labeled "Choose action for record"
    And I select the option labeled "Delete record (all forms/events)"
    And I click on the button labeled "DELETE RECORD" in the dialog box
    Then I close popup
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Arm 1:"
  
  Scenario: 25 to 26 - Add new record for Arm 2
    When I visit Project ID 14
    # And I click on the link labeled "Add / Edit Records"
    # And I select 'Arm 2: Arm Two' from the dropdown identified by 'select[id="arm_name"]'
    # Then I click on the button labeled "Add new record for the arm selected above"
    And I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm 2"
    And I click on the button labeled "Add new record for this arm"
    And I visit the version URL "DataEntry/index.php?pid=14&id=3&event_id=44&page=text_validation"
    And I enter "Mary" into the "ptname_v2_v2" text input field
    And I select 'Unverified' from the dropdown identified by 'select[name="text_validation_complete"]'
    Then I click on the button labeled "Save & Exit Form"

  Scenario: 27 - Add new event 
    When I visit Project ID 14
    And I click on the link labeled "Record Status Dashboard"
    #Then I click on the element identified by 'tr.odd > td > a:contains("2")'
    Then I visit the version URL "DataEntry/record_home.php?pid=14&arm=2&id=3"
    And I click on the button labeled "Add new"
    And I visit the version URL "DataEntry/index.php?pid=14&id=3&event_id=44&page=text_validation&instance=2"
    And I enter "Josh" into the "ptname_v2_v2" text input field
    And I enter "josh@noreply.com" into the "email_v2" text input field
    And I click on the element identified by 'button[id="submit-btn-dropdown"]:first'
    And I should see "Save & Go To Next Form"
    Then I click on the link labeled "Save & Go To Next Form"
    And I enter "June" into the "ptname" text input field
    Then I click on the button labeled "Save & Exit Form"

  Scenario: 28 - Edit record
    When I visit Project ID 14
    And I click on the link labeled "Record Status Dashboard"
    #Then I click on the element identified by 'tr.odd > td > a:contains("2")'
    Then I visit the version URL "DataEntry/record_home.php?pid=14&arm=2&id=3"
    And I visit the version URL "DataEntry/index.php?pid=14&id=3&event_id=44&page=data_types"
    And I enter "Mary" into the "ptname" text input field
    And I select 'Complete' from the dropdown identified by 'select[name="data_types_complete"]'
    Then I click on the button labeled "Save & Exit Form"
    And I visit the version URL "DataEntry/index.php?pid=14&id=3&event_id=45&page=data_types"
    And I enter "Mary" into the "ptname" text input field
    And I select 'Incomplete' from the dropdown identified by 'select[name="data_types_complete"]'
    Then I click on the button labeled "Save & Exit Form"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see "Arm 2:"
  
  Scenario: 29 to 31 - Delete Event
    When I visit Project ID 14
    And I click on the link labeled "Record Status Dashboard"
    Then I visit the version URL "DataEntry/record_home.php?pid=14&arm=2&id=3"
    And I click on the element identified by ':nth-child(3) > :nth-child(4) > a > .fas'
    And I click on the button labeled "Cancel" in the dialog box
    And I click on the element identified by ':nth-child(3) > :nth-child(4) > a > .fas'
    And I click on the button labeled "Delete this event" in the dialog box
    And I click on the button labeled "Choose action for record"
    And I select the option labeled "Delete record (all forms/events)"
    And I click on the button labeled "DELETE RECORD" in the dialog box
    Then I click on the link labeled "Record Status Dashboard"