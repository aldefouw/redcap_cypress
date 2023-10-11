Feature: User Interface: The system shall ignore survey identifier and timestamp fields on all data import spreadsheets and allow all other data to be imported.

#As a REDCap end user
#I want to see that Data import is functioning as expected
#
#Scenario: B.3.16.600.100 Import ignores survey identifier and timestamp fields
#
##SETUP  
#Given I login to REDCap with the user "Test_Admin"
#And I create a new project named "B.3.16.600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "B.3.16.600Project.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION 
#When I click on the button labeled "Move project to production"  
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box 
#And I click on the button labeled "YES, Move to Production Status" in the dialog box 
#Then I should see "Project status:  Production" 
#
#When I click on the link labeled "Data Import Tool" 
#And I click on the button labeled "Choose File" 
#And I upload the csv file labeled "B.3.16.600_DataImport.csv" 
#And I click on the button labeled "Upload File" 
#And I click on the button labeled "Import Data" 
#Then I should see "Import Successful!"
#
#When I click the link labeled " Data Exports, Reports and Stats" 
#And I click the button labeled " View Report" 
###VERIFY_DE 
#Then I should see a table header and rows including the following values in the report data table:
#|record_id| Survey Identifier    |  Survey Timestamp    |ptname |
#|         4      |                                  |                                       | My Name|
#|         5      |                                  |                                       | Your Name|
#|         6      |                                  |                                       | That Name|

#Manual: new records were imported and survey timestamp fields and identifier fields are ignored 
