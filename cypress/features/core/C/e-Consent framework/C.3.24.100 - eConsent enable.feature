Feature: Survey Settings: The system shall support the enabling/disabling of e-Consent framework. The framework categories are listed below: (Disabled | Auto-Archiver enabled |  Auto-Archiver + e-Consent Framework (includes end-of-survey certification & archival of PDF consent form))

As a REDCap end user
I want to see that eConsent is functioning as expected

Scenario: C.3.24.100.100 Enable/Disable eConsent framework

#SETUP
Given I login to REDCap with the user "Test_Admin"
And I create a new project named " C.3.24.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 

#SETUP_PRODUCTION
When I click on the button labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project Status: Production"

#FUNCTIONAL_REQUIREMENT
##ACTION: e-consent survey settings - disabled
When I click on the link labeled "Designer"  
And I click on the button labeled "Survey settings" for the instrument labeled "Consent"
And I click on the radio labeled "Disabled" for the field labeled "e-Consent Framework"
And I click on the button labeled "Save Changes"
Then I should see "Your survey settings were successfully saved!"

##ACTION: add record
When I click on the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click on the bubble labeled "Consent" for event "Event 1" 
Then I should see "Adding new Record ID 5."

When I click on the button labeled "Save & Stay"
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
##VERIFY
Then I should see "Consent"
And I should NOT see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

When I click on the button labeled "Submit"
And I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"

##VERIFY_FiRe
When I click on the link labeled "File Repository"
Then I should see "0 Files" for the field labeled "PDF Survey Archive"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username                    |        Action                 | List of Data Changes OR Fields Exported |
| [survey respondent]  | Update Response 5 | consent_complete = '2' |

#FUNCTIONAL_REQUIREMENTauto-archive enabled
When I click on the link labeled "Designer"  
And I click on the button labeled "Survey settings" for the instrument labeled "Consent"
And I click on the radio labeled "Auto-Archiver enabled" for the field labeled "e-Consent Framework"
And I click on the button labeled "Save Changes"
Then I should see "Your survey settings were successfully saved!"

##ACTION: add record
When I click on the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click on the bubble labeled "Consent" for event "Event 1" 
Then I should see "Adding new Record ID 6."

When I click on the button labeled "Save & Stay"
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
##VERIFY
Then I should see "Consent"
And I should NOT see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

When I click on the button labeled "Submit"
And I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"

##VERIFY_FiRe
When I click on the link labeled "File Repository"
Then I should see "1 File" for the field labeled "PDF Survey Archive"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username                    |        Action                 | List of Data Changes OR Fields Exported |
| [survey respondent]  | Update Response 6 | consent_complete = '2' |


#FUNCTIONAL_REQUIREMENT
##ACTION: e-consent survey settings - auto-archive and e-consent
When I click on the link labeled "Designer"  
And I click on the button labeled "Survey settings" for the instrument labeled "Consent"
And I click on the radio labeled "Auto-Archiver + e-Consent Framework" for the field labeled "e-Consent Framework"
And I click on the button labeled "Save Changes"
Then I should see "Your survey settings were successfully saved!"

##ACTION: add record
When I click on the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click on the bubble labeled "Consent" for event "Event 1" 
Then I should see "Adding new Record ID 7."

When I click on the button labeled "Save & Stay"
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
And I click on the button labeled "Next Page" 
Then I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

When I click on the checkbox for the field labeled "I certify that all of my information in the document above is correct."
And I click on the button labeled "Submit"
And I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"

##VERIFY_FiRe
When I click on the link labeled "File Repository"
Then I should see "2 Files" for the field labeled "PDF Survey Archive"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username                    |        Action                 | List of Data Changes OR Fields Exported |
| [survey respondent]  | Update Response 7 | consent_complete = '2' |


