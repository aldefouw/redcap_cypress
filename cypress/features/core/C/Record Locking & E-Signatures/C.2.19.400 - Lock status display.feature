Feature: User Interface: The tool shall display locked status of forms for all records.

As a REDCap end user
I want to see that Record locking and E-signatures is functioning as expected

Scenario: C.2.19.400.100 display lock status
#SETUP 
Given I login to REDCap with the user "Test_Admin" 
And I create a new project named "C.2.19.400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

#SETUP_PRODUCTION 
When I click on the link labeled "Project Setup" 
And I click on the button labeled "Move project to production"  
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box 
Then I should see "Project status: Production" 

#USER_RIGHTS
When I click on the link labeled "User Rights"  
And I enter "Test_User1" into the input field labeled "Add with custom rights" 
And I click on the button labeled "Add with custom rights" 
Then I should see "Adding new user "test_user1"" 

When I click on the checkbox for the field labeled "Record Locking Customization"
And I click on the radio labeled "Locking / Unlocking" for the field labeled "Lock / Unlock Records (instrument level)"
And I click on the checkbox for the field labeled "Lock/Unlock *Entire* Records (record level)"
And I click on the button labeled "Add user"
And I click on the checkbox for the field labeled "Logging"
Then I should see "User "test_user1" was successfully added"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action                 | List of Data Changes OR Fields Exported |
| test_admin | Add user test_user1 | user = 'test_user1'|

And I logout

Given I login to REDCap with the user "Test_User1"

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
| test_user1  | Lock/Unlock Record 3 | Action: Lock instrument, Record: 3, Form: Text Validation, Event: Event 1|

##VERIFY_LOCK_ESIG: Record instrument lock on Locking Management
When I click on the link labeled "Customize & Manage Locking/E-signatures"
And I click on the button labeled "I understand. Let me make changes" in the dialog box
And I click on the link labeled "E-signature and Locking Management"
Then I should see a table header and rows including the following values in the E-signature and Locking Management table:
| Record|  Form Name     | Locked?     |
|     3      | Text Validation |  lock image|
|     3      | Consent            |                     |

##ACTION Lock icon for event
When I click on the link labeled "Record Status Dashboard"
And I click on the link labeled "3"
Then I should see "Record Home Page"

When I click on the dropdown option labeled "Lock entire record" from the dropdown button with the placeholder text of "Choose action for record" 
And I click on the button labeled "Lock entire record" in the dialog box
Then I should see "Record "3" is now LOCKED"
##VERIFY_RH
And I should see the lock image for "Record ID 3"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username|        Action                  | List of Data Changes OR Fields Exported |
| test_user1  | Lock/Unlock Record 3 | Action: Lock entire record, Record: 3 - Arm 1: Arm 1|

##VERIFY_LOCK_ESIG: record locked
When I click on the link labeled "Customize & Manage Locking/E-signatures"
And I click on the button labeled "I understand. Let me make changes" in the dialog box
And I click on the link labeled "E-signature and Locking Management"
Then I should see a table header and rows including the following values in the E-signature and Locking Management table:
| Record|                                                 Form Name     | Locked?     |
|     3 (Arm 1: Arm 1) (entire record) |                         |  lock image|

##ACTION : unlock record 3
When I click on the link labeled "Record Status Dashboard"
And I click on the link labeled "3"
Then I should see "Record Home Page"

When I click on the dropdown option labeled "Unlock entire record" from the dropdown button with the placeholder text of "Choose action for record" 
And I click on the button labeled "Unlock entire record" in the dialog box
Then I should see "Record "3" is now UNLOCKED"
##VERIFY_RH
And I should NOT see the lock image for "Record ID 3"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username|        Action                  | List of Data Changes OR Fields Exported |
| test_user1  | Lock/Unlock Record 3 | Action: Unlock entire record, Record: 3 - Arm 1: Arm 1|

##VERIFY_LOCK_ESIG: record locked
When I click on the link labeled "Customize & Manage Locking/E-signatures"
And I click on the button labeled "I understand. Let me make changes" in the dialog box
And I click on the link labeled "E-signature and Locking Management"
Then I should NOT see "3 (Arm 1: Arm 1) (entire record)"

##ACTION Unlock icon for instrument
When I click on the link labeled "Record Status Dashboard"
And I click the bubble for the instrument labeled "Text Validation" for record "3" for event "Event 1"
Then I should see "Text Validation"
And I should see a button labeled "Unlock form"

When I click on the button labeled "Unlock form"
And I click on the button labeled "Unlock" in the dialog box
Then I should see "UNLOCK SUCCESSFUL!"

When I click on the button labeled "Close" in the dialog box
Then I should see "Text Validation"
And I should see the checkbox for the field labeled "Lock this instrument?"

When I click on the button labeled "Save & Exit Form"
Then I should see "Record Home Page"
And I should see "Record ID 3 successfully edited."
##VERIFY_RH
And I should NOT see the lock image for the Data Instrument labeled "Text Validation" for event "Event 1"

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username|        Action               | List of Data Changes OR Fields Exported |
| test_user1  | Update record 3       |                                                                                 |

##VERIFY_LOCK_ESIG: verify that there isn't a lock in that view
When I click on the link labeled "Customize & Manage Locking/E-signatures"
And I click on the button labeled "I understand. Let me make changes" in the dialog box
And I click on the link labeled "E-signature and Locking Management"
Then I should see a table header and rows containing the following values in the E-signature and Locking Management table:
| Record|  Form Name     | Locked?     |
|     3      | Text Validation |                     |
|     3      | Consent            |                     |

