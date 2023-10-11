Feature: The system shall allow creation of a participant list automatically using a designated email field when a survey is in any instrument position.

As a REDCap end user
I want to see that Participant List is functioning as expected

#Scenario: B.3.15.300.100 Participant list linked to designated email field
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.3.15.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION
#When I click on the link labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see "Project status: Production"
#
###VERIFY_SETUP
#Given I click on the link labeled "Project Setup"
#Then I should see a button labeled "Disable" for the field labeled "Designate an email field"
#And I should see "Field currently designated: email"
#
##SETUP_SURVEY enable survey in first position
#When I click on the link labeled "Designer"
#And I click on the button labeled "Enable" for the instrument labeled "Text Validation"
#And I click on the button labeled "Save Changes"
#Then I should see an enabled icon for the instrument labeled "Text Validation"
#
##FUNCTIONAL_REQUIREMENT
###ACTION Verify Survey Distribution Tool
#When I click on the link labeled "Survey Distribution Tools"
#And I click on the button labeled "Participant List"
#Then I should see the option labeled "[Initial survey] "Text Validation"" selected on the field labeled "Participant List belonging to"
#And I should see the email "email@test.edu" for the record labeled "1"
#And I logout

