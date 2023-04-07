Feature: Field Validation

  As a REDCap end user
  I want to see that Field Validation is functioning as expected

  Scenario: 0 - Project Setup
    Given I am an "admin" user who logs into REDCap
    And I create a project named "FirstProject_1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"

    And I click on the link labeled "Control Center"
    And I click on the link labeled "Field Validation Types"

    And I disable the Field Validation Type named "Date (M-D-Y)" within the Control Center
    And I disable the Field Validation Type named "Datetime (D-M-Y H:M)" within the Control Center
    And I disable the Field Validation Type named "Datetime w/ seconds (Y-M-D H:M:S)" within the Control Center
    And I disable the Field Validation Type named "Email" within the Control Center
    And I disable the Field Validation Type named "Integer" within the Control Center
    And I disable the Field Validation Type named "Number" within the Control Center
    And I disable the Field Validation Type named "Time (HH:MM)" within the Control Center

    When I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"

    And I click on the link labeled "Add / Edit Records"

    And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page

    When I click on the button labeled "Choose action for record"
    And I select the option labeled "Delete record (all forms/events)"
    And I click on the button labeled "DELETE RECORD" in the dialog box
    And I close the popup

    And I click on the link labeled "Project Setup"

    And I should see that surveys are disabled
    And I disable longitudinal mode
    And I should see that longitudinal mode is "disabled"

    And I open the dialog box for the Repeatable Instruments and Events module
    And I check the checkbox labeled "Text Validation"
    And I click on the button labeled "Save" in the dialog box

    And I should see that repeatable instruments are modifiable
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
    When I click on the button labeled "Data Dictionary"
    And I upload the data dictionary located at "core/08_FieldValidation_v1115_DataDictionary.csv"
    Then I should see "Changes Made Successfully!"

  Scenario: 4 - Open Text Validation Instrument 
    When I click on the link labeled "Designer"
    And I click on the link labeled "Text Validation"
    Then I should see a button labeled "Return to list of instruments"

  Scenario: 5 - Check Validation Options
    Given I click on the Add Field input button below the field named "Record ID"
    And I select "Text Box (Short Text, Number, Date/Time, ...)" from the Field Type dropdown of the open "Edit Field" dialog box
    Then I should see the dropdown identified by "[name=val_type]" with the options below
      | Date (D-M-Y) | Date (Y-M-D) | Datetime (M-D-Y H:M) | Datetime (Y-M-D H:M) | Datetime w/ seconds (D-M-Y H:M:S) | Datetime w/ seconds (M-D-Y H:M:S) | Phone (North America) | Zipcode (U.S.) |

    # ^ this might not be what we want, this is checking for these options and not that the options specified in the script are not there
    When I click on the button labeled "Cancel"

  Scenario: 6 - Enable Field Validation Types
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Field Validation Types"
    And I enable the Field Validation Type named "Date (M-D-Y)" within the Control Center
    And I enable the Field Validation Type named "Datetime (D-M-Y H:M)" within the Control Center
    And I enable the Field Validation Type named "Datetime w/ seconds (Y-M-D H:M:S)" within the Control Center
    And I enable the Field Validation Type named "Email" within the Control Center
    And I enable the Field Validation Type named "Integer" within the Control Center
    And I enable the Field Validation Type named "Number" within the Control Center
    And I enable the Field Validation Type named "Number (1 decimal place - comma as decimal)" within the Control Center
    And I enable the Field Validation Type named "Time (HH:MM)" within the Control Center

  Scenario: 7 - Open Text Validation Instrument
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    When I click on the link labeled "Designer"
    And I click on the link labeled "Text Validation"
    Then I should see a button labeled "Return to list of instruments"
    Given I click on the Add Field input button below the field named "Record ID"
    And I select "Text Box (Short Text, Number, Date/Time, ...)" from the Field Type dropdown of the open "Edit Field" dialog box
    Then I should see the dropdown identified by "select[id=val_type]" with the options below
      | Date (D-M-Y) | Datetime (M-D-Y H:M) | Datetime w/ seconds (Y-M-D H:M:S) | Email | Integer | Number | Number (1 decimal place - comma as decimal) | Time (HH:MM) |
    When I click on the button labeled "Cancel"

  Scenario: 8 - Add A New Record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I click the bubble to add a record for the "Text Validation" longitudinal instrument on event "Status"

  Scenario: 9 - Date (D-M-Y) Field
    When I enter "01-31-2022" into the data entry form field labeled "Date (D-M-Y)"
    And I should see a dialog containing the following text: "The value you provided could not be validated because it does not follow the expected format. Please try again."
    And I click on the button labeled "Close" in the dialog box
    Given I clear field and enter "31-01-2022" into the data entry form field labeled "Date (D-M-Y)"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
    Then I should see "Record ID 1 successfully edited"

  Scenario: 10 - DateTime (M-D-Y H:M) Field
    When I enter "01-31-2022" into the data entry form field labeled "DateTime (M-D-Y H:M)"
    And I should see a dialog containing the following text: "The value you provided could not be validated because it does not follow the expected format. Please try again."
    And I click on the button labeled "Close" in the dialog box
    Given I clear field and enter "01-31-2022 10:00" into the data entry form field labeled "DateTime (M-D-Y H:M)"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 11 - Datetime w/seconds (Y-M-D H:M:S) Field
    When I enter "01-31-2022 10:00" into the data entry form field labeled "DateTime with Seconds (Y-M-D H:M:S)"
    And I should see a dialog containing the following text: "The value you provided could not be validated because it does not follow the expected format. Please try again."
    And I click on the button labeled "Close" in the dialog box
    Given I clear field and enter "2022-01-31 10:00:04" into the data entry form field labeled "DateTime with Seconds (Y-M-D H:M:S)"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 12 - Email Field
    When I enter "redcap@" into the data entry form field labeled "Email"
    And I should see a dialog containing the following text: "This field must be a valid email address (like joe@user.com). Please re-enter it now."
    And I click on the button labeled "Close" in the dialog box
    Given I clear field and enter "redcap@user.com" into the data entry form field labeled "Email"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 13 - Integer Field
    When I enter "50.2" into the data entry form field labeled "Integer"
    And I should see a dialog containing the following text: "This value you provided is not an integer. Please try again."
    And I click on the button labeled "Close" in the dialog box
    Given I clear field and enter "50" into the data entry form field labeled "Integer"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 14 - Number Field
    When I enter "abc" into the data entry form field labeled "Numbers"
    And I should see a dialog containing the following text: "This value you provided is not a number. Please try again."
    And I click on the button labeled "Close" in the dialog box
    Given I clear field and enter "6.78" into the data entry form field labeled "Numbers"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 15 - Number (1 decimal place comma as decimal) Field
    When I enter "10.9" into the data entry form field labeled "Number (1 decimal place comma as decimal)"
    And I should see a dialog containing the following text: "The value you provided could not be validated because it does not follow the expected format. Please try again."
    And I click on the button labeled "Close" in the dialog box
    When I clear field and enter "10,9" into the data entry form field labeled "Number (1 decimal place comma as decimal)"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 16 - Time (HH:MM) Field
    When I enter "17" into the data entry form field labeled "Time (HH:MM)"
    And I should see a dialog containing the following text: "The value entered must be a time value in the following format HH:MM within the range 00:00-23:59 (e.g., 04:32 or 23:19)."
    And I click on the button labeled "Close" in the dialog box
    When I clear field and enter "17:00" into the data entry form field labeled "Time (HH:MM)"
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 17 - Date (D-M-Y) Range Field
    When I enter "15-02-22" into the data entry form field labeled "Date (D-M-Y) range"
    And I should see a dialog containing the following text: "The value you provided is outside the suggested range. (01-01-2019 - 31-01-2019). This value is admissible, but you may wish to double check it."
    And I click on the button labeled "Close" in the dialog box
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 18 - DateTime (M-D-Y H:M) Range Field
    When I enter "01-15-22 16:00" into the data entry form field labeled "DateTime (M-D-Y H:M) range"
    And I should see a dialog containing the following text: "The value you provided is outside the suggested range. (01-01-2019 10:00 - 01-01-2019 15:36). This value is admissible, but you may wish to double check it."
    And I click on the button labeled "Close" in the dialog box
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 19 - DateTime with Seconds (Y-M-D H:M:S) Range Field
    When I enter "2022-01-15 09:15:10" into the data entry form field labeled "DateTime with Seconds (Y-M-D H:M:S) range"
    And I should see a dialog containing the following text: "The value you provided is outside the suggested range. (2019-01-01 09:00:00 - 2019-01-01 09:15:00). This value is admissible, but you may wish to double check it."
    And I click on the button labeled "Close" in the dialog box
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 20 - Integer Range Field
    When I enter "30" into the data entry form field labeled "Integer range"
    And I should see a dialog containing the following text: "The value you provided is outside the suggested range. (0 - 10). This value is admissible, but you may wish to double check it."
    And I click on the button labeled "Close" in the dialog box
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 21 - Number Range Field
    When I enter "5.5" into the data entry form field labeled "Number range"
    And I should see a dialog containing the following text: "The value you provided is outside the suggested range. (5.505 - 6.005). This value is admissible, but you may wish to double check it."
    And I click on the button labeled "Close" in the dialog box
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 22 - Number (1 Decimal Place comma as decimal) Range Field
    When I enter "21,8" into the data entry form field labeled "Number (1 Decimal Place comma as decimal) range"
    And I should see a dialog containing the following text: "The value you provided is outside the suggested range. (1,0 - 20,0). This value is admissible, but you may wish to double check it."
    And I click on the button labeled "Close" in the dialog box
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument

  Scenario: 23 - Time (HH:MM) Range Field
    When I enter "05:01" into the data entry form field labeled "Time (HH:MM) range"
    And I should see a dialog containing the following text: "The value you provided is outside the suggested range. (06:00 - 08:00). This value is admissible, but you may wish to double check it."
    And I click on the button labeled "Close" in the dialog box
    And I select the submit option labeled "Save & Stay" on the Data Collection Instrument



