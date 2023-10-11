Feature: User Interface: The system shall not allow data to be changed on locked data entry forms.

As a REDCap end user
I want to see that Data import is functioning as expected

Scenario: B.3.16.900.100 Limit import to unlocked record forms

#SETUP 
Given I login to REDCap with the user "Test_Admin" 
And I create a new project named "B.3.16.900.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.16.xml", and clicking the "Create Project" button 

#SETUP_PRODUCTION
When I click on the link labeled "Project Setup"  
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project Status: Production"

##ACTION: Import data
When I click on the link labeled "Data Import Tool" 
And I click on the button labeled "Choose File" 
And I select the file labeled "B.3.16.900.100_ImportChangedUnlocked" 
And I click on the button labeled "Upload File" 
Then I should see a table header and rows containing the following values in in the Data Display Table:
|record_id | name |
|       1         | Name|

When I click the button labeled "Import Data"
Then I should see "Import Successful!"

#FUNCTIONAL_REQUIREMENT
##ACTION: lock record 1
When I click on the link labeled "Record Status Dashboard" 
And I click the link labeled "1"
And I select the dropdown option labeled "Lock entire record" for the dropdown field labeled "Choose action for record"
And I click on the button labeled "Lock entire record" on the dialog box
Then I should see "Record "1" is now LOCKED"

#VERIFY_DI
When I click on the link labeled "Data Import Tool" 
And I click on the button labeled "Choose File" 
And I select the file labeled "B.3.16.900.100_ImportChangedLocked" 
And I click on the button labeled "Upload File" 
Then I should see a table header and rows containing the following values in in the Error Display Table:
|Record | Error message |
|  1         | This record has been locked at the record level. No value within this record can be modified.|

#VERIFY_LOG
When I click the link labeled "Logging"
Then I should see a table header and rows containing the following values in the logging table:
#M: should not see anything was imported after record was locked
| Username    |Action                           | List of Data Changes          |
|  test_admin |Lock/Unlock Record 1| Action Lock entire record |
