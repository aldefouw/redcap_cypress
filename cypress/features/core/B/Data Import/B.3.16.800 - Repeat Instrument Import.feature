Feature: User Interface: The system shall require the repeating instrument and instance number in the csv file when importing data to a repeating event project.

As a REDCap end user
I want to see that Data import is functioning as expected

Scenario: B.3.16.800.100 Import requires the repeating instrument and instance number
#SETUP
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "B.3.16.800.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 

#SETUP_PROJECTSETUP
When I click on the link labeled "Project Setup"  
And I click on the button labeled "Modify" for the field labeled " Repeating instruments and events"
And I select "not repeating" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)" in the dialog box
And I select "not repeating" on the dropdown field labeled "Event 2 (Arm 1: Arm 1)" in the dialog box
And I click on the button labeled "Save"
Then I should see "Successfully saved!"

#SETUP_PRODUCTION
When I click on the button labeled "Move project to production"
And I click on the radio labeled "Delete ALL data in the project" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
And I click on the button labeled "Ok" in the pop-up box
Then I should see "Project Status: Production"

#FUNCTIONAL REQUIREMENT
##ACTION: Error during import
When I click on the link labeled "Data Import Tool"  
And I click on the tab labeled "CVS import"
Then I should see the button labeled "Choose File"

When I click on the button labeled "Choose File"
And I select the file labeled " B316800100_W_REPEATS"
And I click on the button labeled "Upload File"
##VERIFY 
Then I should see "ERROR:"
And I click on the link labeled "RETURN TO PREVIOUS PAGE"

#SETUP_PROJECTSETUP
When I click on the link labeled "Project Setup"  
And I click on the button labeled "Enable" for the field labeled "Repeating instruments and events"
And I select "Repeat instruments (repeat independently of each other" on the dropdown field for event  "Event 1 (Arm 1: Arm 1)" 
And I select the instrument labeled "Text Validation" for event "Event 1 (Arm 1: Arm 1)"
And I select the instrument labeled "Data Types" for event "Event 1 (Arm 1: Arm 1)"
And I click on the button labeled "Save"
Then I should see "Successfully saved!"

#FUNCTIONAL REQUIREMENT
##ACTION: import without repeat instrument
When I click on the link labeled "Data Import Tool"  
And I click on the tab labeled "CVS import"
Then I should see the button labeled "Choose File"

When I click on the button labeled "Choose File"
And I select the file labeled "B316800100 _WOUT_REPEATS"
And I click on the button labeled "Upload File"
##VERIFY 
Then I should see "ERROR:"

#FUNCTIONAL REQUIREMENT
##ACTION: import with repeat instrument
When I click on the button labeled "Choose File"
And I select the file labeled "B316800100 _W_REPEATS"
And I click on the button labeled "Upload File"


##VERIFY 
Then I should see "Your document was uploaded successfully"

When I click on the button labeled "Import Data"
Then I should see "Import Successful!"

