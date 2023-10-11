Feature: Control Center: The system shall allow users to edit survey responses to be enabled or disabled.   

 As a REDCap end user 
 I want to see that allow edit survey response is functioning as expected    

Scenario: A.6.4.1600.100   
##SETUP_DEV
#Given I login to REDCap with the user "Test_Admin"
#And I create a new project named "A.6.4.1600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
##FUNCTIONAL REQUIREMENT
# ##ACTION Admin Disable edit survey response function in control center
# When I click on the link labeled "Control Center"
# And I click on the link labeled "User Settings"
#And I select the dropdown option labeled "Disabled" on the dropdown field labeled "Allow users to edit survey responses?"
#And I click on the button labeled "Save Changes"
# Then I should see "Your system configuration values have now been changed!"
#
###VERIFY: Admin Go to user rights and look for the edit survey checkbox (should be missing)
# When I click on the link labeled "My Projects"    And I click on the link labeled "A.6.4.1600.100"
#And I click on the link labeled "User Rights"  And I click on the link labeled "test_admin"
#And I click on the button labeled "Edit user privileges"
#Then I should NOT see the checkbox labeled "Edit user privileges" for the instrument labeled "Survey"
# And I click on the button labeled "Cancel"
#
# #FUNCTIONAL REQUIREMENT
###ACTION: Admin Enable edit survey response function in control center
#Given I click on the link labeled "Control Center"
#When I click on the link labeled "User Settings"
#And I select the dropdown option labeled "Enabled" on the dropdown field labeled "Allow users to edit survey responses?"
#And I click on the button labeled "Save Changes"
#Then I should see "Your system configuration values have now been changed!"
#
###VERIFY: Admin Go to user rights and look for the edit survey checkbox (should be there)
#Given I click on the link labeled "My Projects"
#When I click on the link labeled "A.6.4.1600.100"
#And I click on the link labeled "User Rights"
#And I click on the link labeled "test_admin"
#And I click on the button labeled "Edit user privileges"
#Then I should see the checkbox labeled "Edit user privileges" for the instrument labeled "Survey"
#
##FUNCTIONAL REQUIREMENT
# ##ACTION: Enable editing survey responses for survey instrument
#When I click on the checkbox labeled "Edit user privileges" for the instrument labeled "Survey"
#And I click on the button labeled "Save Changes"
# Then I should see "User "test_admin" was successfully edited"
#
##SETUP Check edit survey function in a  record
#Given I click the link labeled "Record Status Dashboard"
#And I click the bubble for the "Survey" longitudinal instrument on event "Event Three" for record "1"
# And I click on the button labeled "Survey options"  And I select the option labeled "Open survey"
# And I enter "SURVEY RESPONSE" in the field labeled "Name"  And I click on the button labeled "Submit"
# Then I should see "Thank you for taking this survey"  And I click on the button labeled "Close survey"
#
###VERIFY_RSD
#Given I click on the button labeled "Leave without saving changes"
#Then I should see the Completed Survey Response icon for the "Survey" longitudinal instrument on event "Event Three" for record "1"
#
#When I click the bubble for the "Survey" longitudinal instrument on event "Event Three" for record "1"
#Then I should see "Survey response is editable"
#
# #FUNCTIONAL REQUIREMENT
###ACTION: Edit survey response
#When I click on the button labeled "Edit response"
#And I enter "EDITED SURVEY RESPONSE" in the field labeled "Name"
#And I click on the button labeled "Save & Stay" from the dropdown field
#Then I should see "EDITED SURVEY RESPONSE" in the field labeled "Name"
#
###VERIFY_LOG
#When I click the link labeled "Logging"
#Then I should see a table header and rows including the following values in the logging table:
# | Username                   |        Action                 | List of Data Changes OR Fields Exported |
# | test_admin                 | Update record 1      | name_survey  = 'EDITED SURVEY RESPONSE ' |
# | [survey respondent] | Update Response 1 | name_survey  = 'SURVEY RESPONSE ' |
