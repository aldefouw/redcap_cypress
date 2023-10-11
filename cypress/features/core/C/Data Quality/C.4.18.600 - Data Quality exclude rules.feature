Feature: User Interface: The system shall support excluding discrepancies found in rule execution.

As a REDCap end user
I want to see that Data Quality Module is functioning as expected

Scenario: C.4.18.600.100 Exclude discrepancies

#SETUP
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "C.4.18.600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button
 #SETUP_PRODUCTION  
When I click on the link labeled "Project Setup"  
And I click on the button labeled "Move project to production"   
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box  

##ACTION executing all rules. 
When I click on the link labeled "Data Quality"
And I click on the button labeled "All" in the Data Quality Rules controller box
Then I should see a table header and rows containing the following values in the data quality report table: 
| Rule # |      Rule Name     |       Rule Logic (Show discrepancy only if...) 		|  Total Discrepancies| 
|      A    |  Blank values*                                                    |  -                 	 	|  377 export  |view |
|      B    |  Blank values* (required fields only)              |  -                 	 	|  2 export  |view |
|      C    |  Field validation errors (incorrect data type)|  -                 	 	|  1 export  |view |
|      D    | Field validation errors (out of range)             |  -                  		|  4 export  |view |
|      E    | Outliers for numerical fields (numbers, integers, sliders, calc fields)**|  -   | 2 export  |view  |
|      F    |  Hidden fields that contain values***           |  -                   		|  1 export  |view |
|      G   | Multiple choice fields with invalid values     |  -                  		 |  1 export  |view |
|      H   | Incorrect values for calculated fields             |  -                   		|  26 export  |view |
|      I    | Fields containing "missing data codes"          |  -                                                |  4 export  |view |
|      1   |  [radio]=9.9                                                         |   [radio]= '9.9'  		|  1 export  |view |
|      2   |  [ptname]<>[name]                        	       |   [ptname]<>[name]   	|  8 export  |view |

#FUNCTIONAL_REQUIREMENT
##ACTION: verify ability to exclude a discrepancy
When I click on the link labeled "view" for the Rule Name labeled "Field validation errors (out of range)"
Then I should see "Rule: Field validation errors (out of range)" in the dialog box
And I should see "Discrepancies found: 4" in the dialog box
And I should see a table header and rows including the following values in the data quality table: 
| Record |      Discrepant fields with their values | Status             |  Exclude| 
| 5 (#1)   |          integer = 1111111111                   | Out of range |  exclude|
| 5 (#1)   |       number_1_comma = 22222222.0 | Out of range |  exclude|
| 5 (#1)   |           number_1_period = 4.2               | Out of range |  exclude|
| 5 (#1)   |              number = 10.000                        | Out of range |  exclude|

When I click on the link labeled "exclude" for the discrepant field labeled "Integer"
Then I should see a table header and rows including the following values in the data quality table: 
| Record |      Discrepant fields with their values | Status             |  Exclude| 
| 5 (#1)   |          integer = 1111111111                   | Out of range |  remove exclusion|

And I click on the button labeled "Close" in the dialog box
#M: refresh the page

##VERIFY
When I click on the button labeled "All" in the Data Quality Rules controller box
Then I should see a table header and rows containing the following values in the data quality report table: 
| Rule # |      Rule Name     |       Rule Logic (Show discrepancy only if...) 		|  Total Discrepancies| 
|      D    | Field validation errors (out of range)             |  -                  		|  3 export  |view |

#FUNCTIONAL_REQUIREMENT
##ACTION: verify ability to add back excluded discrepancy
When I click on the link labeled "view" for the Rule Name labeled "Field validation errors (out of range)"
Then I should see "Rule: Field validation errors (out of range)" in the dialog box
And I should see "Discrepancies found: 3" in the dialog box
And I should see a link labeled "view" in the dialog box

When I click on the link labeled "view" in the dialog box
Then I should see "Rule: Field validation errors (out of range)" in the dialog box
And I should see "Discrepancies found: 4" in the dialog box
And I should see a table header and rows including the following values in the data quality table: 
| Record |      Discrepant fields with their values | Status             |  Exclude| 
| 5 (#1)   |          integer = 1111111111                   | Out of range |  remove exclusion|
| 5 (#1)   |       number_1_comma = 22222222.0 | Out of range |  exclude|
| 5 (#1)   |           number_1_period = 4.2               | Out of range |  exclude|
| 5 (#1)   |              number = 10.000                        | Out of range |  exclude|

When I click on the link labeled "remove exclusion" for the discrepant field labeled "Integer"
And I should see a table header and rows containing the following values in the data quality table: 
| Record |      Discrepant fields with their values | Status             |  Exclude| 
| 5 (#1)   |          integer = 1111111111                   | Out of range |  exclude|
| 5 (#1)   |       number_1_comma = 22222222.0 | Out of range |  exclude|
| 5 (#1)   |           number_1_period = 4.2               | Out of range |  exclude|
| 5 (#1)   |              number = 10.000                        | Out of range |  exclude|

And I click on the button labeled "Close" in the dialog box
#M: refresh the page

##VERIFY
When I click on the button labeled "All" in the Data Quality Rules controller box
Then I should see a table header and rows including the following values in the data quality table: 
| Rule # |      Rule Name     |       Rule Logic (Show discrepancy only if...) 		|  Total Discrepancies| 
|      D    | Field validation errors (out of range)             |  -                  		|  4 export  |view |

