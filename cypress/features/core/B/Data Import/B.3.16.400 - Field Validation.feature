Feature: User Interface: The system shall import only valid formats for text fields with validation.

#As a REDCap end user
#I want to see that Data import is functioning as expected
#
#Scenario: B.3.16.400.100 Import valid formats for text fields
#
##SETUP
#Given I login to REDCap with the user "Test_Admin"
#And I create a new project named "B.3.16.400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.16.xml", and clicking the "Create Project" button
#
##SETUP_PRODUCTION
#When I click on the button labeled "Move project to production"
#And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
#And I click on the button labeled "YES, Move to Production Status" in the dialog box
#Then I see "Project status:  Production"
#
##VERIFY_RSD: no records exist
#When I click on the link labeled "Record Status Dashboard" 
#Then I should see "No records exist yet"
#
##FUNCTIONAL_REQUIREMENT
###ACTION
#Given I click on the link labeled "Data Import Tool" 
#When I click on the button labeled "Choose File" 
#And I upload the file labeled "B.3.16.400_DataImport_Rows.csv" 
#And I click on the button labeled "Upload File" 
#Then I should see "Your document was uploaded successfully and is ready for review" 
#And I click on the button labeled "Import Data" 
#Then I should see "Import Successful!" 
#
##VERIFY_RSD: 3 records
#When I click on the link labeled "Record Status Dashboard" 
#Then I should see record "100" in the table
#And I should see record "200" in the table
#And I should see record "300" in the table
#
##VERIFY_LOG 
#When I click on the link labeled "Logging" 
#Then I should see a table header and including the following values in the logging table:
#| Username |            Action                           | List of Data Changes OR Fields Exported |
#| test_admin| Create record (import) 100|                        record_id = '100'                    |
#| test_admin| Create record (import) 200|                        record_id = '200'                    |
#| test_admin| Create record (import) 300|                   record_id = '300'                         |
#
#
##FUNCTIONAL_REQUIREMENT
###ACTION
#When I click on the link labeled "Data Import Tool" 
#And I select the dropdown option labeled "Yes, blank values in the file will overwrite existing" in the dropdown field labeled "Allow blank values to overwrite existing saved values?"
#And I click the button labeled "Yes, I understand" in the dialogue box
#And I click the button labeled "Choose file"
#And I upload the file labeled "B.3.16.400_DataImport_rows Bad.csv" 
#And I click the button labeled "Upload File"
#Then I should see "Errors were detected in the import file that prevented it from being uploaded"
#And I should see a table header and rows containing the following values in the report data table:
#| Record |           Field Name          |       Value      |
#|   300     |               email                |   ringo@noreply|
#|   300     |              bdate                 |  0007-40-07|
#|   300     |     multiple_radio_auto |          99     |
#
#
#
##FUNCTIONAL_REQUIREMENT
###ACTION: Corrected format
#
#When I click the button labeled "Choose file"
#And I upload the file labeled "B.3.16.400_DataImport_rows Corrected.csv" 
#And I click the button labeled "Upload File"
#Then I should see a table header and rows containing the following values in the report data table:
#| record_id |           email               |       bdate     | multiple_radio_auto |
#|   300          | ringo@noreply.edu|1940-07-07|        2                       |
#
#When I click the button labeled "Import Data"
#Then I should "Import Successful! 3 records were created or modified during the import."
#
###VERIFY_LOG
# When I click on the link labeled "Logging" 
#Then I should see a table header and including the following values in the logging table:
#| Username |            Action                           | List of Data Changes OR Fields Exported |
#| test_admin| Create record (import) 300 |  email = 'ringo@noreply.edu' |
#| test_admin| Create record (import) 300 |bdate = '1940-07-07' |
#| test_admin| Create record (import) 300 |multiple_radio_auto = '2' |

