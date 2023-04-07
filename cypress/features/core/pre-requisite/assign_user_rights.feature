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
  --- 12. Logging
  --- 13. Data Quality Tool
  --- 15. Create Records
  --- 17. Rename Records
  --- 18. Delete Records
  --- 19. Record Locking Customization
  --- 20. Lock/Unlock Records
  --- 22. Allow locking of all forms at once for a given record
  - The system allows data entry form user access to be:
  --- 23. No Access
  --- 24. Read Only
  --- 25. View & Edit
  --- 26. Edit Survey Responses
  - 27. The system shall allow for the creation, copying and deletion of user roles.
  - 32. The system shall support adding and removing users from user roles.

  # @focus
  # Scenario: Fast setup (disable when testing full script)
  #   Given I am an "admin" user who logs into REDCap
  #   And I create a project named "SecondProject_1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/06_AssignUserRights_v1115.xml"
  #   And I enable surveys
  #   And I disable longitudinal mode
  #   And I click on the button labeled "Additional customizations"
  #   And I click on the checkbox near the text "Enable the Field Comment Log"
  #   And I click on the button labeled "Save"
  #   Then I should see "Success! Your changes have been saved."

  #   Given I click on the link labeled "User Rights"
  #   And I enter "test_user" into the input field near the text "Add with custom rights"
  #   And I click on the button labeled "Add with custom rights"
  #   Then I should see 'Adding new user "test_user"'
    
  #   Given I remove all Basic Rights within the open User Rights dialog box
  #   And I check the User Right named "User Rights"
  #   # Script has expected result: "Data Entry rights remain".
  #   # Consider adding an assertion here.
  #   And I save changes within the context of User Rights
  #   And I am a "standard" user who logs into REDCap
  #   And I click on the link labeled "My Projects"
  #   And I click on the link labeled "SecondProject_1115"

  Scenario: Project Setup - 1
    Given I am an "admin" user who logs into REDCap
    And I create a project named "SecondProject_1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/06_AssignUserRights_v1115.xml"
    
  Scenario: Project Setup - 2
    When I should see that surveys are enabled
    When I disable longitudinal mode
    And I click on the button labeled "Additional customizations"
    And I click on the checkbox labeled "Enable the Field Comment Log"
    #  ^ Defaults to enabled, despite importing CDISC from project with it disabled.
    And I click on the button labeled "Save"
    Then I should see "Success! Your changes have been saved."

  Scenario: 1 - Add test_user to SecondProject_1115
    When I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    And I click on the link labeled "User Rights"
    And I enter "test_user" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    Then I should see 'Adding new user "test_user"'
    And I remove all Basic Rights within the open User Rights dialog box
    #   Unasserted: Script has expected result: "Data Entry rights remain."
    Then I save changes within the context of User Rights
    
    When I click on the link labeled "My Projects"
    Then I should see "Listed below are the REDCap projects"

    Given I logout
    Then I should see "Please log in"
    And I am a "standard" user who logs into REDCap
    Then I should see "Logged in as"
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    Then I should see a link labeled "Project Home"
    And I should see a link labeled "Codebook"
    And I should see a link labeled "Record Status Dashboard"
    And I should see a link labeled "View / Edit Records"
    And I should see "Applications"
    Given I logout

  Scenario: 2 - Add expiration data for test_user
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    And I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I enter "1/1/23" into the input field labeled "Expiration Date"
    # ^ "second input" needed, due to hidden helper element that for some reason matches :visible
    #   This might get replaced with its own step definition for entering an expiration date
    #   @adam
    And I save changes within the context of User Rights

    Given I logout
    And I am a "standard" user who logs into REDCap
    When I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    Then I should see "Your access to this particular REDCap project has expired."
    Given I logout

  Scenario: 3 - Assign Project Design and Setup right to test_user
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    And I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    Then I should see 'Editing existing user "test_user"'



    And I clear field and enter "" into the input field labeled "Expiration Date"
    When I check the User Right named "Project Setup & Design"
    And I save changes within the context of User Rights
    Then I should see "never" within the "test_user" row of the column labeled "Expiration" of the User Rights table
    And I should see a "checkmark" within the "test_user" row of the column labeled "Project Design and Setup" of the User Rights table

  Scenario: 4 - Assign User Rights right to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "User Rights"
    And I save changes within the context of User Rights
    Then I should see a "checkmark" within the "test_user" row of the column labeled "User Rights" of the User Rights table
    

  Scenario: 5 - Verify links visibility for granted rights
    Given I logout
    And I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    Then I should see a link labeled "Project Setup"
    And I should see a link labeled "Designer"
    And I should see a link labeled "Dictionary"
    And I should see a link labeled "User Rights"

  Scenario: 6 - Assign Data Access Groups right to test_user
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Data Access Groups"
    And I save changes within the context of User Rights
    Then I should see a "checkmark" within the "test_user" row of the column labeled "Data Access Groups" of the User Rights table
    
    And I click on the link labeled "User Rights"
    Then I should see a link labeled "DAGs"

  Scenario: 7 - Assign Data Exports - De-identified right to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I select the User Right named "Data Exports" and choose "De-Identified*"
    And I save changes within the context of User Rights
    Then I should see "De-Identified" within the "test_user" row of the column labeled "Data Export Tool" of the User Rights table

    When I click on the link labeled "User Rights"
    Then I should see a link labeled "Data Exports, Reports, and Stats"

  Scenario: 8 - Assign Add/Edit/Organize Reports right to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Add/Edit/Organize Reports"
    And I save changes within the context of User Rights
    Then I should see a "checkmark" within the "test_user" row of the column labeled "Reports & Report Builder" of the User Rights table

    When I click on the link labeled "User Rights"
    Then I should see a link labeled "Reports"

  Scenario: 9 - Assign Survey Distribution Tools right to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Survey Distribution Tools"
    And I save changes within the context of User Rights
    Then I should see a "checkmark" within the "test_user" row of the column labeled "Survey Distribution Tools" of the User Rights table
    
    When I click on the link labeled "User Rights"
    Then I should see a link labeled "Survey Distribution Tools"

  Scenario: 10 - Assign Data Import Tool right to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Data Import Tool"
    And I save changes within the context of User Rights
    Then I should see a "checkmark" within the "test_user" row of the column labeled "Data Import Tool" of the User Rights table
    
    When I click on the link labeled "User Rights"
    Then I should see a link labeled "Data Import Tool"

  Scenario: 11 - Assign Data Comparison Tool right to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Data Comparison Tool"
    And I save changes within the context of User Rights
    Then I should see a "checkmark" within the "test_user" row of the column labeled "Data Comparison Tool" of the User Rights table
    
    When I click on the link labeled "User Rights"
    Then I should see a link labeled "Data Comparison Tool"

  Scenario: 12 - Revoke Data Exports, Data Import, and Data Comparison rights from test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I select the User Right named "Data Exports" and choose "No Access"
    And I uncheck the User Right named "Data Import Tool"
    And I uncheck the User Right named "Data Comparison Tool"
    And I check the User Right named "Logging"
    And I save changes within the context of User Rights
    Then I should see an "x" within the "test_user" row of the column labeled "Data Export Tool" of the User Rights table
    And I should see an "x" within the "test_user" row of the column labeled "Data Import Tool" of the User Rights table
    And I should see an "x" within the "test_user" row of the column labeled "Data Comparison Tool" of the User Rights table
    And I should see a "checkmark" within the "test_user" row of the column labeled "Logging" of the User Rights table
    
    When I click on the link labeled "User Rights"
    Then I should NOT see a link labeled "Data Import Tool"
    And I should NOT see a link labeled "Data Comparison Tool"
    #   Manual script has expected result "Data Export application is no longer available in the
    #   left sidebar", but the "Data Exports, Reports, and Stats" remains, which is normal AFAIK.
    #   @adam
    And I should see a link labeled "Logging"
    When I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should NOT see "Other Export Options"

  Scenario: 13 - Assign Data Quality - Create & Edit Rules right to test_user
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"  
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Data Quality - Create & edit rules"
    And I save changes within the context of User Rights
    Then I should see a "checkmark" within the "test_user" row of the column labeled "Data Quality (create/edit rules)" of the User Rights table
    
    When I click on the link labeled "User Rights"
    Then I should see a link labeled "Data Quality"

  Scenario: 14 - Assign Data Quality - Execute Rules right to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Data Quality - Execute rules"
    And I save changes within the context of User Rights
    Then I should see a "checkmark" within the "test_user" row of the column labeled "Data Quality (execute rules)" of the User Rights table

    When I click on the link labeled "Data Quality"
    Then I should see "Execute rules"

  Scenario: 15 - Assign Create Records right to test_user
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Create Records"
    And I save changes within the context of User Rights
    Then I should see a "checkmark" within the "test_user" row of the column labeled "Create Records" of the User Rights table
    
    When I click on the link labeled "View / Edit Records"
    Then I should see a button labeled "Add new record"

  Scenario: 16 - Revoke Create Records right from test_user
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I uncheck the User Right named "Create Records"
    And I save changes within the context of User Rights
    Then I should see an "x" within the "test_user" row of the column labeled "Create Records" of the User Rights table

    When I click on the link labeled "Add / Edit Records"
    Then I should NOT see a button labeled "Add new record"

  Scenario: 17 - Assign Rename Records right to test_user
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Rename Records"
    And I save changes within the context of User Rights
    Then I should see a "checkmark" within the "test_user" row of the column labeled "Rename Records" of the User Rights table

  Scenario: 18 - Assign Delete Records right to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Delete Records"
    And I save changes within the context of User Rights
    Then I should see a "checkmark" within the "test_user" row of the column labeled "Delete Records" of the User Rights table

  Scenario: 19 - Assign Record Locking Customization right to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Record Locking Customization"
    And I save changes within the context of User Rights
    Then I should see a "checkmark" within the "test_user" row of the column labeled "Record Locking Customization" of the User Rights table

    When I click on the link labeled "User Rights"
    Then I should see a link labeled "Customize & Manage Locking/E-signatures"

  Scenario: 20 - Assign Lock/Unlock Records - Locking / Unlocking With E-signature Authority right to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking with E-signature authority"
    Then I should see "Please note that giving a user 'Locking / Unlocking with E-signature authority' privileges"
    
    When I click on the button labeled "Close"
    And I save changes within the context of User Rights
    Then I should see a "shield" within the "test_user" row of the column labeled "Lock/Unlock Records" of the User Rights table

  Scenario: 21 - Assign Lock/Unlock Records - Locking / Unlocking right to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I select the User Right named "Lock/Unlock Records" and choose "Locking / Unlocking"

    When I save changes within the context of User Rights
    Then I should see a "checkmark" within the "test_user" row of the column labeled "Lock/Unlock Records" of the User Rights table


  Scenario: 22 - Assign Lock/Unlock *Entire* Records (Record Level) right to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I check the User Right named "Lock/Unlock *Entire* Records"
    
    When I save changes within the context of User Rights
    Then I should see a "checkmark" within the "test_user" row of the column labeled "Record Locking Customization" of the User Rights table

  Scenario: 23 - Assign Data Entry - No Access right to test_user
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I set Data Viewing Rights to No Access for the instrument "Text Validation"
    And I set Data Viewing Rights to No Access for the instrument "Data Types"
    And I save changes within the context of User Rights

    When I click on the link labeled "View / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"
    Then I should NOT see "Text Validation"
    And I should NOT see "Data Types"

  Scenario: 24 - Assign Data Entry - Read Only right to test_user
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I set Data Viewing Rights to Read Only for the instrument "Text Validation"
    And I set Data Viewing Rights to Read Only for the instrument "Data Types"
    And I save changes within the context of User Rights
    
    When I click on the link labeled "View / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble to select a record for the "Text Validation" classic instrument
    Then I should NOT see a button labeled "Save & Exit Form"

  Scenario: 25 - Assign Data Entry - View & Edit right to test_user
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I set Data Viewing Rights to View & Edit for the instrument "Text Validation"
    And I set Data Viewing Rights to View & Edit for the instrument "Data Types"
    And I save changes within the context of User Rights

    When I click on the link labeled "View / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"

  Scenario: 26 - Assign Data Entry - Edit Survey Responses to test_user
    Given I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Edit user privileges"
    And I set Data Viewing Rights to Edit survey responses for the instrument "Text Validation"
    And I save changes within the context of User Rights

    When I click on the link labeled "View / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble to select a record for the "Text Validation" classic instrument

    # Then I should see a button labeled "Edit response"
    # ^ Exporting the project with a completed survey response, then creating a project using that CDISC causes
    #   the survey response to change its form status from "Completed Survey Response" to just "Complete", and
    #   so the "Edit response" button does not appear.
    #   @adam

  Scenario: 27 - Create "Data Entry" role
    Given I click on the link labeled "User Rights"
    And I enter "Data Entry" into the input field labeled "Create role"
    And I click on the button labeled "Create role"
    And I click on the button labeled "Create role" in the dialog box
    Then I should see 'Role "Data Entry" was successfully added'

  Scenario: 28 - Copy "Data Entry" role as "Reviewer"
    Given I click on the link labeled "Data Entry"
    And I click on the button labeled "Copy role" in the dialog box
    And I clear field and enter "Reviewer" into the input field labeled "New role name:"
    And I click on the button labeled "Copy role" in the dialog box
    Then I should see 'Role "Reviewer" was successfully added'

    When I click on the button labeled "Cancel" in the dialog box
    Then I should see a link labeled "Data Entry"
    And I should see a link labeled "Reviewer"

  Scenario: 29 - Cancel deletion of "Reviewer" role
    Given I click on the link labeled "Reviewer"
    And I click on the button labeled "Delete role" in the dialog box
    Then I should see "Delete role?"

    When I click on the button labeled "Cancel" in the dialog box
    Then I should see 'Editing existing user role "Reviewer"'

    When I click on the button labeled "Cancel" in the dialog box
    Then I should see a link labeled "Reviewer"

  Scenario: 30 - Delete "Reviewer" role
    Given I click on the link labeled "Reviewer"
    And I click on the button labeled "Delete role" in the dialog box
    Then I should see "Delete role?"

    When I click on the button labeled "Delete role" in the dialog box
    Then I should see 'Role "Reviewer" was successfully deleted'
    And I should NOT see a link labeled "Reviewer"

  Scenario: 31 - Attempt to assign test_user (self) to role without User Rights privileges
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Assign to role" on the tooltip
    And I select "Data Entry" on the dropdown field labeled "Select Role:" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "NOTICE: User Rights mismatch"

    Given I click on the button labeled "Close"

  Scenario: 32 - As admin, assign test_user to role without User Rights privileges
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    And I click on the link labeled "User Rights"
    And I click on the link labeled "test_user"
    And I click on the button labeled "Assign to role" on the tooltip
    And I select "Data Entry" on the dropdown field labeled "Select Role:" on the role selector dropdown
    And I click on the button labeled exactly "Assign" on the role selector dropdown
    # Then I should see 'User "test_user" has been successfully ASSIGNED to the user role "Data Entry".'
    # ^ Full string not detected due to awkward HTML structure
    Then I should see 'has been successfully ASSIGNED to the user role "Data Entry"'
    And I should see "test_user" within the "Data Entry" row of the column labeled "Username" of the User Rights table

  Scenario: 33 - Remove test_user from "Data Entry" role
    Given I click on the link labeled "test_user"
    And I click on the button labeled "Remove from role"
    Then I should see 'has been successfully REMOVED from their user role'
    And I should see "NOTICE: User's privileges will remain the same"

    When I click on the button labeled "Close" in the dialog box
    Then I should see "—" within the "test_user" row of the column labeled "Role name" of the User Rights table

# END