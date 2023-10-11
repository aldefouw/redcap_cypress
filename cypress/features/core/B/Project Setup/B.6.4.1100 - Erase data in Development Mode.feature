Feature: User Interface: General: The system shall support the ability to erase all data for a project at once only in development.

As a REDCap end user
I want to see that Project Setup is functioning as expected

Scenario: B.6.4.1100.100 Erase all data only in development as User
##SETUP_DEV
Given I login to REDCap with the user "Test_User1"
And I create a new project named "B.6.4.1100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

##ACTION Verify record exist ##VERIFY_RSD
When I click on the link labeled "Record Status Dashboard"
Then I should see record "3" 

When I click on the link labeled "Project Setup"  
And I click on the link labeled "Other Functionality"
Then I should see a button labeled "Erase all data"

#FUNCTIONAL REQUIREMENT
##ACTION Erase data
When I click on the button labeled "Erase all data"
And I click on the button labeled "Erase all data" in the dialog box
Then I should see "SUCCESS!"
And I click on the button labeled "Close" in the dialog box

##VERIFY_RSD
When I click on the link labeled "Record Status Dashboard"
Then I should see "No records exist yet"

##SETUP_PRODUCTION
When I click on the button labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project Status: Production"

#FUNCTIONAL REQUIREMENT
##ACTION Erase data button missing in production mode
When I click on the link labeled "Other Functionality"
##VERIFY
Then I should NOT see a button labeled "Erase all data"
And I logout

Scenario: B.6.4.1100.200 Erase all data in production mode as Admin
##SETUP_PRODUCTION
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "B.6.4.1100.200.PROD" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
When I click on the button labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project Status: Production"

##ACTION Verify record exist ##VERIFY_RSD
When I click on the link labeled "Record Status Dashboard"
Then I should see record "3" 

When I click on the link labeled "Project Setup"  
And I click on the link labeled "Other Functionality"
Then I should see a button labeled "Erase all data"

#FUNCTIONAL REQUIREMENT
##ACTION Erase data 
When I click on the button labeled "Erase all data"
And I click on the button labeled "Erase all data" in the dialog box
Then I should see "SUCCESS!"
And I click on the button labeled "Close" in the dialog box

##VERIFY_RSD
When I click on the link labeled "Record Status Dashboard"
Then I should see "No records exist yet"
