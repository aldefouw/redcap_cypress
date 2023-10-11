Feature: User Interface: The system shall provide default rules after installation of the application.

As a REDCap end user
I want to see that Data Quality Module is functioning as expected

Scenario: C.4.18.100.100 Default data quality rules

#SETUP 
Given I login to REDCap with the user "Test_Admin" 
And I create a new project named "C.4.18.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_418.xml", and clicking the "Create Project" button
 
#SETUP_PRODUCTION 
When I click on the link labeled "Project Setup" 
And I click on the button labeled "Move project to production"  
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box 
Then I should see "Project status: Production" 

#FUNCTIONAL_REQUIREMENT
##ACTION
When I click on the link labeled "Data Quality"
Then I should see "Data Quality Rules"
And I should see a table header and rows containing the following values in the Data Quality Rules table: 
| Rule # |                               Rule Name                           | Rule Logic (Show discrepancy  only if...) |        
|      A    |  Blank values*                                                    |  -                                                                 |  
|      B    |  Blank values* (required fields only)              |  -                                                                |  
|      C    |  Field validation errors (incorrect data type)|  -                                                                |  
|      D    | Field validation errors (out of range)             |  -                                                                |  
|      E    | Outliers for numerical fields (numbers, integers, sliders, calc fields)**|  -                  |  
|      F    |  Hidden fields that contain values***           |  -                                                                 |  
|      G   | Multiple choice fields with invalid values     |  -                                                                 |  
|      H   | Incorrect values for calculated fields             |  -                                                                 |  
|      I    | Fields containing "missing data codes"           |  -                                                                |  
|      1    | [radio]=9.9                                                          |  [radio]='9..9'			      |  
|      2   | [ptname]<>[name]			                       |  [ptname]<>[name]                                |  
