Feature: Saving Data: The system shall support the prompt to save when a user attempts to navigate away from a data entry page without saving: (Save changes and leave | Leave without saving changes | Stay on page)

#As a REDCap end user
#I want to see that leave without saving data entry page navigation is functioning as expected
#
#Scenario: B.3.14.500.100 Navigate away from a data entry page options
##SETUP
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.3.14.500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION
#When I click on the link labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see "Project status: Production"
#
##FUNCTIONAL_REQUIREMENT
#Given I click the link labeled "Add/Edit Records"
#And I click on the button labeled "Add new record for the arm selected above"
#And I click the bubble for the "Data Types" longitudinal instrument on event "Event 1"
###ACTION Navigate away from the record
#And I click on the link labeled "Project Setup"
#
###VERIFY
#Then I should see the button labeled "Save changes and leave" within the dialog box
#And I should see the button labeled "Leave without saving changes" within the dialog box
#And I should see the button labeled "Stay on page" within the dialog box
#
###ACTION Leave without saving changes
#When I click on the button labeled "Leave without saving changes"
###VERIFY
#Then I should see "Main project settings"
#
###VERIFY_LOG:
#When I click on the link labeled "Logging"
#Then I should NOT see table rows including the following values in the logging table:
#| Username | Action                  |
#| test_user1 | Create record 7 |
#
##FUNCTIONAL_REQUIREMENT
#Given I click the link labeled "Add/Edit Records"
#And I click on the button labeled "Add new record for the arm selected above"
#And I click the bubble for the "Data Types" longitudinal instrument on event "Event 1"
#And I click on the link labeled "Project Setup"
###ACTION Save changes and leave
#When I click on the button labeled "Save changes and leave"
###VERIFY
#Then I should see "Main project settings"
#
###VERIFY_LOG:
#When I click on the link labeled "Logging"
#Then I should see table rows including the following values in the logging table:
#| Username | Action                  |
#| test_user1 | Create record 7 |
#
##FUNCTIONAL_REQUIREMENT
#Given I click the link labeled "Add/Edit Records"
#And I click on the button labeled "Add new record for the arm selected above"
#And I click the bubble for the "Data Types" longitudinal instrument on event "Event 1"
#And I click on the link labeled "Project Setup"
###ACTION Stay on page
#When I click on the button labeled "Stay on page"
###VERIFY
#Then I should see "Adding new Record ID 8."
