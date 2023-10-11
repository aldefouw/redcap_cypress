Feature: User Interface: The system shall provide the option to allow blank values to overwrite existing saved values.

#As a REDCap end user
#I want to see that Data import is functioning as expected
#
#Scenario: B.3.16.1200.100 Data import overwrite existing values with blank
#
##SETUP
#Given I login to REDCap with the user "Test_Admin"
#And I create a new project named "B.3.16.1200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION
#When I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#And I click on the button labeled "Ok" in the pop-up box
#Then I should see "Project Status: Production"
#
##FUNCTIONAL REQUIREMENT
###ACTION: Error during import
#When I click on the link labeled "Data Import Tool"
#And I click on the tab labeled "CVS import"
#Then I should see the button labeled "Choose File"
#
#When I click on the button labeled "Choose File"
#And I select the file labeled "B3161200100_INACCURATE"
#And I click on the button labeled "Upload File"
###VERIFY
#Then I should see "ERROR:"
#And I click on the link labeled "RETURN TO PREVIOUS PAGE"
#
##FUNCTIONAL REQUIREMENT
###ACTION: w DAGs
#When I click on the button labeled "Choose File"
#And I select the file labeled "B3161200100_ACCURATE"
#And I click on the button labeled "Upload File"
#
###VERIFY
#Then I should see "Your document was uploaded successfully"
#
#When I click on the button labeled "Import Data"
#Then I should see "Import Successful!"
