Feature: User Interface: The system shall support editing of user defined rules.

As a REDCap end user
I want to see that Data Quality Module is functioning as expected

Scenario: C.4.18.700.100 Edit rule

#SETUP
Given I login to REDCap with the user "Test_User1"
And I create a new project named "C.4.18.700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project418.xml", and clicking the "Create Project" button

#SETUP_PRODUCTION  
When I click on the link labeled "Project Setup"  
And I click on the button labeled "Move project to production"   
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box  
#USER_RIGHTS  
When I click on the link labeled "User Rights"  
And I click on the link labeled "Test_User1"
And I click on the button labeled "Edit User Privileges"
And I verify the checkbox labeled "Create & edit rules" for the field labeled "Data Quality" is selected
And I verify the checkbox labeled "Execute rules" for the field labeled "Data Quality" is selected
And I click on the button labeled "Save Changes" 
Then I should see "User "test_user1" was successfully edited"

#FUNCTIONAL_REQUIREMENT
##ACTION: Manual rule add
When I click on the link labeled "Data Quality"
Then I should see "Data Quality Rules"

When I enter "Integer" for the field labeled "Rule Name"
And I enter "[integer]='1'" for the field labeled "Logic Editor"
And I click on the button labeled "Update & Close Editor" in the dialog box
And I click on the button labeled "Add"
##VERIFY
Then I should see a table header and rows including the following values in the Data Quality Rules table: 
| Rule # | Rule Name   | Rule Logic (Show discrepancy only if...) |        
|      3     |  Integer         |             [integer]='1'                           |  

#FUNCTIONAL_REQUIREMENT
##ACTION executing rule 
When I click on the button labeled "All" in the Data Quality Rules controller box
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
|      I    | Fields containing "missing data codes"          |  -                                             |  4 export  |view |
|      1   |  [radio]=9.9                                                         |   [radio]= '9.9'  		|  1 export  |view |
|      2   |  [ptname]<>[name]                        	       |   [ptname]<>[name]   	|  8 export  |view |
|      3   |  Integer                                              	       |   [integer]='1'                	|  6 export  |view |

#USER_RIGHTS
##ACTION: change rights-cannot create rules  
When I click on the link labeled "User Rights"  
And I click on the link labeled "Test_User1"
And I click on the button labeled "Edit User Privileges"
And I deselect the checkbox labeled "Create & edit rules" for the field labeled "Data Quality" 
And I click on the button labeled "Save Changes" 
Then I should see "User "test_user1" was successfully edited"


#FUNCTIONAL_REQUIREMENT
##ACTION: cannot add rule and can execute rules
When I click on the link labeled "Data Quality"
Then I should see "Data Quality Rules"
And I should NOT see a button labeled "Add"

When I click on the button labeled "All" in the Data Quality Rules controller box
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
|      I    | Fields containing "missing data codes"          |  -                                             |  4 export  |view |
|      1   |  [radio]=9.9                                                         |   [radio]= '9.9'  		|  1 export  |view |
|      2   |  [ptname]<>[name]                        	       |   [ptname]<>[name]   	|  8 export  |view |
|      3   |  Integer                                              	       |   [integer]='1'                	|  6 export  |view |

#USER_RIGHTS
##ACTION: change rights - cannot execute rules  
When I click on the link labeled "User Rights"  
And I click on the link labeled "test_user1"
And I click on the button labeled "Edit User Privileges"
And I select the checkbox labeled "Create & edit rules" for the field labeled "Data Quality" 
And I deselect the checkbox labeled "Execute rules" for the field labeled "Data Quality"
And I click on the button labeled "Save Changes" 
Then I should see "User "test_user1" was successfully edited"

#FUNCTIONAL_REQUIREMENT
##ACTION: can add rule and cannot execute rules
When I click on the link labeled "Data Quality"
Then I should see "Data Quality Rules"
And I should see a button labeled "Add"
And I should NOT see a button labeled "All"
