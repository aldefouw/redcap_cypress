Feature: User Interface: Longitudinal Project Settings: The system shall support enabling and disabling longitudinal data collection.

As a REDCap end user
I want to see that Project Setup is functioning as expected

#Scenario: B.4.27.300.100 Change project longitudinal status
###SETUP_DEV
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.4.27.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
###ACTION Verify event exist ##VERIFY_RSD
#When I click on the link labeled "Record Status Dashboard"
#Then I should see "Event 2" in arm labeled "Arm 1: Arm 1"
#
##FUNCTIONAL REQUIREMENT
###ACTION Disable longitudinal
#When I click on the link labeled "Project Setup"
#And I click on the button labeled "Disable" on the field labeled "Use longitudinal data collection with defined events?"
#And I click on the button labeled "Disable" in the dialog box
#Then I should see the button labeled "Enable" on the field labeled "Use longitudinal data collection with defined events?"
#
###VERIFY_RSD
#When I click on the link labeled "Record Status Dashboard"
#Then I should see "Text Validation"
#I should NOT see event "Event 1"
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#Then I should see a table header and rows including the following values in the logging table:
#| Username   |        Action            | List of Data Changes OR Fields Exported |
#| test_user1  | Manage/Design   | Modify project settings |
#
##FUNCTIONAL REQUIREMENT
###ACTION Enable longitudinal
#When I click on the link labeled "Project Setup"
#And I click on the button labeled "Enable" on the field labeled "Use longitudinal data collection with defined events?"
#Then I should see "Saved!"
#
###VERIFY_RSD
#When I click on the link labeled "Record Status Dashboard"
#Then I should see "Event 1" in arm labeled "Arm 1: Arm 1"
#And I should see "Event 2" in arm labeled "Arm 1: Arm 1"
#And I should see "Event 3" in arm labeled "Arm 1: Arm 1"
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#Then I should see a table header and rows including the following values in the logging table:
#| Username   |        Action            | List of Data Changes OR Fields Exported |
#| test_user1  | Manage/Design   | Modify project settings |
#
###SETUP_PRODUCTION
#When I click on the button labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see "Project Status: Production"
#
##FUNCTIONAL REQUIREMENT
###ACTION Verify longitudinal button is disabled in production mode for user
#When I click on the link labeled "Project Setup"
###VERIFY
#Then I verify the button labeled "Disable" for the field labeled "Use longitudinal data collection with defined events?" is disabled
#And I logout
#
#Given I login to REDCap with the user "Test_Admin"
###ACTION Admin disable longitudinal while in production
#When I click on the button labeled "Disable" for the field labeled "Use longitudinal data collection with defined events?"
#And I click on the button labeled "Disable" in the dialog box
#Then I should see "Saved!"
#And I should see the button labeled "Enable" on the field labeled "Use longitudinal data collection with defined events?"
#
#
###VERIFY_RSD
#When I click on the link labeled "Record Status Dashboard"
#Then I should see "Text Validation"
#I should NOT see "Event 1"
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#Then I should see a table header and rows including the following values in the logging table:
#| Username   |        Action            | List of Data Changes OR Fields Exported |
#| test_admin  | Manage/Design   | Modify project settings |
