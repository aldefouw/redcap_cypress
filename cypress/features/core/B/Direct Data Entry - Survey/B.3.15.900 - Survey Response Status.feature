Feature: User Interface: The system shall support the following statuses for surveys: (Incomplete (no data saved) | Partial Survey Response |  Completed Survey Response)

As a REDCap end user
I want to see that Survey Feature is functioning as expected

#Scenario: B.3.15.900.100 Survey completion statuses
#
##SETUP
#Given I login to REDCap with the user "Test_User1"
#And I create a new project named "B.3.15.900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION
#When I cclick on the link labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see "Project status: Production"
#
##SETUP_DESIGNER
#When I click on the link labeled "Designer"
#And I click on the button labeled "Survey settings" for the instrument labeled "Survey"
#And I select "Yes" on the dropdown field labeled "Allow 'Save & Return Later ' option for respondents?"
#And I click on the button labeled "Save Changes"
#Then I should see "Your survey settings were successfully changed!"
#
##FUNCTIONAL REQUIREMENT
###ACTION Survey mode Incomplete (no data saved)
#When I click the link labeled "Add/Edit Records"
#And I click on the button labeled "Add new record for the arm selected above"
###VERIFY_incomplete (no data) icon on record homepage
#Then I should see an Incomplete (no data saved) status icon the "Survey" longitudinal instrument on event "Event Three"
#
##FUNCTIONAL REQUIREMENT
###ACTION Survey mode Partial Survey Response
#When I click the bubble for the "Survey" longitudinal instrument on event "Event Three"
#And I click on the button labeled "Save & Stay"
#And I click on the button labeled "Survey options"
#And I select the option labeled "Open survey"
#Then I should see "Please complete the survey below"
#
###VERIFY_RSD
#When I click on the button labeled "Save & Return Later"
#And I click on the button labeled "Close" in the dialog box
##M: Close browser tab
#And I click on the button labeled "Leave without saving changes" in the dialog box
#Then I should see "Record Home Page"
#And I should see a Partial Survey Response icon for the "Survey" longitudinal instrument on event "Event Three" for record "5"
#
##FUNCTIONAL REQUIREMENT
###ACTION Survey mode Completed Survey Response
#Given I click the link labeled "Add/Edit Records"
#And I click on the button labeled "Add new record for the arm selected above"
#And I click the bubble for the "Survey" longitudinal instrument on event "Event Three"
#And I click on the button labeled "Save & Stay"
#And I click on the button labeled "Survey options"
#And I select the option labeled "Open survey"
#Then I should see "Please complete the survey below"
#
#When I click on the button labeled "Submit"
#Then I should see "Thank you taking this survey"
#And I click on the button labeled "Close survey"
#
###VERIFY_RSD
#When I click on the button labeled "Leave without saving changes"
#Then I should see a Completed Survey Response icon for the "Survey" longitudinal instrument on event "Event Three" for record "6"
