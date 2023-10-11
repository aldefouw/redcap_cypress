Feature: Control Center: The system shall support the enabling/disabling of field validation types.  (Date (Y-M-D) | Datetime (Y-M-D H:M) | Datetime w/seconds (Y-M-D H:M:S) | Email | Integer | Number | Number (1 decimal place - comma as decimal) | Time (HH:MM))    

As a REDCap end user  
I want to see that Field validation is functioning as expected    

Scenario: A.4.8.100.100 Control center Enable/disable field validation     
#SETUP  
Given I login to REDCap with the user "Test_Admin"     
And I create a new project named "A.4.8.100.100 " by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button     

#SETUP_PRODUCTION  
When I click on the link labeled "Project Setup"   
And I click on the button labeled "Move project to production"   
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box   
And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status   
Then I should see Project status: "Production"     

#FUNCTIONAL REQUIREMENT  
##ACTION - Verify field validation Disable  
When I click on the link labeled "Control Center"    
And I click on the link labeled "Field Validation Types"  
Then I should see "Validation Types Currently Available for Use in All Projects"    

When I click on the button labeled "Disable" for the field labeled "Date (D-M-Y)"  
And I click on the button labeled "Disable" for the field labeled "Datetime (M-D-Y H:M)"  
And I click on the button labeled "Disable" for the field labeled "Datetime w/seconds (Y-M-D H:M:S)"  
And I click on the button labeled "Disable" for the field labeled "Email"  
And I click on the button labeled "Disable" for the field labeled "Integer"  
And I click on the button labeled "Disable" for the field labeled "Number"  
And I click on the button labeled "Disable" for the field labeled "Number (1 decimal place - comma as decimal)"  
And I click on the button labeled "Disable" for the field labeled "Time (HH:MM)"  
Then I should see the disabled icon for the field labeled "Date (D-M-Y)"  
And I should see the disabled icon for the field labeled "Datetime (M-D-Y H:M)"  
And I should see the disabled icon for the field labeled "Datetime w/seconds (Y-M-D H:M:S)"  
And I should see the disabled icon for the field labeled "Email"  And I should see the disabled icon for the field labeled "Integer"  
And I should see the disabled icon for the field labeled "Number"  
And I should see the disabled icon for the field labeled "Number (1 decimal place - comma as decimal)" 
 And I should see the disabled icon for the field labeled "Time (HH:MM)"    

##VERIFY: options not available on validation dropdown field  
When I click on the link labeled "My Projects"  
And I click on the link labeled "A.4.8.100.100"  
And I click on the link labeled "Designer"  
And I click on the button labeled "Enter Draft Mode"  
Then I should see "The project is now in Draft Mode."    
When I click on the instrument labeled "Data Types"  
And I click on the button labeled "Add Field" at the bottom of the instrument  
And I select the dropdown option labeled "Text Box" from the dropdown field with the placeholder text "Select a Type of Field"  
Then I should see the field labeled "Validation?"    

When I click on the dropdown field for the field labeled "Validation?"  
Then I should NOT see the dropdown option "Date (D-M-Y)"  
And I should NOT see the dropdown option " Datetime (M-D-Y H:M)"  
And I should NOT see the dropdown option " Datetime w/seconds (Y-M-D H:M:S)"  
And I should NOT see the dropdown option "Email"  
And I should NOT see the dropdown option "Integer"  
And I should NOT see the dropdown option "Number" 
 And I should NOT see the dropdown option "Number (1 decimal place - comma as decimal)"  
And I should NOT see the dropdown option "Time (HH:MM)"   

 #SETUP   
Given I click on the button labeled "Cancel" 
 When I click on the link labeled "Control Center"   
 And I click on the link labeled "Field Validation Types"  
Then I should see "Validation Types Currently Available for Use in All Projects"   
 When I click on the button labeled "Enable" for the field labeled "Date (D-M-Y)"  
And I click on the button labeled "Enable" for the field labeled "Datetime (M-D-Y H:M)" 
 And I click on the button labeled "Enable" for the field labeled "Datetime w/seconds (Y-M-D H:M:S)" 
 And I click on the button labeled "Enable" for the field labeled "Email"  
And I click on the button labeled "Enable" for the field labeled "Integer"  
And I click on the button labeled "Enable" for the field labeled "Number"  
And I click on the button labeled "Enable" for the field labeled "Number (1 decimal place - comma as decimal)"  
And I click on the button labeled "Enable" for the field labeled "Time (HH:MM)"  
Then I should see the green checkmark icon for the field labeled "Date (D-M-Y)" 
 And I should see the green checkmark icon for the field labeled "Datetime (M-D-Y H:M)"  
And I should see the green checkmark icon for the field labeled "Datetime w/seconds (Y-M-D H:M:S)"  
And I should see the green checkmark icon for the field labeled "Email"  
And I should see the green checkmark icon for the field labeled "Integer" 
 And I should see the green checkmark icon for the field labeled "Number"  
And I should see the green checkmark icon for the field labeled "Number (1 decimal place - comma as decimal)"  
And I should see the green checkmark icon for the field labeled "Time (HH:MM)"    

#FUNCTIONAL REQUIREMENT  
##ACTION - Verify field validation Enable    
##VERIFY: options are available on validation dropdown field 

When I click on the link labeled "My Projects"  
And I click on the link labeled "A.4.8.100.100"  And I click on the link labeled "Designer"  
And I click on the instrument labeled "Data Types"  
And I click on the button labeled "Add Field" at the bottom of the instrument  
And I select the dropdown option labeled "Text Box" from the dropdown field with the placeholder text "Select a Type of Field"  Then I should see the field labeled "Validation?"    
When I click on the dropdown field for the field labeled "Validation?"  
Then I should see the dropdown option "Date (D-M-Y)"  
And I should see the dropdown option " Datetime (M-D-Y H:M)"  
And I should see the dropdown option " Datetime w/seconds (Y-M-D H:M:S)"  
And I should see the dropdown option "Email"
  And I should see the dropdown option "Integer"  
And I should see the dropdown option "Number"  
And I should see the dropdown option "Number (1 decimal place - comma as decimal)"  
And I should see the dropdown option "Time (HH:MM)"  And I click on the button labeled "Cancel"
