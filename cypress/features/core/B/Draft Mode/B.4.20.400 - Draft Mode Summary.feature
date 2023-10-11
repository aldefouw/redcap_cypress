Feature: User Interface: The system shall provide detailed summary of all drafted changes.

As a REDCap end user
I want to see that Draft Mode is functioning as expected

Scenario: B.4.20.400.100 Detailed summary of drafted changes 

#SETUP
Given I login to REDCap with the user "Test_User1" 
And I create a new project named "B.4.20.400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 

#SETUP_PRODUCTION
When I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see Project Status: "Production"

##ACTION: Draft Mode
When I click on the link labeled "Designer"
And I click on the button labeled "Enter Draft Mode"
Then I should see "The project is now in Draft Mode"

When I click on the instrument labeled "Data Types"
And I click on the Edit image for the field labeled "Radio Button Manual"
And I enter "102, Choice102" on the fourth row of the input field labeled "Choices (one choice per line)"
And I click on the button labeled "Save"
And I click on the button labeled "Add Field" at the bottom of the instrument
Then I should see a dropdown field labeled "Select a Type of Field"

When I click on the dropdown field labeled "Select a Type of Field"
Given And I add a new Notes box field labeled "Notes Box" with the variable name "notesbox4"
And I click on the button labeled "Save"
Then I should see the field labeled "Notes Box"

#FUNCTIONAL_REQUIREMENT
When I click on the button labeled "View detailed summary of all drafted changes"
Then I should see "Review Drafted Changes"
And I should see "102, Choice102" in a yellow cell for the variable labeled "radio_button manual"
And I should see "Notes Box" in a green cell for the variable labeled "notesbox4"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table row containing the following values in the logging table: 
| Username |  Action                 | List of Data Changes OR Fields Exported | 
| test_user1 | Manage/Design | Create project field |
| test_user1 | Manage/Design | Edit project field |
