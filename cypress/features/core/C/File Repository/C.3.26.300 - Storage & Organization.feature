Feature: User Interface: The system shall support the storage, organization, and sharing of project files for permanent folders: (Data Export | e-Consent PDFs | Recycle Bin | Custom Create folder / Sub-folder)

As a REDCap end user
I want to see that file repository is functioning as expected

Scenario: C.3.26.300.100 Automatic uploading of data export logs into the data export folder

#SETUP 
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "C.3.26.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
And I click on the link labeled "My Projects"
And I click on the link labeled "A.3.26.300.100"  

#SETUP Export data automatically placed in file repo
Given I click on the link labeled "Data Exports, Reports, and Stats"
And I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
And I click on the button labeled "Export Data" in the dialog box
Then I should see a dialog containing the following text: "Data export was successful!"

Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
Then I should have a csv file 

#FUNCTIONAL_REQUIREMENT
##ACTION Export data automatically placed in file repo
When I click on the link labeled "File Repository"
And I click on the link labeled "Data Export Files"

Then I verify I see the csv file 
And I should see "Data export file created by test_admin on YYYY-MM-DD"

Scenario: C.3.26.300.200 Automatic uploading of e-Consent Framework PDFs
REDUNDANT
Scenario: C.3.26.300.300 Recycle bin function - permanently force delete 

#SETUP 
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "C.3.26.300.300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
And I click on the link labeled "My Projects"
And I click on the link labeled "A.3.26.300.300"  

##ACTION Upload to top tier file repo 
When I click on the link labeled "File Repository"
And I upload a "csv" format file located at "import_files/testusers_bulk_upload.csv", by clicking the button near "Select files to upload" to browse for the file, and clicking the button labeled "Open" to upload the file

##VERIFY_FiRe file uploaded in folder
Then I should see "testusers_bulk_upload.csv"

#FUNCTIONAL_REQUIREMENT
##ACTION Delete file
When I check the checkbox labeled "testusers_bulk_upload.csv"
And I click on the button labeled "Delete"
Then I should see a dialog containing the following text: "Delete files?"
And I click on the button labeled "Delete" in the dialog box
##VERIFY file deleted in folder
Then I should see a dialog containing the following text: "SUCCESS!"
And I close the popup
Then I should NOT see "testusers_bulk_upload.csv"


#FUNCTIONAL_REQUIREMENT
##ACTION Cancel Restore deleted file
When I click on the link labeled "Recycle Bin"
Then I should see "testusers_bulk_upload.csv"
When I click on the link labeled "Restore deleted file?"
Then I should see a dialog containing the following text: "File: testusers_bulk_upload.csv"
When I click on the button labeled "Cancel" in the dialog box
##VERIFY file still in recycle folder
Then I should see "testusers_bulk_upload.csv"

#FUNCTIONAL_REQUIREMENT
##ACTION Restore deleted file
When I click on the link labeled "Recycle Bin"
Then I should see "testusers_bulk_upload.csv"
When I click on the link labeled "Restore deleted file?"
Then I should see a dialog containing the following text: "File: testusers_bulk_upload.csv"
When I click on the button labeled "Restore" in the dialog box
##VERIFY file still in recycle folder
Then I should see a dialog containing the following text: "SUCCESS!"
And I close the popup
Then I should see NOT "testusers_bulk_upload.csv"
When I click on the link labeled "File Repository"
Then I should see "testusers_bulk_upload.csv"

#FUNCTIONAL_REQUIREMENT
##ACTION Delete file
When I check the checkbox labeled "testusers_bulk_upload.csv"
And I click on the button labeled "Delete"
Then I should see a dialog containing the following text: "Delete files?"
And I click on the button labeled "Delete" in the dialog box
##VERIFY file deleted in folder
Then I should see a dialog containing the following text: "SUCCESS!"
And I close the popup
Then I should NOT see "testusers_bulk_upload.csv"

#FUNCTIONAL_REQUIREMENT
##ACTION Cancel Permanently deleted file
When I click on the link labeled "Recycle Bin"
Then I should see "testusers_bulk_upload.csv"
When I click on the link labeled "Permanently deleted file"
Then I should see a dialog containing the following text: "File: testusers_bulk_upload.csv"
When I click on the button labeled "Cancel" in the dialog box
##VERIFY file still in recycle folder
Then I should see "testusers_bulk_upload.csv"

#FUNCTIONAL_REQUIREMENT
##ACTION Permanently deleted file
When I click on the link labeled "Recycle Bin"
Then I should see "testusers_bulk_upload.csv"
When I click on the link labeled "Permanently deleted file"
Then I should see a dialog containing the following text: "File: testusers_bulk_upload.csv"
When I click on the button labeled "Delete" in the dialog box
##VERIFY file deleted in recycle folder
Then I should see a dialog containing the following text: "File was successfully deleted!"
And I close the popup
Then I should see NOT "testusers_bulk_upload.csv"
When I click on the link labeled "File Repository"
Then I should see NOT "testusers_bulk_upload.csv"

##VERIFY_LOG
When I click on the button labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action            | List of Data Changes OR Fields Exported |
test_admin | Manage/Design | Permanently delete file from File Repository
test_admin | Manage/Design | Delete file from File Repository
test_admin | Manage/Design | Restore file in File Repository
test_admin | Manage/Design | Delete file from File Repository

Scenario: C.3.26.300.400 Custom folder / sub-folder
REDUNDANT with C.3.26.200
