Feature: User Interface:  The system shall support the ability to create, modify, copy, or delete reports.

As a REDCap end user
I want to see that Reporting is functioning as expected

Scenario: C.5.22.200.100 - MISSING SCENARIO TITLE

#SETUP 
Given I login to REDCap with the user "Test_User1" 
And I create a new project named "C.5.22.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

#SETUP_PRODUCTION 
When I click on the link labeled "Project Setup" 
And I click on the button labeled "Move project to production"  
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box 
Then I should see "Project status: Production" 

#FUNCTIONAL_REQUIREMENT
##ACTION:  create report
When I click on the link labeled "Data Exports, Reports, and Stats" 
And I click on the button labeled "Create New Report"
And I enter "C.5.22.200.100 REPORT" in the field labeled "Name of Report:"
And I click on the button labeled "Save Report"
Then I should see "Your report has been saved!" in the dialog box

##VERIFY: saved name
When I click on the button labeled "View report" in the dialog box
Then I should see "C.5.22.200.100 REPORT"

When I click on the button labeled "Edit Report"
Then I should see "Edit Existing Report: "C.5.22.200.100 REPORT"

#FUNCTIONAL_REQUIREMENT
##ACTION:  edit report name
When I enter " C.5.22.200.100 REPORT_EDIT" in the field labeled "Name of Report:"
And I click on the button labeled "Save Report"
Then I should see "Your report has been saved!" in the dialog box

##VERIFY: edited name
When I click on the button labeled "View report" in the dialog box
Then I should see "C.5.22.200.100 REPORT_EDIT"

When I click on the button labeled "Edit Report"
Then I should see "Edit Existing Report: "C.5.22.200.100 REPORT_EDIT"

When I enter "C.5.22.200.100 REPORT_EDIT2" in the field labeled "Name of Report:"
And I click on the button labeled "Save Report"
Then I should see "Your report has been saved!" in the dialog box

##VERIFY: edited name
When I click on the button labeled "View report" in the dialog box
Then I should see "C.5.22.200.100 REPORT_EDIT2"

When I click on the link labeled "Data Exports, Reports, and Stats" 
Then I should see a table row including the following values in the reports table:  
| 2 | C.5.22.100.100 REPORT_EDIT2 |  

#FUNCTIONAL_REQUIREMENT
##ACTION:  copy report
When I click on the button labeled "Copy" for the report labeled "C.5.22.100.100 REPORT_EDIT2"
Then I should see "COPY REPORT?"

When I click on the button labeled "Copy" in the dialog box
##VERIFY: copy
Then I should see a table row including the following values in the reports table:  
| 2 | C.5.22.100.100 REPORT_EDIT2 |  
| 3 | C.5.22.100.100 REPORT_EDIT2 (copy) |  

#FUNCTIONAL_REQUIREMENT
##ACTION:  delete report
When I click on the button labeled "Delete" for the report labeled "C.5.22.100.100 REPORT_EDIT2"
Then I should see "DELETE REPORT?"

When I click on the button labeled "Delete" in the dialog box
##VERIFY: delete
Then I should see a table row including the following values in the reports table:  
| 2 | C.5.22.100.100 REPORT_EDIT2 (copy) |  
