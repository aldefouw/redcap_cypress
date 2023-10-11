Feature: User Interface: The e-Consent framework shall support editing of responses by users.

As a REDCap end user
I want to see that eConsent is functioning as expected

Scenario: C.3.24.600.100 Enable/disable edit ability for e-Consent framework

#SETUP
Given I login to REDCap with the user "Test_Admin"
And I create a new project named " C.3.24.600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 

#SETUP_PRODUCTION
When I click on the button labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project Status: Production"

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
Then I should see "Adding new Record ID 5."

When I click on the button labeled "Save & Stay"
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
And I enter "Consent Name" in the field labeled "Name"
And I click on the button labeled "Next Page" 
Then I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

When I click on the checkbox for the field labeled "I certify that all of my information in the document above is correct."
And I click on the button labeled "Submit"
And I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes"
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username                 |        Action                 | List of Data Changes OR Fields Exported |
| [survey respondent]| Update Response 5 | consent_complete = '2'                               |
| [survey respondent]| Update Response 5 | name_consent = 'Consent Name'             |

##VERIFY_FiRe
When I click on the link labeled "File Repository"
Then I should see "1 File" for the field labeled "PDF Survey Archive"

When I click on the link labeled "PDF Survey Archive"
And I click on the link on the PDF link for record "5"
Then I should have a pdf file with the following values in the report: "1) Name" is "Consent Name"
#M: Close document

##ACTION: edit survey response
When I click on the link labeled "Record Status Dashboard"
And I click on the bubble for the instrument labeled "Consent" for event "Event 1" for record "5"
And I click on the button labeled "Edit response"
Then I should see "Survey response is editable (now editing)"

When I enter "Consent 2 Name" in the field labeled "Name"
And I click on the button labeled "Save & Exit Form"
Then I should see "Record ID 5 successfully edited."

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username                 |        Action           | List of Data Changes OR Fields Exported |
| test_admin               | Update record 5| name_consent = 'Consent 2 Name'         |

##VERIFY_FiRe
When I click on the link labeled "File Repository"
Then I should see "1 File" for the field labeled "PDF Survey Archive"

When I click on the link labeled "PDF Survey Archive"
And I click on the link on the PDF link for record "5"
Then I should have a pdf file with the following values in the report: I should NOT see "1) Name" is "Consent 2 Name"
#M: Close document

##ACTION: disable e-consent survey settings - auto-archive and e-consent
When I click on the link labeled "Designer"  
And I click on the button labeled "Survey settings" for the instrument labeled "Consent"
And I deselect the checkbox labeled "Allow e-Consent responses to be edited by users?"
And I click on the button labeled "Save Changes"
Then I should see "Your survey settings were successfully saved!"

##VERIFY: cannot edit survey response
When I click on the link labeled "Record Status Dashboard"
And I click on the bubble for the instrument labeled "Consent" for event "Event 1" for record "5"
Then I should see "Survey responses is read-only because it was complete via the e-Consent Framework."

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username                 |        Action           | List of Data Changes OR Fields Exported |
| test_admin               | Manage/Design | Modify survey info         |

