Feature: User Interface: The e-Consent framework will enable surveys to be considered as complete (submit button appears) once the certification step has been successfully completed.

As a REDCap end user
I want to see that eConsent is functioning as expected

Scenario: C.3.24.300.100 Certification required to submit completed survey

#SETUP
Given I login to REDCap with the user "Test_Admin"
And I create a new project named " C.3.24.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Consent.xml", and clicking the "Create Project" button 

#SETUP_PRODUCTION
When I click on the button labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project Status: Production"

#SETUP: Project Setup:modify repeating instruments
When I click on the button labeled "Modify" for the field labeled "Repeating instruments and events"
And I click on the button labeled "Close" in the dialog box
And I select the dropdown option labeled "Repeat Instruments (repeat independently of each other" for event "Event 1 (Arm 1: Arm 1)"
And I check the checkbox labeled "Consent"
And I click on the button labeled "Save"
Then I should see "Successfully saved!"

#SETUP_eConsent
When I click on the button labeled "Designer"
And I click on the button labeled "Survey settings" for the instrument labeled "Consent"
And I click on the radio labeled "Auto-Archiver + e-Consent Framework" for the field labeled "e-Consent Framework"
And I click on the button labeled "Save Changes"
Then I should see "Your survey settings were successfully saved!"

##ACTION: add record
When I click on the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click on the bubble labeled "Consent" for event "Event 1" 
Then I should see "Adding new Record ID 1."

When I click on the button labeled "Save & Stay"
And I click on the button labeled "Okay" in the dialog box
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
Then I should see "Consent"

When I enter a signature in the field labeled "5) Signature"
And I enter a signature in the field labeled "8) Signature"
And I click on the button labeled "Next Page" 
Then I should see "Displayed below is a read-only copy of your survey responses."
And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."
##VERIFY: cannot submit without attestation
And I verify I CANNOT click on the button labeled "Submit"

When I check the checkbox labeled "I certify that all of my information in the document above is correct."
##VERIFY: can submit once attestation complete
And I click on the button labeled "Submit"
Then I should see "Thank you for taking the survey."

When I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"

When I click the "+" for the Data Collection Instrument labeled "Consent" for event "Event 1"
And I click on the button labeled "Save & Stay"
And I click on the button labeled "Okay" in the dialog box
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
Then I should see "Consent"

When I enter a signature in the field labeled "5) Signature"
And I enter a signature in the field labeled "8) Signature"
And I click on the button labeled "Next Page" 
Then I should see "Displayed below is a read-only copy of your survey responses."
And I should see a button labeled "Previous Page"

#FUNCTIONAL_REQUIREMENT
##ACTION: click on previous page and cancel
When I click on the button labeled "Previous Page"
Then I should see "Erase your signature(s) in this survey?"

When I click on the button labeled "Cancel" in the dialog box 
Then I should see "Displayed below is a read-only copy of your survey responses."

#FUNCTIONAL_REQUIREMENT
##ACTION: click on previous page and accept
When I click on the button labeled "Previous Page"
Then I should see "Erase your signature(s) in this survey?"
And I click on the button labeled "Erase my signature(s) and go to earlier page" in the dialog box 
Then I should see "Consent"
And I should NOT see a signature in the field labeled "5) Signature"
And I should NOT see "signature_consent_2" in the field labeled "6) Signature"
And I should NOT see "signature_consent_3" in the field labeled "7) Signature"
And I should NOT see a signature in the field labeled "8) Signature"
And I should NOT see "signature_consent_5" in the field labeled "9) Signature"
#M: Close browser page

When I click on the button labeled "Leave without saving changes" in the dialog box
And I click the bubble for the Data Collection Instrument labeled "Consent" for instance "2" for event "Event 1"
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
Then I should see "Consent"
##VERIFY: partial survey completion not accepted
And I should see "You have partially completed this survey."

When I click on the button labeled "Start Over"
And I click on the button labeled "OK" in the pop-up box
Then I should see "Consent"
And I verify I see "Name" in the field labeled "1) Name"
And I verify I see "Name" in the field labeled "2) Name"
And I verify I see "email@test.edu" in the field labeled "3) Email"
And I verify I see "2023-09-04" in the field labeled "4) DOB"
And I enter a signature in the field labeled "5) Signature"
And I verify I see "signature_consent_2" in the field labeled "6) Signature"
And I verify I see "signature_consent_3" in the field labeled "7) Signature"
And I enter a signature in the field labeled "8) Signature"
And I verify I see "signature_consent_5" in the field labeled "9) Signature"
#M: Close browser page

When I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for instance "1" for event "Event 1"
And I should see a Partial Survey Response icon for the Data Collection Instrument labeled "Consent" for instance "2" for event "Event 1"

##VERIFY_FiRe
When I click on the link labeled "File Repository"
Then I should see "1 File" for the field labeled "PDF Survey Archive"

When I click on the link labeled "PDF Survey Archive"
And I click on the link on the PDF link for record "1"
Then I should have a pdf file with the following values in the footer: "Name Name, 2023-09-04, Version: version test, Type: type test"
#M: Close document
