Feature: User Interface: The system shall support the ability for a user to keep or remove all record data during project status change from Development to Production.

As a REDCap end user
I want to see that My Project is functioning as expected

Scenario: B.6.11.300.100 Move project from development to production while keeping data
#SETUP
Given I login to REDCap with the user "Test_User1"
And I create a new project named "B.6.11.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

#FUNCTIONAL REQUIREMENT
##ACTION: move to production
When I click on the link labeled "My Projects"  
And I click on the link labeled "B.6.11.300.100"  
And I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production" 
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "Yes, Move to Production Status" in the dialog box
##VERIFY
Then I should see "Project status: Production"

##VERIFY_RSD:
When I click on "Record Status Dashboard"  
Then I should see "1" 


Scenario: B.6.11.300.200 Move project from development to production while deleting data
#SETUP
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "B.6.11.300.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

#FUNCTIONAL REQUIREMENT
##ACTION: move to production
When I click on the link labeled "My Projects"  
And I click on the link labeled "B.6.11.300.200"  
And I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production" 
And I click on the radio labeled "Delete ALL data" in the dialog box
And I click on the button labeled "Yes, Move to Production Status" in the dialog box
And I click on the button labeled "OK" in the pop-up box
##VERIFY
Then I should see "Project status: Production"

##VERIFY_RSD:
When I click on "Record Status Dashboard"  
Then I should see "No records exist yet"
