Feature: User Interface: The tool shall support the filtering the record list:

As a REDCap end user
I want to see that Record locking and E-signatures is functioning as expected

Scenario: C.2.19.300.100 Record locking and E-signatures filtering
#SETUP 
Given I login to REDCap with the user "Test_Admin" 
And I create a new project named "C.2.19.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

#SETUP_PRODUCTION 
When I click on the link labeled "Project Setup" 
And I click on the button labeled "Move project to production"  
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box 
Then I should see "Project status: Production" 

#FUNCTIONAL REQUIREMENT
##ACTION Lock icon for instrument
When I click on the link labeled "Record Status Dashboard"
And I click the bubble for the instrument labeled "Text Validation" for record "3" for event "Event 1"
Then I should see "Text Validation"
And I should see the checkbox for the field labeled "Lock this instrument?"

When I click on the checkbox for the field labeled "Lock this instrument?"
And I click on the button labeled "Save & Exit Form"
Then I should see "Record Home Page"
And I should see "Record ID 3 successfully edited."
##VERIFY_RH
And I should see the lock image for the Data Instrument labeled "Text Validation" for event "Event 1"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username|        Action               | List of Data Changes OR Fields Exported |
| test_admin | Lock/Unlock Record 3 | Action: Lock instrument, Record: 3, Form: Text Validation, Event: Event 1|

##VERIFY_LOCK_ESIG: Record instrument lock on Locking Management
When I click on the link labeled "Customize & Manage Locking/E-signatures"
And I click on the button labeled "I understand. Let me make changes" in the dialog box
And I click on the link labeled "E-signature and Locking Management"
Then I should see a table header and rows including the following values in the E-signature and Locking Management table:
| Record|  Form Name     | Locked?     |
|     3      | Text Validation |  lock image|
|     3      | Consent            |                     |

#FUNCTIONAL REQUIREMENT
##ACTION Enable Locking/E-signatures at instrument level
And I should see "SHOW ALL ROWS  |  Show timestamp / user  |  Hide timestamp / user  |  Show locked  |  Show not locked  | Show e-signed  |  Show not e-signed (excludes N/A)  |  Show both locked and e-signed  | Show neither locked nor e-signed (excludes N/A)  |  Show locked but not e-signed (excludes N/A)"

When I click on the button labeled "Export all (CSV)"
Then I should have a "csv" file with a table header and rows including the following values in the report table:
| Record | Event Name                   | Form Name      | Repeat Instance | Locked?            | E-signed?|
| 3           | Event 1 (Arm 1: Arm 1)| Text Validation|                               | MM/DD/YYYY | N/A|
#M: Close file
