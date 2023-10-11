Feature: User Interface: Longitudinal Project Settings: The system shall support the ability to create repeating events and instruments within events.

As a REDCap end user
I want to see that Manage project user access is functioning as expected

Scenario: B.4.27.600.100 Repeat instrument and event 
#A.6.4.500.100
##SETUP_DEV
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "B.4.27.600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 

When I click on the link labeled "Project Setup"
Then I should see "Repeating instruments and events" 

#FUNCTIONAL_REQUIREMENT
##ACTION Repeat Instruments
When I click on the button labeled "Modify" for the field labeled "Repeatable Instruments and events"
And I select "not repeating" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)" in the dialog box
And I select "Repeat Instruments (repeat independently of each other)" on the dropdown field labeled "Event Three (Arm 1: Arm 1)" in the dialog box
And I check the checkbox labeled "Survey" for the event labeled "Event Three (Arm 1: Arm 1)" in the dialog box
And I click on the button labeled "Save" in the dialog box
#VERIFY
Then I should see "Successfully saved"
And I click on the button labeled "Close" in the dialog box

#VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action            | List of Data Changes OR Fields Exported |
| test_admin | Manage/Design  | Set up repeating instruments/events |

##ACTION Verify repeat instrument function in record
Given I click on the link labeled "Add/Edit Records"
And I select "1" on the dropdown field labeled "Choose an existing Record ID"
And I click the bubble to select a record for the "Survey" longitudinal instrument on event "Event Three"
And I enter "MyName" in the field labeled "Name"
And I click the button labeled "Save & Add New Instance"
And I enter "MyOtherName" in the field labeled "Name"
And I click the button labeled "Save & Exit Record" 
Then I should see "Record ID 1 successfully edited"

When I click on the link labeled "Record Status Dashboard"
And I click the bubble for the "Survey" longitudinal instrument on event "Event Three" for record "1"
And I click the bubble for instance "1"
#VERIFY 
Then I should see "Current instance: "

When I click on the link labeled "Record Status Dashboard"
And I click the bubble for the "Data Types" longitudinal instrument on event "Event 1" for record "1"
Then I should NOT see "Current instance:"

##VERIFY_DE
When I click on the link labeled "Data Export, Reports, and Stats"
Then I should see "A All data (records and fields)"
And I click the button labeled "View Report"
Then I should NOT see repeat instrument "Data Types" for "Event 1 (Arm 1: Arm 1)"
And I should see repeat instrument "Survey" for "Event Three (Arm 1: Arm 1)"
And I should see "MyOtherName"

#FUNCTIONAL_REQUIREMENT
##ACTION Not repeating instrument
When I click on the link labeled "Project Setup"
Then I should see "Repeating instruments and events" 

When I open the dialog box for the Repeatable Instruments and Events module
And I select "Repeat Instruments (repeat independently of each other)" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)"
And I check the checkbox labeled "Data Types"
And I select "not repeating" on the dropdown field labeled "Event Three (Arm 1: Arm 1)"
And I click on the button labeled "Save"
#VERIFY
Then I see "Successfully saved!"
And I click on the button labeled "Close" in the dialog box

#VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action          | List of Data Changes OR Fields Exported |
| test_admin| Manage/Design | Set up repeating instruments/events |

##ACTION Verify no repeat instance in record
Given I click on the link labeled "Add/Edit Records"
And I select "1" on the dropdown field labeled "Choose an existing Record ID"
And I click the bubble to select a record for the "Survey" longitudinal instrument on event "Event Three"
Then I should NOT see "Current instance:"
#VERIFY
When I click the button labeled "Cancel"
Then I should see "data entry cancelled - not saved"

When I click the bubble for the "Data Types" longitudinal instrument on event "Event 1"
Then I should see "Current instance:"

##VERIFY_DE
When I click on the link labeled "Data Export, Reports, and Stats"
Then I should see "A All data (records and fields)"

When I click the button labeled "View Report"
Then I should see repeat instrument instance for instrument "Data Types" for "Event 1 (Arm 1: Arm 1)" 
And I should NOT see repeat instrument instance for instrument "Survey" for "Event Three (Arm 1: Arm 1)"
And I should NOT see "MyOtherName"
And I should see repeat event instance for event "Event 2 (Arm 1: Arm 1)"
And I should NOT see repeat event instance for event "Event Three (Arm 1: Arm 1)"

#FUNCTIONAL_REQUIREMENT
##ACTION Repeat event
When I click on the link labeled "Project Setup"
And I open the dialog box for the Repeatable Instruments and Events module
And I select "Not repeating" on the dropdown field labeled "Event 2 (Arm 1: Arm 1)"
And I select "Repeat Entire Event" on the dropdown field labeled "Event Three (Arm 1: Arm 1)"
And I click on the button labeled "Save"
#VERIFY
Then I see "Successfully saved!"
And I click on the button labeled "Close" in the dialog box

#VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action          | List of Data Changes OR Fields Exported |
| test_admin| Manage/Design | Set up repeating instruments/events |

##ACTION Verify repeat event function in record
Given I click on the link labeled "Add/Edit Records"
And I select "1" on the dropdown field labeled "Choose an existing Record ID"
Then I should see "(#2)"

When I click on "Add new"
And I click the bubble for the "Survey" longitudinal instrument on event "Event Three" instance "2"
And I enter "My repeat event name" in the field labeled "Name"
And I click the button "Save & Exit Form"
Then I should see "(#2)"

##VERIFY_DE
And I click on the link labeled "Data Export, Reports, and Stats"
Then I should see "A All data (records and fields)"
And I click the button labeled "View Report"
Then I should NOT see repeat event instance for event "Event 2 (Arm 1: Arm 1)"
And I should see repeat event instance for event "Event Three (Arm 1: Arm 1)"
And I should see "My repeat event name"

#FUNCTIONAL_REQUIREMENT
##ACTION No Repeat event
When I click on the link labeled "Project Setup"
And I open the dialog box for the Repeatable Instruments and Events module
And I select "Repeat Entire Event" on the dropdown field labeled "Event 2 (Arm 1: Arm 1)" 
And I select "Not repeating" on the dropdown field labeled "Event Three (Arm 1: Arm 1)"
And I click on the button labeled "Save"
##VERIFY 
Then I should see "Successfully saved" 

##VERIFY_DE
When I click on the link labeled "Data Export, Reports, and Stats"
Then I should see "A All data (records and fields)
And I click the button labeled "View Report"
Then I should see repeat event instance for event "Event 2 (Arm 1: Arm 1)"
And I should see repeat event instance for event "Event Three (Arm 1: Arm 1)"
And I should NOT see "My repeat event name"

#FUNCTIONAL_REQUIREMENT
##ACTION Delete repeat event
Given I click on the link labeled "Add/Edit Records"
And I select "1" on the dropdown field labeled "Choose an existing Record ID"
And I click the X to delete all data related to the event named "Event 2 (Arm 1: Arm 1)" instance "2"
And I click on the button labeled "Delete this instance of this event" in the dialog box
##VERIFY 
Then I should NOT see "(#2)"

#VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table header and rows including the following values in the logging table:
| Username   |        Action                                                       | 
| test_admin| Update record 1 (Event 2 (Arm 1: Arm 1)) | 

