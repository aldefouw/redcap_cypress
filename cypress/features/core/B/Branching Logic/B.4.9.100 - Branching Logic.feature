Feature: User Interface: The system shall support branching logic for data entry forms.

As a REDCap end user
I want to see that Branching Logic is functioning as expected

Scenario: B.4.9.100.100 Branching Logic

#SETUP
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "B.4.9.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_4.9.xml", and clicking the "Create Project" button  

##VERIFY: Branching logic 
When I click on the link labeled "Designer"
And I click on the instrument labeled "Data Types"
Then I verify I see "Branching logic: [record_id] = '999'" on the field labeled "Name"
And I verify I see "Branching logic: [record_id] = '999'" on the field labeled "Text box"
And I verify I see "Branching logic: [record_id] = '999'" on the field labeled "Text2"
And I verify I see "Branching logic: [record_id] = '999'" on the field labeled "Notes Box"


#FUNCTIONAL_REQUIREMENT: survey mode
When I click on the link labeled "Survey Distribution Tools"
And I click on the button labeled "Open public survey"
Then I should NOT see the field labeled "Name"
And I should NOT see the field labeled "Text2"
And I should NOT see the field labeled "Text box"
And I should NOT see the field labeled "Notes box"
And I should see the field labeled "Calculated Field"
And I should see the field labeled "Multiple Choice dropdown Auto"
And I should see the field labeled "Multiple Choice dropdown Manual"
#M: Close the survey page

#FUNCTIONAL_REQUIREMENT: data entry mode
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble for the instrument labeled "Data Types" for event "Event 1"
And I click the button labeled "OK" in the pop-up box
And I click the button labeled "OK" in the pop-up box
And I click the button labeled "OK" in the pop-up box
And I click the button labeled "OK" in the pop-up box
Then I should NOT see the field labeled "Name"
And I should NOT see the field labeled "Text2"
And I should NOT see the field labeled "Text box"
And I should NOT see the field labeled "Notes box"
And I should see the field labeled "Calculated Field"
And I should see the field labeled "Multiple Choice dropdown Auto"
And I should see the field labeled "Multiple Choice dropdown Manual"

##ACTION: change branching logic
When I click on the link labeled "Designer"
And I click on the button labeled "Leave without saving changes" in the dialog box
And I click on the instrument labeled "Data Types"
And I click on the Branching Logic icon for the field labeled "Name"
And I enter " [record_id] <> '999'" in the field labeled "Advanced Branching Logic Syntax" 
And I click on the button labeled "Update & Close Editor"
And I click on the button labeled "Save"
And I click on the button labeled "No" in the dialog box
Then I should see "Branching logic: [record_id] <> '999'" on the field labeled "Name"

##ACTION: change branching logic
When I click on the Branching Logic icon for the field labeled "Text2"
And I enter " [record_id] <> '999'" in the field labeled "Advanced Branching Logic Syntax" 
And I click on the button labeled "Update & Close Editor"
And I click on the button labeled "Save"
And I click on the button labeled "Yes" in the dialog box
Then I should see "Branching logic: [record_id] <> '999'" on the field labeled "Text2"

#FUNCTIONAL_REQUIREMENT: survey mode
When I click on the link labeled "Survey Distribution Tools"
And I click on the button labeled "Open Public Survey"
Then I should see the field labeled "Name"
And I should see the field labeled "Text2"
And I should see the field labeled "Text box"
And I should see the field labeled "Notes box"
And I should see the field labeled "Calculated Field"
And I should see the field labeled "Multiple Choice dropdown Auto"
And I should see the field labeled "Multiple Choice dropdown Manual"
#M: Close tab
 
#FUNCTIONAL_REQUIREMENT: data entry mode
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble for the instrument labeled "Data Types" for event "Event 1"
Then I should see the field labeled "Name"
And I should see the field labeled "Text2"
And I should see the field labeled "Text box"
And I should see the field labeled "Notes box"
And I should see the field labeled "Calculated Field"
And I should see the field labeled "Multiple Choice dropdown Auto"
And I should see the field labeled "Multiple Choice dropdown Manual"
 
##ACTION
When I click on the link labeled "Designer"
And I click on the button labeled "Leave without saving changes" in the dialog box
And I click on the instrument labeled "Data Types"
And I click on the Branching Logic icon for the field labeled "Descriptive Text with File"
And I click on the radio labeled "Drag-N-Drop Logic Builder"
And I drag the field choice labeled "radio_button_manual = Choice101 (101)" to the box labeled "Show the field only if"
And I click on the button labeled "Save"
Then I should see "Branching logic: [radio_button_manual] = '101'" on the field labeled "Descriptive Text with File"

When I click on the Branching Logic icon for the field labeled "Required"
And I click on the radio labeled "Drag-N-Drop Logic Builder"
And I drag the field choice labeled "checkbox = Checkbox (3)" to the box labeled "Show the field only if"
And I click on the button labeled "Save"
Then I should see "Branching logic: [checkbox(3)] = '1'" on the field labeled "Required"

#FUNCTIONAL_REQUIREMENT: survey mode
When I click on the link labeled "Survey Distribution Tools"
And I click on the button labeled "Open public survey"
And I select the radio option labeled "Choice101" on the field labeled "Radio Button Manual"
Then I should see the field labeled "Descriptive Test with File"

When I select the radio option labeled "Choice99" on the field labeled " Radio Button Manual "
Then I should NOT see the field labeled "Descriptive Test with File"

When I select the multi-select option labeled "Checkbox3" on the field labeled "Checkbox"
Then I should see the field labeled "Required"

When I deselect the multi-select option labeled "Checkbox3" on the field labeled "Checkbox"
Then I should NOT see the field labeled "Required"
#M: Close the survey page
 
##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table row including the following values in the logging table: 
| Username |  Action  | List of Data Changes OR Fields Exported | 
| test_admin | Manage/Design | Add/edit branching logic | 

