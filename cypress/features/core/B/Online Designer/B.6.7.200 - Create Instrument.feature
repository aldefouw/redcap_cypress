Feature: Form Creation: The system shall support the creation of new data collection instruments via the Online Designer.

As a REDCap end user
I want to see that Online Designer is functioning as expected

Scenario: B.6.7.200.100 Create form with Online Designer

#SETUP
Given I login to REDCap with the user "Test_Admin"   
And I create a new project named "B.6.7.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 
When I click on the link labeled "My Projects"  
And I click on the link labeled "B.6.7.200.100"  
And I click on the link labeled "Project Setup"
And I click on the button labeled "Online Designer"
Then I should see "Data Collection Instruments"

#FUNCTIONAL_REQUIREMENT
##ACTION: Create new form
When I click on the button labeled "Create"
And click on the last button labeled "Add instrument here"
And I enter "New Form" in the field labeled "New instrument name"
And I click on the button labeled "Create"
Then I should see "SUCCESS!"
Given I click on the button labeled "Close" in the dialog box
#VERIFY 
Then I should see the instrument labeled "New Form"

#VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action           | List of Data Changes OR Fields Exported |
| test_admin | Manage/Design | Create data collection instrument | 
