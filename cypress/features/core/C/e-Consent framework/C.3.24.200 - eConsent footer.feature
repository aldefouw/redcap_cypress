Feature: The e-Consent framework shall support the automatic insertion of select text fields into the footer of the PDF consent form.  Selectors e-Consent version | First name field |Last name field | e-Consent type | Date of birth field | Signature field #1-#5

As a REDCap end user
I want to see that eConsent is functioning as expected

Scenario: C.3.24.200.100 e-Consent text validation

#SETUP
Given I login to REDCap with the user "Test_Admin"
And I create a new project named " C.3.24.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Consent.xml", and clicking the "Create Project" button 

#SETUP_PRODUCTION
When I click on the button labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project Status: Production"

#SETUP_eConsent
When I click on the button labeled "Designer"
And I click on the button labeled "Survey settings" for the instrument labeled "Consent"
And I click on the radio labeled "Auto-Archiver + e-Consent Framework" for the field labeled "e-Consent Framework"
And I verify I see "version test" in the field labeled "e-Consent version:"
And I verify I see "fname "Name"" in the field labeled "First name field:"
And I verify I see "lname "Name"" in the field labeled "Last name field:"
And I verify I see "type test" in the field labeled "e-Consent type:"
And I verify I see "dob "DOB"" in the field labeled "Date of birth field:"
And I verify I see "signature_consent "Signature"" in the field labeled "Signature field #1:"
And I verify I see "signature_consent_2 "Signature"" in the field labeled "Signature field #2:"
And I verify I see "signature_consent_3 "Signature"" in the field labeled "Signature field #3:"
And I verify I see "signature_consent_4 "Signature"" in the field labeled "Signature field #4:"
And I verify I see "signature_consent_5 "Signature"" in the field labeled "Signature field #5:"
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
And I verify I see "Name" in the field labeled "1) Name"
And I verify I see "Name" in the field labeled "2) Name"
And I verify I see "email@test.edu" in the field labeled "3) Email"
And I verify I see "2023-09-03" in the field labeled "4) DOB"
And I enter a signature in the field labeled "5) Signature"
And I verify I see "signature_consent_2" in the field labeled "6) Signature"
And I verify I see "signature_consent_3" in the field labeled "7) Signature"
And I enter a signature in the field labeled "8) Signature"
And I verify I see "signature_consent_5" in the field labeled "9) Signature"

When I click on the button labeled "Next Page" 
Then I should see "Displayed below is a read-only copy of your survey responses."
And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

When I check the checkbox labeled "I certify that all of my information in the document above is correct."
And I click on the button labeled "Submit"
Then I should see "Thank you for taking the survey."

When I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"

##VERIFY_FiRe
When I click on the link labeled "File Repository"
Then I should see "1 File" for the field labeled "PDF Survey Archive"

When I click on the link labeled "PDF Survey Archive"
And I click on the link on the PDF link for record "1"
Then I should have a pdf file with the following values in the footer: "Name Name, 2023-09-03, Version: version test, Type: type test"
#M: Close document

##ACTION: add record_missing sig_1
When I click on the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click on the bubble labeled "Consent" for event "Event 1" 
Then I should see "Adding new Record ID 2."

When I click on the button labeled "Save & Stay"
And I click on the button labeled "Okay" in the dialog box
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
Then I should see "Consent"
And I verify I see "Name" in the field labeled "1) Name"
And I verify I see "Name" in the field labeled "2) Name"
And I verify I see "email@test.edu" in the field labeled "3) Email"
And I verify I see "2023-09-03" in the field labeled "DOB"
And I DO NOT enter a signature in the field labeled "5) Signature"
And I verify I see "signature_consent_2" in the field labeled "6) Signature"
And I verify I see "signature_consent_3" in the field labeled "7) Signature"
And I enter a signature in the field labeled "8) Signature"
And I verify I see "signature_consent_5" in the field labeled "9) Signature"

When I click on the button labeled "Next Page"
Then I should see "NOTE: Some fields are required!"

When I click on the button labeled "Okay" in the dialog box
#M: Close browser page
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Partial Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1" for record "1"

When I click on the Partial Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1"
And I select the dropdown option "Open survey" from the dropdown field labeled "Survey Options"
Then I should see "Consent"
And I should see "You have not completed the entire survey, and your responses are thus considered only partially complete. For security reasons, you will not be allowed to continue taking the survey from the place where you stopped."
And I should see the button labeled "Start Over"
#M: Close browser page
And I click on the button labeled "Leave without saving changes" in the dialog box

##VERIFY_FiRe
When I click on the link labeled "File Repository"
And I click on the link labeled "PDF Survey Archive"
Then I should NOT see a PDF link for record "2"

##ACTION: add record_missing sig_2
When I click on the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click on the bubble labeled "Consent" for event "Event 1" 
Then I should see "Adding new Record ID 3."

When I click on the button labeled "Save & Stay"
And I click on the button labeled "Okay" in the dialog box
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
Then I should see "Consent"
And I verify I see "Name" in the field labeled "1) Name"
And I verify I see "Name" in the field labeled "2) Name"
And I verify I see "email@test.edu" in the field labeled "3) Email"
And I verify I see "2023-09-03" in the field labeled "DOB"
And I enter a signature in the field labeled "5) Signature"
And I clear the field labeled "6) Signature"
And I verify I see "signature_consent_3" in the field labeled "7) Signature"
And I enter a signature in the field labeled "8) Signature"
And I verify I see "signature_consent_5" in the field labeled "9) Signature"

When I click on the button labeled "Next Page"
Then I should see "NOTE: Some fields are required!"

When I click on the button labeled "Okay" in the dialog box
#M: Close browser page
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Partial Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1" for record "4"

##VERIFY_FiRe
When I click on the link labeled "File Repository"
And I click on the link labeled "PDF Survey Archive"
Then I should NOT see a PDF link for record "3"

##ACTION: add record_missing sig_3
When I click on the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click on the bubble labeled "Consent" for event "Event 1" 
Then I should see "Adding new Record ID 4."

When I click on the button labeled "Save & Stay"
And I click on the button labeled "Okay" in the dialog box
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
Then I should see "Consent"
And I verify I see "Name" in the field labeled "1) Name"
And I verify I see "Name" in the field labeled "2) Name"
And I verify I see "email@test.edu" in the field labeled "3) Email"
And I verify I see "2023-09-03" in the field labeled "DOB"
And I enter a signature in the field labeled "5) Signature"
And I verify I see "signature_consent_2" in the field labeled "6) Signature"
And I clear the field labeled "7) Signature"
And I enter a signature in the field labeled "8) Signature"
And I verify I see "signature_consent_5" in the field labeled "9) Signature"

When I click on the button labeled "Next Page"
Then I should see "NOTE: Some fields are required!"

When I click on the button labeled "Okay" in the dialog box
#M: Close browser page
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Partial Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1" for record "4"

##VERIFY_FiRe
When I click on the link labeled "File Repository"
And I click on the link labeled "PDF Survey Archive"
Then I should NOT see a PDF link for record "4"

##ACTION: add record_missing sig_4
When I click on the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click on the bubble labeled "Consent" for event "Event 1" 
Then I should see "Adding new Record ID 5."

When I click on the button labeled "Save & Stay"
And I click on the button labeled "Okay" in the dialog box
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
Then I should see "Consent"
And I verify I see "Name" in the field labeled "1) Name"
And I verify I see "Name" in the field labeled "2) Name"
And I verify I see "email@test.edu" in the field labeled "3) Email"
And I verify I see "2023-09-03" in the field labeled "DOB"
And I enter a signature in the field labeled "5) Signature"
And I verify I see "signature_consent_2" in the field labeled "6) Signature"
And I verify I see "signature_consent_3" in the field labeled "7) Signature"
And I DO NOT enter a signature in the field labeled "8) Signature"
And I verify I see "signature_consent_5" in the field labeled "9) Signature"

When I click on the button labeled "Next Page"
Then I should see "NOTE: Some fields are required!"

When I click on the button labeled "Okay" in the dialog box
#M: Close browser page
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Partial Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1" for record "5"

##VERIFY_FiRe
When I click on the link labeled "File Repository"
And I click on the link labeled "PDF Survey Archive"
Then I should NOT see a PDF link for record "5"

##ACTION: add record_missing sig_5
When I click on the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click on the bubble labeled "Consent" for event "Event 1" 
Then I should see "Adding new Record ID 6."

When I click on the button labeled "Save & Stay"
And I click on the button labeled "Okay" in the dialog box
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
Then I should see "Consent"
And I verify I see "Name" in the field labeled "1) Name"
And I verify I see "Name" in the field labeled "2) Name"
And I verify I see "email@test.edu" in the field labeled "3) Email"
And I verify I see "2023-09-03" in the field labeled "DOB"
And I enter a signature in the field labeled "5) Signature"
And I verify I see "signature_consent_2" in the field labeled "6) Signature"
And I verify I see "signature_consent_3" in the field labeled "7) Signature"
And I enter a signature in the field labeled "8) Signature"
And I clear the field labeled "9) Signature"

When I click on the button labeled "Next Page"
Then I should see "NOTE: Some fields are required!"

When I click on the button labeled "Okay" in the dialog box
#M: Close browser page
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Partial Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1" for record "6"

##VERIFY_FiRe
When I click on the link labeled "File Repository"
And I click on the link labeled "PDF Survey Archive"
Then I should NOT see a PDF link for record "6"

##ACTION: add record_missing sig_5
When I click on the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click on the bubble labeled "Consent" for event "Event 1" 
Then I should see "Adding new Record ID 7."

When I click on the button labeled "Save & Stay"
And I click on the button labeled "Okay" in the dialog box
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
Then I should see "Consent"

When I clear the field labeled "1) Name"
And I clear the field labeled "2) Name"
And I verify I see "email@test.edu" in the field labeled "3) Email"
And I clear the field labeled "DOB"
And I enter a signature in the field labeled "5) Signature"
And I verify I see "signature_consent_2" in the field labeled "6) Signature"
And I verify I see "signature_consent_3" in the field labeled "7) Signature"
And I enter a signature in the field labeled "8) Signature"
And I verify I see "signature_consent_5" in the field labeled "9) Signature"
And I click on the button labeled "Next Page"
Then I should see "Consent"
And I should see "Displayed below is a read-only copy of your survey responses."
And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

When I check the checkbox labeled "I certify that all of my information in the document above is correct."
And I click on the button labeled "Submit"
Then I should see "Thank you for taking the survey."

When I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1" for record "7"

##VERIFY_FiRe
When I click on the link labeled "File Repository"
Then I should see "2 Files" for the field labeled "PDF Survey Archive"

When I click on the link labeled "PDF Survey Archive"
And I click on the link on the PDF link for record "7"
#M: Verify name and dob missing from footer
Then I should have a pdf file with the following values in the footer: "Version: version test, Type: type test"
#M: Close document

#SETUP_eConsent_change field
When I click on the button labeled "Designer"
And I click on the button labeled "Survey settings" for the instrument labeled "Consent"
And I click on the radio labeled "Auto-Archiver + e-Consent Framework" for the field labeled "e-Consent Framework"
And I enter "UPDATED VERSION TEST" in the field labeled "e-Consent version:"
And I verify I see "fname "Name"" in the field labeled "First name field:"
And I verify I see "lname "Name"" in the field labeled "Last name field:"
And I verify I see "type test" in the field labeled "e-Consent type:"
And I verify I see "dob "DOB"" in the field labeled "Date of birth field:"
And I verify I see "signature_consent "Signature"" in the field labeled "Signature field #1:"
And I verify I see "signature_consent_2 "Signature"" in the field labeled "Signature field #2:"
And I verify I see "signature_consent_3 "Signature"" in the field labeled "Signature field #3:"
And I verify I see "signature_consent_4 "Signature"" in the field labeled "Signature field #4:"
And I verify I see "signature_consent_5 "Signature"" in the field labeled "Signature field #5:"
And I click on the button labeled "Save Changes"
Then I should see "Your survey settings were successfully saved!"

##ACTION: add record
When I click on the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click on the bubble labeled "Consent" for event "Event 1" 
Then I should see "Adding new Record ID 8."

When I click on the button labeled "Save & Stay"
And I click on the button labeled "Okay" in the dialog box
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
Then I should see "Consent"

When I verify I see "Name" in the field labeled "1) Name"
And I verify I see "Name" in the field labeled "2) Name"
And I verify I see "email@test.edu" in the field labeled "3) Email"
And I verify I see "2023-09-03" in the field labeled "DOB"
And I enter a signature in the field labeled "5) Signature"
And I verify I see "signature_consent_2" in the field labeled "6) Signature"
And I verify I see "signature_consent_3" in the field labeled "7) Signature"
And I enter a signature in the field labeled "8) Signature"
And I verify I see "signature_consent_5" in the field labeled "9) Signature"
And I click on the button labeled "Next Page"
Then I should see "Displayed below is a read-only copy of your survey responses."
And I should see a checkbox for the field labeled "I certify that all of my information in the document above is correct."

When I check the checkbox labeled "I certify that all of my information in the document above is correct."
And I click on the button labeled "Submit"
Then I should see "Thank you for taking the survey."

When I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1" for record "8"

##VERIFY_FiRe
When I click on the link labeled "File Repository"
Then I should see "3 Files" for the field labeled "PDF Survey Archive"

When I click on the link labeled "PDF Survey Archive"
And I click on the link on the PDF link for record "8"
Then I should have a pdf file with the following values in the footer: "Name Name, 2023-09-03, Version: UPDATED VERSION TEST, Type: type test"
#M: Close document

#SETUP_eConsent_change field
When I click on the button labeled "Designer"
And I click on the button labeled "Survey settings" for the instrument labeled "Consent"
And I click on the radio labeled "Auto-Archiver enabled" for the field labeled "e-Consent Framework"
And I click on the button labeled "Save Changes"
Then I should see "Your survey settings were successfully saved!"

##ACTION: add record
When I click on the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click on the bubble labeled "Consent" for event "Event 1" 
Then I should see "Adding new Record ID 9."

When I click on the button labeled "Save & Stay"
And I click on the button labeled "Okay" in the dialog box
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
Then I should see "Consent"
And I verify I see "Name" in the field labeled "1) Name"
And I verify I see "Name" in the field labeled "2) Name"
And I verify I see "email@test.edu" in the field labeled "3) Email"
And I verify I see "2023-09-03" in the field labeled "4) DOB"
And I enter a signature in the field labeled "5) Signature"
And I verify I see "signature_consent_2" in the field labeled "6) Signature"
And I verify I see "signature_consent_3" in the field labeled "7) Signature"
And I enter a signature in the field labeled "8) Signature"
And I verify I see "signature_consent_5" in the field labeled "9) Signature"

When I click on the button labeled "Submit" 
Then I should see "Thank you for taking the survey."

When I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for event "Event 1" for record "9"

##VERIFY_FiRe_no eConsent
When I click on the link labeled "File Repository"
Then I should see "4 Files" for the field labeled "PDF Survey Archive"

When I click on the link labeled "PDF Survey Archive"
And I click on the link on the PDF link for record "9"
Then I should have a pdf file
And I should NOT see the following values in the footer: "Name Name, 2023-09-03, Version: UPDATED VERSION TEST, Type: type test"
#M: Close document
