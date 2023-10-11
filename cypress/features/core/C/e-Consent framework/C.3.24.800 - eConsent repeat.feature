Feature: User Interface: The e-Consent framework shall support repeatable instruments and repeatable events

As a REDCap end user
I want to see that eConsent is functioning as expected

Scenario: C.3.24.800.100 e-Consent framework & Repeatable instruments/events

#SETUP
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "C.3.24.800.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Consent.xml", and clicking the "Create Project" button 

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

#FUNCTIONAL_REQUIREMENT
##ACTION: instance 1 for event 1
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
And I check the checkbox labeled "I certify all of my information in the document above is correct."
And I click on the button labeled "Submit" 
Then I should see "Thank you for taking the survey."

When I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for instance "1" for event "Event 1" for record "1"

#FUNCTIONAL_REQUIREMENT
##ACTION: instance 2 for event 1
When I click the "+" for the Data Collection Instrument labeled "Consent" for event "Event 1"
And I click on the button labeled "Save & Stay"
And I click on the button labeled "Okay" in the dialog box
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
Then I should see "Consent"

When I enter a signature in the field labeled "5) Signature"
And I enter a signature in the field labeled "8) Signature"
And I click on the button labeled "Next Page" 
And I check the checkbox labeled "I certify all of my information in the document above is correct."
And I click on the button labeled "Submit" 
Then I should see "Thank you for taking the survey."

When I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for instance "2" for event "Event 1" for record "1"

#FUNCTIONAL_REQUIREMENT
##ACTION: instance 1 for event 3
When I click the bubble for the Data Collection Instrument labeled "Consent" for event "Event 3"
And I click on the button labeled "Save & Stay"
And I click on the button labeled "Okay" in the dialog box
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
Then I should see "Consent"

When I enter a signature in the field labeled "5) Signature"
And I enter a signature in the field labeled "8) Signature"
And I click on the button labeled "Next Page" 
And I check the checkbox labeled "I certify all of my information in the document above is correct."
And I click on the button labeled "Submit" 
Then I should see "Thank you for taking the survey."

When I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for instance "1" for event "Event 3" for record "1"

#FUNCTIONAL_REQUIREMENT
##ACTION: instance 2 for event 3
When I click the "+" for the Data Collection Instrument labeled "Consent" for event "Event 3"
And I click on the button labeled "Save & Stay"
And I click on the button labeled "Okay" in the dialog box
And I select the dropdown option labeled "Open survey" from the dropdown button with the placeholder text of "Survey options" 
Then I should see "Consent"

When I enter a signature in the field labeled "5) Signature"
And I enter a signature in the field labeled "8) Signature"
And I click on the button labeled "Next Page" 
And I check the checkbox labeled "I certify all of my information in the document above is correct."
And I click on the button labeled "Submit" 
Then I should see "Thank you for taking the survey."

When I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
##VERIFY_RSD
Then I should see a Completed Survey Response icon for the Data Collection Instrument labeled "Consent" for instance "2" for event "Event 3" for record "1"

##VERIFY_LOG: Keeping here in case you change your mind and want to include something in logging. If you don't feel like its valuable, then delete

##VERIFY_FiRe
When I click on the link labeled "File Repository"
Then I should see "4 Files" for the field labeled "PDF Survey Archive"

When I click on the link labeled "PDF Survey Archive"
Then I should have 4 pdf files for record "1"
