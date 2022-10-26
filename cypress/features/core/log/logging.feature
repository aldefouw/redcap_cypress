Feature: Logging

  As a REDCap end user
  I want to see that Logging is functioning as expected

  Scenario: Add new record
    Given I am an "admin" user who logs into REDCap
    And I create a project named "23_Logging_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/logging.xml"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "23_Logging_v1115"

    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    Then I should see "Text Validation"
    And I enter "Test" into the field labeled "Name"
    And I enter "test@test.com" into the field labeled "Email"
    Then I click on the button labeled "Save & ..."
    And I should see "Save your changes?"
    And I enter "Testing" into the field labeled "Name"
    Then I click on the button labeled "Save & Exit"

  Scenario: Add new record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    Then I should see "Text Validation"
    And I enter "Test2" into the field labeled "Name"
    And I enter "test2@test.com" into the field labeled "Email"
    Then I click on the button labeled "Save & Exit"

  Scenario: Add new record
    When I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    Then I should see "Text Validation"
    And I enter "Delete" into the field labeled "Name"
    And I enter "delete@test.com" into the field labeled "Name"
    Then I click on the button labeled "Save & Exit"

  Scenario: Delete record
    When I click on the link labeled "Record Status Dashboard"
    And I click on the bubble for the "Text Validation" data collection instrument instrument for record ID "3"
    And I click on the link labeled "Record ID 3"
    And I click on the button labeled "Choose action for record"
    And I should see "Delete record (all forms)"
    And I click on the link labeled "Delete record (all forms)"
    And I should see "DELETE RECORD"
    And I click on the button labeled "DELETE RECORD"
    And I should see "Record ID \"3\" was successfully deleted."
    And I click on the button labeled "Close"

  Scenario: Add new role
    When I click on the link labeled "User Rights"
    And I enter "Data" into the field identified by "input[id=new_rolename]"
    And I click on the button labeled "Create role"
    And I should see "Creating new role"
    And I click on the element identified by "button:nth-child(2)"
    Then I should see "Role was successfully added!"

  Scenario: Edit role
    When I click on the link labeled "Data"
    And I select the "Project Design and Setup" option
    Then I click on the button labeled "Save Changes"

  Scenario: Delete role
    When I click on the link labeled "Data"
    And I click on the button labeled "Delete role"
    Then I should see popup message "Delete role?"
    And I click on the button labeled "Delete role"
    Then I should see popup message "Role "Data\" was successfully deleted!"
  
  Scenario: Add new user
    When I click on the link labeled "User Rights"    
    And I fill in the "Add new user" field with "user1115_3"
    And I select the user "user1115_3"
    And I click on the button labeled "Add with custom rights"
    Then I should see a new user added when I click on the button labeled "Add user"
  
  Scenario: Remove user
    When I click on the link labeled "user1115_3"
    And I click on the button labeled "Edit user privileges"
    Then I should see get warning "Remove user?" when I click on the button labeled "Remove user"
    And I click on the button labeled "Remove user"
  
  Scenario: Login as test_user2
    When I click on the button labeled "Log out"
    Then I should see the login page
    Given I am an "standard2" user who logs into REDCap
    Then I should see the text "Logged in as test_user2"

  Scenario: Data Exports, Reports, and Stats
    When I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Export Data"
    And I select the radio button labeled "CSV / Microsoft Excel (raw data)"
    And I click on the button labeled "Export Data"
    Then I should see a popup labeled "Data export was successful!"
    And I click on the icon "Excel CSV"
    #Then I should see the file downloaded

  Scenario: Edit user privileges for test_user1
    When I click on the link labeled "User Rights"
    Then I click on the link labeled "test_user1"
    And I want to assign the "Record Locking Customization" user right 
    And I want to enable "Locking/Unlocking with E-Signature authority"
    Then I should see a popup with "NOTICE" and I close popup
    And I click on the button labeled "Saved Changes"
    Then I should see a green checkmark for "Record Locking Customization" and a green shield for "Lock/Unlock Records"

  Scenario: Edit record - Lock/E-signature
    When I click on the dropdown labeled "select record"
    #Then I should see two records 
    And I select the record labeled "1"
    #And I click on the red radio button under the Status column
    Then I should see the Text Validation instrument for Record ID "1"
    And I select the checkbox "Lock"
    And I click the button labeled "Save and Stay"
    Then I should see a message that says "Locked by test_user"
    And I select the checkbox "E-Signature"
    And I click the button labeled "Save and Stay"
    Then I should see a pop-up asking for "Username/password verification"
    And I enter the Username: "test_user" and password "password"
    And I click on the button labeled "Save"
    Then I should see a message that says "E-signed by test_user"
    And I click on he button labeled "Unlock form"
    Then I should see a popup asking to verify "UNLOCK FORM?"
    And I click on the button labeled "Unlock"
    Then I should see a popup stating "UNLOCK SUCCESSFUL!"
    And I click on the button labeled "Close"
    And I click on the button labeled "Save and Exit Form"
    #Then I should be returned to the Record Home Page

  Scenario: Enter draft mode and edit instrument
    When I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see a message that says "Success!"
    And I click on the link labeled "Text Validation"
    And I click on the button labeled "Add field" at the end
    And I enter "textbox" as the field label and and variable name
    And I click on the button labeled "Save"
    Then I should see a new field created called "textbox"
    And I click on the button labeled "Return tp the list of instruments"
    #Then I should be on the instruments page
  
  Scenario: Add instrument
    When I click on the button labeled "Create"
    Then I should see a button labeled "Add instrument here"
    And I click on the button labeled "Add instrument here"
    And I enter the form name "Form 2"
    And I click on the button labeled "Create"
    Then I should see a pop up message "The new instrument was successfully created. The page will be reloaded to reflect this change."
    And I click on the button labeled "Close"
  
  Scenario: Submit changes for review
    When I click on the link labeled "Designer"
    And I click on the button labeled "Submit Changes for Review"
    Then I should see a popup asking "SUBMIT CHANGES FOR REVIEW?"
    And I click on the button labeled "Submit"
    Then I should see a popup message "SUCCESS! The changes you just submitted were made AUTOMATICALLY."
    And I click on the button labeled "Close"

  Scenario: Logging page
    When I click on the link labeled "Logging"
    Then I should see "filter by event", "filter by user name", " filter by record", "filter by time range", and "displaying events"
    And I should see a table with with the following columns: "Time/Date", "Username", "Action", "List of Data Changes or Fields Exported"

  Scenario: Logging: filter by event - Data export
    #When I am on the Logging page
    And I select the "Data Export" option from the "Filter by event" dropdown field
    Then I should see "Download exported data file" under the "List of Data Changes or Fields Exported" column
    And I should see field names of previously exported data under the "List of Data Changes or Fields Exported" column

  Scenario: Logging: filter by event - Manage/Design
    #When I am on the Logging page
    And I select the "Manage/Design" option from the "Filter by event" dropdown field
    Then I should see "Approve production project modifications" under the "List of Data Changes or Fields Exported" column
    And I should see "Create data collection instrument" under the "List of Data Changes or Fields Exported" column
    And I should see "Create project field" under the "List of Data Changes or Fields Exported" column
    And I should see "Enter draft mode" under the "List of Data Changes or Fields Exported" column
  
  Scenario: Logging: filter by event - User or role
    #When I am on the Logging page
    And I select the "User or role" option from the "Filter by event" dropdown field
    Then I should see "Updated User", "Deleted User", "Created User" under the "Action" column
    And I should see "Updated Role", "Edited Role", "Created Role" under the "Action" column
    And I should see the username or role name displayed for the corresponding action under the "List of Data Changes or Fields Exported" column
  
  Scenario: Logging: filter by event - Record created-updated-deleted
    #When I am on the Logging page
    And I select the "Record created-updated-deleted" option from the "Filter by event" dropdown field
    Then I should see "Updated Record", "Deleted Record", "Created Record" under the "Action" column
    And I should see the field name and new value displayed of field under the "List of Data Changes or Fields Exported" column

  Scenario: Logging: filter by event - Record locking & e-signatures
    #When I am on the Logging page
    And I select the "Record locking & e-signatures" option from the "Filter by event" dropdown field
    Then I should see "E-signature", "Lock/Unlock Record" under the "Action" column
    And I should see the  Action, Record, Form, and Event display new data. under the "List of Data Changes or Fields Exported" column

  Scenario: Logging: filter by event - Page Views
    #When I am on the Logging page
    And I select the "Page Views" option from the "Filter by event" dropdown field
    Then I should see "Page Views" under the "Action" column
    And I should see the page accessed under the "List of Data Changes or Fields Exported" column

  Scenario: Logging: filter by event - All event types (username)
    #When I am on the Logging page
    And I select "All event types" option from the "Filter by event" dropdown field
    And I select "test_user" option from the "Filter by user name" dropdown field
    Then I should see all event types for "test_user"
    
  Scenario: Logging: filter by event - All event types (record)
   # When I am on the Logging page
    And I select "All event types" option from the "Filter by event" dropdown field
    And I select "2" option from the "Filter by record" dropdown field
    Then I should see all event types for record "2"
  
  Scenario: Download All logging
    #When I am on the Logging page
    And I click on the button labeled "All logging"
    #Then I should see a file downloaded
  
  Scenario: Open logging file
    #When I open the logging file
    Then I should see timestamp under the "Time/Date" column
    And I should see "test_user" and "test_user2" under the "Username" column 
    And I should see "Created Record", "Created Role","Created User","Data Export","Deleted Record","Deleted Role" ,"Deleted User","Edited Role","E-signature","Lock/Unlock Record","Manage/Design","Updated Record","Updated User" under the "Action" column
    And I should see the changes mades under the "List of Data Changes" column
    #And I close the file
  
  Scenario: Verify project settings
    When I login as "admin"
    And I click on the button labeled "Control Center"
    And I click on the link labeled "Edit project settings"
    And I select "Logging" from the dropdown field
    Then I should see the project settings for the "Logging" project
    And I select "Yes, delete the record’s logged events when deleting the record." from the "Delete a record's logging activity when deleting the record?" dropdown field
    And I click on the button labeled "Save Changes"
    And I click on the link labeled "Logging" to navigate back to the project
  
  Scenario: Delete Record
    When I login as "test_user"
    And I click on the link labeled "Add/Edit Records"
    And I select record "2" from the "Choose an existing Record ID" dropdown field
    And click on the dropdown field labeled "Choose aciton for record" And I select "Delete Record"
    Then I should see a popup "DELETE RECORD '2'"
    And I select the checkbox "Also remove the logged data values for this record (not common)"
    Then I should see a popup "Confirmation: Type 'DELETE'"
    And I write "DELETE" and click on the button labeled "Confirm"
    And I click on the button labeled "Delete Record"
    Then I should see a popup that says "Record deleted!"
    And I click on the button labeled "Close"

  Scenario: Logging: filter by event - Record created-updated-deleted
    #When I am on the Logging page
    And I select the "Record created-updated-deleted" option from the "Filter by event" dropdown field
    Then I should see "Updated Record", "Deleted Record", "Created Record" under the "Action" column
    And I should see "DATA REMOVED" under the "List of Data Changes or Fields Exported" column
    And I should see "All data values were removed.." under the "List of Data Changes or Fields Exported" column
  
  Scenario: Enter Draft Move and Enable Longitudinal Data Collection
    When I login as "admin"
    And I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see a message that says "Success!"
    And I click on the tab labeled "Project Setup"
    And I click on the button labeled "Enable" for "Use longitudinal data collection with defined events?"
    Then I should see a green checkmark beside "Use longitudinal data collection with defined events?"

  Scenario: Submit changes for review
    When I click on the link labeled "Designer"
    And I click on the button labeled "Submit Changes for Review"
    Then I should see a popup asking "SUBMIT CHANGES FOR REVIEW?"
    And I click on the button labeled "Submit"
    Then I should see a popup message "SUCCESS! The changes you just submitted were made AUTOMATICALLY."
    And I click on the button labeled "Close"
  
  Scenario: Designate Instruments
    When I login as "admin"
    And I click on the button labeled "Designate Instruments for My Events"
    And I click on the tab labeled "Arm 2"
    And I click on the button labeled "Begin Editing"
    And I select Text Validation checkbox under "Event 1"
    And I click on the button labeled "Save"
    Then I shoudl see a green checkmark under "Event 1" for Text Validation survey

  Scenario: Add new record to an Arm 
    When I login as "test_user"
    And I click on the link labeled "Record Status Dashboard"
    And I click on the tab labeled "Arm 2"
    And I click on the button labeled "Add new record for this arm"
    And I fill in Name with "Arm2"
    Then I click on the button labeled "Save & Exit"
  
  Scenario: Logging: filter by event - Record created-updated-deleted
    #When I am on the Logging page
    And I select the "Record created-updated-deleted" option from the "Filter by event" dropdown field
    Then I should see "Updated Record", "Deleted Record", "Created Record" under the "Action" column
    #And I should see the Action column include the Arm name after the record number
    And I should see the data values for "Arm2" under the "List of Data Changes or Fields Exported" column

  Scenario: Delete Record
    And I click on the link labeled "Add/Edit Records"
    And I select "Arm 2" And record "2" from the "Choose an existing Record ID" dropdown field
    And click on the dropdown field labeled "Choose aciton for record" And I select "Delete Record"
    Then I should see a popup "DELETE RECORD '2'"
    And I select the checkbox "Also remove the logged data values for this record (not common)"
    Then I should see a popup "Confirmation: Type 'DELETE'"
    And I write "DELETE" and click on the button labeled "Confirm"
    And I click on the button labeled "Delete Record"
    Then I should see a popup that says "Record deleted!"
    And I click on the button labeled "Close"
  
  Scenario: Logging: filter by event - Record created-updated-deleted
    #When I am on the Logging page
    And I select the "Record created-updated-deleted" option from the "Filter by event" dropdown field
    Then I should see "Updated Record", "Deleted Record", "Created Record" under the "Action" column
    And I should see "DATA REMOVED" under the "List of Data Changes or Fields Exported" column
    And I should see "All data values were removed.." under the "List of Data Changes or Fields Exported" column