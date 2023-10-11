Feature: User Interface: Longitudinal Project Settings: The system shall require administrators to delete events for longitudinal projects while in production

As a REDCap end user
I want to see that Manage project user access is functioning as expected

Scenario: B.4.27.700.100 Admin delete events and arm in Define My Events
#SETUP 
Given I login to REDCap with the user "Test_User1"
And I create a new project named "B.4.27.700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

#SETUP_PRODUCTION
When I click on the button labeled "Move project to production" 
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I see "Project status:  Production"

#FUNCTIONALREQUIREMENT
##ACTION User unable to delete event
When I click on the link labeled "Project Setup"
And I click on the button labeled "Define My Events"
##VERIFY
Then I should see "Events cannot be modified in production"
And I should NOT see the delete icon for the event labeled "1"
And I logout

#SETUP 
Given I login to REDCap with the user "Test_Admin"
When I click on the link labeled "Project Setup"
And I click on the button labeled "Define My Events"
Then I should see the delete icon for the event labeled "Event 2" for arm "Arm 1: Arm 1" with a unique event ID

#FUNCTIONALREQUIREMENT
##ACTION Admin deletes event
When I click on the delete icon for the event labeled "Event 1" for arm "Arm 1: Arm 1"
And I click on the button labeled "OK" in the pop-up box
And I click on the button labeled "OK" in the pop-up box
Then I should NOT see the event labeled "Event 1" for arm "Arm 1: Arm 1"

#VERIFY_LOG
When I click on the button labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action            | List of Data Changes OR Fields Exported |
| test_admin| Manage/design | Delete event (Event: Event 1, Arm: Arm 1) |

##ACTION Delete Arm
Given I click on the link labeled "Project Setup"
And I click on the button labeled "Define My Events"
And I click on the link labeled "Delete Arm 1"
And I click on the button labeled "OK" in the pop-up box
#VERIFY
Then I should NOT see "Arm 1"

#VERIFY_LOG
When I click on the button labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action            | List of Data Changes OR Fields Exported |
| test_admin| Manage/design | Delete arm (Arm 1: Arm 1)
