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
      #these are all enable/disable buttons - need a step definition
    And I click on the element identified by "#datetime_mdy > :nth-child(3) > button"
    And I click on the element identified by "#datetime_seconds_ymd > :nth-child(3) > button"
And I want to pause
    # pauses are to prevent detaching
    And I click on the element identified by "#email > :nth-child(3) > button"
    And I click on the element identified by "#integer > :nth-child(3) > button" 
    And I click on the element identified by "#number > :nth-child(3) > button"
    #And I click on the element identified by "#number_1dp_comma_decimal > :nth-child(3) > button"
      #this is already disabled. this could use a "I should see that (validation type) is enabled/disabled" step definition
And I want to pause
   And I click on the element identified by "#time > :nth-child(3) > button"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"

    And I click on the link labeled "Add / Edit Records"
    And I select "1" from the dropdown identified by "[id=record]"
    #And I select "1" on the dropdown field labeled "-- select record --"
      #this fails ?
    When I click on the button labeled "Choose action for record"
    And I select the option labeled "Delete record (all forms/events)"
    And I click on the button labeled "DELETE RECORD" in the dialog box
    And I close popup

    And I click on the link labeled "Project Setup"
    And I should see that surveys are disabled
    When I click on the element identified by "[id=setupLongiBtn]"
      #we have a "I enable surveys for Project ID" and a "I should see that longitudinal mode is enable/disable" but not a "I enable longitudinal mode ..."

    And I click on the button labeled "Disable" in the dialog box
    Then I should see that longitudinal mode is "disabled"
    When I click on the element identified by "[id=enableRepeatingFormsEventsBtn]"
      #we have a "I enable surveys for Project ID" and a "I should see that repeatable instruments are enable/disable/modify" but not a "I modify repeatable instruments ..."
    And I click on the checkbox identified by "[name=repeat_form-41-data_types]"
      #doesnt have a label to identify 
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
    #fails because project is not in production (and not in draft mode) so box reads "Changes Made Successfully!" and not "Changes to the DRAFT have been made successfully!"
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
    # ^ this might not be what we want, this is checking for these options and not that the options specified in the script are not there
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
    #the step definition "When I click on the bubble for the "Text Validation" data collection instrument for record ID "1"" fails

  Scenario: 9 - Date (D-M-Y) Field
    When I enter "01-31-2022" into the data entry form field labeled "Date (D-M-Y)"
    Then I should see "The value you provided could not be validated because it does not follow the expected format. Please try again." 
    Given I clear the field and enter "31-01-2022" into the "val_date_dmy" text input field
    #Given I clear the field labeled "Date (D-M-Y)"
    #And I enter "31-01-2022" into the input field labeled "Date (D-M-Y)"
      #I think these two should work if we wanted to avoid the "val_date_dmy" but the individual clear the field step def doesnt recognize field label
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 10 - DateTime (M-D-Y H:M) Field
    When I enter "01-31-2022" into the data entry form field labeled "DateTime (M-D-Y H:M)"
    Then I should see "The value you provided could not be validated because it does not follow the expected format. Please try again." 
    Given I clear the field and enter "01-31-2022 10:00" into the "val_datetime_mdy" text input field
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 11 - Datetime w/seconds (Y-M-D H:M:S) Field
    When I enter "01-31-2022 10:00" into the data entry form field labeled "DateTime with Seconds (Y-M-D H:M:S)"
    Then I should see "The value you provided could not be validated because it does not follow the expected format. Please try again." 
    Given I clear the field and enter "2022-01-31 10:00:04" into the "val_datetime_seconds_ymd" text input field
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 12 - Email Field
    When I enter "redcap@" into the data entry form field labeled "Email"
    Then I should see "This field must be a valid email address (like joe@user.com). Please re-enter it now." 
    Given I clear the field and enter "redcap@user.com" into the "val_email" text input field
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 13 - Integer Field
    When I enter "50.2" into the data entry form field labeled "Integer"
    Then I should see "This value you provided is not an integer. Please try again." 
    Given I clear the field and enter "50" into the "val_integer" text input field
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 14 - Number Field
    When I enter "abc" into the data entry form field labeled "Numbers"
    Then I should see "This value you provided is not a number. Please try again." 
    Given I clear the field and enter "6.78" into the "val_number" text input field
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 15 - Number (1 decimal place comma as decimal) Field
    When I enter "10.9" into the data entry form field labeled "Number (1 decimal place comma as decimal)"
    Then I should see "The value you provided could not be validated because it does not follow the expected format. Please try again." 
    Given I clear the field and enter "10,9" into the "val_number_1dp" text input field
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 16 - Time (HH:MM) Field
    When I enter "17" into the data entry form field labeled "Time (HH:MM)"
    Then I should see "The value entered must be a time value in the following format HH:MM within the range 00:00-23:59 (e.g., 04:32 or 23:19)." 
    Given I clear the field and enter "17:00" into the "val_time" text input field
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 17 - Date (D-M-Y) Range Field
    When I enter "15-02-22" into the data entry form field labeled "Date (D-M-Y) range"
    Then I should see "The value you provided is outside the suggested range. (01-01-2019 - 31-01-2019). This value is admissible, but you may wish to double check it." in an alert box
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 18 - DateTime (M-D-Y H:M) Range Field
    When I enter "01-15-22 16:00" into the data entry form field labeled "DateTime (M-D-Y H:M) range"
    Then I should see "The value you provided is outside the suggested range. (01-01-2019 10:00 - 01-01-2019 15:36). This value is admissible, but you may wish to double check it." in an alert box
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 19 - DateTime with Seconds (Y-M-D H:M:S) Range Field
    When I enter "2022-01-15 09:15:10" into the data entry form field labeled "DateTime with Seconds (Y-M-D H:M:S) range"
    Then I should see "The value you provided is outside the suggested range. (2019-01-01 09:00:00 - 2019-01-01 09:15:00). This value is admissible, but you may wish to double check it." in an alert box
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 20 - Integer Range Field
    When I enter "30" into the data entry form field labeled "Integer range"
    Then I should see "The value you provided is outside the suggested range. (0 - 10). This value is admissible, but you may wish to double check it." in an alert box
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 21 - Number Range Field
    When I enter "5.5" into the data entry form field labeled "Number range"
    Then I should see "The value you provided is outside the suggested range. (5.505 - 6.005). This value is admissible, but you may wish to double check it." in an alert box
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 22 - Number (1 Decimal Place comma as decimal) Range Field
    When I enter "21,8" into the data entry form field labeled "Number (1 Decimal Place comma as decimal) range"
    Then I should see "The value you provided is outside the suggested range. (1,0 - 20,0). This value is admissible, but you may wish to double check it." in an alert box
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 23 - Time (HH:MM) Range Field
    When I enter "05:01" into the data entry form field labeled "Time (HH:MM) range"
    Then I should see "The value you provided is outside the suggested range. (06:00 - 08:00). This value is admissible, but you may wish to double check it." in an alert box
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument



