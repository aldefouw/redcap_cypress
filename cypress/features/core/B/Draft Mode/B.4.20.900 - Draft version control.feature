Feature: User Interface: The system shall record all versions of the data dictionary post-production with date time stamp, requestor, and approver.

As a REDCap end user
I want to see that Draft Mode is functioning as expected

#Scenario: B.4.20.900.100 Data dictionary version history
#
##SETUP
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.4.20.900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
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
###ACTION
#Given I click on the instrument labeled "Data Types"
#And I click on the button labeled "Add Field" at the bottom of the instrument
#And I click on the dropdown field labeled "Select a Type of Field"
#And I add a new Notes Box (Paragraph Text) labeled "DD History" with the variable name "dd_history"
#And I click on the button labeled "Save"
#Then I should see the field labeled "DD History"
#
###ACTION: Commit Changes
#When I click on the button labeled "Submit Changes for Review"
#And I click on the button labeled "Submit" in the dialog box
#Then I should see "SUCCESS!!"
#And I click on the button labeled "Close" in the dialog box
#
###ACTION
#When I click on the button labeled "Project Home"
#And I click on the link labeled "Project Revision History"
#Then I should see "Project Revision History"
#
##FUNCTIONAL_REQUIREMENT
#Then I should see a row containing the following values in the Project Review History table:
#|      Created project  | mm/dd/yyyy hh:mm |                                                 |      Created by Test_User1 (User1 Test)  |
#|Move to production| mm/dd/yyyy hh:mm | Download data dictionary | Moved to production by Test_User1 (User1 Test) |
#|Production revision # 1|dd/mm/yyyy hh:mm | Download data dictionary | Requested by Test_User1 (User1 Test) automatically|
