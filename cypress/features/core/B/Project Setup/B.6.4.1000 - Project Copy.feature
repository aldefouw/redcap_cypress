Feature: User Interface: General: The system shall support the ability to copy the project, all users, and all data.

As a REDCap end user
I want to see that Project Setup is functioning as expected

#Scenario: B.6.4.1000.100 Copy a project with all users and all data
##SETUP_DEV
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.6.4.1000.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
#When I click on the link labeled "My Projects"
#And I click on the link labeled "B.6.4.1000.100"
#And I click on the link labeled "Other Functionality"
#Then I should see the button labeled "Copy the Project"
#
##FUNCTIONAL REQUIREMENT
###ACTION: Copy original in development mode
#When I click on the button labeled "Copy the Project"
#And I enter "B.6.4.1000.100.DEV" into the field labeled "Project title:"
#And I click on the link labeled "Select All"
#And I click on the button labeled "Copy project"
#And I click on the button labeled "I Agree" in the dialog box
#Then I should see "COPY SUCCESSFUL!"
#
###VERIFY_UR
#When I click on the link labeled "User Rights"
#Then I should see the user "test_user1"
#
###VERIFY_RSD
#When I click on the link labeled "Record Status Dashboard"
#Then I should see records exist
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#Then I should see a table header and rows including the following values in the logging table:
#| Username   |        Action           | List of Data Changes OR Fields Exported |
#| test_user1  | Add user              | user = 'test_user1'|
#| test_user1  | Manage/Design | Copy project from |
#
##SETUP_PRODUCTION
#Given I click on the link labeled "My Projects"
#And I click on the link labeled "B.6.4.1000.100"
#And I click on the link labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see "Project Status: Production"
#
##FUNCTIONAL REQUIREMENT
###ACTION: Copy original in production mode
#When I click on the link labeled "Other Functionality"
#Then I should see the button labeled "Copy the Project"
#
#When I click on the button labeled "Copy the Project"
#And I enter "B.6.4.1000.100.PROD" into the field labeled "Project title:"
#And I click on the link labeled "Select All"
#And I click on the button labeled "Copy project"
#And I click on the button labeled "I Agree" in the dialog box
#Then I should see "COPY SUCCESSFUL!"
#
###VERIFY_UR
#When I click on the link labeled "User Rights"
#Then I should see the user "test_user1"
#
###VERIFY_RSD
#When I click on the link labeled "Record Status Dashboard"
#Then I should see records exist
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#Then I should see a table header and rows including the following values in the logging table:
#| Username   |        Action           | List of Data Changes OR Fields Exported |
#| test_user1  | Add user              | user = 'test_user1'|
#| test_user1  | Manage/Design | Copy project from |
#
##SETUP_ANALYSIS
#Given I click on the link labeled "My Projects"
#And I click on the link labeled "B.6.4.1000.100"
#And I click on the link labeled "Other Functionality"
#And I click on the button labeled "Move to Analysis/Cleanup status"
#And I click on the button labeled "YES, Move to Analysis/Cleanup Status" in the dialog box
#And I click on the button labeled "OK" in the pop-up box
#Then I should see "Project status: Analysis/Cleanup"
#
##FUNCTIONAL REQUIREMENT
###ACTION: Copy original in analysis mode
#Given I click on the button labeled "Copy the Project"
#And I enter "B.6.4.1000.100.ANALYSIS" into the field labeled "Project title:"
#And I click on the link labeled "Select All"
#And I click on the button labeled "Copy project"
#And I click on the button labeled "I Agree" in the dialog box
#Then I should see "COPY SUCCESSFUL!"
#
###VERIFY_UR
#When I click on the link labeled "User Rights"
#Then I should see the user "test_user1"
#
###VERIFY_RSD
#When I click on the link labeled "Record Status Dashboard"
#Then I should see records exist
#
###VERIFY_LOG
#When I click on the link labeled "Logging"
#Then I should see a table header and rows including the following values in the logging table:
#| Username   |        Action           | List of Data Changes OR Fields Exported |
#| test_user1  | Add user              | user = 'test_user1'|
#| test_user1  | Manage/Design | Copy project from |
#
##SETUP_COMPLETED
#Given I click on the link labeled "My Projects"
#And I click on the link labeled "B.6.4.1000.100"
#And I click on the link labeled "Other Functionality"
#And I click on the button labeled "Mark project as Completed"
#And I click on the button labeled "Mark project as Completed" in the dialog box
#And I click on the button labeled "OK" in the pop-up box
#Then I should see "My Projects"
#
##FUNCTIONAL REQUIREMENT
###ACTION: UNABLE to Copy original in complete mode as User
#When I click on the link labeled "Show Completed Projects"
#And I click on the link labeled "B.6.4.1000.100"
###VERIFY
#Then I should see "NOTICE: Project was marked as Completed"
#And I click on the button labeled "Return to My Projects page"
#And I logout
#
###ACTION: UNABLE to Copy original in complete mode as Admin
#Given I login to REDCap with the user "Test_Admin"
#And I click on the link labeled "Control Center"
#And I click on the link labeled "Browse Projects"
#And I enter "B.6.4.1000.100" in the field labeled "Search project title by keyword(s):"
#And I click on the button labeled "Search project title"
#And I click on the link labeled "B.6.4.1000.100"
###VERIFY
#Then I should see "NOTICE: Project was marked as Completed"
#And I click on the button labeled "Return to My Projects page"
