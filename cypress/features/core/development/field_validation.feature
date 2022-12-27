Feature: Field Validation

  As a REDCap end user
  I want to see that Field Validation is functioning as expected

  Scenario: Project Setup - 1
    Given I am an "admin" user who logs into REDCap
    And I create a project named "FirstProject_1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
  
  Scenario: Project Setup - 2
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Field Validation Types"
    And I click on the element identified by "#date_dmy > :nth-child(3) > button"
    And I click on the element identified by "#datetime_mdy > :nth-child(3) > button"
    And I click on the element identified by "#datetime_seconds_ymd > :nth-child(3) > button"
And I want to pause
    And I click on the element identified by "#email > :nth-child(3) > button"
    And I click on the element identified by "#integer > :nth-child(3) > button"
  #this one detaches 
    And I click on the element identified by "#number > :nth-child(3) > button"
  #this is already disabled
    #And I click on the element identified by "#number_1dp_comma_decimal > :nth-child(3) > button"
And I want to pause
   And I click on the element identified by "#time > :nth-child(3) > button"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"

    And I click on the link labeled "Add / Edit Records"
    And I select "1" from the dropdown identified by "[id=record]"
    When I click on the button labeled "Choose action for record"
    And I select the option labeled "Delete record (all forms/events)"
    And I click on the button labeled "DELETE RECORD" in the dialog box
    And I close popup

    And I click on the link labeled "Project Setup"
    And I should see that surveys are disabled
    When I click on the element identified by "[id=setupLongiBtn]"
    And I click on the button labeled "Disable" in the dialog box
    Then I should see that longitudinal mode is "disabled"
    When I click on the element identified by "[id=enableRepeatingFormsEventsBtn]"
    And I click on the checkbox identified by "[name=repeat_form-41-data_types]"
    And I click on the button labeled "Save" in the dialog box
    And I should see that repeatable instruments are disabled
    And I should see that auto-numbering is "enabled"
    And I should see that the scheduling module is "disabled"
    And I should see that the randomization module is "disabled"
    And I should see that the designate an email field for communications setting is "disabled"


  Scenario: 1 - Login as Admin
    Given I am an "admin" user who logs into REDCap

  Scenario: 2 - Go to My Projects Page
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"

  Scenario: 3 - Upload Data Dictionary
    Given I upload a data dictionary located at "core/08_FieldValidation_v1115_DataDictionary.csv" to project ID 14
    Then I should see "Changes Made Successfully!"
    
  Scenario: 4 - Open Text Validation Instrument 
    When I click on the link labeled "Designer"
    And I click on the link labeled "Text Validation"
    Then I should see a button labeled "Return to list of instruments"

  Scenario: 5 - Check Validation Options
    Given I click on the Add Field input button below the field named "Record ID"
    And I select "Text Box (Short Text, Number, Date/Time, ...)" from the Field Type dropdown of the open "Edit Field" dialog box
    Then I should see the dropdown identified by "[id=val_type]" with the options below
    | Date (M-D-Y) | Date (Y-M-D) | Datetime (D-M-Y H:M) | Datetime (Y-M-D H:M) | Datetime w/ seconds (D-M-Y H:M:S) | Datetime w/ seconds (M-D-Y H:M:S) | Phone (North America) | Zipcode (U.S.) |
    #this might not be what we want, this is checking for these options and not that the options specified in the script are not there
    When I click on the button labeled "Cancel"

  Scenario: 6 - Enable Field Validation Types
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Field Validation Types"
    And I click on the element identified by "#date_dmy > :nth-child(3) > button"
    And I click on the element identified by "#datetime_mdy > :nth-child(3) > button"
    And I click on the element identified by "#datetime_seconds_ymd > :nth-child(3) > button"
  And I want to pause
    And I click on the element identified by "#email > :nth-child(3) > button"
    And I click on the element identified by "#integer > :nth-child(3) > button"
  And I want to pause
    And I click on the element identified by "#number > :nth-child(3) > button"
  And I want to pause
    And I click on the element identified by "#number_1dp_comma_decimal > :nth-child(3) > button"
    And I click on the element identified by "#time > :nth-child(3) > button"

  Scenario: 7 - Open Text Validation Instrument 
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    When I click on the link labeled "Designer"
    And I click on the link labeled "Text Validation"
    Then I should see a button labeled "Return to list of instruments"
    Given I click on the Add Field input button below the field named "Record ID"
    And I select "Text Box (Short Text, Number, Date/Time, ...)" from the Field Type dropdown of the open "Edit Field" dialog box
    Then I should see the dropdown identified by "[id=val_type]" with the options below
    | Date (D-M-Y) | Datetime (M-D-Y H:M) | Datetime w/ seconds (Y-M-D H:M:S) | Email | Integer | Number | Number (1 decimal place - comma as decimal) | Time (HH:MM) |
    When I click on the button labeled "Cancel"

  Scenario: 8 - Add A New Record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    Then I should see "Record Home Page"
    When I click on the element identified by ".odd > .nowrap > a > img"
    #An empty Text Validation instrument appears for Record ID 1

  Scenario: 9 - Date (D-M-Y) Field
    When I enter "01-31-2022" into the data entry form field labeled "Date (D-M-Y)"
    Then I should see "The value you provided could not be validated because it does not follow the expected format. Please try again." 
    When I close popup
    And I enter "31-01-2022" into the data entry form field labeled "Date (D-M-Y)"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument


    






