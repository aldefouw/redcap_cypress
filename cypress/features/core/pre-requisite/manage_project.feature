Feature: Manage Project

    As a REDCap end user
    I want to see that Manage Project is functioning as expected

    Scenario: 0 - Initial Setup Requirement - Add from Email Address
        Given I am an "admin" user who logs into REDCap
        And I click on the link labeled "Control Center"
        And I click on the link labeled "General Configuration"
        And I enter "no-reply@test.com" into the input field labeled "Set a Universal FROM Email address"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 0 - Initial Setup Requirement - Edit test_user2 to not Create or Copy Projects
        Given I click on the link labeled "Control Center"
        When I click on the link labeled "Browse Users"
        And I enter "test_user2" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
        And I click on the button labeled "Search"
        Then I should see "User information for"
        When I click on the button labeled "Edit user info"
        And I uncheck the checkbox element labeled "Allow this user to create or copy projects?"
        And I should see "Allow this user to create or copy projects?"
        And I click on the button labeled "Save"
        Then I should see "User has been successfully saved."

    Scenario: 1 - Visit Control Center Page
        Given I click on the link labeled "Control Center"
        Then I should see "Control Center Home"

    Scenario: 2- User Settings Configuration - Create Projects
        When I click on the link labeled "User Settings"
        Then I should see "Yes, normal users can create new projects"
        And I should see "No, only Administrators can create new projects"
        When I select "No, only Administrators can create new projects" on the dropdown field labeled "Allow normal users to create new projects?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 3- User Settings Configuration - Move Projects to Production
        Given I should see "Yes, normal users can move projects to production"
        And I should see "No, only Administrators can move projects to production"
        And I select "No, only Administrators can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 4- User Settings Configuration - Edit Survey Responses
        Given I select "Disabled" on the dropdown field labeled "Allow users to edit survey responses?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 5- User Settings Configuration - Allow Production Draft Mode Changes
        Given I should see "Never (always require an admin to approve changes)"
        And I should see "Yes, if no existing fields were modified"
        And I should see "Yes, if project has no records OR if has records and no existing fields were modified"
        And I should see "Yes, if no critical issues exist"
        And I should see "Yes, if project has no records OR if has records and no critical issues exist"
        When I select "Never (always require an admin to approve changes)" on the dropdown field labeled "Allow production Draft Mode changes to be approved automatically under certain conditions?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 6- User Settings Configuration - Modify Repeatable Instruments & Events
        Given I should see "Yes, normal users can modify the repeatable instance setup in production"
        And I should see "No, only Administrators can modify the repeatable instance setup in production"
        When I select "No, only Administrators can modify the repeatable instance setup in production" on the dropdown field labeled "Allow normal users to modify the 'Repeatable Instruments & Events' settings for projects while in production status?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 7- User Settings Configuration - Modify Events and Arms in Production Status
        Given I should see "Yes, normal users can add/modify events in production"
        And I should see "No, only Administrators can add/modify events in production"
        When I select "No, only Administrators can add/modify events in production" on the dropdown field labeled "Allow normal users to add or modify events and arms on the Define My Events page for longitudinal projects while in production status?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 8- Verify test_user2 can not Create or Copy Projects
        When I click on the link labeled "Browse Users"
        And I enter "test_user2" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
        And I click on the button labeled "Search"
        Then I should see "User information for"
        And I should see "test_user2"
        When I click on the button labeled "Edit user info"
        And I should see "Edit user info"
        And I uncheck the checkbox element labeled "Allow this user to request that projects be created for them by a REDCap administrator?"
        # Waiting is sub-ideal but it is seemingly the only way to avoid CSRF errors about multiple tabs!  This seems to be REDCap's fault rather than Cypress.
        And I wait for 0.5 seconds
        And I click on the button labeled "Save"
        Then I should see "User has been successfully saved."

    Scenario: 9- Login with test_user2
        Given I am a "standard2" user who logs into REDCap
        Then I should NOT see "New Project"

    Scenario: 10- Login with test_user
        Given I am a "standard" user who logs into REDCap
        Then I should see a link labeled "New Project"

    Scenario: 11- Cancel Create Project Request
        When I click on the link labeled "New Project"
        Then I should see "Send Request"
        And I click on the button labeled "Cancel"
        Then I should see "Welcome to REDCap!"

    Scenario: 12- Logout as test_user
        Given I am an "admin" user who logs into REDCap

    Scenario: 13- Allow Normal Users to Create New Projects
        Given I click on the link labeled "Control Center"
        And I click on the link labeled "User Settings"
        Then I should see "Settings related to Project Creation and Project Status Changes"
        When I select "Yes, normal users can create new projects" on the dropdown field labeled "Allow normal users to create new projects?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 14- Login with test_user
        Given I am an "standard" user who logs into REDCap

    Scenario: 15- Create Project and add test_admin to Project
        Given I click on the link labeled "New Project"
        Then I should see "Create Project"
        And I enter "FirstProject_1115" into the field identified by "input" labeled "Project title:"
        And I select "Operational Support" on the dropdown field labeled "Project's purpose:"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created and is ready to be accessed."

        When I click on the link labeled "User Rights"
        And I enter "test_admin" into the username input field
        And I click on the button labeled "Add with custom rights"
        Then I should see "Adding new user"
        Given I save changes within the context of User Rights
        Then I should see "test_admin"

    Scenario: 16- Change Project to Just for Fun
        Given I click on the link labeled "Project Setup"
        And I click on the button labeled "Modify project title, purpose, etc."
        Then I should see "Modify Project Settings"
        And I select "Practice / Just for fun" on the dropdown field labeled "Project's purpose:"
        When I click on the button labeled "Save"
        Then I should see "Success! Your changes have been saved."

    Scenario: 17- Open and Add First Instrument
        Given I click on the link labeled "Designer"
        Then I should see "Data Collection Instruments"
        When I click on the link labeled "Form 1"
        Then I should see "Record ID"
        Given I add a new Text Box field labeled "Name" with variable name "ptname"
        Then I should see "Name"
        And I should see "Variable: ptname"

    Scenario: 18- Copy Instrument
        Given I click on the button labeled "Return to list of instruments"
        Then I should see "Data Collection Instruments"
        When I click on the button labeled "Choose action"
        And I click on the link labeled "Copy"
        And I click on the button labeled "Copy instrument"
        Then I should see "Form 1 2"
        And I should see "SUCCESS! The instrument was successfully copied. The page will now reload to reflect the changes."

    Scenario: 19- Add Email Field to My First Instrument 2
        Given I click on the link labeled "Form 1 2"
        Then I should see "Current instrument:"

        Given I add a new Text Box field labeled "Email" with variable name "email"
        And I edit the Data Collection Instrument field labeled "Email"
        And I select "Email" from the Validation dropdown of the open "Edit Field" dialog box
        And I save the field
        Then I should see "Email"
        And I should see "Variable: email"

    Scenario: 20- Verify Project Home and Other Functionality Pages
        Given I click on the link labeled "Project Home"
        Then I should see "The tables below provide general dashboard information"
        When I click on the link labeled "Other Functionality"
        Then I should see "Project Status Management"

    Scenario: 21- Copy Project
        Given I click on the button labeled "Copy the project"
        Then I should see "Make a Copy of the Project"
        And I enter "ProjectCopy_1115" into the field identified by "input" labeled "Project title:"
        And I click on the link labeled "Select All"
        And I click on the button labeled "Copy project"
        Then I should see "COPY SUCCESSFUL!"
        When I click on the link labeled "User Rights"
        Then I should see a link labeled "test_user"
        When I click on the link labeled "Record Status Dashboard"
        Then I should see "No records exist yet"
        When I click on the link labeled "Project Setup"
        And I click on the link labeled "Other Functionality"
        Then I should see "Delete the project"
        And I should see "Erase all data"

    Scenario: 22 - Cancel Move Project to Production
        Given I should see a link labeled "Project Setup"
        And I click on the link labeled "Project Setup"

        When I click on the button labeled "Move project to production"
        Then I should see "Yes, Request Admin to Move to Production Status"

        When I click on the button labeled "Cancel" in the dialog box
        Then I should see "Move project to production"

    Scenario: 23 - Login as admin1115
        Given I am an "admin" user who logs into REDCap

    Scenario: 24 - Allow Normal Users to Move to Production
        Given I click on the link labeled "Control Center"
        When I click on the link labeled "User Settings"
        And I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 25 - Login with test_user
        Given I am a "standard" user who logs into REDCap

    Scenario: 26 - Move ProjectCopy_1115 to Production
        Given I click on the link labeled "My Projects"
        And I click on the link labeled "ProjectCopy_1115"
        Then I should see "Project Setup"
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        When I move the project to production by selection option "Keep ALL data saved so far"
        Then I should see "Success! The project is now in production."

    Scenario: 27 - Other Functionality Tab Options Visibility
        Given I click on the link labeled "Other Functionality"
        Then I should NOT see "Delete the project"
        And I should see "Request delete project"
        And I should NOT see "Erase all data"

    Scenario: 28 - Login as admin1115
        Given I logout
        And I am an "admin" user who logs into REDCap

    Scenario: 29 - Admin Other Functionality Tab Options Visibility
        Given I click on the link labeled "My Projects"
        And I click on the link labeled "ProjectCopy_1115"
        And I click on the link labeled "Other Functionality"
        Then I should see "Delete the project"
        And I should see "Erase all data"
        When I click on the button labeled "Delete the project"
        Then I should see "Permanently delete this project?"
        When I click on the button labeled "Cancel"
        Then I should see "Delete the project"

    Scenario: 30 - Delete Project ProjectCopy_1115
        When I permanently delete the project via the Other Functionality page
        When I see "Project successfully deleted!"
        And I see "The project was successfully deleted from REDCap"
        Then I click on the button labeled "Close" in the dialog box

    Scenario: 31 - Login with test_user
        Given I am an "standard" user who logs into REDCap

    Scenario: 32 - Disable / Enable Longitudinal Data Collection
        Given I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I enable longitudinal mode
        Then I should see that longitudinal mode is "enabled"

    Scenario: 33 - Add Event 2 in Arm 1
        Given I see "Define My Events"
        And I click on the button labeled "Define My Events"
        Then I should see "Event 1"
        Given I add an event named "Event 2" into the currently selected arm

    Scenario: 34 - Add Event 1 in Arm 2
        When I click on the link labeled "Add New Arm"
        And I enter "Arm 2" into the Arm name field
        And I click on the button labeled "Save"
        Then I should see "No events have been defined for this Arm"
        Given I add an event named "Event 1" into the currently selected arm
        Then I should see "Event 1"

    Scenario: 35 - Edit Designate Instruments for Arm 1
        Given I click on the link labeled "Designate Instruments for My Events"
        And I click on the link labeled "Arm 1"
        Then I should see "Event 1"
        And I should see "Event 2"
        And I enable the Data Collection Instrument named "Form 1" for the Event named "Event 1"
        And I enable the Data Collection Instrument named "Form 1 2" for the Event named "Event 1"

    Scenario: 36 - Edit Designate Instruments for Arm 2
        Given I click on the link labeled "Arm 2"
        Then I should see "Arm name:"
        And I should see "Arm 2"
        And I enable the Data Collection Instrument named "Form 1" for the Event named "Event 1"

    Scenario: 37 - Enable Repeatable Instruments and Events
        Given I click on the link labeled 'Project Setup'
        And I should see that repeatable instruments are disabled
        And I open the dialog box for the Repeatable Instruments and Events module
        And I select "Repeat Instruments (repeat independently of each other)" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)"
        And I check the checkbox labeled "Form 1 2"
        And I select "Repeat Entire Event (repeat all instruments together)" on the dropdown field labeled "Event 1 (Arm 2: Arm 2)"
        And I click on the button labeled "Save"
        Then I should see "Your settings for repeating instruments and/or events have been successfully saved. (The page will now reload.)"
        Then I should see that repeatable instruments are modifiable

    Scenario: 38 - Disable / Enable Surveys
        Given I should see that surveys are disabled
        When I enable surveys for the project
        Then I should see that surveys are enabled
        When I disable surveys for the project
        Then I should see that surveys are disabled
        When I enable surveys for the project
        Then I should see that surveys are enabled

    #the following # out lines are looking for enabled/disabled surveys for specific instruments. We do not currently have a step definition for individual instrument surveys, only to check if surveys are enabled within the entire project
    Scenario: 39 - Enable Survey for My First Instrument
        Given I click on the button labeled "Online Designer"
        Then I should see "The Online Designer will allow you to make project modifications"

        #TODO: Convert this to an English-friendly step definition for enabling a specific survey instrument
        When I click on the element identified by "button:contains('Enable'):first"

        Then I should see "Set up my survey for data collection instrument"
        When I click on the button labeled "Save Changes"
        Then I should see "Your survey settings were successfully saved!"

    Scenario: 40 - Delete Survey
        Given I click on the button labeled "Survey settings"
        Then I should see "Modify survey settings for data collection instrument"
        When I click on the button labeled "Delete Survey Settings"
        Then I should see "Delete this instrument's survey settings"
        And I click on the button labeled "Delete Survey Settings" in the dialog box
        Then I should see "Survey successfully deleted!"
        And I close the popup
        Then I should see "Data Collection Instruments"

    Scenario: 41 - Enable Survey for My First Instrument

        #TODO: Convert this to an English-friendly step definition for enabling a specific survey instrument
        When I click on the element identified by "button:contains('Enable'):first"

        And I click on the button labeled "Save Changes"
        Then I should see "Your survey settings were successfully saved!"
        #Surveys are enabled for Form 1
        #Survey symbol replaces Enable button.

    Scenario: 42 - Change Survey Status to Offline
        Given I click on the button labeled "Survey settings"
        And I select "Survey Offline" on the dropdown field labeled "Survey Status"
        And I click on the button labeled "Save Changes"
        Then I should see "Your survey settings were successfully saved!"

    Scenario: 43 - Change Survey Status to Active
        Given I click on the button labeled "Survey settings"
        And I select "Survey Active" on the dropdown field labeled "Survey Status"
        And I click on the button labeled "Save Changes"
        Then I should see "Your survey settings were successfully saved!"

    Scenario: 44 - Open and Submit Public Survey
        Given I click on the link labeled "Survey Distribution Tools"
        And I click on the link labeled "Public Survey Link"
        Then I should see "Using a public survey link is the simplest and fastest way to collect responses for your survey"
        And I visit the public survey URL for this project
        And I enter "User Name Here" into the "Name" survey text input field
        And I click on the button labeled "Submit"
        Then I should see "Thank you"

    Scenario: 45 - Verify Survey Responses are Read Only
        Given I am an "standard" user who logs into REDCap
        Then I should see a link labeled "My Projects"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Add / Edit Records"
        And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
        Then I should see "Record Home Page"
        When I click the bubble to select a record for the "Form 1(survey)" longitudinal instrument on event "Event 1"
        Then I should see "Survey response is read-only"

    Scenario: 46 - Login as admin1115
        Given I logout
        And I am an "admin" user who logs into REDCap

    Scenario: 47 - Allow Users to Edit Survey Responses
        Given I click on the link labeled "Control Center"
        When I click on the link labeled "User Settings"
        And I select "Enabled" on the dropdown field labeled "Allow users to edit survey responses?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 48 - Login with test_user
        Given I logout
        And I am an "standard" user who logs into REDCap

    Scenario: 49 - Edit User Rights for test_user
        Given I change survey edit rights for "test_user" user on the form called "Form 1" on project ID 13

    Scenario: 50 - Verify Survey Responses are Visible and Editable
        Given I click on the link labeled "Add / Edit Records"
        And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
        Then I should see "Record Home Page"
        When I click the bubble to select a record for the "Form 1(survey)" longitudinal instrument on event "Event 1"
        And I should see "Survey response is editable"
        And I should see "Edit response"

    Scenario: 51 - Enable the Designate an email field…
        Given I click on the link labeled "Project Setup"
        Then I should see that the designate an email field for communications setting is "disabled"
        And I enable designation of an email field for communications setting
        Then I should see "Choose an email field to use for invitations to survey participants:"
        When I select "email" on the dropdown field labeled "Choose an email field to use for invitations to survey participants:"
        And I click on the button labeled "Save"
        Then I should see "Field currently designated: email"
        And I should see that the designate an email field for communications setting is "enabled"

    Scenario: 52 - Move FirstProject_1115 to Production
        Given I click on the button labeled "Move project to production"
        Then I should see "Move Project To Production Status?"
        When I move the project to production by selection option "Keep ALL data saved so far"
        Then I should see "Success! The project is now in production."

    Scenario: 53 - Enter Draft Mode and Verify Can Not Delete an Event
        Given I click on the button labeled "Online Designer"
        Then I should see "Enter Draft Mode"
        When I click on the button labeled "Enter Draft Mode"
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Define My Events"

        Then I should see "Record Status Dashboard"
        And I should see "Event 1"
        And I should see "Event 2"
        And I should see "Events cannot be modified in production status except by a REDCap administrator."
        And I should NOT see options to Edit or Delete events

    Scenario: 54 - Add New Field and Submit Changes for Review
        Given I click on the link labeled "Designer"
        Then I should see "Since this project is currently in PRODUCTION"
        When I click on the link labeled "Form 1"
        When I add a new Text Box field labeled "Text2" with variable name "text2"
        Then I should see "Variable: text2"
        When I click on the button labeled "Submit Changes for Review"
        Then I should see "SUBMIT CHANGES FOR REVIEW?"
        When I click on the button labeled "Submit"
        #Then I should see "Awaiting review of project changes"
        #should see if email sends

    Scenario: 55 - Login as admin1115
        Given I logout
        And I am an "admin" user who logs into REDCap

    Scenario: 56 - Remove Drafted Changes
        Given I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Designer"
        And I click on the button labeled "Project Modification Module"
        Then I should see "Below is a listing of the changes to be committed to this project."
        When I click on the button labeled "Remove All Drafted Changes"
        And I should see "DELETE ALL DRAFT MODE CHANGES"
        And I click on the button labeled "Remove All Drafted Changes" in the dialog box
        Then I should see "The changes were NOT committed to the project but were removed"

    Scenario: 57 - Allow Users to Make Draft Mode Changes
        Given I click on the link labeled "Control Center"
        When I click on the link labeled "User Settings"
        And I select "Yes, if project has no records OR if has records and no critical issues exist" on the dropdown field labeled "Allow production Draft Mode changes to be approved automatically under certain conditions?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 58 - Login with test_user
        Given I logout
        And I am an "standard" user who logs into REDCap

    Scenario: 59 - Add New Field and Submit Changes
        Given I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Designer"
        Then I should see "The project is currently in PRODUCTION status"
        And I click on the button labeled "Enter Draft Mode"
        And I click on the link labeled "Form 1"
        When I add a new Text Box field labeled "Text2" with variable name "text2"
        Then I should see "Variable: text2"
        When I click on the button labeled "Submit Changes for Review"
        And I click on the button labeled "Submit"
        Then I should see "SUCCESS! The changes you just submitted were made AUTOMATICALLY"
        When I click on the button labeled "Close"

    Scenario: 60 - Verify Can Not Edit Define My Events in Production
        Given I click on the button labeled "Enter Draft Mode"
        Then I should see "Since this project is currently in PRODUCTION"
        When I click on the link labeled "Project Setup"
        And I should see that repeatable instruments are modifiable
        When I click on the button labeled "Define My Events"
        #And I click on the element identified by "[title=Edit]"
        Then I should see "Events cannot be modified in production status"

    Scenario: 61 - Verify Can Not Edit Designate Instruments Tab in Production
        Given I click on the link labeled "Designate Instruments for My Events"
        Then I should see "Events cannot be modified in production status except by a REDCap administrator"

    Scenario: 62 - Login as admin1115
        Given I logout
        And I am an "admin" user who logs into REDCap

    Scenario: 63 - Allow Normal Users to Modify the Repeatable Instruments & Events
        Given I click on the link labeled "Control Center"
        And I click on the link labeled "User Settings"
        And I select "Yes, normal users can modify the repeatable instance setup in production" on the dropdown field labeled "Allow normal users to modify the 'Repeatable Instruments & Events' settings for projects while in production status?"
        And I select "Yes, normal users can add/modify events in production" on the dropdown field labeled "Allow normal users to add or modify events and arms on the Define My Events page for longitudinal projects while in production status?"
        And I click on the button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 64 - Login with test_user
        Given I logout
        And I am an "standard" user who logs into REDCap

    Scenario: 65 - Verify Changing Repeating Forms
        Given I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"

        And I should see "Enable optional modules and customizations"

        When I open the dialog box for the Repeatable Instruments and Events module
        And I wait for 3 seconds
        Then I should see "Please be aware that if you uncheck any of the instruments or events that have currently been set as a repeating instrument or repeating event"
        Then I should see "Close"
        And I click on the button labeled "Close" in the dialog box

        Given I select "Repeat Instruments (repeat independently of each other)" on the dropdown field labeled "Event 1 (Arm 1: Arm 1)"
        Then I should see "Cancel"
        And I click on the button labeled "Cancel" in the dialog box

    Scenario: 66 - Add Event 3 to Arm 1
        Given I click on the button labeled "Define My Events"
        Then I should see "Arm 1"
        When I enter "Event 3" into the input field labeled "Descriptive name for this event"
        And I click on the button labeled "Add new event"
        Then I should see "Event 3"

    Scenario: 67 - Add Arm 3
        Given I should see a link labeled "Add New Arm"
        When I click on the link labeled "Add New Arm"
        And I enter "Arm 3" into the Arm name field
        And I click on the button labeled "Save"
        Then I should see "Arm 3"

    Scenario: 68 - Verify Can Not Edit Event 3
        Given I click on the link labeled "Arm 1"
        And I verify I cannot change the Event Name of "Event 3" while in production
        And I should see "events can only be renamed by REDCap administrators"
        And I click on the button labeled "Close" in the dialog box
        Then I should see "Event 3"

    Scenario: 69 - Edit Event 3
        Given I logout
        And I am an "admin" user who logs into REDCap
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Define My Events"
        Then I should see "Arm 1"
        And I change the current Event Name from "Event 3" to "Event Three"
        Then I should see "Event Three"

    Scenario: 70 - Attempt to Remane Arm 2
        Given I logout
        And I am a "standard" user who logs into REDCap
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Define My Events"
        And I click on the link labeled "Arm 2"
        Then I should see "Arm 2"
        When I click on the link labeled "Rename Arm 2"
        Then I should see "Sorry, but arms can only be renamed by REDCap administrators when a project is in production status"
        When I click on the button labeled "Close"
        Then I should see a link labeled "Rename Arm 2"

    Scenario: 71 - Rename Arm 2
        Given I logout
        And I am an "admin" user who logs into REDCap
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Define My Events"
        And I click on the link labeled "Arm 2"
        Then I should see "Arm 2"
        When I click on the link labeled "Rename Arm 2"
        Then I should see "Arm name:"
        And I enter "Arm Two" into the Arm name field
        And I click on the button labeled "Save"
        Then I should see "Arm Two"

    Scenario: 72 - Check Instrument Designation
        Given I logout
        And I am a "standard" user who logs into REDCap
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Designate Instruments for My Events"
        Then I should see "Data Collection Instrument"
        When I click on the link labeled "Arm 2"
        Then I should see "Since this project is in production, only REDCap administrators are allowed to uncheck any instruments that are already designated"
        When I enable the Data Collection Instrument named "Form 1 2" for the Event named "Event 1"
        And I verify the Data Collection Instrument named "Form 1 2" is enabled for the Event named "Event 1"

    Scenario: 73 - Uncheck Instrument Designation
        Given I logout
        And I am a "admin" user who logs into REDCap
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I should see "Designate Instruments for My Events"
        And I click on the button labeled "Designate Instruments for My Events"
        And I click on the link labeled "Arm 2"
        And I disable the Data Collection Instrument named "Form 1 2" for the Event named "Event 1"
        And I verify the Data Collection Instrument named "Form 1 2" is disabled for the Event named "Event 1"

    Scenario: 74 - Submit Automatic Changes
        Given I click on the link labeled "Designer"
        Then I should see "Since this project is currently in PRODUCTION, changes will not be made in real time"
        When I click on the button labeled "Submit Changes for Review"
        Then I should see "SUBMIT CHANGES FOR REVIEW?"
        When I click on the button labeled "Submit"
        Then I should see "SUCCESS! The changes you just submitted were made AUTOMATICALLY."
        And I click on the button labeled "Close" in the dialog box

    Scenario: 75 - Confirm One Record and Two Instruments
        Given I click on the link labeled "Record Status Dashboard"
        Then I should see a link labeled "1"
        And I should see a link labeled "Arm 1"
        And I should see a link labeled "Arm 2"
        #Looks silly to look for "1records" - but in this case there is no space in the actual HTML!  (Spacing is handled by margin on the span!)
        And I should see "1records"
        And I should see "Form 1"
        And I should see "Form 1 2"