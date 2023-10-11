Feature: User Interface: The system shall support the ability to run custom data quality rules real time.

As a REDCap end user
I want to see that Data Quality Module is functioning as expected

Scenario: C.4.18.1000.100 Real-time rule execution

#SETUP 
Given I login to REDCap with the user "Test_Admin" 
And I create a new project named "C.4.18.1000.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_418.xml", and clicking the "Create Project" button

#SETUP_PRODUCTION 
When I click on the link labeled "Project Setup" 
And I click on the button labeled "Move project to production"  
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box 
Then I should see "Project status: Production" 
 
#SETUP_PRODUCTION: Rule Creation
When I click on the link labeled "Data Quality"
Then I should see "Data Quality Rules"
 
When I enter "Integer" for the field labeled "Rule Name"
And I enter "[integer]<>'1999'" for the field labeled "Logic Editor"
And I click on the button labeled "Update & Close Editor" in the dialog box
And I click on the button labeled "Execute in real time on data entry forms" button
And I click on the button labeled "Add"
Then I should see a table header and rows containing the following values in the Data Quality Rules table: 
| Rule # | Rule Name   | Rule Logic (Show discrepancy only if...) |        
|      3 |  Integer    |             [integer]<>'1999'         |
 
#FUNCTIONAL_REQUIREMENT
##ACTION: System shall support the ability to run custom data quality rules real time
When I click the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
And I enter "2000" in the field labeled "Integer"	
And I click on the button labeled "Close" in the dialog box
And I click the button labeled "Save and Exit Form"
Then I should see "WARNING: Data Quality rules were violated!"
And I click on the button labeled "Close" in the dialog box
