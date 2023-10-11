Feature: Form Creation: The system shall support the creation of new data collection instruments using the Data Dictionary.

As a REDCap end user
I want to see that project Designer is functioning as expected

Scenario: B.6.7.100.100 Data dictionary export/import function

#SETUP
Given I login to REDCap with the user "Test_Admin" 
And I click on the link labeled "New Project"
And I enter "B.6.7.100.100" into the input field labeled "Project title"
And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose"
And I click on the radio labeled "Empty project (blank slate)"
And I click on the button labeled "Create Project"

#FUNCTIONAL_REQUIREMENT
##ACTION: Download data dictionary
When I click on the link labeled "Dictionary"
And I click on the link labeled "Download the current Data Dictionary" to download a file
##VERIFY
Then I should see the field name labeled "record_id"

##ACTION: Upload data dictionary
When I click on the link labeled "Dictionary" 
And I upload a "csv" format file located at "dictionaries/Project1xml_DataDictionary.csv", by clicking the button near "Upload your Data Dictionary file" to browse for the file, and clicking the button labeled "Upload" to upload the file

##VERIFY
Then I should see "Your document was uploaded successfully and awaits your confirmation below."
When I click on the button labeled "Commit Changes"
Then I should see "Changes Made Successfully!"

When I click on the link labeled "Online Designer"
Then I should see "Text Validation"
And I should see "Consent"

#VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action           | List of Data Changes OR Fields Exported |
| test_admin | Manage/Design | Upload data dictionary                           |

##ACTION: Upload data dictionary with removed form and Reordered form (#B.6.7.500.200 & B.6.7.600.200)
When I click on the link labeled "Dictionary" 
And I click on the button labeled "Choose File"
And I select the file labeled "Data Dictionary File 2.csv"
And I click on the button labeled "Upload File"
##VERIFY
Then I should see "Your document was uploaded successfully and awaits your confirmation below."

When I click on the button labeled "Commit Changes"
Then I should see "Changes Made Successfully!"

When I click on the link labeled "Online Designer"
Then I should see "Text Validation"
And I should NOT see "Consent"

#VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action           | List of Data Changes OR Fields Exported |
| test_admin | Manage/Design | Upload data dictionary                           |

##ACTION: Unable to upload data dictionary with Errors
When I click on the link labeled "Dictionary" 
And I click on the button labeled "Choose File"
And I select the file labeled "Data Dictionary File 3.csv"
And I click on the button labeled "Upload File"
##VERIFY
Then I should see "Errors found in your Data Dictionary: "
And I click on the button labeled "RETURN TO PREVIOUS PAGE"
Then I should see "Steps for making project changes"

#VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action           | List of Data Changes OR Fields Exported |
| test_admin | Manage/Design | Upload data dictionary                           |
