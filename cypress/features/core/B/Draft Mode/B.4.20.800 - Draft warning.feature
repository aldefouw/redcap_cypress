Feature: User Interface: The system shall flag any changes that may negatively impact data with the following critical warnings: Possible label mismatch | Possible data loss | Data WILL be lost

As a REDCap end user
I want to see that Draft mode is functioning as expected

#Scenario: B.4.20.800.100 Flag critical warnings
#
##SETUP
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.4.20.800.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION
#When I click on the link labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see Project Status: "Production"
#
###ACTION: Draft Mode
#When I click on the link labeled "Designer"
#And I click on the button labeled "Enter Draft Mode"
#Then I should see "The project is now in Draft Mode"
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#Then I should see a table row containing the following values in the logging table:
#| Username |  Action                 | List of Data Changes OR Fields Exported |
#| test_user1 | Manage/Design | Enter Draft Mode |
#
###ACTION
#When I click on the link labeled "Designer"
#And I click on the instrument labeled "Data Types"
#And I click on the Edit image for the field labeled "Radio Button Manual"
##DATA WILL BE LOST
#And I delete the third option "101, Choice101" on the third row of the input field labeled "Choices (one choice per line)"
##DATA MISMATCH
#And I edit the second option from "100, Choice100" to "101, Choice100" on the second row of the input field labeled "Choices (one choice per line)"
#And I click on the button labeled "Save"
#Then I should see the radio option labeled "Choice99"
#And I should see the radio option labeled "Choice100"
#
###FUNCTIONAL_REQUIREMENT
#When I click on the link labeled "View detailed summary of all drafted changes"
#Then I should see "Will these changes be automatically approved? No, an admin will have to review these changes."
#And I should see a table header and rows containing the following values in the summary data table:
#| Variable Name              |         Choices or Calculations                                                                          |
#| radio_button_manual |      * Possible label mismatch because of label changes. Check if okay. |
#                                                     *Data MIGHT be lost due to deleted choice(s)
#
#When I click on the button labeled "Compare"
#Then I should see a table header and rows containing the following values in the Choice Change Summary data table:
#| Existing Value| Status      | Number of records having this value|
#| 100                  | Removed| 8|
#| 101                  | Altered    | 0 |
#
#And I click on the button labeled "Close" in the dialog box

