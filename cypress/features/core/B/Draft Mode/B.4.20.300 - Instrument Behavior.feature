Feature: User Interface: The system shall require changes made to data collection instruments in production status projects to be made only by entering draft mode.  Changes in draft mode are implemented upon acceptance of submission, not real time.

As a REDCap end user
I want to see that Draft Mode is functioning as expected

#Scenario: B.4.20.300.100 Changes occur in draft mode non-real-time
#
##SETUP
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.4.20.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION
#When I click on the link labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see Project Status: "Production"
#
#
##FUNCTIONAL_REQUIREMENT
###ACTION: Draft Mode
#When I click on the link labeled "Designer"
#And I click on the button labeled "Enter Draft Mode"
#Then I should see "The project is now in Draft Mode"
#
###VERIFY: (look at a table that shows summary of changes)
#When I click on the instrument labeled "Data Types"
#And I click on the Edit image for the field labeled "Radio Button Manual"
#And I enter "102, Choice102" on the fourth row of the input field labeled "Choices (one choice per line)"
#And I click on the button labeled "Save"
#And I click on the button labeled "View detailed summary of all drafted changes"
#Then I should see "102, Choice102" in a yellow cell for the variable labeled "radio_button manual"
#
###ACTION
#Given I click on the button labeled "RETURN TO PREVIOUS PAGE"
#And I click on the button labeled "Submit Changes for Review"
#And I click on the button labeled "Submit" in the dialog box
#Then I should see "Changes Were Made Automatically"
#And I click on the button labeled "Close" in the dialog box
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#Then I should see a table row containing the following values in the logging table:
#| Username |  Action  | List of Data Changes OR Fields Exported |
#| test_user1| Manage/Design | Approve production project modifications (automatic) |
