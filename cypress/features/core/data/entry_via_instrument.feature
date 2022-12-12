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
    And I add a new field of type "yesno" and enter "test" into the field labeled "test"
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
    #And I click on the checkbox labeled "Data Dictionary"

  # Scenario: 0 - Project modifications to the Data Types form
  #   When I visit Project ID 14
  #   Then I click on the link labeled 'Designer'
  #   And I click on the link labeled 'Data Types'
  #   And I add a new field of type "text" and enter "Value" into the field labeled "Value", validated by label "Integer"
  #   And I edit the field labeled "Calculated Field"
  #   #add value*2 calculated equation
  #   And I add a new field of type "text" and enter "Date Picker" into the field labeled "Date Picker", validated by label "M-D-Y"
  #   And I add a new field of type "text" and enter "Date Picker - Now" into the field labeled "Date Picker - Now", validated by label "M-D-Y H:M"
  
  # Scenario: 1 - Login as test_user
  #   Given I am a "standard" user who logs into REDCap
  #   And I visit Project ID 14

  # Scenario: 2 to 4 - Add/Edit Records
  #   When I visit Project ID 14
  #   Then I click on the link labeled "Add / Edit Records"
  #   And I click on the button labeled "Add new record"
  #   And I click on the bubble for the "Data Types" data collection instrument for record ID "1"
  #   And I enter "John" into the "ptname" text input field
  #   And I click on the element identified by 'button[id="submit-btn-dropdown"]:first'
  #   And I should see "Save & Stay"
  #   And I click on the link labeled "Save & Stay"
  #   And I click on the button labeled "Ignore and leave record"

  # Scenario: 5 - Edit field
  #   When I visit Project ID 14
  #   Then I click on the link labeled "Designer"
  #   And I edit the field labeled "Required"
  #   And I click the input element identified by 'input#field_req0'
  #   And I click on the button labeled "Save"

  # Scenario: 6 - Edit record
  #   When I visit Project ID 14
  #   Then I click on the link labeled "Record Status Dashboard"
  #   And I click on the bubble for the "Data Types" data collection instrument for record ID "1"
  #   And I enter "This is a notes box" into the "notebox" text input field
  #   And I enter "5" into the "value" text input field
