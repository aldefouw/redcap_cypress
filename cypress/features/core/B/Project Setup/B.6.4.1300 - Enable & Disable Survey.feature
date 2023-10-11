Feature: User Interface: Survey Project Settings: The system shall support enabling and disabling survey functionality at the project level.

As a REDCap end user
I want to see that Manage project user access is functioning as expected

Scenario: B.6.4.1300.100 Enable/Disable survey in Project Set-up
#SETUP 
Given I login to REDCap with the user "Test_User1"
And I create a new project named "B.6.4.1300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 

##ACTION Disable survey in project setup
Given I click on the link labeled "Project Setup"
When I click on the button labeled "Disable" on the field labeled "Use surveys in this project?"
And I click on the button labeled "Disable" on the dialog box
##VERIFY
Then I should see "Saved!"
And I should see a button labeled "Enable" on the field labeled "Use surveys in this project?"

Given I click on the link labeled " Designer"
Then I should see surveys are disabled

#VERIFY_LOG
When I click on the button labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action         | List of Data Changes OR Fields Exported |
| test_user1   | Manage/design | Modify project settings |

When I click on the link labeled "Project Setup"
#FUNCTIONAL REQUIREMENT
##ACTION Enable survey in project setup
And I click on the button labeled "Enable" on the field labeled "Use surveys in this project?"
##VERIFY
Then I should see "Saved!"
And I should see a button labeled "Disable" on the field labeled "Use surveys in this project?"

##ACTION Enable survey in Online Designer #B.3.15.100.100
Given I click on the link labeled "Designer"
And I enable surveys for the data instrument named "Text Validation"
And I click on the button labeled "Save Changes"
##VERIFY
Then I should see "Your survey settings were successfully saved!"

#VERIFY_LOG
When I click on the button labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action         | List of Data Changes OR Fields Exported |
| test_user1  | Manage/design | Set up survey |

##ACTION Disable survey in Online Designer #B.3.15.100.100
Given I click on the link labeled "Designer"
And I click on the button labeled "Survey settings" for the data instrument named "Text Validation"
And I click on the button labeled "Delete Survey Settings"
And I click on the button labeled "Delete Survey Settings" in the dialog box
And I click on the button "Close" in the dialog box

##VERIFY
Then I should see the button labeled "Enable" for the data instrument named "Text Validation"

#VERIFY_LOG
When I click on the button labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action         | List of Data Changes OR Fields Exported |
| test_user1  | Manage/design | Delete survey |
