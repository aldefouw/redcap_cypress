Feature: Field Creation: The system shall support the creation of Begin New Section (with optional text).

#As a REDCap end user
#I want to see that Project Designer is functioning as expected
#
#Scenario: B.6.7.1600.100 Creation of Section through the Online Designer
#
##SETUP
#Given I login to REDCap with the user "Test_Admin"
#And I create a new project named "B.6.7.1600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing "Empty project", and clicking the "Create Project" button
#
###SETUP_PRODUCTION
#When I click on the link labeled "My Projects"
#And I click on the link labeled "B.6.7.1600.100"
#When I click on the button labeled "Project Setup"
#And I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I should see "Project Status: Production"
#
#When I click on the link labeled "Designer"
#And I click on the button labeled "Enter Draft Mode"
#Then I should see "The project is now in Draft Mode"
#
##FUNCTIONAL_REQUIREMENT
###ACTION: section break creation
#When I click on the instrument labeled "Form 1"
#And I click on the button labeled "Add Field" at the bottom of the instrument
#Then I should see a dropdown field labeled "Select a Type of Field"
#
#When I click on the dropdown field labeled "Select a Type of Field"
#And I add a new Begin New Section (with optional text) labeled "Section Break"
#And I click on the button labeled "Save"
#Then I should see the "Sorry, but Section Headers cannot be the last field on a data entry form"
#And I click on the button labeled "OK"
#And I should NOT see the field labeled "Section Break"
#
#When I click on the button labeled "Add Field" below the field labeled "Record ID"
#And I select the dropdown option "Notes Box (Paragraph Text)" from the dropdown field with the placeholder text "Select a Type of Field"
#Given And I add a new Notes box field labeled "Notes Box" with the variable name "notesbox"
#And I click on the button labeled "Save"
##VERIFY
#Then I should see the field labeled "Notes Box"
#
#When I click on the button labeled "Add Field" below the field labeled "Record ID"
#And I click on the dropdown field labeled "Select a Type of Field"
#And I add a new Begin New Section (with optional text) labeled "Section Break"
#And I click on the button labeled "Save"
#Then I should see a yellow field labeled "Section Break"
#
###SETUP_PRODUCTION
#When I click on the button labeled "Submit Changes for Review"
#And I click on the button labeled "Submit" in the dialog box
#Then I should see "Changes Were Made Automatically"
#When I click on the button labeled "Close" in the dialog box
#
###VERIFY: section break
#When I click on the link labeled "Add / Edit Records"
#And I click on the button labeled "Add new record"
#And I click on the link labeled "Data Types"
#Then I should see a section break labeled "Section Break"
#
#Scenario: B.6.7.1600.200 Creation of section through Data Dictionary upload
#
##SETUP
#Given I login to REDCap with the user "Test_Admin"
#And I create a new project named "B.6.7.1600.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing "Empty project", and clicking the "Create Project" button
#
##FUNCTIONAL_REQUIREMENT
###ACTION: Upload data dictionary
#When I click on the link labeled "Dictionary"
#And I click on the button labeled "Choose File"
#And I select the file labeled "Project1xml_DataDictionary.csv"
#And I click on the button labeled "Upload File"
#Then I should see "Your document was uploaded successfully and awaits your confirmation below."
#
#When I click on the button labeled "Commit Changes"
#Then I should see "Changes Made Successfully!"
#
###VERIFY: section break
#When I click on the link labeled "Add / Edit Records"
#And I click on the button labeled "Add new record"
#And I click on the link labeled "Data Types"
#Then I should see a section break labeled "Date"
