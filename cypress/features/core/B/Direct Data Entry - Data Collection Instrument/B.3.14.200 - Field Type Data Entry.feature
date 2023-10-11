Feature: Creating a Record and Entering Data: The system shall support data entry for the defined core field types.

As a REDCap end user
I want to see that data entry for field type is functioning as expected

Scenario: B.3.14.200.100 Appropriate data entry by field type

#SETUP
Given I login to REDCap with the user "Test_User1"
And I create a new project named "B.3.14.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button 

#SETUP_PRODUCTION
When I click on the link labeled "My Projects"  
And I click on the link labeled "B.3.14.200.100"  
And I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production" 
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project status: Production"

#SETUP
Given I click the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click the bubble for the "Data Types" longitudinal instrument on event "Event 1"
Then I should see "Adding new Record ID 7"

#FUNCTIONAL REQUIREMENT
##ACTION: Data entry various field types
When I select the radio option labeled "Choice99" for the field labeled "radio"
And I select the dropdown option labeled "DDChoice6" on the dropdown field labeled "Multiple Choice Dropdown Manual"
And I enter "Notes box" for the field labeled "Notes box 2"
And I select the option labeled "Checkbox2" for the multiselect field labeled "Checkbox"
And I enter "TESTER" on the signature field in the pop-up box 
And I click on the button labeled "Save signature" in the pop-up box
And I click on the link labeled "Upload file" for the field labeled "File Upload"
And I upload the file labeled "File_Upload.docx"
And I click on the button labeled "Upload file" in the dialog box
And I select the option "True" on the field labeled "True/False"
And I select the option "No" on the field labeled "Yes/No"
And I set the value to "65" by using the slider for the field labeled "Slider"
And I click on the button labeled "Save & Exit Form"
Then I should see "Record ID 7 successfully added."

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see table rows containing the following values in the logging table:
| Username | Action | List of Data Changes OR Fields Exported |
| test_user1 | Update record 7 | radio = '9..9' |
| test_user1 | Update record 7 | multiple_dropdown_manual_2 = '6'
| test_user1 | Update record 7 |  notesbox2 = 'Notes box'|
| test_user1 | Update record 7 | checkbox(1) = checked|
| test_user1 | Update record 7 | checkbox(2) = checked |
| test_user1 | Update record 7 | signature = '(unique signature hash)' |
| test_user1 | Update record 7 |  file upload = '(unique file hash)' |
| test_user1 | Update record 7 |  tf= '1' |
| test_user1 | Update record 7 | yn = '0' |
| test_user1 | Update record 7 | slider = '65' |

##VERIFY_DE
When I click on the link labeled "Data Exports, Reports, and Stats"
Then I should see a table row containing the following values in the reports table:
| A | All data (all records and fields) | 


When I click on the button labeled "View Report"
Then I should see a table header and rows including the following values in the report data table: 
| Record ID|   radio                    | Multiple Choice Dropdown Manual | Notes box 2 | Checkbox1 | Checkbox2 |
| 7               |   Choice99 (9..9)   | DDChoice6 (6)                                      | Notes box | Checked (1)  | Checked (1) |

And I should see a table header and rows including the following values in the report data table: 
| Record ID | Signature                |   File Upload       | True/False | Yes/No| Slider |
|  7               | signature.png link |   file upload link | True (1)      | No (0)  | 65 |
