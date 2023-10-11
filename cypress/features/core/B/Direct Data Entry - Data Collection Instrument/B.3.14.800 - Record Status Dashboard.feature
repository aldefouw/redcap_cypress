Feature: Saving Data: The system shall support a Record Status Dashboard to display a listing of all existing records and data collection instrument form statuses.

As a REDCap end user
I want to see that record status dashboard is functioning as expected

#Scenario: B.3.14.800.100 record status dashboard display
#
##SETUP
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.3.14.800.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button
#And I click on the link labeled "My Projects"
#And I click on the link labeled "B.3.14.800.100"
#
##FUNCTIONAL REQUIREMENT
###ACTION - View Record Status Dashboard
#When I click on the link labeled "Record Status Dashboard"
#
###VERIFY
#Then I should see "Default dashboard"
#And I should see the link labeled "1"
#And I should see the bubble "Text Validation" for the event "Event 1" for record "1"
#And I should see the link labeled "Arm 2: Arm Two"
#
