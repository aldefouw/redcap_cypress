Feature: A.6.4.600 Manage project creation, deletion, and settings

  Manage project creation, deletion, and settings
  Control Center: The system shall support the option to limit adding or modifying events and arms while in production to administrators. Note: user can add instrument to event in production.

  Scenario: A.6.4.600.100 User’s ability to add or modify events and arms while in production mode

    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.6.4.600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml" and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.600.100"
    Then I should see "Project Status"
    And I should see "Development"

    When I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Assign to role"
    And I should see the dropdown field labeled "Select Role"
    When I assign "1_FullRights" on dropdown field labeled "Select Role"
    And I click on the button labeled "Assign"
    Then I should see "Test_User1" user assigned "1_FullRights" role
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.600.100"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"

    Given I should see a link labeled "Add New Arm"
    When I click on the link labeled "Add New Arm"
    And I enter "Arm 3" in the field labeled "Arm name: "
    And I click on the button labeled "Save"
    Then I should see "Arm 3"

    When I click on the link labeled "Logging"
    Then I should see "Create arm" in the logging table
    And I should see "Arm 3" in the logging table

    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    And I click on the link labeled "Arm 3"
    Then I should see the button labeled "Add new event"

    When I enter "Event 1" into the input field labeled "Event Label"
    And I enter "1" in the input field labeled "Days Offset"
    And I click on the button labeled "Add new event"
    Then I should see "Event 1"

    When I click on the link labeled "Logging"
    Then I should see "Create event" in the logging table
    And I should see "Event 1, Arm: Arm 3" in the logging table

    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    And I click on the link labeled "Arm Two"
    And I click on the link labeled "Rename Arm 2"
    And I enter "Arm 2" into the input field labeled "Arm name"
    And I click on the button labeled "Save"
    Then I should see "Arm name: Arm 2"

    When I click on the link labeled "Logging"
    Then I should see "Edit arm name/number" in the logging table
    And I should see "Arm 2: Arm 2" in the logging table

    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    And I click on the link labeled "Arm 2"
    And I click on the Edit image for "Event 1"
    When I enter "Event One" into the input field labeled "Event Label"
    And I click on the button labeled "Save"
    Then I should see "Event One"

    When I click on the link labeled "Logging"
    And I should see "Edit event" in the logging table
    And I should see "Event One, Arm: Arm 2" in the logging table

    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    And I click on the link labeled "Arm 1"
    Then I should see the button labeled "Add new event"

    When I enter "Event 4" into the input field labeled "Event Label"
    And I enter "4" in the input field labeled "Days Offset"
    And I click on the button labeled "Add new event"
    Then I should see "Event 4"

    When I click on the link labeled "Logging"
    Then I should see "Create event" in the logging table
    And I should see "Event 4, Arm: Arm 1" in the logging table

    When I click on the link labeled "Record Status Dashboard"
    Then I should see "Arm 3: Arm 3"
    And I should see "Arm 2: Arm 2"

    When I click on the link labeled "Arm 2"
    Then I should see "Event One"

    When I click on the link labeled "Arm 1"
    Then I should see "Event 4"

    Given I click on the link labeled "Project Setup"
    When I click on the button labeled "Designate Instruments for My Events"
    And I click on the link labeled "Arm 1"
    And I click on the button labeled "Begin Editing"
    And I disable the Data Collection Instrument named "Data Types" for the Event named "Event 1"
    And I click on the button labeled "Save"
    Then I should NOT see Data Collection Instrument named "Data Types" enabled for the Event named "Event 1"

    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm 1"
    Then I should NOT see Data Collection Instrument named "Data Types" for the Event named "Event 1"

    When I click on the link labeled "Logging"
    Then I should see "Perform instrument-event mappings" on the first row of the logging table

    Given I click on the link labeled "Project Setup"
    When I click on the button labeled "Designate Instruments for My Events"
    And I click on the link labeled "Arm 1"
    And I click on the button labeled "Begin Editing"
    And I enable the Data Collection Instrument named "Consent" for the Event named "Event 2"
    And I click on the button labeled "Save"
    Then I should see Data Collection Instrument named "Consent" enabled for the Event named "Event 2"

    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm 1"
    Then I should see Data Collection Instrument named "Consent" for the Event named "Event 2"

    Given I click on the link labeled "Project Setup"
    When I click on the button labeled "Designate Instruments for My Events"
    And I click on the link labeled "Arm 1"
    And I click on the button labeled "Begin Editing"
    And I enable Data Collection Instrument named "Text Validation" for the Event named "Event 4"
    And I click on the button labeled "Save"
    Then I should see Data Collection Instrument named "Text Validation" enabled for the Event named "Event 4"

    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm 1"
    Then I should see Data Collection Instrument named "Text Validation" for the Event named "Event 4"

    Given I click on the link labeled "Project Setup"
    When I click on the button labeled "Designate Instruments for My Events"
    And I click on the link labeled "Arm 3"
    When I click on the button labeled "Begin Editing"
    And I enable the Data Collection Instrument named "Consent" for the Event named "Event 1"
    And I click on the button labeled "Save"
    Then I should see Data Collection Instrument named "Consent" enabled for the Event named "Event 1"

    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm 3"
    Then I should see Data Collection Instrument named "Consent" for the Event named "Event 1"
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.600.100"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio button labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project Status"
    And I should see "Production"

    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    When I select "No, only Administrators can add/modify events in production" on the dropdown field labeled "Allow normal users to add or modify events and arms on the Define My Events page for longitudinal projects while in production status?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.600.100"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    Then I should see "Events cannot be modified in production"
    And I should NOT see the button labeled "Add new arm"
    And I should NOT see the button labeled "Add new event"

    When I click on the dropdown labeled "Upload or download arms/events”
    Then I should NOT see the option "Upload arms (CSV)"
    And I should NOT see the option "Upload events (CSV)"

    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Designate Instruments for My Events"
    Then I should NOT see options to Edit or Delete events
    And I should see "Events cannot be modified in production"
    And I should NOT see the button labeled "Begin Editing"

    When I click on the dropdown labeled "Upload or download instrument mappings"
    Then I should NOT see the option "Upload instrument-event mappings (CSV)"
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    When I select "Yes, normal users can add/modify events in production" on the dropdown field labeled "Allow normal users to add or modify events and arms on the Define My Events page for longitudinal projects while in production status?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.600.100"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"

    Given I should see a link labeled "Add New Arm"
    When I click on the link labeled "Add New Arm"
    And I enter "Arm 4" in the field labeled "Arm name: "
    And I click on the button labeled "Save"
    Then I should see "Arm 4"

    Given I click on the link labeled "Arm 4"
    Then I should see the button labeled "Add new event"
    When I enter "Event 1" into the input field labeled "Event Label"
    And I enter "1" in the input field labeled "Days Offset"
    And I click on the button labeled "Add new event"
    Then I should see "Event 1"

    When I click on the link labeled "Logging"
    Then I should see "Create arm" in the logging table
    And I should see "Arm 4" in the logging table
    And I should see "Create event" in the logging table
    And I should see "Event 1, Arm: Arm 4" in the logging table

    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    And I click on the link labeled "Arm 2"
    And I click on the link labeled "Rename Arm 2"
    Then I should see "Sorry, but arms can only be renamed by REDCap administrators"
    And I click on the button labeled "Close" in the dialog box
    Then I should see "Arm 2"

    When I click on the link labeled "Record Status Dashboard"
    Then I should see a link labeled "Arm 2"

    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    And I click on the link labeled "Arm 1"
    And I verify I cannot change the Event Name "Event 2" while in production
    And I should see "events can only be renamed by REDCap administrators"
    And I click on the button labeled "Close" in the dialog box
    Then I should see "Event 2"

    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm 1"
    Then I should see "Event 2"

    Given I click on the link labeled "Project Setup"
    When I click on the button labeled "Designate Instruments for My Events"
    And I click on the link labeled "Arm 1"
    And I click on the button labeled "Begin Editing"
    Then I should see "only REDCap administrators are allowed to uncheck any instruments that are already designated"
    And I am UNABLE to "uncheck" the Data Collection Instrument named "Data Types" for the Event named "Event One" in arm "Arm 2"

    When I click on the dropdown field labeled "Upload or download instrument mappings"
    And I click on the option "Upload instrument-event mappings (CSV)"
    And I choose the file "instrument designation"
    And I click on button labeled "Upload" in the dialog box
    Then I should see "ERROR"
    And I click on the button labeled "Close" in the dialog box

    Given I click on the link labeled "Arm 1"
    When I enable the Data Collection Instrument named "Data Types" for the Event named "Event 4"
    And I click on the button labeled "Save"
    Then I should see Data Collection Instrument named "Data Types" enabled for the Event named "Event 4"

    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm 1"
    Then I should see Data Collection Instrument named "Data Types" enabled for the Event named "Event 4"

    When I click on the link labeled "Logging"
    Then I should see a "Perform instrument-event mappings" on the first row of the logging table

    Given I click on the link labeled "Project Setup"
    When I click on the button labeled "Designate Instruments for My Events"
    And I click on the link labeled "Arm 4"
    And I click on the button labeled "Begin Editing"
    And I enable the Data Collection Instrument named "Consent" for the Event named "Event 1"
    And I click on the button labeled "Save"
    Then I should see Data Collection Instrument named "Consent" enabled for the Event named "Event 1"

    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm 4"
    Then I should see Data Collection Instrument named "Consent" enabled for the Event named "Event 1"
    And I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.600.100"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    And I click on the link labeled "Arm 1"
    Then I should see "Rename Arm 1"

    When I click on the link labeled "Rename Arm 1"
    And I change the current Arm Name from "Arm 1" to "Arm One"
    And I click on the button labeled "Save"
    Then I should see "Arm One"

    When I click on the link labeled "Record Status Dashboard"
    Then I should see "Arm 1: Arm One"

    When I click on the link labeled "Logging"
    Then I should see "Edit arm name" in the logging table
    And I should see "Arm 1: Arm One" in the logging table

    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Define My Events"
    And I click on the link labeled "Arm One"
    When I click on the Edit image for the Event labeled "Event 4"
    And I change the current Event Name from "Event 4" to "Event Four"
    And I click on the button labeled "Save"
    Then I should see "Event Four"

    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm One"
    Then I should see "Event Four"

    When I click on the link labeled "Logging"
    Then I should see "Edit event" in the logging table
    And I should see "Event Four, Arm: Arm One" in the logging table

    Given I click on the link labeled "Project Setup"
    When I click on the button labeled "Designate Instruments for My Events"
    And I click on the link labeled "Arm 2"
    And I click on the button labeled "Begin Editing"
    And I disable the Data Collection Instrument named "Data Types" for the Event named "Event One"
    And I click on the button labeled "Save"
    Then I should not see Data Collection Instrument named "Data Types" for the Event named "Event One" enabled

    When I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "Arm 2"
    Then I should not see Data Collection Instrument named "Data Types" for the Event named "Event One" enabled

    When I click on the link labeled "Logging"
    Then I should see "Perform instrument-event mappings" on the first row of the logging table

    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    When I select "No, only Administrators can add/modify events in production" on the dropdown field labeled "Allow normal users to add or modify events and arms on the Define My Events page for longitudinal projects while in production status?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
