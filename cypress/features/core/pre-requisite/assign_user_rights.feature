Feature: Assign User Rights

  As a REDCap end user
  I want to see that Assign User Rights is functioning as expected

  
  Scenario: Project Setup - 1 
    Given I am an "admin" user who logs into REDCap
    And I create a project named "SecondProject_1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"

  Scenario: Project Setup - 2
    Given I enable surveys for Project ID 14
    And I disable longitudinal mode
    And I click on the button labeled "Additional customizations"
    And I should see "You may use the options below to make customizations to the project."
    And I check the checkbox labeled "Enable the Field Comment Log or Data Resolution Workflow (Data Queries)?"
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Success! Your changes have been saved."

  Scenario: 1 - Add test_user to SecondProject_1115
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    And I click on the link labeled "User Rights"

    And I enter "test_user" into the username input field
    And I click on the button labeled "Add with custom rights"
    And I remove all Basic Rights within the open User Rights dialog box
    And I save changes within the context of User Rights

    When I click on the link labeled "My Projects"
    Then I should see "Listed below are the REDCap projects"

    Given I logout
    And I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    Then I should see a link labeled "Project Home"
    And I should see a link labeled "Codebook"
    And I should see a link labeled "Record Status Dashboard"
    And I should see a link labeled "View / Edit Records"

  Scenario: 2 - Add expiration data for test_user
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    And I click on the link labeled "User Rights"
    And I assign an expired expiration date to user "Test User" with username of "test_user" on project ID 14
    Given I logout
    And I am a "standard" user who logs into REDCap
    When I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    Then I should see "Your access to this particular REDCap project has expired."
    Given I logout

  Scenario: 3-4 - Assign Project Design and Setup & User Rights to test_user
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    And I click on the link labeled "User Rights"
    And I remove the expiration date to user "Test User" with username of "test_user" on project ID 14
    Then I should NOT see "10/31/2022"

    When I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then I should see 'Editing existing user "test_user"'
    When I check the User Right named "Project Setup & Design"
    And I check the User Right named "User Rights"
    Then I save changes within the context of User Rights

  Scenario: 5 - Verify User Rights Links Visibility
    Given I logout
    And I am an "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    Then I should see a link labeled "Project Setup"
    And I should see a link labeled "Designer"
    And I should see a link labeled "Dictionary"
    And I should see a link labeled "User Rights"

  Scenario: 6 - Assign Data Access Groups to test_user
    When I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    And I click on the link labeled "User Rights"

    Given I should see a link labeled "test_user"
    And I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then I should see 'Editing existing user "test_user"'

    When I check the User Right named "Data Access Groups"
    And I save changes within the context of User Rights
    Then I should see a link labeled "test_user"

    When I click on the link labeled "Project Home"
    Then I should see a link labeled "DAGs"

    When I click on the link labeled "DAGs"
    Then I should see "Data Access Groups"

  Scenario: 7 - Assign Data Exports - De-identified to test_user
    Given I click on the link labeled "User Rights"

    Given I assign the "De-Identified*" user right to the user named "Test User" with the username of "test_user" on project ID 14
    #Verify in the main User Rights page the ‘Data Export Tool’ box says De-identified for user user1115_1.
    Then I should see a link labeled "Data Exports, Reports, and Stats"

  Scenario: 8 - Assign Add/Edit/Organize Reports to test_user
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then I check the User Right named "Add/Edit/Organize Reports"
    And I save changes within the context of User Rights

  Scenario: 9 - Assign Survey Distribution Tools to test_user
    Given I assign the "Survey Distribution Tools" user right to the user named "Test User" with the username of "test_user" on project ID 14
    And I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then I check the User Right named "Survey Distribution Tools"
    And I save changes within the context of User Rights
    Then I should see a link labeled "Survey Distribution Tools"

  Scenario: 10 - Assign Data Import Tool to test_user
    Given I assign the "Data Import Tool" user right to the user named "Test User" with the username of "test_user" on project ID 14
    And I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then I check the User Right named "Data Import Tool"
    And I save changes within the context of User Rights
    Then I should see a link labeled "Data Import Tool"

  Scenario: 11 - Assign Data Comparison Tool to test_user
    Given I assign the "Data Comparison Tool" user right to the user named "Test User" with the username of "test_user" on project ID 14
    And I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then I check the User Right named "Data Comparison Tool"
    And I save changes within the context of User Rights
    Then I should see a link labeled "Data Comparison Tool"

  Scenario: 12 - Remove Data Exports, Data Import, and Data Comparison User Rights 
    When I click on the link labeled "test_user"  
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then I should see "Editing existing user"
    When I click on the element identified by ':nth-child(7) > [style="padding-top:2px;"] > :nth-child(1) > input'
    And I click on the button labeled "Save Changes"
    And I remove the "Data Import Tool" user right to the user named "Test User" with the username of "test_user" on project ID 14
    And I remove the "Data Comparison Tool" user right to the user named "Test User" with the username of "test_user" on project ID 14
    And I assign the "Logging" user right to the user named "Test User" with the username of "test_user" on project ID 14
    When I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    #Verify in the main User Rights page the ‘Data Export Tool’ box says No Access for user user1115_1.
    Then the user right identified by "[name=data_import_tool]" should not be checked
    And the user right identified by "[name=data_comparison_tool]" should not be checked
    And the user right identified by "[name=data_logging]" should be checked
    When I click on the link labeled "User Rights"
    Then I should see "Data Exports, Reports, and Stats" 
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should NOT see "Other Export Options"
    When I click on the link labeled "User Rights"
    Then I should NOT see "Data Import Tool"
      #Fails here - link is not visible but still says found 
    And I should NOT see "Data Comparison Tool"
    And I should see link labeled "Logging"

  Scenario: 13 - Assign Data Quality - create/edit rules to test_user
    Given I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then I should see "Editing existing user"
    When I check the User Right named "Data Quality - Create & edit rules"
    And I click on the button labeled "Save Changes"
    And I click on the link labeled "test_user"
    Then I should see "Edit user privileges"
    When I click on the element identified by "[id=tooltipBtnSetCustom]"
    Then the user right identified by "[name=data_quality_design]" should be checked
    When I click on the link labeled "User Rights"
    Then I should see a link labeled "Data Quality"

  Scenario: 14 - Assign Data Quality - Execute rules to test_user
    Given I click on the link labeled "test_user"  
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then I should see "Editing existing user"
    When I check the user right identified by "[name=data_quality_execute]"
    And I click on the button labeled "Save Changes"
    And I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then the user right identified by "[name=data_quality_execute]" should be checked

  Scenario: 15 - Assign Create Records to test_user
    Given I assign the "Create Records" user right to the user named "Test User" with the username of "test_user" on project ID 14
    And I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then the user right identified by "[name=record_create]" should be checked
    When I click on the link labeled "Add / Edit Records"
    Then I should see "Add new record"

  Scenario: 16 - Remove Create records 
    Given I remove the "Create Records" user right to the user named "Test User" with the username of "test_user" on project ID 14
    When I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then the user right identified by "[name=record_create]" should not be checked
    When I click on the link labeled "Add / Edit Records"
    Then I should NOT see "Add new record"

  Scenario: 17 - Assign Rename Records to test_user 
    Given I assign the "Rename Records" user right to the user named "Test User" with the username of "test_user" on project ID 14
    And I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then the user right identified by "[name=record_rename]" should be checked

  Scenario: 18 - Assign Delete Records to test_user
    Given I assign the "Delete Records" user right to the user named "Test User" with the username of "test_user" on project ID 14
    And I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then the user right identified by "[name=record_delete]" should be checked

  Scenario: 19 - Assign Record Locking Customization to test_user
    Given I assign the "Record Locking Customization" user right to the user named "Test User" with the username of "test_user" on project ID 14
    And I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then the user right identified by "[name=lock_record_customize]" should be checked
    When I click on the link labeled "User Rights"
    Then I should see a link labeled "Customize & Manage Locking/E-signatures"

  Scenario: 20 - Assign Locking / Unlocking with E-signature authority to test_user
    Given I assign the "Locking / Unlocking with E-signature authority" user right to the user named "Test User" with the username of "test_user" on project ID 14
    #Verify in the main User Rights page the ‘Lock/Unlock Records’ box contains a green shield with a check for user user1115_1.

  Scenario: 21 - Assign Locking / Unlocking to test_user
    Given I assign the "Locking / Unlocking" user right to the user named "Test User" with the username of "test_user" on project ID 14
    #The main User Rights page the ‘Lock/Unlock Records’ box contains a green check for user user1115_1.

  Scenario: 22 - Assign Lock/Unlock *Entire* Records (record level) to test_user
    Given I assign the "Lock/Unlock *Entire* Records (record level)" user right to the user named "Test User" with the username of "test_user" on project ID 14
    And I click on the link labeled "test_user"
    And I should see "Edit user privileges"
    And I click on the button labeled "Edit user privileges"
    Then the user right identified by "[name=lock_record_multiform]" should be checked

Scenario: before step 26 
    Given I logout
    And I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    When I click on the link labeled "Designer"
    And I click on the element identified by "button:contains('Enable'):first"
    And I click on the button labeled "Save Changes"
    Then I should see "Your survey settings were successfully saved!"

    When I visit the public survey URL for Project ID 14
    And I enter "name" into the "Name" survey text input field
    And I click on the button labeled "Submit"
    Given I logout
    And I am a "standard" user who logs into REDCap

  Scenario: 23 - Assign No Access to test_user
    Given I grant No Access level of Data Entry Rights on the "Text Validation" instrument for the username "test_user" for project ID 14
    And I grant No Access level of Data Entry Rights on the "Data Types" instrument for the username "test_user" for project ID 14
    And I click on the link labeled "View / Edit Records"
    And I select "2" from the dropdown identified by "[id=record]"
    Then I should see "Record Home Page"
    And I should NOT see "Text Validation"

  Scenario: 24 - Assign Read Only to test_user
    Given I grant Read Only level of Data Entry Rights on the "Text Validation" instrument for the username "test_user" for project ID 14
    And I grant Read Only level of Data Entry Rights on the "Data Types" instrument for the username "test_user" for project ID 14
    And I click on the link labeled "User Rights"
    When I click on the link labeled "Record Status Dashboard"
    When I click on the bubble for the "Text Validation" data collection instrument for record ID "2"
    Then I should see "Text Validation"
    And I should NOT see "Edit response"

  Scenario: 25 - Assign View and Edit to test_user
    Given I grant View & Edit level of Data Entry Rights on the "Text Validation" instrument for the username "test_user" for project ID 14
    And I grant View & Edit level of Data Entry Rights on the "Data Types" instrument for the username "test_user" for project ID 14
    And I click on the link labeled "User Rights"
    When I click on the link labeled "Record Status Dashboard"
    When I click on the bubble for the "Data Types" data collection instrument for record ID "1"
    Then I should see "Data Types"
    And I should see a button labeled "Save & Exit Form"
    When I click on the link labeled "Record Status Dashboard"
    And I click on the bubble for the "Text Validation" data collection instrument for record ID "2"
    Then I should see "Text Validation"
    And I should NOT see "Edit response"

  Scenario: 26 - Assign Edit Survey Responses to test_user
    Given I change survey edit rights for "test_user" user on the form called "Text Validation" on project ID 14
    And I click on the link labeled "User Rights"
    When I click on the link labeled "Record Status Dashboard"
    When I click on the bubble for the "Text Validation" data collection instrument for record ID "2"
    Then I should see "Data Types"
    And I should see a button labeled "Edit response"

  Scenario: 27 - Create Data Entry Role 
    When I click on the link labeled "User Rights"
    And I enter "Data Entry" into the field identified by "[id=new_rolename]"
    And I click on the button labeled "Create role"
    Then I should see "Creating new role"
    And I click on the element identified by "button:contains('Create role'):last"
    Then I should see a link labeled "Data Entry"

  Scenario: 28 - Copy Data Entry Role
    Given I click on the element identified by "[id=rightsTableUserLinkId_1]"
    Then I should see "Editing existing user role"
    When I click on the button labeled "Copy role"
    And I clear the field labeled "New role name:"
    And I enter "Reviewer" into the field identified by "[id=role_name_copy]"
    And I click on the element identified by "button:contains('Copy role'):last"
    Then I should see "was successfully added"
    When I click on the link labeled "User Rights"
    And I should see a link labeled "Data Entry"
    And I should see a link labeled "Reviewer"

  Scenario: 29 - Cancel Delete Reviewer Role
    Given I click on the link labeled "Reviewer"
    Then I should see "Editing existing user role"
    When I click on the button labeled "Delete role"
    Then I should see "Delete role?"
    When I click on the element identified by "button:contains('Cancel'):last"
    And I click on the button labeled "Close"
    Then I should see a link labeled "Reviewer"

  Scenario: 30 - Delete Reviewer Role 
    Given I delete role name "Reviewer"
    #And I click on the button labeled "Delete role"
    #And I click on the button labeled "button:contains('Delete role'):first"

    #Given I click on the link labeled "Reviewer"
    #Given I click on the element identified by "[id=rightsTableUserLinkId_2]"
    #Then I should see "Editing existing user role"
    #When I click on the button labeled "Delete role"
    #Then I should see "Delete role?"
    #When I click on the element identified by "button:contains('Delete role'):last"
    #Then I should see "was successfully deleted"

    And I click on the link labeled "User Rights"
And I want to pause
    And I should NOT see "Reviewer"

  Scenario: 31 - Assign test_user to Data Entry
    When I enter "test_user" into the field identified by "[id=new_username_assign]"
    And I click on the button labeled "Assign to role"
    And I select "Data Entry" from the dropdown identified by "[id=user_role]"
    And I click on the element identified by "[id=assignDagRoleBtn]"
    Then I should see "NOTICE: User Rights mismatch"
    Given I logout

  Scenario: 32 - Assign test_user to Data Entry 
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    And I click on the link labeled "User Rights"
    When I enter "test_user" into the field identified by "[id=new_username_assign]"
    And I click on the button labeled "Assign to role"
    And I select "Data Entry" from the dropdown identified by "[id=user_role]"
    And I click on the element identified by "[id=assignDagRoleBtn]"
    Then I should see "has been successfully ASSIGNED to the user role"
    #Verify the user is now in the same row as the Data Entry role.

  Scenario: 33 - Remove test_user from Data Entry Role 
    When I click on the link labeled "test_user"  
    And I click on the button labeled "Remove from role"
    And I should see "NOTICE: User's privileges will remain the same"
    When I click on the button labeled "Close"
    #The user is no longer on the same row as the Data Entry role.
















