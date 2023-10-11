Feature: User Interface: The Record Locking Customization module shall allow the customization of: Display or not display E-Signature option on each data collection instrument | Lock Record Custom Text | Display or not display the Lock option for each data collection instrument

As a REDCap end user
I want to see that Record locking and E-signatures is functioning as expected

Scenario: C.2.19.700.100 Customize Record Locking display and text
#SETUP 
Given I login to REDCap with the user "Test_Admin" 
And I create a new project named "C.2.19.700.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

#SETUP_PRODUCTION 
When I click on the link labeled "Project Setup" 
And I click on the button labeled "Move project to production"  
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box 
Then I should see "Project status: Production" 

#FUNCTIONAL REQUIREMENT
##ACTION Lock Record Custom Text
When I click on the link labeled "Customize & Manage Locking/E-signatures"
And I select the button labeled "I understand. Let me make changes" in the dialog box
Then I should see "Record Locking Customization"

When I deselect the checkbox labeled "Display the Lock option for this instrument?" for the instrument labeled "Survey"
And I verify the checkbox labeled "Display the Lock option for this instrument?" is selected for the instrument labeled "Text Validation"
And I check the checkbox labeled "Also display E-signature option on instrument?" for the instrument labeled "Text Validation"
And I enter "Test custom text" in the notes box field for the Data Collection Instrument labeled "Text Validation"
And click on the button labeled "Save"
And I verify the checkbox labeled "Display the Lock option for this instrument?" is selected for the instrument labeled "Data Types"
And I enter "Test custom text" in the notes box field for the Data Collection Instrument labeled "Data Types"
And click on the button labeled "Save"

#FUNCTIONAL REQUIREMENT
##ACTION Display E-Signature or Lock option
Then I should see a table header and rows including the following values in the table:  
| Display the Lock option for this instrument?| Data Collection Instrument | Also display E-signature option on instrument?| Lock Record Custom Text |
|                                  [✓]                                       |         Text Validation               |                                  [✓]                                       |         Test custom text |
|                                  [✓]                                       |         Data Types                      |                                                                              |         Test custom text |
|                                                                               |         Survey                              |                                                                              |         [blank] |

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action           | List of Data Changes OR Fields Exported |
| test_admin | Manage/Design | Customize record locking                           |
| test_admin | Manage/Design | Customize record locking                           |

##VERIFY_RECORD
When I click on the link labeled "Record Status Dashboard"
And I click the bubble for the instrument labeled "Text Validation" for record "1" for event "Event 1"
Then I should see "Text Validation"
And I should see "Test custom text"
And I should see a checkbox for the field labeled "E-signature"

When I check the checkbox labeled "Test custom text"
And I check the checkbox labeled "E-signature"
And I click on the button labeled "Save & Stay"
Then I should see "E-signature: Username/password verification" in the dialog box

Given I enter credentials for user "Test_Admin"
Then I should see "E-signed by test_admin"
And I should see "Instrument locked by test_admim"

When I click on the link labeled "Data Types"
Then I should see "Data Types"
And I should see "Test custom text"
And I should NOT see a checkbox for the field labeled "E-signature"

When I click on the link labeled "Record Status Dashboard"
And I click the bubble for the instrument labeled "Survey" for event "Event Three" for record "1"
Then I should NOT see the checkbox for the field labeled "Lock this instrument?"
And I should NOT see a checkbox for the field labeled "E-signature"
And I should NOT see a signature field


FUNCTIONAL REQUIREMENT
##ACTION Edit and Delete Lock Record Custom Text
When I click on the link labeled "Customize & Manage Locking/E-signatures"
And I select the button labeled "I understand. Let me make changes" in the dialog box
Then I should see "Record Locking Customization"

When I click on the edit image for the Data Collection Instrument labeled "Text Validation"
And I enter "Edit Test custom text" in the notes box field for the Data Collection Instrument labeled "Text Validation"
And click on the button labeled "Save"
And I click on the edit image for the Data Collection Instrument labeled "Data Types"
And I clear the notes box field for the Data Collection Instrument labeled "Data Types"
And click on the button labeled "Save"
Then I should see a table header and rows including the following values in the table:  
| Display the Lock option for this instrument?| Data Collection Instrument | Also display E-signature option on instrument?| Lock Record Custom Text |
|                                  [✓]                                       |         Text Validation               |                                  [✓]                                       |        Edit Test custom text |
|                                  [✓]                                       |         Data Types                      |                                                                              |          [blank]                 |
|                                                                               |         Survey                              |                                                                              |         [blank]                 |

##VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action           | List of Data Changes OR Fields Exported |
| test_admin | Manage/Design | Customize record locking                           |

##VERIFY_RECORD
When I click on the link labeled "Record Status Dashboard"
And I click the bubble for the instrument labeled "Text Validation" for record "3" for event "Event 1"
Then I should see "Text Validation"
And I should see "Edit Test custom text"
And I should see a checkbox for the field labeled "E-signature"

When I check the checkbox labeled "Edit Test custom text"
And I check the checkbox labeled "E-signature"
And I click on the button labeled "Save & Stay"
Then I should see "E-signature: Username/password verification" in the dialog box

Given I enter credentials for user "Test_Admin"
Then I should see "E-signed by test_admin"
And I should see "Instrument locked by test_admim"

When I click on the link labeled "Data Types"
Then I should see "Data Types"
And I should see "Lock this instrument?"
And I should NOT see a checkbox for the field labeled "E-signature"

When I click on the link labeled "Record Status Dashboard"
And I click on the button labeled "Leave without saving changes" in the dialog box
And I click the bubble for the instrument labeled "Survey" for event "Event Three" for record "1"
Then I should NOT see the checkbox for the field labeled "Lock this instrument?"
And I should NOT see a checkbox for the field labeled "E-signature"
And I should NOT see a signature field


