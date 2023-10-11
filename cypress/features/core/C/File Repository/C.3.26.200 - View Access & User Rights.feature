Feature: User Interface: The system shall support limiting file repository user view access and export rights.

As a REDCap end user
I want to see that file repository is functioning as expected

Scenario: C.3.26.200.100 Limit user view and export access based on User Rights and DAG

#SETUP 
Given I login to REDCap with the user "Test_Admin"
When I create a new project named "A.3.26.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
And I click on the link labeled "My Projects"  
And I click on the link labeled "A.3.26.200.100"  

##SETUP auto-archive
And I click the link labeled "Designer"
And I click the button labeled "Survey Settings" for the instrument "Consent"
And I click on the button labeled "Auto-Archiver + eConsent enabled"
Then I click the button labeled "Save Changes"

##SETUP File Repository
And I click the link labeled "File Repository"

#Create DAG limited folder
And I click the button labeled "Create Folder"
And I type "TestGroup1_Folder" into the field labeled "New folder name"
And I select "TestGroup1" in the dropdown labeled "Limit access by Data Access Group?"
And I click on the button labeled "Create Folder"
Then I should see "TestGroup1_Folder"

#Create role limited folder
And I click the button labeled "Create Folder"
And I type "Role1_Folder" into the field labeled "New folder name"
And I select "1_FullRights" in the dropdown labeled "Limit access by User Role?"
And I click on the button labeled "Create Folder"
Then I should see "Role1_Folder"

##SETUP User Rights:
When I click on the link labeled "User Rights"   
Given I upload a "csv" format file located at "import_files/user list for project 1.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
Then I should see a dialog containing the following text: "Upload users (CSV) - Confirm"
And I should see a table header and rows containing the following values in the table:
| username   |
| test_user1 |
| test_user2 |
| test_user3 |
| test_user4 |

Given I click on the button labeled "Upload"
Then I should see a dialog containing the following text: "SUCCESS!"
And I close the popup

And I should see a table header and rows including the following values in the table:
|Role name                            | Username   |
|                      		      | test_admin |
|                        		      | test_user1 |
|                      		      | test_user2 |
|                       	             	      | test_user3 |
|                        		      | test_user4 |
| 1_FullRights  |                     |		|
| 2_Edit_RemoveID|             |		|
| 3_ReadOnly_Deidentified |                    |
| 4_NoAccess_Noexport     |                     |

##SETUP Assign to roles
When I click on the link labeled "Test_User1" 
And I click on the button labeled "Assign to role" 
And I should see the dropdown field labeled "Select Role" with the option "1_FullRights" selected 
And I click on the button labeled "Assign" 
Then I should see "Test_User1" user assigned "1_FullRights" role 

When I click on the link labeled "Test_User2" 
And I click on the button labeled "Assign to role" 
And I should see the dropdown field labeled "Select Role" with the option "1_FullRights" selected 
And I click on the button labeled "Assign" 
Then I should see "Test_User2" user assigned "1_FullRights" role 

When I click on the link labeled "Test_User3" 
And I click on the button labeled "Assign to role" 
And I should see the dropdown field labeled "Select Role" with the option "3_ReadOnly_Deidentified" selected 
And I click on the button labeled "Assign" 
Then I should see "Test_User3" user assigned "3_ReadOnly_Deidentified" role 

When I click on the link labeled "Test_User4" 
And I click on the button labeled "Assign to role" 
And I should see the dropdown field labeled "Select Role" with the option "3_ReadOnly_Deidentified" selected 
And I click on the button labeled "Assign" 
Then I should see "Test_User4" user assigned "3_ReadOnly_Deidentified" role 

##SETUP DAG: Assign User to DAG 
When I select "Test_User1" from "Assign User" dropdown  
And I select "TestGroup1" from "DAG" dropdown  
And I click on the button labeled "Assign"
Then I should see "Test_User1" assigned to "TestGroup1"

When I select "Test_User2" from "Assign User" dropdown  
And I select "TestGroup2" from "DAG" dropdown  
Then I should see "Test_User2" assigned to "TestGroup2"

When I select "Test_User3" from "Assign User" dropdown  
And I select "TestGroup1" from "DAG" dropdown  
And I click on the button labeled "Assign"
Then I should see "Test_User3" assigned to "TestGroup1"

#"Test_User4" is not assigned to a DAG

And I logout

##SETUP Record: Create record while in DAG through eConsent framework 
Given I login to REDCap with the user "Test_User1"
When I click on the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click on the bubble labeled "Consent" for event "Event 1" 
Then I should see "Adding new Record ID"


When I click on the button labeled "Save & Stay"
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
And I click on the button labeled "Next Page" 
Then I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

When I click on the checkbox for the field labeled "I certify that all of my information in the document above is correct."
And I click on the button labeled "Submit"
And I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"
And I should see "TestGroup1"

#FUNCTIONAL_REQUIREMENT
##ACTION Upload to top tier file repo (all users will see file) - using the Drag and drop files here to upload button
When I click on the link labeled "File Repository"
And I upload a "csv" format file located at "import_files/user list for project 1.csv", by clicking the button near "Drag and drop files here to upload" to browse for the file, and clicking the button labeled "Open" to upload the file

##VERIFY_FiRe file uploaded in folder
Then I should see "user list for project 1.csv"
And I should see "Role1_Folder"
And I should see "TestGroup1_Folder"


##ACTION Upload to top tier file repo (all users will see file) - using the Select files to upload button
When I click on the link labeled "File Repository"
When I upload a "csv" format file located at "import_files/testusers_bulk_upload.csv", by clicking the button near "Select files to upload" to browse for the file, and clicking the button labeled "Open" to upload the file

##VERIFY_FiRe file uploaded in folder
Then I should see "testusers_bulk_upload.csv"


#FUNCTIONAL_REQUIREMENT
##ACTION Upload to DAG folder
When I click on the link labeled "TestGroup1_Folder"
Then I should see "All Files/TestGroup1_Folder"
When I upload a "csv" format file located at "import_files/user list for project 1.csv", by clicking the button near "Select files to upload" to browse for the file, and clicking the button labeled "Open" to upload the file

##VERIFY_FiRe uploaded in subfolder
Then I should see "user list for project 1.csv"

#FUNCTIONAL_REQUIREMENT
##ACTION Upload to Role folder
When I click on the link labeled "File Repository"
And I click on the link labeled "Role1_Folder"
Then I should see "All Files/Role1_Folder"
#C.3.26.400.100 #Upload more than one file at the same time using the select files to upload button
When I upload a "csv" format file located at "import_files/user list for project 1.csv" and "import_files/testusers_bulk_upload.csv", by clicking the button near "Select files to upload" to browse for the file, and clicking the button labeled "Open" to upload the file

##VERIFY_FiRe uploaded in subfolder
Then I should see "user list for project 1.csv"
And I should see "testusers_bulk_upload.csv"

#FUNCTIONAL_REQUIREMENT
##ACTION Auto-archive file in DAG TestGroup1
When I click on the link labeled "File Repository"
And I click on the link labeled "PDF Survey Archive"
Then I should see a table header and rows including the following values in the PDF Survey Archive table:
Name | Record | 
"pdf" format file | (record-name) TestGroup1

And I logout

##SETUP Record: Create record while in DAG through
Given I login to REDCap with the user "Test_User2"
When I click on the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click on the bubble labeled "Consent" for event "Event 1" 
Then I should see "Adding new Record ID"

When I click on the button labeled "Save & Stay"
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
And I click on the button labeled "Next Page" 
Then I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

When I click on the checkbox for the field labeled "I certify that all of my information in the document above is correct."
And I click on the button labeled "Submit"
And I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"
And I should see "TestGroup2"


#FUNCTIONAL_REQUIREMENT
When I click on the link labeled "File Repository"
##ACTION Unable to access DAG folder
##VERIFY_FiRe See file uploaded by Test_User1
Then I should see "Data Export Files"
And I should see "Recycle Bin"
And I should see "Role1_Folder"
And I should NOT see "TestGroup1_Folder"
And I should see "user list for project 1.csv"
And I should see "testusers_bulk_upload.csv"

#FUNCTIONAL_REQUIREMENT
##ACTION Interact in Role folder
When I click on the link labeled "File Repository"
And I click on the link labeled "Role1_Folder"
#Download file previously uploaded by test_user1
And I click the link labeled "user list for project 1.csv"
Then I should have a csv file labeled "user list for project 1.csv"

##ACTION Upload to Role folder
When I upload a "csv" format file located at "import_files/instrument designation.csv", by clicking the button near "Select files to upload" to browse for the file, and clicking the button labeled "Open" to upload the file

##VERIFY_FiRe uploaded in subfolder
Then I should see "instrument designation.csv"
And I should see "user list for project 1.csv"
And I should see "testusers_bulk_upload.csv"

#FUNCTIONAL_REQUIREMENT
##ACTION Auto-archive file in DAG TestGroup2
When I click on the link labeled "File Repository"
And I click on the link labeled "PDF Survey Archive"
#See consent just created in testgroup2
#Don't see consent created by testgroup1
Then I should see a table header and rows including the following values in the PDF Survey Archive table:
Name | Record | 
"pdf" format file | [record-name] TestGroup2

And I logout


#FUNCTIONAL_REQUIREMENT
Given I login to REDCap with the user "Test_User3"
When I click on the link labeled "File Repository"
##ACTION Unable to access Role folder
##VERIFY_FiRe See file uploaded by Test_User1
Then I should see "Data Export Files"
And I should see "Recycle Bin"
And I should NOT see "Role1_Folder"
And I should see "TestGroup1_Folder"
And I should see "user list for project 1.csv"
And I should see "testusers_bulk_upload.csv"

##ACTION Download to top tier file imported by user 1 & user 2
When I click on the link labeled "user list for project 1.csv"
Then I should have a csv file labeled "user list for project 1.csv"
When I click on the link labeled "testusers_bulk_upload.csv"
Then I should have a csv file labeled "testusers_bulk_upload.csv"

#FUNCTIONAL_REQUIREMENT
##ACTION Access DAG folder
When I click on the link labeled "TestGroup1_Folder"
Then I should see the link labeled "user list for project 1.csv"

When I click on the link labeled "user list for project 1.csv"
##VERIFY_FiRe Download another users file in subfolder
Then I should have a csv file labeled "user list for project 1.csv"

#FUNCTIONAL_REQUIREMENT
##ACTION Auto-archive file in DAG TestGroup1
When I click on the link labeled "File Repository"
And I click on the link labeled "PDF Survey Archive"
Then I should see a table header and rows including the following values in the PDF Survey Archive table:
Name | Record | 
"pdf" format file | [record-name] TestGroup1
#Don't see consent created by testgroup2

And I logout


#FUNCTIONAL_REQUIREMENT
##ACTION Download to top tier file 
Given I login to REDCap with the user "Test_User4"
When I click on the link labeled "File Repository"
##ACTION Unable to access Role folder 
##VERIFY_FiRe See file uploaded by Test_User1 & Test_User2
Then I should see "Data Export Files"
And I should see "Recycle Bin"
And I should NOT see "Role1_Folder"
And I should see "TestGroup1_Folder"
And I should see "user list for project 1.csv"
And I should see "testusers_bulk_upload.csv"

##ACTION Download to top tier file imported by user 1 & user 2
When I click on the link labeled "user list for project 1.csv"
Then I should have a csv file labeled "user list for project 1.csv"
When I click on the link labeled "testusers_bulk_upload.csv"
Then I should have a csv file labeled "testusers_bulk_upload.csv"

#FUNCTIONAL_REQUIREMENT
##ACTION Access DAG folder
When I click on the link labeled "TestGroup1_Folder"
Then I should see the link labeled "user list for project 1.csv"

When I click on the link labeled "user list for project 1.csv"
##VERIFY_FiRe Download another users file in subfolder
Then I should have a csv file labeled "user list for project 1.csv"

#FUNCTIONAL_REQUIREMENT
##ACTION Auto-archive access all file
When I click on the link labeled "File Repository"
And I click on the link labeled "PDF Survey Archive"
Then I should see a table header and rows including the following values in the PDF Survey Archive table:
Name | Record | 
"pdf" format file | [record-name] testgroup1
"pdf" format file | [record-name] testgroup2

#FUNCTIONAL_REQUIREMENT
##ACTION C.3.26.500.100 Delete folders - unable to delete with file in folder
When I click on the link labeled "File Repository"
And I check the checkbox labeled "TestGroup1_Folder"
And I click on the button labeled "Delete"
##VERIFY will not let you delete folder with file inside
Then I should see a dialog containing the following text: "Alert"
When I click on the button labeled "Close" in the dialog box
Then I should see "TestGroup1_Folder"

##ACTION Cancel Remove files from folder
When I click on the link labeled "TestGroup1_Folder"
And I check the checkbox labeled "user list for project 1.csv"
And I click on the button labeled "Delete"
Then I should see a dialog containing the following text: "Delete multiple files?"
And I click on the button labeled "Cancel" in the dialog box
##VERIFY file still in folder
Then I should see "user list for project 1.csv"

##ACTION Delete/Remove files from folder
When I check the checkbox labeled "user list for project 1.csv"
And I click on the button labeled "Delete"
Then I should see a dialog containing the following text: "Delete multiple files?"
And I click on the button labeled "Delete" in the dialog box
##VERIFY file deleted in folder
Then I should see a dialog containing the following text: "SUCCESS!"
And I close the popup
Then I should NOT see "user list for project 1.csv"

##ACTION C.3.26.500.100 Delete folders - Cancel deletion 
When I click on the link labeled "File Repository"
And I click on the delete file? icon labeled "X" for the folder labeled "TestGroup1_Folder"
##VERIFY Cancel deletion 
Then I should see a dialog containing the following text: "Folder: TestGroup1_Folder"
When I click on the button labeled "Cancel" in the dialog box
Then I should see "TestGroup1_Folder"

##ACTION C.3.26.500.100 Delete folders
When I click on the delete file? icon labeled "X" for the folder labeled "TestGroup1_Folder"
##VERIFY Folder deleted
Then I should see a dialog containing the following text: "Folder: TestGroup1_Folder"

When I click on the button labeled "Delete" in the dialog box
Then I should NOT see "TestGroup1_Folder"

