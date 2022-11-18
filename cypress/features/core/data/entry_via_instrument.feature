Feature: Data Entry through the Data Collection Instrument

  As a REDCap end user
  I want to see that Data Entry through the Data Collection Instruments is functioning as expected

  Scenario: 0 - Create the Project
    Given I am an "admin" user who logs into REDCap
    And I create a project named "14_DirectDataEntrywithDataCollectionInstrument_v1115" with project purpose Operational Support via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
  
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
    #And I click on the checkbox labeled "Data Dictionary"

  Scenario: 0 - Project modifications to the Data Types form
    When I visit Project ID 14
    Then I click on the link labeled 'Designer'
    And I click on the link labeled 'Data Types'
    And I add a new field of type "text" and enter "Value" into the field labeled "Value", validated by label "Integer" identified by 'select[name="integer"]'
    Then I should see "Value"


