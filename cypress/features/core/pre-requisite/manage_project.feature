Feature: Manage Project

    As a REDCap end user
    I want to see that Manage Project is functioning as expected

    Scenario: Edit test_user2 to not Create or Copy Projects
        Given I am an "admin" user who logs into REDCap
        And I visit the "Control Center" page
        When I click on the link labeled "Browse Users"
        And I enter "test_user2" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
        And I click on the button labeled "Search"
        Then I should see "User information for"
        When I click on the button labeled "Edit user info"
        And I click on the element identified by "[name=allow_create_db]"
        And I click on the input button labeled "Save"

    Scenario: 2- User Settings Configuration - Create Projects
        When I click on the link labeled "User Settings"
        Then I should see "Yes, normal users can create new projects"
    #And I select "Yes, normal users can create new projects" from the dropdown identified by "select[name=superusers_only_create_project]"
        And I select "No, only Administrators can create new projects" from the dropdown identified by "select[name=superusers_only_create_project]"
        And I click on the input button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 3- User Settings Configuration - Move Projects to Production
        When I click on the link labeled "User Settings"
        And I select "Yes, normal users can move projects to production" from the dropdown identified by "select[name=superusers_only_move_to_prod]"
        And I select "No, only Administrators can move projects to production" from the dropdown identified by "select[name=superusers_only_move_to_prod]"
        And I click on the input button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 4- User Settings Configuration - Edit Survey Responses
        When I click on the link labeled "User Settings"
        And I select "Enabled" from the dropdown identified by "select[name=enable_edit_survey_response]"
        And I select "Disabled" from the dropdown identified by "select[name=enable_edit_survey_response]"
        And I click on the input button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 5- User Settings Configuration - Allow Production Draft Mode Changes
        When I click on the link labeled "User Settings"
        And I select "Yes, if no existing fields were modified" from the dropdown identified by "select[name=auto_prod_changes]"
        And I select "Yes, if project has no records OR if has records and no existing fields were modified" from the dropdown identified by "select[name=auto_prod_changes]"
        And I select "Yes, if no critical issues exist" from the dropdown identified by "select[name=auto_prod_changes]"
        And I select "Yes, if project has no records OR if has records and no critical issues exist" from the dropdown identified by "select[name=auto_prod_changes]"
        And I select "Never (always require an admin to approve changes)" from the dropdown identified by "select[name=auto_prod_changes]"
        And I click on the input button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 6- User Settings Configuration - Modify Repeatable Instruments & Events
        When I click on the link labeled "User Settings"
        And I select "Yes, normal users can modify the repeatable instance setup in production" from the dropdown identified by "select[name=enable_edit_prod_repeating_setup]"
        And I select "No, only Administrators can modify the repeatable instance setup in production" from the dropdown identified by "select[name=enable_edit_prod_repeating_setup]"
        And I click on the input button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 7- User Settings Configuration - Modify Events and Arms in Production Status
        When I click on the link labeled "User Settings"
        And I select "Yes, normal users can add/modify events in production" from the dropdown identified by "select[name=enable_edit_prod_events]"
        And I select "No, only Administrators can add/modify events in production" from the dropdown identified by "select[name=enable_edit_prod_events]"
        And I click on the input button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 8- Verify test_user2 can not Create or Copy Projects
        When I click on the link labeled "Browse Users"
        And I enter "test_user2" into the field labeled "User Search: Search for user by username, first name, last name, or primary email"
        And I click on the button labeled "Search"
        Then I should see "(NOTE: Currently normal users CANNOT create or copy projects. See the User Settings page in the Control Center to change this setting.)"
      #I dont think this detects

    Scenario: 9- Login with test_user2
        When I click on the link labeled "Log out"
        And I enter "test_user2" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        Then I should NOT see "New Project"

    Scenario: 10- Login with test_user
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        Then I should NOT see "New Project"
        Then I should see a link labeled "New Project"

    Scenario: 11- Cancel Create Project Request
        And I click on the link labeled "New Project"
        Then I should see "Send Request"
        And I click on the button labeled "Cancel"
        Then I should see "Welcome to REDCap!"

    Scenario: 12- Logout as test_user
        Given I logout

    Scenario: 13- Allow Normal Users to Create New Projects
        And I am an "admin" user who logs into REDCap
        And I visit the "Control Center" page
        When I click on the link labeled "User Settings"
        Then I should see "Settings related to Project Creation and Project Status Changes"
        And I select "Yes, normal users can create new projects" from the dropdown identified by "select[name=superusers_only_create_project]"
        And I click on the input button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 14- Login with test_user
#        When I click on the link labeled "Log out"
#        And I enter "test_user" into the field labeled "Username:"
#        And I enter "Testing123" into the field labeled "Password:"
#        And I click on the button labeled "Log In"

    Scenario: 15- Create Project and add test_admin to Project
        And I click on the link labeled "New Project"
        And I enter "FirstProject_1115" into the field identified by "[name=app_title]"
        And I select "Operational Support" from the dropdown identified by "[name=purpose]"
        And I click on the button labeled "Create Project"
        Then I should see "Your new REDCap project has been created and is ready to be accessed."
        When I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "User Rights"
        And I enter "test_admin" into the field identified by "[id=new_username]"
        And I click on the button labeled "Add with custom rights"
        Then I should see "Adding new user"
        When I click on the button labeled "Add user"
        Then I should see "test_admin"

    Scenario: 16- Change Project to Just for Fun
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Modify project title, purpose, etc."
        Then I should see "Modify Project Settings"
        When I select "Practice / Just for fun" from the dropdown identified by "[name=purpose]"
        Then I should see "Modify Project Settings"
        When I click on the button labeled "Save"
        Then I should see "Success! Your changes have been saved."

    Scenario: 17- Open and Add First Instrument
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Designer"
        Then I should see "Data Collection Instruments"
        When I click on the link labeled "Form 1"
        #my first instrument?
        Then I should see "Record ID"
        And I click on the element identified by "input[id=btn-last]"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" from the dropdown identified by "[name=field_type]"
        And I enter "Name" into the field identified by "[id=field_label]"
        And I enter "ptname" into the field identified by "[id=field_name]"
        And I click on the button labeled "Save"
        Then I should see "Variable: ptname"

    Scenario: 18- Copy Instrument
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Designer"
        Then I should see "Data Collection Instruments"
        When I click on the button labeled "Choose action"
        And I click on the link labeled "Copy"
    #And I enter "My First Instrument 2" into the field labeled "New instrument name:"
        #this should actually be a "I should see"
        #name is off
        And I click on the button labeled "Copy instrument"
        Then I should see "Form 1 2"
        And I should see "SUCCESS! The instrument was successfully copied. The page will now reload to reflect the changes."

    Scenario: 19- Add Email Field to My First Instrument 2
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Designer"
        And I click on the link labeled "Form 1 2"
        Then I should see "Current instrument:"
        When I click on the element identified by "input[id=btn-last]"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" from the dropdown identified by "[name=field_type]"
        And I enter "Email" into the field identified by "[id=field_label]"
        And I enter "email" into the field identified by "[id=field_name]"
        And I select "Email" from the dropdown identified by "[id=val_type]"
        And I click on the button labeled "Save"
        Then I should see "Variable: email"

    Scenario: 20- Verify Project Home and Other Functionality Pages
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Home"
        Then I should see "The tables below provide general dashboard information"
        When I click on the link labeled "Other Functionality"
        Then I should see "Project Status Management"

    Scenario: 21- Copy Project
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Other Functionality"
        And I click on the button labeled "Copy the project"
        Then I should see "Make a Copy of the Project"
    #When I clear the field labeled "Project title:"
        And I enter "ProjectCopy_1115" into the field identified by "[name=app_title]"
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
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "ProjectCopy_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        And I click on the element identified by "[id=keep_data]"
        Then I should see "Yes, Request Admin to Move to Production Status"
        When I click on the button labeled "Cancel"
        Then I should see "Move project to production"

    Scenario: 23 - Login as admin1115

    Scenario: 24 - Allow Normal Users to Move to Production
        When I click on the link labeled "User Settings"
        And I select "Yes, normal users can move projects to production" from the dropdown identified by "select[name=superusers_only_move_to_prod]"
        And I click on the input button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 25 - Login with test_user
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"

    Scenario: 26 - Move ProjectCopy_1115 to Production
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "ProjectCopy_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        Then I should see "YES, Move to Production Status"
        When I click on the element identified by "[id=keep_data]"
        And I click on the button labeled "YES, Move to Production Status"
        Then I should see "Success! The project is now in production."

    Scenario: 27 - Other Functionality Tab Options Visibility
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "ProjectCopy_1115"
        And I click on the link labeled "Other Functionality"
        Then I should NOT see "Delete the project"
        And I should see "Request delete project"
        And I should NOT see "Erase all data"

    Scenario: 28 - Login as admin1115

    Scenario: 29 - Admin Other Functionality Tab Options Visibility
        When I click on the link labeled "My Projects"
        And I click on the link labeled "ProjectCopy_1115"
        And I click on the link labeled "Other Functionality"
        Then I should see "Delete the project"
        And I should see "Erase all data"
        When I click on the button labeled "Delete the project"
        Then I should see "Permanently delete this project?"
        When I click on the button labeled "Cancel"
        Then I should see "Delete the project"

    Scenario: 30 - Delete Project ProjectCopy_1115
        When I click on the link labeled "My Projects"
        And I click on the link labeled "ProjectCopy_1115"
        And I click on the link labeled "Other Functionality"
        When I click on the button labeled "Delete the project"
        And I enter "DELETE" into the field identified by "[id=delete_project_confirm]"
        Then I should see "Deleting the project named"
        When I click on the element identified by "button:contains('Delete the project'):last"
        And I click on the button labeled "Yes, delete the project"
        Then I should see "Project successfully deleted!"

    Scenario: 31 - Login with test_user
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"

    Scenario: 32 - Diasble / Inable Longitudinal Data Collection
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        Then I should see that longitudinal mode is "Enable"
        When I click on the element identified by "[id=setupLongiBtn]"
        Then I should see that longitudinal mode is "Disable"
        When I click on the element identified by "[id=setupLongiBtn]"
        Then I should see that longitudinal mode is "Enable"
        When I click on the element identified by "[id=setupLongiBtn]"
        Then I should see that longitudinal mode is "Disable"

    Scenario: 33 - Add Event 2 in Arm 1
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Define My Events"
        Then I should see "Event 1"
        When I enter "Event 2" into the field identified by "[id=descrip]"
        And I click on the input button labeled "Add new event"
        Then I should see "Event 2"

    Scenario: 34 - Add Event 1 in Arm 2
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Define My Events"
        And I click on the link labeled "Add New Arm"
        And I enter "Arm 2" into the field identified by "[id=arm_name]"
        And I click on the input button labeled "Save"
        Then I should see "No events have been defined for this Arm"
        When I enter "Event 1" into the field identified by "[id=descrip]"
        And I click on the input button labeled "Add new event"
        Then I should see "Event 1"

    Scenario: 35 - Edit Designate Instruments for Arm 1
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Designate Instruments for My Events"
        Then I should see "Arm name:"
        And I should see "Arm 1"
        When I click on the button labeled "Begin Editing"
        And I click on the element identified by "[id=form_1--41"
        And I click on the button labeled "Save"

    Scenario: 36 - Edit Designate Instruments for Arm 2
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Designate Instruments for My Events"
        And I click on the link labeled "Arm 2"
        Then I should see "Arm name:"
        And I should see "Arm 2"
        When I click on the button labeled "Begin Editing"
        And I click on the element identified by "[id=form_1--44]"
        And I click on the button labeled "Save"

    Scenario: 37 - Enable Repeatable Instruments and Events
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        Then I should see that repeatable instruments are "Enable"
        When I click on the element identified by "[id=enableRepeatingFormsEventsBtn]"
        Then I should see that repeatable instruments are "Disable"
        When I select "Repeat Instruments (repeat independently of each other)" from the dropdown identified by "[name=repeat_whole_event-41]"
        And I click on the element identified by "[name=repeat_form-41-form_1_2]"
        And I select "Repeat Entire Event (repeat all instruments together)" from the dropdown identified by "[name=repeat_whole_event-43]"
        And I click on the button labeled "Save"
        Then I should see "Your settings for repeating instruments and/or events have been successfully saved. (The page will now reload.)"
        And I should see that repeatable instruments are "Modify"

    Scenario: 38 - Diasble / Inable Surveys
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        Then I should see that surveys are disabled
        When I click on the element identified by "[id=setupEnableSurveysBtn]"
        Then I should see that surveys are enabled
        When I click on the element identified by "[id=setupEnableSurveysBtn]"
        Then I should see that surveys are disabled
        When I click on the element identified by "[id=setupEnableSurveysBtn]"
        Then I should see that surveys are enabled

    Scenario: 39 -  Enable Survey for My First Instrument
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Online Designer"
        Then I should see "The Online Designer will allow you to make project modifications"
    #And I should see that surveys are enabled
        #The Enable button appears in the Enabled a survey column for all instruments.
    #And I should see that surveys are enabled
        #The Enable button appears in the Enabled a survey column for all instruments.
        When I click on the element identified by "button:contains('Enable'):first"
        Then I should see "Set up my survey for data collection instrument"
        When I click on the button labeled "Save Changes"
        Then I should see "Your survey settings were successfully saved!"
    #And I should NOT see "input"
        #Survey symbol replaces Enable button.

    Scenario: 40 - Delete Survey
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Online Designer"
        And I click on the button labeled "Survey settings"
        Then I should see "Modify survey settings for data collection instrument"
        When I click on the button labeled "Delete Survey Settings"
        Then I should see "Delete this instrument's survey settings"
        And I click on the element identified by "button:contains('Delete Survey Settings'):last"
        Then I should see "Survey successfully deleted!"
    #When I click on the button labeled "Close"
    #Then I should see that surveys are disabled
        #The Enable button appears in the Enabled a survey column for all instruments.

    Scenario: 41 - Enable Survey for My First Instrument
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Online Designer"
        When I click on the element identified by "button:contains('Enable'):first"
        And I click on the button labeled "Save Changes"
        Then I should see "Your survey settings were successfully saved!"
     #And I should NOT see "input"
        #Survey symbol replaces Enable button.

    Scenario: 42 - Change Survey Status to Offline
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Online Designer"
        And I click on the button labeled "Survey settings"
        And I select "Survey Offline" from the dropdown identified by "[name=survey_enabled]"
        And I click on the button labeled "Save Changes"
        Then I should see "Your survey settings were successfully saved!"
    #And I should NOT see "input"
        #Survey symbol replaces Enable button.

    Scenario: 43 - Change Survey Status to Active
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Online Designer"
        And I click on the button labeled "Survey settings"
        And I select "Survey Active" from the dropdown identified by "[name=survey_enabled]"
        And I click on the button labeled "Save Changes"
        Then I should see "Your survey settings were successfully saved!"

    Scenario: 44 - Open and Submit Public Survey
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Survey Distribution Tools"
        Then I should see "Using a public survey link is the simplest and fastest way to collect responses for your survey"
        When I visit the public survey URL for Project ID 14
        And I click on the element identified by "[name=submit-btn-saverecord]"

    Scenario: 45 - Verify Survey Responses are Read Only
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Add / Edit Records"
        And I select "1" from the dropdown identified by "[id=record]"
        Then I should see "Record Home Page"
        When I click on the element identified by ".odd > .nowrap > a > img"
        #Select My First Instrument with the green checkmark.
        Then I should see "input"
        #Survey response is read-only message appears on My First instrument page.

    Scenario: 46 - Login as admin1115

    Scenario: 47 - Allow Users to Edit Survey Responses
        When I click on the link labeled "User Settings"
        And I select "Enabled" from the dropdown identified by "select[name=enable_edit_survey_response]"
        And I click on the input button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 48 - Login with test_user
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"

    Scenario: 49 - Edit User Rights for test_user
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "User Rights"
        And I click on the link labeled "test_user"
        And I click on the button labeled "Edit user privileges"
        Then I should see "Editing existing user"
        When I click on the element identified by "[id=form-editresp-form_1]"
        And I click on the button labeled "Save Changes"
        Then I should see "was successfully edited"

    Scenario: 50 - Verify Survey Responses are Visible and Editable
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Add / Edit Records"
        And I select "1" from the dropdown identified by "[id=record]"
        Then I should see "Record Home Page"
        When I click on the element identified by ".odd > .nowrap > a > img"
        #Select My First Instrument with the green checkmark.
        And I should see "Survey response is editable"
        And I should see "Edit response"

    Scenario: 51 - Enable the Designate an email field…
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        Then I should see that the designate an email field for communications setting is "Enable"
        When I click on the element identified by "[id=enableSurveyPartEmailFieldBtn]"
        Then I should see "Choose an email field to use for invitations to survey participants:"
        When I select "email" from the dropdown identified by "[id=surveyPartEmailFieldName]"
        And I click on the button labeled "Save"
        Then I should see that the designate an email field for communications setting is "Disable"

    Scenario: 52 - Move FirstProject_1115 to Production
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Move project to production"
        Then I should see "Move Project To Production Status?"
        When I click on the element identified by "[id=keep_data]"
        And I click on the button labeled "YES, Move to Production Status"
        Then I should see "Success! The project is now in production."

    Scenario: 53 - Enter Draft Mode and Verify Can Not Delete an Event
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Project Setup"
        And I click on the button labeled "Online Designer"
        Then I should see "Enter Draft Mode"
        When I click on the input button labeled "Enter Draft Mode"
        Then I should see "Data Collection Instruments"
        And I should see a link labeled "Form 1"
        And I should see a link labeled "Form 1 2"
        When I click on the link labeled "Project Setup"
        And I click on the button labeled "Define My Events"
        Then I should NOT see "[title=Delete]"

    Scenario: 54 - Add New Field and Submit Changes for Review
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Designer"
        Then I should see "Since this project is currently in PRODUCTION"
        When I click on the link labeled "Form 1"
        And I click on the element identified by "input[id=btn-last]"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" from the dropdown identified by "[name=field_type]"
        And I enter "Text2" into the field identified by "[id=field_label]"
        And I enter "text2" into the field identified by "[id=field_name]"
        And I click on the button labeled "Save"
        Then I should see "Variable: text2"
        When I click on the input button labeled "Submit Changes for Review"
        Then I should see "SUBMIT CHANGES FOR REVIEW?"
        When I click on the button labeled "Submit"
        Then I should see "Awaiting review of project changes"
        #this is not what shows

    Scenario: 55 - Login as admin1115

    Scenario: 56 - Remove Drafted Changes
        When I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Designer"
        And I click on the button labeled "Project Modification Module"
        Then I should see "Below is a listing of the changes to be committed to this project."
        When click on the button labeled "Remove All Drafted Changes"
        And I click on the element identified by "button:contains('Remove All Drafted Changes'):first"
        Then I should see "the project was reset back to before it entered Draft Mode"

    Scenario: 57 - Allow Users to Make Draft Mode Changes
        When I click on the link labeled "User Settings"
        And I select "Yes, if project has no records OR if has records and no critical issues exist" from the dropdown identified by "select[name=auto_prod_changes]"
        And I click on the input button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 58 - Login with test_user
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"

    Scenario: 59 - Add New Field and Submit Changes
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Designer"
        Then I should see "Since this project is currently in PRODUCTION"
        And I click on the input button labeled "Enter Draft Mode"
        And I click on the link labeled "Form 1"
        And I click on the element identified by "input[id=btn-last]"
        And I select "Text Box (Short Text, Number, Date/Time, ...)" from the dropdown identified by "[name=field_type]"
        And I enter "Text2" into the field identified by "[id=field_label]"
        And I enter "text2" into the field identified by "[id=field_name]"
        And I click on the button labeled "Save"
        Then I should see "Success! The changes were made automatically"


    Scenario: 60 - Verify Repeatable Instruments is Disabled
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"
        And I click on the link labeled "My Projects"
        And I click on the link labeled "FirstProject_1115"
        And I click on the link labeled "Designer"
        And I click on the input button labeled "Enter Draft Mode"
        Then I should see "Since this project is currently in PRODUCTION"
        When I click on the link labeled "Project Setup"
        Then I should see that repeatable instruments are "Enable"
        When I click on the button labeled "Define My Events"
        Then I should see "Events cannot be modified in production status"

    Scenario: 61 -
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"

    Scenario: 62 - Login as admin1115

    Scenario: 63 - Allow Normal Users to Modify the Repeatable Instruments & Events
        When I click on the link labeled "User Settings"
        And I select "Yes, normal users can modify the repeatable instance setup in production" from the dropdown identified by "select[name=enable_edit_prod_repeating_setup]"
        And I select "Yes, normal users can add/modify events in production" from the dropdown identified by "select[name=enable_edit_prod_events]"
        And I click on the input button labeled "Save Changes"
        Then I should see "Your system configuration values have now been changed!"

    Scenario: 64 - Login with test_user
        When I click on the link labeled "Log out"
        And I enter "test_user" into the field labeled "Username:"
        And I enter "Testing123" into the field labeled "Password:"
        And I click on the button labeled "Log In"

    Scenario: 65 -

    Scenario: 66 -

    Scenario: 67 -

    Scenario: 68 -

    Scenario: 69 -

    Scenario: 70 -

    Scenario: 71 -

    Scenario: 72 -

    Scenario: 73 -

    Scenario: 74 -

    Scenario: 75 -











