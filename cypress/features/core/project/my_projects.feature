Feature: My Projects

  As a REDCap end user
  I want to see that My Projects is functioning as expected

# We can add projects with the same name
# Scenario 11 - Not able to delete record 2. Link containing 2 does not point to Record 2 but points to Arm 2. 
# Hence added 2 records for Scenario 10. So Scenario 11 could work

  Scenario: Project Setup 1 - Create Project 13_MyProjects_v1115 and assign userrights to delete a record
    Given I am a "standard" user who logs into REDCap
    And I create a project named "13_MyProjects_v1115" with project purpose Operational Support via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
    Then I click on the link labeled "User Rights"
    And I click to edit username "test_user (Test User)"
    And I click on the button labeled "Edit user privileges"
    And I scroll the user rights page to the bottom
    And I check the User Right named 'Delete Records'
    And I click on the button labeled "Save Changes"

  Scenario: Project Setup 2 - Longitudinal Data Collection is enabled and Project is in development
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "13_MyProjects_v1115"
    And I should see "Development"
    And I click on the link labeled "Project Setup"
    And I should see that longitudinal mode is "enabled"

  Scenario: 1 - My Projects dashboard displays six columns
    Given I click on the link labeled "My Projects"
    Then I should see "Project Title"
    And I should see "Records"
    And I should see "Fields"
    And I should see "Instruments"
    And I should see "Type"
    And I should see "Status"

  Scenario: 2 - The number in Records column in the My Projects dashboard should match the no:of records in a project
    Given I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see 1 record in the Record Status Dashboard
    And I click on the link labeled "Arm 2:"
    Then I should see 0 records in the Record Status Dashboard
    And I click on the link labeled "My Projects"
    Then I should see "1" in column 2 next to the link "13_MyProjects_v1115"

  Scenario: 3 - The number in Fields column in the My Projects dashboard should match the sum of fields and instruments in a project
    Given I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Designer"
    Then I should see 2 instruments
    And The sum of field count of all the instruments should equal to 21
    And I click on the link labeled "My Projects"
    Then I should see "23" in column 3 next to the link "13_MyProjects_v1115"
    # No:of instruments + field count = 2+21=23. Which matches the Field Count in My Projects Dashboard
    
  Scenario: 4 - The number in Instruments column in the My Projects dashboard should match the no:of instruments in a project
    Given I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Designer"
    Then I should see 2 instruments
    And I click on the link labeled "My Projects"
    Then I should see "2" in column 4 next to the link "13_MyProjects_v1115"
   
  Scenario: 5 - Check if Longitudinal Data Collection is enabled in both the project and My Projects Dashboard
    Given I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Project Setup"
    Then I should see that longitudinal mode is "enabled"
    And I click on the link labeled "My Projects"
    Then I should see the icon "Longitudinal / repeating forms" in column 5 next to the link "13_MyProjects_v1115"
    
  Scenario: 6 - Disable Longitudinal Data Collection and ensure it reflects in the My Projects Dashboard
    Given I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Project Setup"
    And I disable longitudinal mode
    And I click on the link labeled "My Projects"
    Then I should see the icon "Classic" in column 5 next to the link "13_MyProjects_v1115"
   
  Scenario: 7 - Check if the Project is in Development mode in both the project and My Projects Dashboard
    Given I click on the link labeled "13_MyProjects_v1115"
    Then I should see "Development"
    And I click on the link labeled "My Projects"
    Then I should see the icon "Development" in column 6 next to the link "13_MyProjects_v1115"
    
  Scenario: 8 - Change the Project Title and ensure it reflects in the My Projects Dashboard
    Given I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Modify project title, purpose, etc."
    And I enter "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789Validation" into the field identified by "[id=app_title]"
    And I click on the button labeled "Save"
    Then I should see "13_MyProjects_v1115ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789Validation"
    And I click on the link labeled "My Projects"
    Then I should see "13_MyProjects_v1115ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789Validation"

  Scenario: 9 - Change the Project Title back and ensure it reflects in the My Projects Dashboard
    Given I click on the link labeled "13_MyProjects_v1115ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789Validation"
    Then I should see "13_MyProjects_v1115ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789Validation"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Modify project title, purpose, etc."
    And I clear the field identified by "[id=app_title]"
    And I enter "13_MyProjects_v1115" into the field identified by "[id=app_title]"
    And I click on the button labeled "Save"
    Then I should see "13_MyProjects_v1115"
    And I click on the link labeled "My Projects"
    Then I should see "13_MyProjects_v1115"

  Scenario: 10 - Add a new record and ensure it reflects in the My Projects Dashboard
    Given I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    Then I click on the image "circle_gray" link for the row containing "Text Validation"
    And I enter "John" into the field identified by "input[name=ptname_v2_v2]"
    And I enter "John@gmail.com" into the field identified by "input[name=email_v2]"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "successfully added"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see 2 records in the Record Status Dashboard
    And I click on the link labeled "My Projects"
    Then I should see "2" in column 2 next to the link "13_MyProjects_v1115"

  # Not able to delete record 2. Link containing 2 does not point to Record 2 but points to Arm 2. 
  # Hence added 2 records for Scenario 10. So Scenario 11 could work
  Scenario: 10 Duplicate - Add a new record and ensure it reflects in the My Projects Dashboard
    Given I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    Then I click on the image "circle_gray" link for the row containing "Text Validation"
    And I enter "JohnDup" into the field identified by "input[name=ptname_v2_v2]"
    And I enter "JohnDup@gmail.com" into the field identified by "input[name=email_v2]"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "successfully added"
    And I click on the link labeled "Record Status Dashboard"
    Then I should see 3 records in the Record Status Dashboard
    And I click on the link labeled "My Projects"
    Then I should see "3" in column 2 next to the link "13_MyProjects_v1115"

  Scenario: 11 - Delete the last record and ensure it reflects in the My Projects Dashboard
    Given I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Record Status Dashboard"
    And I click on the link labeled "3"
    And I click on the button labeled "Choose action for record"
    And I click on the link labeled "Delete record"
    And I click on the button labeled "DELETE RECORD"
    Then I should see 'Record ID "3" was successfully deleted.'
    And I close the popup
    And I click on the link labeled "Record Status Dashboard"
    Then I should see 2 records in the Record Status Dashboard
    And I click on the link labeled "My Projects"
    Then I should see "2" in column 2 next to the link "13_MyProjects_v1115"

  Scenario: 12 - Add a field and ensure it reflects in the My Projects Dashboard
    Given I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Designer"
    And I click on the table cell containing a link labeled "Text Validation"
    And I click on the Add Field input button below the field named "Email"
    And I select "textarea" from the dropdown identified by "select[name=field_type]"
    And I enter "Notes Box" into the field identified by "textarea[name=field_label]"
    And I enter "notesbox1" into the field identified by "input[name=field_name]"
    And the AJAX "GET" request at "Design/online_designer_render_fields.php*" tagged by "render" is being monitored
    And I click on the button labeled "Save"
    And the AJAX request tagged by "render" has completed
    Then I should see "notesbox1"
    And I should see the element identified by "textarea[id=notesbox1]"
    And I click on the link labeled "Designer"
    Then I should see 2 instruments
    And The sum of field count of all the instruments should equal to 22
    And I click on the link labeled "My Projects"
    Then I should see "24" in column 3 next to the link "13_MyProjects_v1115"
    # No:of instruments + field count = 2+22=24. Which matches the Field Count in My Projects Dashboard

  Scenario: 13 - Delete a field and ensure it reflects in the My Projects Dashboard
    Given I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Designer"
    And I click on the table cell containing a link labeled "Text Validation"
    And the AJAX "GET" request at "Design/delete_field.php?*" tagged by "delete" is being monitored
    And the AJAX "GET" request at "Design/online_designer_render_fields.php*" tagged by "render" is being monitored
    And I delete the field named "notesbox1"
    And the AJAX request tagged by "delete" has completed
    And the AJAX request tagged by "render" has completed
    Then I should NOT see "notesbox1"
    And I click on the link labeled "Designer"
    Then I should see 2 instruments
    And The sum of field count of all the instruments should equal to 21
    And I click on the link labeled "My Projects"
    Then I should see "23" in column 3 next to the link "13_MyProjects_v1115"
    # No:of instruments + field count = 2+21=23. Which matches the Field Count in My Projects Dashboard

  Scenario: 14 - Add an instrument and ensure it reflects in the My Projects Dashboard
    Given I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Designer"
    And I click on the button labeled exactly "Create"
    Then I should see a button labeled "Add instrument here"
    And I add an instrument below the instrument named "Data Types"
    And I enter "Test" into the field identified by "input[id=new_form-data_types]"
    And I click on the element identified by "input[value=Create]"
    Then I should see "Test"
    And I should see 3 instruments
    And I click on the link labeled "My Projects"
    Then I should see "3" in column 4 next to the link "13_MyProjects_v1115"
  
  Scenario: 15 - Delete an instrument and ensure it reflects in the My Projects Dashboard
    Given I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Designer"
    And I click on the Instrument Action "Delete" for the instrument named "Test"
    And the AJAX "GET" request at "/Design/delete_form.php*" tagged by "Delete" is being monitored
    And I click on the button labeled "Yes, delete it"
    And the AJAX request tagged by "Delete" has completed
    Then I should see "Deleted!"
    And I should see "The data collection instrument and all its fields have been successfully deleted!"
    Then I should no longer see the element identified by "tr[id=row_3]"
    And I should see 2 instruments
    And I click on the link labeled "My Projects"
    Then I should see "2" in column 4 next to the link "13_MyProjects_v1115"

  # Manual testing document does not say to login as admin while moving to Production
  Scenario: 16 - Move to Production and mark Project as complete and ensure the project no longer appears on the My Projects Dashboard
    Given I am an "admin" user who logs into REDCap
    And  I click on the link labeled "Control Center"
    And  I click on the link labeled "Browse Projects"
    And I enter "13_MyProjects_v1115" into the field identified by "input[id=project_search]"
    And I click on the button labeled "Search project title"
    Then I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far." in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Success! The project is now in production."
    Then I logout
    When I am an "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "13_MyProjects_v1115"
    Then I should see "13_MyProjects_v1115"
    And I click on the link labeled "Other Functionality"
    And I click on the button labeled "Mark project as Completed"
    And I confirm to mark project as complete
    Then I should see "The project has now been marked as COMPLETED" in an alert box
    # Added wait due to DOM detachment error
    And I wait for 3 seconds
    Then I should see "My Projects"
    And I click on the link labeled "My Projects"
    Then I should NOT see "13_MyProjects_v1115"
    
  Scenario: 17 - Project is displayed in Completed list
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Show Completed Projects"
    Then I should see "13_MyProjects_v1115"
    And I should see the icon "Completed" in column 6 next to the link "13_MyProjects_v1115"

  Scenario: 18 - Hide the Completed list and the project is no longer displayed
    Given I click on the link labeled "Hide Completed Projects"
    Then I should NOT see "13_MyProjects_v1115"

  Scenario: 19 - Project is restored back to production and ensure it reflects in the My Projects Dashboard
    Given I am an "admin" user who logs into REDCap
    And  I click on the link labeled "Control Center"
    And  I click on the link labeled "Browse Projects"
    And I enter "13_MyProjects_v1115" into the field identified by "input[id=project_search]"
    And I click on the button labeled "Search project title"
    Then I click on the link labeled "13_MyProjects_v1115"
    Then I should see "Please note that this project has been marked as 'Completed' and is no longer accessible."
    And the AJAX "POST" request at "ProjectGeneral/change_project_status.php*" tagged by "render" is being monitored
    And I click on the button labeled "Restore Project"
    And the AJAX request tagged by "render" has completed
    Then I should see "The project has now been restored. The page will now reload to reflect the changes"
    And I close the popup
    When I am an "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    Then I should see "13_MyProjects_v1115"
    And I should see the icon "Production" in column 6 next to the link "13_MyProjects_v1115"
    
  Scenario: 20 - Move the project to Analysis/Cleanup and ensure it reflects in the My Projects Dashboard
    Given I click on the link labeled "13_MyProjects_v1115"
    And I click on the link labeled "Other Functionality"
    And I click on the button labeled "Move to Analysis/Cleanup status"
    Then I should see "Do you wish to set the status of the project to ANALYSIS/CLEANUP?"
    And I click on the button labeled "YES, Move to Analysis/Cleanup Status" 
    Then I should see "The project has now been set to ANALYSIS/CLEANUP status." in an alert box
    And I scroll the page to the field identified by "button[id=modify-data-locked]"
    And I click on the link labeled "My Projects"
    Then I should see "13_MyProjects_v1115"
    And I should see the icon "Analysis/Cleanup" in column 6 next to the link "13_MyProjects_v1115"

  Scenario: 21 - Move the project to back to Production and ensure it reflects in the My Projects Dashboard
    Given I click on the link labeled "13_MyProjects_v1115"
    Then I should see "Analysis/Cleanup"
    And I click on the link labeled "Other Functionality"
    And I click on the button labeled "Move back to Production status"
    And the AJAX "POST" request at "ProjectGeneral/change_project_status.php*" tagged by "render" is being monitored
    And I click on the button labeled "YES, Move to Production Status" 
    And the AJAX request tagged by "render" has completed
    Then I should see "The project has now been moved back to PRODUCTION status." in an alert box
    When I am an "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    Then I should see "13_MyProjects_v1115"
    And I should see the icon "Production" in column 6 next to the link "13_MyProjects_v1115"
    
  Scenario: 22 - Filter Projects by title
    Given I am an "admin" user who logs into REDCap
    And  I click on the link labeled "Control Center"
    And  I click on the link labeled "Browse Projects"
    And I enter "Project" into the field identified by "input[id=project_search]"
    And I click on the button labeled "Search project title"
    Then I should see all the projects containing "Project"
    
    
  