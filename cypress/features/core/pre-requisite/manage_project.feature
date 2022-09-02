Feature: Manage Project

  As a REDCap end user
  I want to see that Manage Project is functioning as expected

Background: 
    Given I am an "admin" user who logs into REDCap
    And I visit the "Control Center" page

Scenario: 2- User Settings Configuration - Create Projects 
    When I click on the link labeled "User Settings"
    And I select "Yes, normal users can create new projects" from the dropdown identified by "select[name=superusers_only_create_project]"
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
    And I enter "tets_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    Then I should see a link labeled "New Project"

Scenario: 11- Cancel Create Project Request
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the button labeled "Send Request"
    And I click on the input button labeled "Cancel"
    Then I should see "input"
        #Project not requested.

Scenario: 12- Logout as test_user

Scenario: 13- Allow Normal Users to Create New Projects
    When I click on the link labeled "User Settings"
    Then I should see "Settings related to Project Creation and Project Status Changes"
    And I select "Yes, normal users can create new projects" from the dropdown identified by "select[name=superusers_only_create_project]"
    And I click on the input button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

Scenario: 14- Login with test_user
    When I click on the link labeled "Log out"
    And I enter "tets_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    
Scenario: 15- Create Project and add admin1115 to Project
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "New Project"
    And I enter "FirstProject_1115" into the field labeled "Project title:"
    And I select "Operational Support" from the dropdown identified by "Project's purpose:"
    And I click on the button labeled "Create Project"
    Then I should see "input"
        #Message box confirms new project created. 
    When I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "User Rights"
    And I enter "admin1115" into the field identified by "input"
        #Add admin1115 to the project
    And I should see "input"
        #User successfully added

Scenario: 16- Change Project to Just for Fun
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Modify project title, purpose, etc."
    Then I should see "Modify Project Settings"
    When I select "Practice/Just for fun" from the dropdown identified by "Project's purpose:"
    And I click on the link labeled "Save"
    Then I should see "Success! Your changes have been saved."

Scenario: 17- Open and Add First Instrument
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "Designer"
    Then I should see "Data Collection Instruments"
    When I click on the link labeled "My First Instrument"
    Then I should see "Record ID"
        #add inspect link
    And I click on the button labeled "Add Field"
    And I select "COPY PASTE HERE" from the dropdown identified by "Field Type:"
        #"Text Box ( ..."
    And I enter "Name" into the field labeled "Field Label"
    And I enter "ptname" into the field labeled "Variable Name"
    And I click on the button labeled "Save"
    Then I should see "input" 
        #Add something here 

Scenario: 18- Copy Instrument
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "Designer"
    Then I should see "Data Collection Instruments"
    When I select "Copy" from the dropdown identified by "input"
        #find this later 
    And I enter "My First Instrument 2" into the field labeled "New instrument name:"
        #this should actually be a "I should see"
    And I click on the button labeled "Copy instrument"
    Then I should see "SUCCESS! The instrument was successfully copied. The page will now reload to reflect the changes."

Scenario: 19- Add Email Field to My First Instrument 2
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "Designer"
    And I click on the link labeled "My First Instrument 2"
    Then I should see "Current instrument: My First Instrument 2"
    When I click on the button labeled "Add Field"
    And I select "COPY PASTE HERE" from the dropdown identified by "Field Type:"
        #"Text Box ( ..."
    And I enter "Email" into the field labeled "Field Label"
    And I enter "email" into the field labeled "Variable Name"
    And I select "Email" from the dropdown identified by "Validation?"
    And I click on the button labeled "Save"
    Then I should see "input" 
        #Add something here 

Scenario: 20- Verify Project Home and Other Functionality Pages
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "Project Home"
    Then I should see "The tables below provide general dashboard information, such as a list of all users with access to this project, general project statistics, and upcoming calendar events (if any)."
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
    When I enter "ProjectCopy_1115" into the field labeled "Project title:"
    And I click on the link labeled "Select All"
    And I click on the button labeled "Copy project"
    #confirm
    And I should see "input"
        #and i should see "confirmation message"
        #Verify 1
        #Verify 2
        #Verify 3

Scenario: 22 - Cancel Move Project to Production
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "ProjectCopy_1115"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the element identified by "BUBBLE HERE"
        #bubble identifyer for Keep all data 
    Then I should see "input"
        #The Request Admin to Move to Production Status button is available.
    When I click on the button labeled "Cancel"
    Then I should see "input"
        #Project is not moved to production.

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
    Then I should see "input"
        #button identifyer for "YES, Move to Production Status"
    When I click on the element identified by "BUBBLE HERE"
        #bubble identifyer for Keep all data 
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
    Then I should NOT see "input"
        #Delete project option is not available. User cannot delete production project. 
    And I should see "input"
        #Rather, the Request delete project is available.
    And I should NOT see "input"
        #The Erase all data button is not visible.

Scenario: 28 - Login as admin1115

Scenario: 29 - Admin Other Functionality Tab Options Visibility
    When I click on the link labeled "My Projects"
    And I click on the link labeled "ProjectCopy_1115"
    And I click on the link labeled "Other Functionality"
    Then I should see "input"
        #verify the Delete the project 
    And I should see "input"
        #Erase all data buttons are present.
    When I click on the button labeled "Delete the Project"
    Then I should see "input"
        #Permanently delete this project confirmation page displays.
    When I click on the button labeled "Cancel"
    Then I should see "input"
        #Project is not deleted

Scenario: 30 - Delete Project ProjectCopy_1115
    When I click on the link labeled "My Projects"
    And I click on the link labeled "ProjectCopy_1115"
    And I click on the link labeled "Other Functionality"
    When I click on the button labeled "Delete the Project"
    And I enter "DELETE" into the field identified by "input"
        #Complete the required “delete” field 
    And I click on the button labeled "Delete the project"
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
    Then I should see "input"
        #The Enable button appears next to the red dash circle for ‘Use longitudinal data collection…’
    When I click on the button labeled "input"
        #Enable ‘Use longitudinal data collection…’
    Then I should see "input"
        #Disable button appears next to the green checkmark circle for ‘Use longitudinal…’
    When I click on the button labeled "input"
        #Disable ‘Use longitudinal data collection…’
    Then I should not see "input"
        #The Enable button appears next to the red dash circle for ‘Use longitudinal data collection…’
    When I click on the button labeled "input"
        #Enable ‘Use longitudinal data collection…’
    Then I should see "input"
        #Disable button appears next to the green checkmark circle for ‘Use longitudinal…’

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
    When I enter "Event 2" into the field labeled "Event Name"
        #"Event Name" might not work there 
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
    And I enter "Arm 2" into the field identified by "Arm name:"
    And I click on the button labeled "Save"
    Then I should see "No events have been defined for this Arm"
    When I enter "Event 1" into the field labeled "Event Name"
        #"Event Name" might not work there 
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
    And I click on the button labeled "Begin Editing"
    And I click on the checkbox identified by "input"
        #Checkbox for Event 1 - My First Instrument
    And I click on the checkbox identified by "input"
        #Checkbox for Event 1 - My First Instrument 2
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
    And I click on the link labeled "Arm 2: Arm 2"
    And I click on the button labeled "Begin Editing"
    And I click on the checkbox identified by "input"
        #Checkbox for Event 1 - My First Instrument
    And I click on the button labeled "Save"

Scenario: 37 - Enable Repeatable Instruments and Events
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "Project Setup"
    Then I should see "input"
        #The Enable button appears next to the red dash circle for ‘Repeatable instruments and events’
    When I click on the button labeled "input"
        #Enable ‘Repeatable instruments and events’
    Then I should see "use repeatable instruments and/or repeatable events"
    When I select "Repeat Instruments" from the dropdown identified by "input"
        #In the dropdown for Event 1 Arm 1, select ‘Repeat Instruments’ 
    And I click on the checkbox identified by "input"
        #Mark the checkbox next to My First Instrument 2
    And I select "Repeat Entire Event" from the dropdown identified by "input"
        #In the dropdown for Event 1 Arm 2, select ‘Repeat Entire Event’
    And I click on the button labeled "Save"
    Then I should see "Your settings…have been successfully saved!"
        #something like that
    And I should see "input"
        #Modify button appears next to the green checkmark circle for ‘Repeatable instruments …’

Scenario: 38 - Diasble / Inable Surveys
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "Project Setup"
    Then I should see "input"
        #The Enable button appears next to the red dash circle for ‘Use surveys in this project.’
    When I click on the button labeled "input"
        #Enable surveys in the project
    Then I should see "input"
        #Disable button appears next to the green checkmark circle for ‘Use surveys…’ 
    When I click on the button labeled "input"
        #Disable surveys in the project
    Then I should see "input"
        #The Enable button appears next to the red dash circle for ‘Use surveys in this project.
    When I click on the button labeled "input"
        #Enable surveys in the project
    Then I should see "input"
        #Disable button appears next to the green checkmark circle for ‘Use surveys…’ 

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
    And I should not see "input"
        #The Enable button appears in the Enabled a survey column for all instruments.
    And I should see "input"
        #The Enable button appears in the Enabled a survey column for all instruments.
    When I click on the button labeled "input"
        #Enable My First instrument
    Then I should see "Set up my survey for data collection instrument"
    When I click on the button labeled "Save Changes"
    Then I should see "Your survey settings were successfully saved!"
        #or something like it 
    And I should see "input"
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
    And I click on the button labeled "Survey Settings"
    Then I should see "Modify survey settings for data collection instrument"
    When I click on the button labeled "Delete Survey Settings"
    And I click on the button labeled "Delete Survey Settings"
    Then I should see "Survey successfully deleted!"
    When I click on the button labeled "Close"
    Then I should see "input"
        #Enable button is visible

Scenario: 41 - Enable Survey for My First Instrument
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Online Designer"
    And I click on the button labeled "input"
        #Enable My First instrument
    And I click on the button labeled "Save Changes"
    Then I should see "Your survey settings were successfully saved!"
        #or something like it 
    And I should see "input"
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
    And I click on the button labeled "Survey Settings"
    And I select "Survey Offline" from the dropdown identified by "Survey Status" 
    And I click on the button labeled "Save Changes"
    Then I should see "Survey settings successful!"
    And I should see "input"
        #Survey symbol is visible

Scenario: 43 - Change Survey Status to Active
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Online Designer"
    And I click on the button labeled "Survey Settings"
    And I select "Survey Active" from the dropdown identified by "Survey Status" 
    And I click on the button labeled "Save Changes"
    Then I should see "Survey settings successful!"

Scenario: 44 - Open and Submit Public Survey
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "Survey Distribution Tools"
    Then I should see "Using a public survey link is the simplest and fastest way to collect responses for your survey"
    When I click on the link labeled "Open public survey"
        #This will open a new page - probably wont run, but maybe

        #so come back to this one 



Scenario: 45 - Verify Survey Responses are Read Only
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "Add / Edit Records"
    Then I should see "You may view an existing record/response by selecting it from the drop-down lists below."
    And I click on the link labeled "input"
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
        #The Editing existing user page displays - does not exist? 




Scenario: 50 - Verify Survey Responses are Visible and Editable
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "Add / Edit Records"
    And I select "input" from the dropdown identified by "input"
        #choose the existing record

        #Open My First Instrument with the green checkmark ?



Scenario: 51 - Enable the Designate an email field…
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "Project Setup"
    Then I should see "input"
        #The Enable button appears next to the red dash circle for ‘Designate an email field…’
    When I click on the button labeled "input"
        #Enable the ‘Designate an email field…’
    Then I should see "Choose an email field to use for invitations to survey participants:"
    When I select "input" from the dropdown identified by "input"
        #Choose [email] field
    And I click on the button labeled "Save"
    Then I should see "input"
        #Disable button appears next to the green checkmark circle for ‘Designate an email field…’

Scenario: 52 - Move FirstProject_1115 to Production
    When I click on the link labeled "Log out"
    And I enter "test_user" into the field labeled "Username:"
    And I enter "Testing123" into the field labeled "Password:" 
    And I click on the button labeled "Log In"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"

        #so come back to this one 


Scenario: 53 - 

Scenario: 54 - 

Scenario: 55 - Login as admin1115

Scenario: 56 - 

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

Scenario: 59 - 

Scenario: 60 - 

Scenario: 61 - 

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












