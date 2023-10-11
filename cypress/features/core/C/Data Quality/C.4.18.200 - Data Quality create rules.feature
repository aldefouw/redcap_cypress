Feature: User Interface: The system shall support data quality rule creation.

As a REDCap end user
I want to see that Data Quality Module is functioning as expected

Scenario: C.4.18.200.100 Data quality rule creation


#SETUP 
Given I login to REDCap with the user "Test_Admin" 
And I create a new project named "C.4.18.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_418.xml", and clicking the "Create Project" button
 
#SETUP_PRODUCTION 
When I click on the link labeled "Project Setup" 
And I click on the button labeled "Move project to production"  
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box 
Then I should see "Project status: Production" 

#FUNCTIONAL_REQUIREMENT
##ACTION: Manual rule add
When I click on the link labeled "Data Quality"
Then I should see "Data Quality Rules"

When I enter "Integer" for the field labeled "Rule Name"
And I enter "[integer]='1999'" for the field labeled "Logic Editor"
And I click on the button labeled "Update & Close Editor" in the dialog box
And I click on the button labeled "Add"
##VERIFY
Then I should see a table header and rows including the following values in the Data Quality Rules table: 
| Rule # | Rule Name   | Rule Logic (Show discrepancy only if...) |        
|      3     |  Integer         |             [integer]='1999'                           |  

#FUNCTIONAL_REQUIREMENT
##ACTION: Upload rule
When I select the dropdown option labeled "Upload Data Quality Rule (CSV)" from the dropdown field labeled "Upload or download Data Quality Rules"  
And I upload the csv file labeled "C418100TEST_DataQualityRules_Upload"
Then I should see "Upload Data Quality Rule (CSV) - Confirm" in the dialog box

When I click on the button labeled "Upload" in the dialog box
Then I should see "SUCCESS!"

When I click on the button labeled "Close" in the dialog box
Then I should see "Data Quality Rules"
##VERIFY
And I should see a table header and rows containing the following values in the Data Quality Rules table: 
| Rule # | Rule Name   | Rule Logic (Show discrepancy only if...) |        
|      4     |   Integer         |             [integer]<>'1999'                        |  

##ACTION: create record for new rule
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
Then I should see "Adding new Record ID 11"

When I enter "1999" for the field labeled "Integer"
And I click on the button labeled "Close" in the dialog box
And I click on the button labeled "Save & Exit Form"
Then I should see "Record ID 11 successfully added."

##ACTION: create record for uploaded new rule
When I click the link labeled "Add/Edit Records"
And I click the button labeled "Add new record for the arm selected above"
And I click the bubble labeled "Data Types" for event "Event 1" 
Then I should see "Adding new Record ID 12."

When I enter "2000" for the field labeled "Integer"
And I click on the button labeled "Close" in the dialog box
And I click on the button labeled "Save & Exit Form"
Then I should see "Record ID 12 successfully added."

#VERIFY
When I click on the link labeled "Data Quality"
And I click on the button labeled "All" in the Data Quality Rules controller box
Then I should see a table header and rows including the following values in the data quality report table: 
| Rule # |      Rule Name  |       Rule Logic (Show discrepancy only if...) |  Total Discrepancies| 
|      3   |  Integer               |   [integer]='1999'	                                   |    1 export  |view |
|      4   |  Integer               |   [integer]<>'1999'	                                   |  17 export  |view |
##ACTION: edit existing rule
When I click on the edit image for the Rule Logic for rule "4"
And I enter "[integer]='1'" for the field labeled "Logic Editor"
And I click on the button labeled "Update & Close Editor" in the dialog box
And I click on the button labeled "Save"
Then I should see a table header and rows containing the following values in the data quality report table: 
| Rule # |      Rule Name  |  Rule Logic (Show discrepancy only if...) | 
|      4     |  Integer             |  [integer]='1'	                                            |    
#M: refresh browser page

#VERIFY
When I click on the button labeled "All" in the Data Quality Rules controller box
Then I should see a table header and rows containing the following values in the data quality report table: 
| Rule # |      Rule Name  |       Rule Logic (Show discrepancy only if...) |  Total Discrepancies| 
|      4     |  Integer             |   [integer]='1'	                                                  |    6 export  |view |

##ACTION: delete rule
When I click on the "X" delete image for Rule "4"
And I click on the button labeled "OK" in the pop-up box
Then I should NOT see Rule "4"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action           | List of Data Changes OR Fields Exported |
| test_admin | Manage/Design | Delete data quality rule(s)                          |
| test_admin | Manage/Design | Edit data quality rule                                   |
| test_admin | Manage/Design | Execute data quality rule(s)                       |
| test_admin | Manage/Design | Upload Data Quality Rules                         |
| test_admin | Manage/Design | Create data quality rule                              |
