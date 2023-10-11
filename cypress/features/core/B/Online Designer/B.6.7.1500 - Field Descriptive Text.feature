Feature: Field Creation: The system shall support the creation of Descriptive Text (with optional Image/File Attachment.


As a REDCap end user
I want to see that Project Designer is functioning as expected

Scenario: B.6.7.1500.100 Creation of Descriptive field through the Online Designer

#SETUP
Given I login to REDCap with the user "Test_Admin"   
And I create a new project named "B.6.7.1500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing "Empty project", and clicking the "Create Project" button

##SETUP_PRODUCTION
When I click on the link labeled "My Projects"  
And I click on the link labeled "B.6.7.1500.100" 
When I click on the button labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project Status: Production"

When I click on the link labeled "Designer"
And I click on the button labeled "Enter Draft Mode"
Then I should see "The project is now in Draft Mode"

#FUNCTIONAL_REQUIREMENT
##ACTION: Signature field creation
Given When I click on the instrument labeled "Form 1"
And I click on the button labeled "Add Field" at the bottom of the instrument
When I click on the dropdown field labeled "Select a Type of Field"
And I add a new Descriptive Text (with optional Image/Video/Audio/File Attachment) labeled "Descriptive Text with File" with the variable name "descriptive_text_file"
And I click on the link labeled "Upload file"
And I upload the file labeled "B.6.7.1500_Upload File"
And I click on the button labeled "Upload file" in the dialog box
Then I should see "Document was successfully uploaded! "

When I click on the button labeled "Close" in the dialog box
And I click on the button labeled "Save"
##VERIFY 
Then I should see the field labeled "Descriptive Text with File"
And I should see the link labeled "B.6.7.1500_Upload File"

##SETUP_PRODUCTION
When I click on the button labeled "Submit Changes for Review"
And I click on the button labeled "Submit" in the dialog box
Then I should see "Changes Were Made Automatically"
When I click on the button labeled "Close" in the dialog box

##VERIFY_CODEBOOK
When I click on the link labeled "Codebook"
Then I should see a table row containing the following values in the codebook table: 
| [descriptive_text_file] | Descriptive Text with File | descriptive |

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action           | List of Data Changes OR Fields Exported |
| test_admin | Manage/Design | Create project field |

##ACTION: Download file from descriptive field
Given I click on the link labeled "Add/Edit Records"
When I click on the button labeled "Add new record"
Then I should see the field labeled "Descriptive Text with File"
And I should see "Attachment: "
And I should see a link labeled "B.6.7.1500_Upload File"

When I download the file by clicking on the link labeled " B.6.7.1500_Upload File"
##VERIFY
Then I should have a word file downloaded


Scenario: B.6.7.1500.200 Creation of Descriptive field through Data Dictionary upload

#SETUP
Given I login to REDCap with the user "Test_Admin"   
And I create a new project named "B.6.7.1500.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing "Empty project", and clicking the "Create Project" button 

#FUNCTIONAL_REQUIREMENT
##ACTION: Upload data dictionary
When I click on the link labeled "Dictionary" 
And I click on the button labeled "Choose File"
And I select the file labeled "Project1xml_DataDictionary.csv"
And I click on the button labeled "Upload File"
Then I should see "Your document was uploaded successfully and awaits your confirmation below."

When I click on the button labeled "Commit Changes"
Then I should see "Changes Made Successfully!"

##VERIFY_CODEBOOK
When I click on the link labeled "Codebook"
Then I should see a table row containing the following values in the codebook table: 
| [descriptive_text_file] | Descriptive Text with File | descriptive |
