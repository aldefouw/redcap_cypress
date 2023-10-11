Feature: User Interface: General: The system shall support the ability to delete projects only in development for project users and in any status for administrators.

As a REDCap end user
I want to see that Project Setup is functioning as expected

Scenario: B.6.4.1200.100 Projects in development can be deleted by user
##SETUP_DEV
Given I login to REDCap with the user "Test_User1"
And I create a new project named "B.6.4.1200.100.DEV" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown
And I click on the radio labeled "Empty project (blank slate)"
And I click on the button labeled "Create Project" 
Then I should see "B.6.4.1200.100.DEV"

#FUNCTIONAL REQUIREMENT
When I click on the link labeled "My Projects"  
And I click on the link labeled "B.6.4.1200.100.DEV"  
And I click on the link labeled "Other Functionality"
Then I should see a button labeled "Delete the project"

##ACTION Delete the project
When I click on the button labeled "Delete the project"
And I enter "DELETE" in the field labeled "TYPE "DELETE" BELOW" in the dialog box
And I click on the button labeled "Delete the project" in the dialog box
And I click on the button labeled "Yes, delete the project" in the dialog box
Then I should see "Project successfully deleted!"
And I click on the button labeled "Close" in the dialog box
Given I logout

Scenario: B.6.4.1200.200 Projects in production with no records can be deleted by user 
##SETUP_PRODUCTION
Given I login to REDCap with the user "Test_User1"
Given I create a new project named "B.6.4.1200.200.PROD" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown
And I click on the radio labeled "Empty project (blank slate)"
And I click on the button labeled "Create Project" 
Then I should see "B.6.4.1200.200.PROD"

When I click on the link labeled "My Projects"  
And I click on the link labeled " B.6.4.1200.200.PROD"  
And I click on the button labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project Status: Production"

##ACTION Verify record do NOT exist ##VERIFY_RSD
When I click on the link labeled "Record Status Dashboard"
Then I should see "No records exist yet"

#FUNCTIONAL REQUIREMENT
When I click on the button labeled "Project Setup"
And I click on the link labeled "Other Functionality"
Then I should see a button labeled "Request delete project"

##ACTION Delete the project
When I click on the button labeled "OK" in the pop-up box
Then I should see "Project successfully deleted!"
And I click on the button labeled "Close" in the dialog box

Scenario: B.6.4.1200.300 Projects in production with records require admin
##SETUP_PRODUCTION
Given I login to REDCap with the user "Test_User1"
And I create a new project named "B.6.4.1200.300.PROD" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

When I click on the link labeled "My Projects"  
And I click on the link labeled " B.6.4.1200.300.PROD"  
And I click on the button labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project Status: Production"

##ACTION Verify record exist ##VERIFY_RSD
When I click on the link labeled "Record Status Dashboard"
Then I should see record "3" 

#FUNCTIONAL REQUIREMENT
Given I click on the link labeled "Project Setup"
When I click on the link labeled "Other Functionality"
##ACTION Request delete project
And I click on the link labeled "Request delete project"
And I click on the button labeled "OK" in the pop-up box
Then I should see "Success!"
And I logout

Given I login to REDCap with the user "Test_Admin"
Then I should see a button labeled "Delete the project"

##ACTION Delete project
When I click on the button labeled "Delete the project"
And I enter "DELETE" in the field labeled "TYPE "DELETE" BELOW" in the dialog box
And I click on the button labeled "Delete the project" in the dialog box
And I click on the button labeled "Yes, delete the project" in the dialog box
##VERIFY 
Then I should see "Project successfully deleted!"
And I click on the button labeled "Close" in the dialog box
