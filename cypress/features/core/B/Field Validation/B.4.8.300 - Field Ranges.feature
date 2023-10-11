Feature: User Interface: The system shall support ranges for the following data types:  Date (Y-M-D) | Datetime (Y-M-D H:M) | Datetime w/seconds (Y-M-D H:M:S) | Integer | Number | Number (1 Decimal Place,  comma as decimal) | Time (HH:MM)  | Time (MM:SS) | Time (HH:MM:SS)

As a REDCap end user
I want to see that Field validation is functioning as expected

Scenario: B.4.8.300.100 Field range validation 


#SETUP 
Given I login to REDCap with the user "Test_Admin" 
And I create a new project named "B.4.8.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_4.8.xml", and clicking the "Create Project" button
 
#SETUP_PRODUCTION 
When I click on the link labeled "Project Setup" 
And I click on the button labeled "Move project to production"  
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box 
Then I should see "Project status: Production" 

 
#SETUP_DRAFT MODE
When I click on the link labeled "Designer"
And I click on the button labeled "Enter Draft Mode"
Then I should see "The project is now in Draft Mode"
 
## ACTION:M date YMD validation
When I click on the instrument labeled "Data Types"
And I click on the edit image for the field labeled "date YMD"
Then I should see the dropdown option "Date (Y-M-D)" is selected for the field labeled "Validation? (optional)"
And I should see "2023-08-01" in the field labeled "Minimum:"
And I should see "2023-08-31" in the field labeled "Maximum:"
And I click on the button labeled "Save" in the dialog box
 
## ACTION:M Datetime validation
When I click on the edit image for the field labeled "Datetime"
Then I should see the dropdown option "Datetime (Y-M-D H:M)" is selected for the field labeled "Validation? (optional)"
And I should see "2023-09-01 01:01" in the field labeled "Minimum:"
And I should see "2023-09-30 01:59" in the field labeled "Maximum:"
And I click on the button labeled "Save" in the dialog box
 
## ACTION:M Datetime YMD HMSS validation
When I click on the edit image for the field labeled "Datetime YMD HMSS"
Then I should see the dropdown option "Datetime (Y-M-D H:M:S)" is selected for the field labeled "Validation? (optional)"
And I should see "2023-09-01 11:01:01" in the field labeled "Minimum:"
And I should see "2023-09-30 11:01:01" in the field labeled "Maximum:"
And I click on the button labeled "Save" in the dialog box
 
## ACTION:M Time HH:MM validation
When I click on the edit image for the field labeled "Time HH:MM"
Then I should see the dropdown option "Time (HH:MM)" is selected for the field labeled "Validation? (optional)"
And I should see "08:05" in the field labeled "Minimum:"
And I should see "23:00" in the field labeled "Maximum:"
And I click on the button labeled "Save" in the dialog box
 
## ACTION:M Time HH:MM:SS validation
When I click on the edit image for the field labeled "Time HH:MM:SS"
Then I should see the dropdown option "Time (HH:MM:SS)" is selected for the field labeled "Validation? (optional)"
And I should see "08:01:01" in the field labeled "Minimum:"
And I should see "23:00:00" in the field labeled "Maximum:"
And I click on the button labeled "Save" in the dialog box
 
## ACTION:M Time MM:SS validation
When I click on the link labeled "Designer"
And I click on the instrument labeled "Data Types"
And I click on the edit image for the field labeled "Time MM:SS"
Then I should see the dropdown option "Time (MM:SS)" is selected for the field labeled "Validation? (optional)"
And I should see "02:01" in the field labeled "Minimum:"
And I should see "59:00" in the field labeled "Maximum:"
And I click on the button labeled "Save" in the dialog box
 
## ACTION:M Integer validation
When I click on the edit image for the field labeled "Integer"
Then I should see the dropdown option "Integer" is selected for the field labeled "Validation? (optional)"
And I should see "1" in the field labeled "Minimum:"
And I should see "100" in the field labeled "Maximum:"
And I click on the button labeled "Save" in the dialog box
 
## ACTION:M Number validation
When I I click on the edit image for the field labeled "Number"
Then I should see the dropdown option "Number" is selected for the field labeled "Validation? (optional)"
And I should see "1" in the field labeled "Minimum:"
And I should see "5" in the field labeled "Maximum:"
And I click on the button labeled "Save" in the dialog box
 
## ACTION:M Number 1 Decimal validation
When I click on the edit image for the field labeled "Number Decimal"
Then I should see the dropdown option "Number Comma" is selected for the field labeled "Validation? (optional)"
And I should see "1.0" in the field labeled "Minimum:"
And I should see "5.0" in the field labeled "Maximum:"
And I click on the button labeled "Save" in the dialog box
 
## ACTION:M Number Comma validation
When I click on the edit image for the field labeled "Number Comma"
Then I should see the dropdown option "Number (1 decimal place - comma as decimal)" is selected for the field labeled "Validation? (optional)"
And I should see "1,0" in the field labeled "Minimum:"
And I should see "2,0" in the field labeled "Maximum:"
And I click on the button labeled "Save" in the dialog box

#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation within range text
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
Then I should see "Adding new Record ID 5. (Instance #1) "
 
When I enter "2023-08-02" in the field labeled "date YMD"
And I enter "2023-09-02 12:12" in the field labeled "Datetime"
And I enter "2023-09-02 12:12:12" in the field labeled "Datetime YMD HMSS"
And I enter "11:11" in the field labeled "Time HH:MM"
And I enter "11:11:11" in the field labeled "Time HH:MM:SS"
And I enter "11:11" in the field labeled "Time MM:SS"
And I enter "3" in the field labeled "Integer"
And I enter "3" in the field labeled "Number"
And I enter "1.5" in the field labeled "Number Decimal"
And I enter "1,5" in the field labeled "Number Comma"
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 5 successfully added."
 
##VERIFY_LOG
When I click on the link labeled " Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username      | Action               | List of Data Changes OR Fields Exported |
| Test_admin | Create record 5 | date_ymd = '2023-08-02'|
| Test_admin | Create record 5 | datetime_ymd_hm = '2023-09-02 12:12'|
| Test_admin | Create record 5 | datetime_ymd_hmss = '2023-09-02 12:12:12'|
| Test_admin | Create record 5 | integer = '3'|
| Test_admin | Create record 5 | number = '3'|
| Test_admin | Create record 5 | number_dec = '1.5'|
| Test_admin | Create record 5 | num_comma = '1,5'|
| Test_admin | Create record 5 | time_hhmm = '11:11'|
| Test_admin | Create record 5 | time_mm_ss = '11:11'|
| Test_admin | Create record 5 | time_hhmmss = '11:11:11'|

##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table: 
| Record ID | Repeat Instrument | date YMD    |        Datetime          | Datetime YMD HMSS     | Integer | Number| 
|          5       |      Data Types          | 2023-08-02 | 2023-09-02 12:12  |  2023-09-02 12:12:12    |     3         |        3      | 

And I should see a table header and rows containing the following values in the report data table: 
|Record ID| Repeat Instrument| Number Decimal| Number Comma| Time HH:MM | Time MM:SS |Time HH:MM:SS| 
|          5     |       Data Types        |              1.5            |           1,5              |      11:11         |      11:11          |         11:11:11    | 

#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside lower bound (date YMD)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "2022-08-02" in the field labeled "date YMD"
Then I should see "The value you provided is outside the suggested range (2023-08-01 - 2023-08-31). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 6 successfully added"
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record6 (Event 1 (Arm 1: Arm 1)) | date_ymd = '2022-08-02'|

##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument | date YMD    |  
|          6       |      Data Types          | 2022-08-02 |


#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside lower bound (Datetime)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "2022-08-02 12:12" in the field labeled "Datetime"
Then I should see "The value you provided is outside the suggested range (2023-09-01 01:01 - 2023-09-30 01:59). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 7 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table row containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 7 (Event 1 (Arm 1: Arm 1)) | datetime_ymd_hm = '2022-08-02 12:12'|
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument | Datetime |  
|          7       |      Data Types          | 2022-08-02 12:12|
 
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside lower bound (Datetime YMD HMSS)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "2022-08-02 12:12:12" in the field labeled "Datetime YMD HMSS"
Then I should see "The value you provided is outside the suggested range (2023-09-01 11:01:01 - 2023-09-30 11:01:01). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 8 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table row containing the following values in the logging table:
| Username    |  Action                                                            | List of Data Changes OR Fields Exported |
| Test_admin | Create record 8 (Event 1 (Arm 1: Arm 1)) | datetime_ymd_hmss = '2022-08-02 12:12:12'|
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument | Datetime YMD HMSS|  
|          8       |      Data Types          | 2022-08-02 12:12:12  |
 
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside lower bound (Time HH:MM)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "07:07" in the field labeled "Time HH:MM"
Then I should see "The value you provided is outside the suggested range (08:05 - 23:00). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 9 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table row containing the following values in the logging table:
| Username    |  Action                                                            | List of Data Changes OR Fields Exported |
| Test_admin | Create record 9 (Event 1 (Arm 1: Arm 1)) | time_hhmm = '07:07'|
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument | Time HH:MM |  
|          9       |      Data Types          | 07:07                  |
 
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside lower bound (Time HH:MM:SS)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "07:07:07" in the field labeled " Time HH:MM:SS"
Then I should see "The value you provided is outside the suggested range (08:01:01 - 23:00:00). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 10 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 10 (Event 1 (Arm 1: Arm 1)) | time_hhmmss = '07:07:07'|
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument | Time HH:MM:SS |  
|          10      |      Date Types          | 07:07:07                 |
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside lower bound (Time MM:SS)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "01:00" in the field labeled "Time MM:SS"
Then I should see "The value you provided is outside the suggested range (02:01 - 59:00). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 11 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 11 (Event 1 (Arm 1: Arm 1)) | time_mm_ss = '01:00'|
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument | MM:SS |  
|          11      |      Data Types          | 01:00    |
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside lower bound (Integer)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "0" in the field labeled "Integer"
Then I should see "The value you provided is outside the suggested range (1 - 100). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 12 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 12 (Event 1 (Arm 1: Arm 1)) | integer = '0' |
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument | Integer|  
|          12      |      Data Types          | 0           |
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside lower bound (Number)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "0" in the field labeled "Number"
Then I should see "The value you provided is outside the suggested range (1 - 5). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 13 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 13 (Event 1 (Arm 1: Arm 1)) | number = '0' |
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument | Number|  
|          13      |      Data Types          | 0             |

 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside lower bound (Number Decimal)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "0.0" in the field labeled "Number Decimal"
Then I should see "The value you provided is outside the suggested range (1.0 - 5.0). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 14 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 14 (Event 1 (Arm 1: Arm 1)) | number_dec = '0.0' |
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument | Number Decimal|  
|          14      |      Data Types          | 0.0                           |
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside lower bound (Number Comma)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "0,0" in the field labeled "Number Comma"
Then I should see "The value you provided is outside the suggested range (1,0 - 2,0). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 15 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 15 (Event 1 (Arm 1: Arm 1)) | num_comma = '0,0' |
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument | Number Comma|  
|          15      |      Data Types          | 0,0                          |


#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside upper bound (date YMD)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "2024-08-02" in the field labeled "date YMD"
Then I should see "The value you provided is outside the suggested range (2023-08-01 - 2023-08-31). This value is admissible, but you may wish to double check it." in the dialog box
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 16 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 16 (Event 1 (Arm 1: Arm 1)) | date_ymd = '2024-08-02' |

##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument | date YMD    |  
|          16     |      Data Types          | 2024-08-02 |
 
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside upper bound (Datetime)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "2024-08-02 12:12" in the field labeled "Datetime"
Then I should see "The value you provided is outside the suggested range (2023-09-01 01:01 - 2023-09-30 01:59). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 17 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 17 (Event 1 (Arm 1: Arm 1)) | datetime_ymd_hm = '2024-08-02 12:12' |
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument | Datetime |  
|         17       |      Data Types          | 2024-08-02 12:12|
 
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside upper bound (Datetime YMD HMSS)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "2024-08-02 12:12:12" in the field labeled "Datetime YMD HMSS"
Then I should see "The value you provided is outside the suggested range (2023-09-01 11:01:01 - 2023-09-30 11:01:01). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 18 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 18 (Event 1 (Arm 1: Arm 1)) |datetime_ymd_hmss = '2024-08-02 12:12:12' |
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument  | Datetime YMD HMSS |  
|         18       |      Date Types          | 2024-08-02 12:12:12|
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside upper bound (Time HH:MM)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "23:07" in the field labeled "Time HH:MM"
Then I should see "The value you provided is outside the suggested range (08:05 - 23:00). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 19 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 19 (Event 1 (Arm 1: Arm 1)) | time_hhmm = '23:07' |
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument  | Time HH:MM |  
|         19       |      Data Types          | 23:07                 |
 
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside upper bound (Time HH:MM:SS)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "23:07:07" in the field labeled " Time HH:MM:SS"
Then I should see "The value you provided is outside the suggested range (08:01:01 - 23:00:00). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 20 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 20 (Event 1 (Arm 1: Arm 1)) | time_hhmmss = '23:07:07' |
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument  | Time HH:MM:SS |  
|         20       |      Data Types          | 23:07:07                 |
 
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside upper bound (Time MM:SS)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "59:01" in the field labeled "Time MM:SS"
Then I should see "The value you provided is outside the suggested range (02:01 - 59:00). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 21 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 21 (Event 1 (Arm 1: Arm 1)) | time_mm_ss = '59:01' |
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument  | Time MM:SS |  
|         21       |      Data Types          | 59:01               |
 
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside upper bound (Integer)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "200" in the field labeled "Integer"
Then I should see "The value you provided is outside the suggested range (1 - 100). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 22 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 22 (Event 1 (Arm 1: Arm 1)) | integer = '200' |
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument  | Integer |  
|         22       |      Data Types          | 200        |
 
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside upper bound (Number)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "10" in the field labeled "Number"
Then I should see "The value you provided is outside the suggested range (1 - 5). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 23 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 23 (Event 1 (Arm 1: Arm 1)) | number = '10' |
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument  | Number |  
|         23       |      Data Types          | 10             |
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside upper bound (Number Decimal)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "6.0" in the field labeled "Number Decimal"
Then I should see "The value you provided is outside the suggested range (1.0 - 5.0). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 24 successfully added"
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 24 (Event 1 (Arm 1: Arm 1)) | number_dec = '6.0' |
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument  | Number Decimal |  
|         24       |      Data Types          | 6.0                            |
 
 
#FUNCTIONAL REQUIREMENT
##ACTION - Verify field validation outside upper bound (Number Comma)
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "3,0" in the field labeled "Number Comma"
Then I should see "The value you provided is outside the suggested range (1,0 - 2,0). This value is admissible, but you may wish to double check it." in the dialog box
 
When I click the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "Record ID 25 successfully added."
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
| Username    |  Action  | List of Data Changes OR Fields Exported |
| Test_admin | Create record 25 (Event 1 (Arm 1: Arm 1)) | num_comma = '3,0' |
 
##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) |
 
When I click on the button labeled "View Report"
Then I should see a table header and rows containing the following values in the report data table:
| Record ID | Repeat Instrument  | Number Comma |  
|         25       |      Data Types          | 3,0                            |
