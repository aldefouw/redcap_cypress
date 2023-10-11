Feature: Field Creation: The system shall support the ability to add, edit, copy, move and delete data collection fields.

As a REDCap end user
I want to see that Project Designer is functioning as expected

#Scenario: B.6.7.1900.100 Add, edit, copy, move and delete fields
#
##SETUP
#Given I login to REDCap with the user "Test_Admin"
#And I create a new project named "B.6.7.1900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
##SETUP_USER_RIGHTS
#When I click on the link labeled "User Rights"
#And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
#And I click on the button labeled "Assign to role"
#And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
#And I click on the button labeled exactly "Assign" on the role selector dropdown
#Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table
#
###SETUP_PRODUCTION
#When I click on the button labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see "Project Status: Production"
#And I logout
#
#Given I login to REDCap with the user "Test_User1"
#When I click on the link labeled "My Projects"
#And I click on the link labeled "B.6.7.1900.100"
#And I click on the link labeled "Project Setup"
#And I click on the button labeled "Online Designer"
#Then I should see "Data Collection Instruments"
#
#When I click on the button labeled "Enter Draft Mode"
#Then I should see "The project is now in Draft Mode"
#
##FUNCTIONAL_REQUIREMENT
###ACTION: add field
#When I click on the instrument labeled "Data Types"
#And I click on the button labeled "Add Field" at the bottom of the instrument
#And I add a new Text Box field labeled "Add Field" with the variable name "add"
#And I click on the button labeled "Save"
###VERIFY
#Then I should see the field labeled "Add Field"
#
##FUNCTIONAL_REQUIREMENT
###ACTION: move field within instrument
#When I drag the field labeled "Add Field" above the field labeled "Identifier"
###VERIFY
#Then I should see the field labeled "Add Field " before the field labeled "Identifier"
#
##FUNCTIONAL_REQUIREMENT
###ACTION: move field to another instrument
#When I click on the icon labeled "Move" on the field labeled "Required"
#Then I should see "Move field to another location"
#And I should see a dropdown field with the placeholder text of "select a field"
#
#When I select "email" from the dropdown field with the placeholder text of "select a field"
#And I click on the button labeled "Move field" in the dialog box
###VERIFY
#Then I should see "Successfully moved"
#And I should see "The field was successfully moved to a new location on another data collection instrument named "Text Validation"."
#And I click on the button labeled "Close" in the dialog box
#
#Given I click on the button labeled "Return to list of instruments"
#And I click in the link labeled "Text Validation"
#Then I should see the field labeled "Required"
#
##FUNCTIONAL_REQUIREMENT
###ACTION: edit field
#Given I click on the button labeled "Return to list of instruments"
#And I click in the link labeled "Data Types"
#When I click on the edit image for the field labeled "Radio Button Manual"
#And I clear the field labeled "Choices"
#And I enter "9..9, Choice99" on the first row of the input field labeled "Choices (one choice per line)"
#And I enter "100, Choice100" on the second row of the input field labeled "Choices (one choice per line)"
#And I enter "101, Choice101" on the third row of the input field labeled "Choices (one choice per line)"
#And I enter "Abc123, Choice Abc123" on the fourth row of the input field labeled "Choices (one choice per line)"
#And I click on the button labeled "Save"
###VERIFY
#Then I should see the field labeled "Radio Button Manual"
#And I should see the radio button options "Choice99","Choice100", "Choice101, Choice Abc123"
#
##FUNCTIONAL_REQUIREMENT
###ACTION: copy field
#Given I see the field labeled "Notes box"
#And I click on the copy image for the field labeled "Notes box"
#And I click on the button labeled "Cancel" in the dialog box
#Then I should NOT see "notesbox_2"
#
#Given I see the field labeled "Notes box"
#And I click on the copy image for the field labeled " Notes box "
#And I click on the button labeled "Copy field" in the dialog box
###VERIFY
#Then I should see "notesbox_2"
#
##FUNCTIONAL_REQUIREMENT
###ACTION: delete field
#Given I see the field labeled "Multiple Choice Dropdown Manual"
#And I click on the delete field image for the field labeled "Multiple Choice Dropdown Manual"
#And I click on the button labeled "Delete" in the dialog box
###VERIFY
#Then I should NOT see "multiple_dropdown_manual"
#
###VERIFY_DRAFT_CHANGES
#When I click on the link labeled "View detailed summary of all drafted changes"
#Then I should see "Fields to be ADDED:"
#And I should see "notesbox_2 "Notes box""
#And I should see "add "Add Field""
#And I should see "Fields to be DELETED:"
#And I should see "multiple_dropdown_manual "Multiple ... Manual" (8 records/events affected)"
#And I should see a table header and rows including the following values in the table:
#|Variable Name               | Choices or Calculations |
#|radio_button_manual  |9..9, Choice99|
#| radio_button_manual |100, Choice100|
#| radio_button_manual |101, Choice101|
#| radio_button_manual |Abc123, Choice Abc123|
#
###SETUP_PRODUCTION
#When I click on the button labeled "Return to previous page"
#And I click on the button labeled "Submit Changes for Review"
#And I click on the button labeled "Submit" in the dialog box
#Then I should see "Awaiting review of project changes"
#And I logout
#
#Given I login to REDCap with the user "Test_Admin"
#When I click on the button labeled "Project Modification Module"
#And I click on the button labeled "COMMIT CHANGES"
#And I click on the button labeled "COMMIT CHANGES" in the dialog box
#Then I should see "Project Changes Committed/User Notified"
#
#
###VERIFY_CODEBOOK
#When I click on the link labeled "Codebook"
#Then I should see a table row containing the following values in the codebook table:
#| Variable / Field Name   |Field Label             |Field Attributes (Field Type, Validation, Choices, Calculations, etc.) |
#| [add]                                | Add Field              | text |
#| [radio_button_manual]| Radio Button Manual| Choice Abc123|
#| [notesbox_2]                  | Notes box             | notes |
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#Then I should see a table header and rows including the following values in the logging table:
#| Username   |        Action           | List of Data Changes OR Fields Exported |
#| test_user     | Manage/Design | Delete project field |
#| test_user     | Manage/Design | Copy project field |
#| test_user     | Manage/Design | Edit project field |
#| test_user     | Manage/Design | Move project field |
#| test_user     | Manage/Design | Create project field |
