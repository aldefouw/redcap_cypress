Feature: User Interface: The system shall support text validation for text field types: Date (Y-M-D) | Datetime (Y-M-D H:M) | Datetime w/seconds (Y-M-D H:M:S) |  Email  | Integer | Numbers | Number (1 decimal place - comma as decimal) | Time (HH:MM)  | Time (MM:SS) | Time (HH:MM:SS)

As a REDCap end user
I want to see that Field validation is functioning as expected

#Scenario: B.4.8.200.100 Field validation type
#
##SETUP
#Given I login to REDCap with the user "Test_Admin"
#And I create a new project named "B.4.8.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_4.8.xml", and clicking the "Create Project" button
#When I click on the link labeled "My Projects"
#And I click on the link labeled "B.4.8.200.100"
#
##SETUP _PRODUCTION
#When I click on the link labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
#Then I should see "Project status: Production"
#
###VERIFY_CODEBOOK
#When I click on the link labeled "Codebook"
#Then I should see a table header and rows containing the following values in the Data Dictionary Codebook data table:
#| Variable / Field Name|   Field Label  |      Field Attributes      |
#|     [date_ymd]              |   date YMD   |      text (date_ymd, Min: 2023-08-01, Max: 2023-08-31) |
#| [datetime_ymd_hm]    |   Datetime     | text (datetime_ymd, Min: 2023-09-01 01:01, Max: 2023-09-30 01:59)|
#| [datetime_ymd_hmss  ] |  Datetime YMD HMSS| text (datetime_seconds_ymd, Min: 2023-09-01 11:01:01, Max: 2023-09-30 11:01:01)|
#|     [email]                 |   Email   |      text (email)|
#|     [integer]              |  Integer|      text (integer, Min: 1, Max: 100) |
#|     [number]             |   Number   |      text (number, Min: 1, Max: 5)|
#|     [number_dec]    |   Number Decimal   |      text (number_1dp, Min: 1.0, Max: 5.0)|
#|     [num_comma]   |   Number Comma  |      text (number_1dp_comma_decimal, Min: 1,0, Max: 2,0) |
#|     [time_hhmm]    |   Time HH:MM   |      text (time, Min: 08:05, Max: 23:00)|
#|     [time_mm_ss]   |   Time MM:SS   |      text (time_mm_ss, Min: 02:01, Max: 59:00)|
#|     [time_hhmmss] |   Time HH:MM:SS  | text (time_hh_mm_ss, Min: 8:01:01, Max: 23:00:00)|
#
###ACTION:
#When I click the link labeled "Add/Edit Records"
#And I click the button labeled "Add new record for the arm selected above"
#And I click the bubble labeled "Date Types" for event "Event 1"
#Then I should see "Adding new Record ID 5."
#
##FUNCTIONAL REQUIREMENT: field validation with accurate selection
#When I enter "2023-08-02" for the field labeled "date YMD"
#And I enter "2023-09-02 01:03" for the field labeled "Datetime"
#And I enter "2023-09-02 01:03:01" for the field labeled "Datetime YMD HMSS"
#And I enter "99" for the field labeled "Integer"
#And I enter "4" for the field labeled "Number"
#And I enter "1.5" for the field labeled "Number Decimal"
#And I enter "1,5" for the field labeled "Number Comma"
#And I enter "08:10" for the field labeled "Time HH:MM"
#And I enter "02:05" for the field labeled "Time MM:SS"
#And I enter "08:59:59" for the field labeled "Time HH:MM:SS"
#And I click on the button labeled "Save & Stay"
#Then I should see "Record ID 5 successfully edited."
#
#When I click the link labeled "Text Validation"
#Then I should see "Editing existing Record ID 5"
#
#When I enter "email@test.edu" for the field labeled "Email"
#And I click on the button labeled "Save & Stay"
#Then I should see "Record ID 5 successfully edited."
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#And I click on the button labeled "Leave without saving changes" in the dialog box
#Then I should see a table header and rows including the following values in the logging table:
#| Username   |        Action           | List of Data Changes OR Fields Exported |
#| test_admin | Update record 5 | email = 'email@test.edu'|
#| test_admin | Create record 5 | date_ymd = '2023-08-02'|
#| test_admin | Create record 5 | datetime_ymd_hm = '2023-09-02 01:03'|
#| test_admin | Create record 5 | datetime_ymd_hmss = '2023-09-02 01:03:01'|
#| test_admin | Create record 5 | integer = '99'|
#| test_admin | Create record 5 | number = '4'|
#| test_admin | Create record 5 | number_dec = '1.5'|
#| test_admin | Create record 5 | num_comma = '1,5'|
#| test_admin | Create record 5 | time_hhmm = '08:10'|
#| test_admin | Create record 5 | time_mm_ss = '02:05'|
#| test_admin | Create record 5 | time_hhmmss = '08:59:59'|
#
###VERIFY_DE
#When I click on the link labeled "Data Exports, Reports, and Stats"
#Then I should see a table row containing the following values in the reports table:
#| A | All data (all records and fields) |
#
#When I click on the button labeled "View Report"
#Then I should see a table header and rows including the following values in the report data table:
#| Record ID | Repeat Instrument | date YMD |        Datetime         | Datetime YMD HMSS     | Integer | Number|
#|          5       |      Date Types          | 2023-08-02|2023-09-02 01:03|  2023-09-02 01:03:01    |      99     |      4        |
#
#Then I should see a table header and rows containing the following values in the report data table:
#|Record ID| Repeat Instrument| Number Decimal| Number Comma| Time HH:MM | Time MM:SS |Time HH:MM:SS|
#|          5     |       Data Types        |            1.5              |             1,5            |        08:10        |        02:05       |          08:59:59|
#
#Then I should see a table header and rows containing the following values in the report data table:
#|Record ID | Email|
#|          5     | email@test.edu |
#
##FUNCTIONAL REQUIREMENT
###ACTION - Verify field validation with out of range values (works)
#When I click the link labeled "Add/Edit Records"
#And I click the button labeled "Add new record for the arm selected above"
#And I click the bubble labeled "Date Types" for event "Event 1"
#Then I should see "Adding new Record ID 6"
#
#When I enter "2023-09-01" for the field labeled "date YMD"
#And I click on the field labeled "Datetime"
#Then I should see "Alert" in the dialog box
#And I should see "The value you provided is outside the suggested range (2023-08-01 - 2023-08-31). This value is admissible, but you may wish to double check it." in the dialog box
#And I click the button labeled "Close" in the dialog box
#
#When I enter "2023-08-02 01:03" for the field labeled "Datetime"
#And I click on the field labeled "Datetime YMD HMSS"
#Then I should see "Alert" in the dialog box
#And I should see "The value you provided is outside the suggested range (2023-09-01 01:01 - 2023-09-30 01:59). This value is admissible, but you may wish to double check it."
#And I click the button labeled "Close" in the dialog box
#
#When I enter "2023-10-02 01:03:01" for the field labeled "Datetime YMD HMSS"
#And I click on the field labeled "Integer"
#Then I should see "Alert" in the dialog box
#And I should see "The value you provided is outside the suggested range (2023-09-01 11:01:01 - 2023-09-30 11:01:01). This value is admissible, but you may wish to double check it."
#And I click the button labeled "Close" in the dialog box
#
#When I enter "101" for the field labeled "Integer"
#And I click on the field labeled "Number"
#Then I should see "Alert" in the dialog box
#And I should see " The value you provided is outside the suggested range (1 - 100). This value is admissible, but you may wish to double check it."
#And I click the button labeled "Close" in the dialog box
#
#When I enter "6" for the field labeled "Number"
#And I click on the field labeled "Number Decimal"
#Then I should see "Alert" in the dialog box
#And I should see "The value you provided is outside the suggested range (1 - 5). This value is admissible, but you may wish to double check it."
#And I click the button labeled "Close" in the dialog box
#
#When I enter "5.1" for the field labeled "Number Decimal"
#And I click on the field labeled "Number Comma"
#Then I should see "Alert" in the dialog box
#And I should see "The value you provided is outside the suggested range (1.0 - 5.0). This value is admissible, but you may wish to double check it."
#And I click the button labeled "Close" in the dialog box
#
#When I enter "5,1" for the field labeled "Number Comma"
#And I click on the field labeled "Time HH:MM"
#Then I should see "Alert" in the dialog box
#And I should see "The value you provided is outside the suggested range (1,0 - 2,0). This value is admissible, but you may wish to double check it."
#And I click the button labeled "Close" in the dialog box
#
#When I enter "07:05" for the field labeled "Time HH:MM"
#And I click on the field labeled "Time MM:SS"
#Then I should see "Alert" in the dialog box
#And I should see "The value you provided is outside the suggested range (08:05 - 23:00). This value is admissible, but you may wish to double check it."
#And I click the button labeled "Close" in the dialog box
#
#When I enter "01:59" for the field labeled "Time MM:SS"
#And I click on the field labeled "Time HH:MM:SS"
#Then I should see "Alert" in the dialog box
#And I should see "The value you provided is outside the suggested range (02:01 - 59:00). This value is admissible, but you may wish to double check it."
#And I click the button labeled "Close" in the dialog box
#
#When I enter "07:59:59" for the field labeled "Time HH:MM:SS"
#And I click on the field labeled " MM:SS"
#Then I should see "Alert" in the dialog box
#And I should see "The value you provided is outside the suggested range (08:01:01 - 23:00:00). This value is admissible, but you may wish to double check it."
#
#When I click the button labeled "Close" in the dialog box
#And I click on the button labeled "Save & Exit Form"
#Then I should see "Record ID 6 successfully added."
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#And I click on the button labeled "Save changes and leave" in the dialog box
#Then I should see a table header and rows containing the following values in the logging table:
#| Username   |        Action           | List of Data Changes OR Fields Exported |
#| Test_admin | Create record 6 | date_ymd = '2023-09-01'|
#| Test_admin | Create record 6 | datetime_ymd_hm = '2023-08-02 01:03'|
#| Test_admin | Create record 6 | datetime_ymd_hmss = '2023-10-02 01:03:01'|
#| Test_admin | Create record 6 | integer = '101'|
#| Test_admin | Create record 6 | number = '6'|
#| Test_admin | Create record 6 | number_dec = '5.1'|
#| Test_admin | Create record 6 | num_comma = '5,1'|
#| Test_admin | Create record 6 | time_hhmm = '07:05'|
#| Test_admin | Create record 6 | time_mm_ss = '01:59'|
#| Test_admin | Create record 6 | time_hhmmss = '07:59:59'|
#
###VERIFY_DE
#When I click on the link labeled "Data Exports, Reports, and Stats"
#Then I should see a table row containing the following values in the reports table:
#| A | All data (all records and fields) |
#
#When I click on the button labeled "View Report"
#Then I should see a table header and rows containing the following values in the report data table:
#| Record ID | Repeat Instrument | date YMD  |        Datetime         | Datetime YMD HMSS     | Integer | Number|
#|          6       |      Date Types          | 2023-09-01|2023-08-02 01:03|  2023-10-02 01:03:01    |      101     |      6        |
#
#And I should see a table header and rows containing the following values in the report data table:
#|Record ID| Repeat Instrument| Number Decimal| Number Comma| Time HH:MM | Time MM:SS |Time HH:MM:SS|
#|          6     |       Data Types        |            5.1              |             5,1            |        07:05        |        01:59       |          07:59:59|
#
##FUNCTIONAL REQUIREMENT
###ACTION - Verify field validation with characters (will not work)
#When I click the link labeled "Add/Edit Records"
#And I click the button labeled "Add new record for the arm selected above"
#And I click the bubble labeled "Date Types" for event "Event 1"
#Then I should see "Adding new Record ID 7."
#
#When I enter "TEST" for the field labeled "date YMD"
#And I click on the field labeled "Datetime"
#Then I should see "Alert" in the dialog box
#And I should see " The value you provided could not be validated because it does not follow the expected format. Please try again. Required format: Date (Y-M-D)" in the dialog box
#And I click the button labeled "Close" in the dialog box
#
#When I delete "TEST" for the field labeled "date YMD"
#And I enter "TEST" for the field labeled "Datetime"
#Then I should see "Alert" in the dialog box
#And I should see " The value you provided could not be validated because it does not follow the expected format. Please try again. Required format: Date (Y-M-D H:M)" in the dialog box
#And I click the button labeled "Close" in the dialog box
#
#When I delete "TEST" for the field labeled "Datetime"
#And I enter "TEST" for the field labeled "Datetime YMD HMSS"
#Then I should see "Alert" in the dialog box
#And I should see " The value you provided could not be validated because it does not follow the expected format. Please try again. Required format: Date (Y-M-D H:M:S)" in the dialog box
#And I click the button labeled "Close" in the dialog box
#
#When I delete "TEST" for the field labeled "Datetime YMD HMSS"
#And I enter "TEST" for the field labeled "Integer"
#Then I should see "Alert" in the dialog box
#And I should see "This value you provided is not an integer. Please try again." in the dialog box
#And I click the button labeled "Close" in the dialog box
#
#When I delete "TEST" for the field labeled "Integer"
#And I enter "TEST" for the field labeled "Number"
#Then I should see "Alert" in the dialog box
#And I should see "This value you provided is not a number. Please try again." in the dialog box
#And I click the button labeled "Close" in the dialog box
#
#When I delete "TEST" for the field labeled "Number"
#And I enter "TEST" for the field labeled "Number Decimal"
#Then I should see "Alert" in the dialog box
#And I should see "The value you provided could not be validated because it does not follow the expected format. Please try again. Required format: Number (1 decimal place)" in the dialog box
#And I click the button labeled "Close" in the dialog box
#
#When I delete "TEST" for the field labeled "Number Decimal"
#And I enter "TEST" for the field labeled "Number Comma"
#Then I should see "Alert" in the dialog box
#And I should see "The value you provided could not be validated because it does not follow the expected format. Please try again. Required format: Number (1 decimal place - comma as decimal)" in the dialog box
#And I click the button labeled "Close" in the dialog box
#
#When I delete "TEST" for the field labeled "Number Comma"
#And I enter "TEST" for the field labeled "Time HH:MM"
#Then I should see "Alert" in the dialog box
#And I should see "The value entered must be a time value in the following format HH:MM within the range 00:00-23:59 (e.g., 04:32 or 23:19)." in the dialog box
#And I click the button labeled "Close" in the dialog box
#
#When I delete "TEST" for the field labeled "Time HH:MM"
#And I enter "TEST" for the field labeled "Time MM:SS"
#Then I should see "Alert" in the dialog box
#And I should see "The value you provided could not be validated because it does not follow the expected format. Please try again. Required format: Time (MM:SS)" in the dialog box
#And I click the button labeled "Close" in the dialog box
#
#When I delete "TEST" for the field labeled "Time MM:SS"
#And I enter "TEST" for the field labeled "Time HH:MM:SS"
#Then I should see "Alert" in the dialog box
#And I should see "The value you provided could not be validated because it does not follow the expected format. Please try again. Required format: Time (HH:MM:SS)" in the dialog box
#And I click the button labeled "Close" in the dialog box
#
#When I delete "TEST" for the field labeled "Time HH:MM:SS"
#And I click on the link labeled "Text Validation"
#And I click on the button labeled "Save changes and leave" in the dialog box
#And I enter "TEST" for the field labeled "Email"
#Then I should see "Alert" in the dialog box
#And I should see "This field must be a valid email address (like joe@user.com). Please re-enter it now." in the dialog box
#And I click the button labeled "Close" in the dialog box
#
###VERIFY_DE
#When I click on the link labeled "Data Exports, Reports, and Stats"
#And I click on the button labeled "Save changes and leave" in the dialog box
#Then I should see a table row containing the following values in the reports table:
#| A | All data (all records and fields) |
#
#When I click on the button labeled "View Report"
#Then I should see a table header and rows containing the following values in the report data table:
#| Record ID | Repeat Instrument | date YMD |        Datetime         | Datetime YMD HMSS     | Integer | Number|
#|          7       |      Date Types          |                    |                                  |                                            |               |               |
#
#Then I should see a table header and rows containing the following values in the report data table:
#|Record ID| Repeat Instrument| Number Decimal| Number Comma| Time HH:MM | Time MM:SS |Time HH:MM:SS|
#|          7    |       Data Types        |                               |                               |                          |                         |                             |
#
#Then I should see a table header and rows containing the following values in the report data table:
#|Record ID| Name  | Email|
#|          7     |   Name |          |

