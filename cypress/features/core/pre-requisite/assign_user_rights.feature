Feature: Assign User Rights

  As a REDCap end user, I want to see that:
  - The system allows the ability to add, edit or delete the following core user privileges:
  --- 2. Expiration Date
  --- 3. Project Design and Setup
  --- 4. User Rights
  --- 6. Data Access Groups
  --- 7. Data Export Tool
  --- 8. Add/Edit Records
  --- 9. Survey Distribution Tools
  --- 10. Data Import Tool
  --- 11. Data Comparison Tool
  - The system allows data entry form user access to be:
  --- 

  # Notes:
  # - Manual script says to verify that green check or red X appears after adding/removing rights, but
  #   this is not currently done. A step definition for this could be implemented relatively easily,
  #   but I've opted to skip it for now, until a determination that it is necessary is made. A similar
  #   type of assertion is skipped for expiration dates, where "never" is expected to appear in the table.

  Scenario: Project Setup - 1
    Given I am an "admin" user who logs into REDCap
    And I create a project named "AssignUserRightsProject" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
    
  Scenario: Project Setup - 2
    When I enable surveys
    When I disable longitudinal mode
    And I click on the button labeled "Additional customizations"
    And I check the checkbox labeled "Enable the Field Comment Log or Data Resolution Workflow (Data Queries)?"
    And I click on the button labeled "Save"
    Then I should see "Success! Your changes have been saved."
    # Manual script says there should be one record with one instrument that is a survey,
    # but there are no instruments or records.

  Scenario: 1 - Add test_user to AssignUserRightsProject project
    When I click on the link labeled "My Projects"
    And I click on the link labeled "AssignUserRightsProject"
    And I click on the link labeled "User Rights"
    And I enter "test_user" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    Then I should see a dialog containing the following text: "Editing existing user"
    And I remove all Basic Rights within the open User Rights dialog box
    # Script has expected result: "Data Entry rights remain".
    # Consider adding an assertion here.
    Then I save changes within the context of User Rights

    When I click on the link labeled "My Projects"
    Then I should see "Listed below are the REDCap projects"

    Given I logout
    Then I should see "Please log in"

    And I am a "standard" user who logs into REDCap
    Then I should see "Logged in as"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "AssignUserRightsProject"
    Then I should see a link labeled "Project Home"
    And I should see a link labeled "Codebook"
    And I should see a link labeled "Record Status Dashboard"
    And I should see a link labeled "View / Edit Records"
    And I should see "Applications"
    Given I logout

  Scenario: 2 - Add expiration data for test_user
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "AssignUserRightsProject"
    And I click on the link labeled "User Rights"
    And I assign an expired expiration date to user "Test User" with username of "test_user"
    # ^ Current implementation of this step makes preceding steps redundant,
    # but I've kept them in case this one changes, to maintain congruence with the manual script

    Given I logout
    And I am a "standard" user who logs into REDCap
    When I click on the link labeled "My Projects"
    And I click on the link labeled "AssignUserRightsProject"
    Then I should see "Your access to this particular REDCap project has expired."
    Given I logout

  Scenario: 3-4 - Assign Project Design and Setup & User Rights to test_user
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "AssignUserRightsProject"
    And I click on the link labeled "User Rights"
    And I remove the expiration date to user "Test User" with username of "test_user"
    # Then I should NOT see "10/31/2022"
    # Manual script expected result (unasserted):
    #   The Expiration column shows 'never' for test_user

    When I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    Then I should see a dialog containing the following text: "Editing existing user"
    When I check the User Right named "Project Setup & Design"
    And I check the User Right named "User Rights"
    And I save changes within the context of User Rights
    # Manual script expected result (unasserted):
    #   Verify in the main User Rights page, the User Rights contains a green check for user test_user.

  Scenario: 5 - Verify User Rights Links Visibility 
    Given I logout
    And I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "AssignUserRightsProject"
    Then I should see a link labeled "Project Setup"
    And I should see a link labeled "Designer"
    And I should see a link labeled "Dictionary"
    And I should see a link labeled "User Rights"

  Scenario: 6 - Assign Data Access Groups to test_user
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Data Access Groups"
    And I save changes within the context of User Rights
    And I click on the link labeled "User Rights"
    Then I should see a link labeled "DAGs"

  Scenario: 7 - Assign Data Exports - De-identified to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I select the Data Exports privileges option labeled "De-Identified*"
    And I save changes within the context of User Rights
    # Manual script expected result (unasserted):
    #   Verify in the main User Rights page the ‘Data Export Tool’ box says De-identified for user test_user.
    And I click on the link labeled "User Rights"
    Then I should see a link labeled "Data Exports, Reports, and Stats"

  Scenario: 8 - Assign Add/Edit/Organize Reports to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Add/Edit/Organize Reports"
    And I save changes within the context of User Rights
    # Manual script expected result (unasserted):
    #   Verify in the main User Rights page, Reports & Report Builder box contains a green check for user test_user.
    #   - Verified by proxy of "Reports" link appearing, see next 2 steps
    And I click on the link labeled "User Rights"
    Then I should see a link labeled "Reports"

  Scenario: 9 - Assign Survey Distribution Tools to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Survey Distribution Tools"
    And I save changes within the context of User Rights
    # Manual script expected result (unasserted): similar to above
    And I click on the link labeled "User Rights"
    Then I should see a link labeled "Survey Distribution Tools"

  Scenario: 10 - Assign Data Import Tool to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Data Import Tool"
    And I save changes within the context of User Rights
    And I click on the link labeled "User Rights"
    Then I should see a link labeled "Data Import Tool"

  Scenario: 11 - Assign Data Comparison Tool to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Data Comparison Tool"
    And I save changes within the context of User Rights
    And I click on the link labeled "User Rights"
    Then I should see a link labeled "Data Comparison Tool"

  Scenario: 12 - Remove Data Exports, Data Import, and Data Comparison User Rights 
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I select the Data Exports privileges option labeled "No Access"
    And I uncheck the User Right named "Data Import Tool"
    And I uncheck the User Right named "Data Comparison Tool"
    And I check the User Right named "Logging"
    And I save changes within the context of User Rights
    And I click on the link labeled "User Rights"

    Then I should NOT see a link labeled "Data Import Tool"
    And I should NOT see a link labeled "Data Comparison Tool"
    # Manual script has expected result "Data Export application is no longer available
    # in the left sidebar", but the "Data Exports, Reports, and Stats" remains, which is normal.
    # This can probably be chalked up to the script being outdated, and no action is needed
    And I should see a link labeled "Logging"
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should NOT see "Other Export Options"

  Scenario: 13 - Assign Data Quality - create/edit rules to test_user
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"  
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Data Quality - Create & edit rules"
    And I save changes within the context of User Rights
    
    When I click on the link labeled "User Rights"
    Then I should see a link labeled "Data Quality"

  Scenario: 14 - Assign Data Quality - Execute rules to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Data Quality - Execute rules"
    And I save changes within the context of User Rights

    When I click on the link labeled "Data Quality"
    Then I should see "Execute rules"

  Scenario: 15 - Assign Create Records to test_user
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Create Records"
    And I save changes within the context of User Rights

    When I click on the link labeled "View / Edit Records"
    Then I should see a button labeled "Add new record"

  Scenario: 16 - Remove Create records
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I uncheck the User Right named "Create Records"
    And I save changes within the context of User Rights

    When I click on the link labeled "Add / Edit Records"
    Then I should NOT see a button labeled "Add new record"

  Scenario: 17 - Assign Rename Records to test_user
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Rename Records"
    And I save changes within the context of User Rights
    # Verify green check appears

  Scenario: 18 - Assign Delete Records to test_user
    # Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    Then I should see a dialog containing the following text: "Editing existing user"
    And I check the User Right named "Delete Records"
    And I save changes within the context of User Rights
    # Verify green check appears

  Scenario: 19 - Assign Record Locking Customization to test_user
    # Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    Then I should see a dialog containing the following text: "Editing existing user"
    And I check the User Right named "Record Locking Customization"
    And I save changes within the context of User Rights

    When I click on the link labeled "User Rights"
    Then I should see a link labeled "Customize & Manage Locking/E-signatures"
    # User Rights table should show a green check

  Scenario: 20 - Assign Lock/Unlock Records - Locking / Unlocking with E-signature authority to test_user
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "AssignUserRightsProject"
    And I click on the link labeled "User Rights"

    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    Then I should see a dialog containing the following text: "Editing existing user"
    And I select the User Right named "Lock/Unlock Records" and choose "Disabled"
    And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking with E-signature authority"
    Then I should see "Please note that giving a user 'Locking / Unlocking with E-signature authority' privileges"
    
    When I click on the button labeled "Close" in the dialog box
    And I save changes within the context of User Rights
    # User Rights table should show green shield

  Scenario: 21 - Assign Lock/Unlock Records - Locking / Unlocking to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    Then I should see a dialog containing the following text: "Editing existing user"
    And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking"

    When I save changes within the context of User Rights
    # User Rights table should show green check

  Scenario: 22 - Assign Lock/Unlock *Entire* Records (record level) to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    Then I should see a dialog containing the following text: "Editing existing user"
    And I check the User Right named "Lock/Unlock *Entire* Records"
    
    When I save changes within the context of User Rights
    # User Rights table should still show a green check for Record Locking Customization

  Scenario: 23 - Assign Data Entry - No Access to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    Then I should see a dialog containing the following text: "Editing existing user"
    And I set Data Viewing Rights to No Access for the instrument "Text Validation"
    And I set Data Viewing Rights to No Access for the instrument "Data Types"
    And I save changes within the context of User Rights

    And I click on the link labeled "View / Edit Records"
    And I select "1" on the dropdown table field labeled "Choose an existing Record ID"
    Then I should NOT see "Text Validation"
    And I should NOT see "Data Types"

  Scenario: 24 - Assign Data Entry - Read Only to test_user
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I set Data Viewing Rights to Read Only for the instrument "Text Validation"
    And I set Data Viewing Rights to Read Only for the instrument "Data Types"

# Scenario: before step 26
#     Given I logout
#     And I am an "admin" user who logs into REDCap
#     And I click on the link labeled "My Projects"
#     And I click on the link labeled "AssignUserRightsProject"
#     When I click on the link labeled "Designer"
#     And I click on the element identified by "button:contains('Enable'):first"
#     And I click on the button labeled "Save Changes"
#     Then I should see "Your survey settings were successfully saved!"

# #new record - didnt fix issue 
#     Given I visit the version URL "DataEntry/index.php?pid=14&id=2&event_id=41&page=data_types&auto=1"
#     And I click on the button labeled "Save & Exit Form"
   
   
#     Given I logout
#     And I am a "standard" user who logs into REDCap

# #trying to see if this runs 
#   Scenario: 23 - Assign No Access to test_user
#     Given I grant No Access level of Data Entry Rights on the "Text Validation" instrument for the username "test_user" for project ID 14
#     And I grant No Access level of Data Entry Rights on the "Data Types" instrument for the username "test_user" for project ID 14
#     And I click on the link labeled "View / Edit Records"
#     And I select "1" from the dropdown identified by "[id=record]"
#     Then I should see "Record Home Page"
#     And I should NOT see "Text Validation"

#   Scenario: 24 - Assign Read Only to test_user
#     Given I grant Read Only level of Data Entry Rights on the "Text Validation" instrument for the username "test_user" for project ID 14
#     And I grant Read Only level of Data Entry Rights on the "Data Types" instrument for the username "test_user" for project ID 14
#     And I click on the link labeled "User Rights"
#     When I click on the link labeled "Record Status Dashboard"
#     When I click on the bubble for the "Text Validation" data collection instrument instrument for record ID "1"
#     Then I should see "Text Validation"
#     And I should NOT see "Save & Exit Form"

#   Scenario: 25 - Assign View and Edit to test_user
#     Given I grant View & Edit level of Data Entry Rights on the "Text Validation" instrument for the username "test_user" for project ID 14
#     And I grant View & Edit level of Data Entry Rights on the "Data Types" instrument for the username "test_user" for project ID 14
#     And I click on the link labeled "User Rights"
#     When I click on the link labeled "Record Status Dashboard"
#     When I click on the bubble for the "Text Validation" data collection instrument instrument for record ID "1"
#     Then I should see "Text Validation"
#     And I should see a button labeled "Save & Exit Form"
#     When I click on the link labeled "Record Status Dashboard"
#     #Given I am a "standard" user who logs into REDCap
#     And I click on the bubble for the "Data Types" data collection instrument instrument for record ID "2"
#     Then I should see "Data Types"
#     #read only^ - this is the survey an you can still edit it 

#   Scenario: 26 - Assign Edit Survey Responses to test_user
#     Given I click on the link labeled "User Rights"
#     And I click on the link labeled "test_user"
#     #And I should see "Edit user privileges"
#     And I click on the element identified by "[id=tooltipBtnSetCustom]"
#     Then I should see "Editing existing user"
#     And I click on the checkbox identified by "[id=form-editresp-text_validation]"
#     And I click on the button labeled "Save Changes"
#     And I click on the link labeled "User Rights"
#     When I click on the link labeled "Record Status Dashboard"
#     When I click on the bubble for the "Data Types" data collection instrument instrument for record ID "1"
#     Then I should see "Data Types"
#     And I should see a button labeled "Save & Exit Form"

#   Scenario: 27 - Create Data Entry Role
#     When I click on the link labeled "User Rights"
#     And I enter "Data Entry" into the field identified by "[id=new_rolename]"
#     And I click on the button labeled "Create role"
#     Then I should see "Creating new role"
#     And I click on the element identified by "button:contains('Create role'):last"
#     Then I should see a link labeled "Data Entry"

#   Scenario: 28 - Copy Data Entry Role
#     Given I click on the element identified by "[id=rightsTableUserLinkId_1]"
#     Then I should see "Editing existing user role"
#     When I click on the button labeled "Copy role"
#     And I clear the field labeled "New role name:"
#     And I enter "Reviewer" into the field identified by "[id=role_name_copy]"
#     And I click on the element identified by "button:contains('Copy role'):last"
#     Then I should see "was successfully added"
#     #When I click on the button labeled "Save Changes"
#     When I click on the link labeled "User Rights"
#     And I should see a link labeled "Data Entry"
#     And I should see a link labeled "Reviewer"

#   Scenario: 29 - Cancel Delete Reviewer Role
#     Given I click on the link labeled "Reviewer"
#     Then I should see "Editing existing user role"
#     When I click on the button labeled "Delete role"
#     Then I should see "Delete role?"
#     When I click on the element identified by "button:contains('Cancel'):last"
#     #When I click on the button labeled "Cancel"
#     And I click on the button labeled "Close"
#       #Might not work - is the x button 
#     Then I should see a link labeled "Reviewer"

#   Scenario: 30 - Delete Reviewer Role 
#     Given I click on the link labeled "Reviewer"
#     Given I click on the element identified by "[id=rightsTableUserLinkId_2]"
#     Then I should see "Editing existing user role"
#     When I click on the button labeled "Delete role"
#     Then I should see "Delete role?"
#     When I click on the element identified by "button:contains('Delete role'):last"
#     Then I should see "was successfully deleted"
#     #Given I delete role name "Reviewer"
    
#     And I want to pause

#     And I click on the link labeled "User Rights"
#     And I should NOT see "Reviewer"

#   Scenario: 31 - Assign test_user to Data Entry
#     When I enter "test_user" into the field identified by "[id=new_username_assign]"
#     And I click on the button labeled "Assign to role"
#     And I select "Data Entry" from the dropdown identified by "[id=user_role]"
#     And I click on the element identified by "[id=assignDagRoleBtn]"
#     Then I should see "NOTICE: User Rights mismatch"
#     Given I logout

#   Scenario: 32 - Assign test_user to Data Entry 
#     Given I am an "admin" user who logs into REDCap
#     And I click on the link labeled "My Projects"
#     And I click on the link labeled "AssignUserRightsProject"
#     And I click on the link labeled "User Rights"
#     When I enter "test_user" into the field identified by "[id=new_username_assign]"
#     And I click on the button labeled "Assign to role"
#     And I select "Data Entry" from the dropdown identified by "[id=user_role]"
#     And I click on the element identified by "[id=assignDagRoleBtn]"
#     Then I should see "has been successfully ASSIGNED to the user role"
#     #Verify the user is now in the same row as the Data Entry role.

#   Scenario: 33 - Remove test_user from Data Entry Role 
#     When I click on the link labeled "test_user"  
#     And I click on the button labeled "Remove from role"
#     And I should see "NOTICE: User's privileges will remain the same"
#     When I click on the button labeled "Close"
#     #The user is no longer on the same row as the Data Entry role.















