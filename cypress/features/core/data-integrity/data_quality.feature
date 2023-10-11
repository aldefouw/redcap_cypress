Feature: Data Quality

  As a REDCap end user
  I want to see that Data Collection and Storage is functioning as expected

  Scenario: Project Setup 1 - Create Project 18_DataQuality_v1115
    Given I am an "admin" user who logs into REDCap
    And I create a project named "18_DataQuality_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"

  Scenario: Project Setup 2 - Add fields and delete all existing data
  When I click on the link labeled "Project Setup"
  When I click on the link labeled "Other Functionality"
  And I click on the button labeled "Erase all data"
  
  And the AJAX "POST" request at "ProjectGeneral/erase_project_data.php*" tagged by "erase_project_data" is being monitored
  And I click on the button labeled "Erase all data" in the dialog box  
  And the AJAX request tagged by "erase_project_data" has completed
  And I click on the button labeled "Close" in the dialog box
 
    Given I click on the link labeled "Designer"
    And I click on the link labeled "Data Types"
    And I click on the element identified by "input[id=btn-textbox-f]"
    And I select "text" from the dropdown identified by "select[id=field_type]"
    And I enter "Integer Field" into the field identified by "textarea[id=field_label]"  
    And I enter "integer_field" into the field identified by "input[id=field_name]" 
    And the AJAX "GET" request at "Design/check_field_name*" tagged by "check_field_name" is being monitored
    And I select "integer" from the dropdown identified by "select[id=val_type]"
    And the AJAX request tagged by "check_field_name" has completed
    And I enter "0" into the field identified by "input[id=val_min]"
    And I enter "10" into the field identified by "input[id=val_max]"
    And the AJAX "GET" request at "Design/check_field_name*" tagged by "check_field_name" is being monitored
    And I click on the button labeled "Save"
    And the AJAX request tagged by "check_field_name" has completed
    And I click on the link labeled "User Rights"
    And I enter "Test_user" into the field identified by "input[id=new_username]"
    And I click on the button labeled "Add with custom rights" 
    And I check the checkbox identified by "input[name= data_quality_design]"
    And I check the checkbox identified by "input[name=data_quality_execute]"
    
    And the AJAX "POST" request at "UserRights/edit_user.php*" tagged by "edit_user" is being monitored
    And I click on the button labeled "Save Changes" in the dialog box
    And the AJAX request tagged by "edit_user" has completed
    And I enter "Test_user2" into the field identified by "input[id=new_username]"
    And the AJAX "GET" request at "UserRights/search_user.php*" tagged by "search_user" is being monitored
    And I click on the button labeled "Add with custom rights"
    And the AJAX request tagged by "search_user" has completed
    And I scroll the user rights page to the bottom
    And the AJAX "POST" request at "UserRights/edit_user.php*" tagged by "edit_user" is being monitored
    And I click on the button labeled "Add user"
    And the AJAX request tagged by "edit_user" has completed
  
  Scenario: 3 Logout as Admin
    Given I logout  

  Scenario: 4 Login as Standard User
    Given I am a "standard" user who logs into REDCap 
    And I click on the link labeled " My Projects"
    And I click on the link labeled "18_DataQuality_v1115"
    Then I should see "Data Quality"

  Scenario: 5 Click Add / Edit Records and add New record for the arm selected
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    
  Scenario: 6 Click on Text Validation
    Given I click on a bubble with instrument named "Text Validation" and event named "Event 1"
    Then I should see " Adding new Record ID " 
  
  Scenario: 7 Add values to new record
    Given I enter "user1115_1" into the field identified by "Input[name=ptname_v2_v2]"
    And I enter "user1115_1@redcap.com" into the field identified by "Input[name=email_v2]"

  Scenario: 8 Save new record
    Given I select "Complete" from the dropdown identified by "select[name=text_validation_complete]"
    And I click on the button labeled "Save & Exit Form"
    Then I see a "circle_green" bubble for instrument named "Text Validation" and event named "Event 1"

  Scenario: 9 Go into the Data Types form
    Given I click on a bubble with instrument named "Data Types" and event named "Event 1"
    And I enter "User11151" into the field identified by "Input[name=ptname]"
    And I enter "This is a text" into the field identified by "Input[name=text2]"
    And I enter "8" into the field identified by "Input[name=integer_field]"
    And I enter "User11151" into the field identified by "Input[name=required]"
    And I select "Complete" from the dropdown identified by "select[name=data_types_complete]"
    And I click on the button labeled "Save & Exit Form"
    Then I see a "circle_green" bubble for instrument named "Data Types" and event named "Event 1"

  Scenario: 10 Create Record 2
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Then I should see 'Record "2" is a new Record ID'

  Scenario: 11 Create a record
    Given I click on a bubble with instrument named "Data Types" and event named "Event 1"

  Scenario: 12 Add values to the new record
    Given I enter "213" into the field identified by "Input[name=integer_field]" 
    And I click on the element identified by "Input[name=textbox]"    
    Then I should see "The value you provided is outside the suggested range (0 - 10). " in an alert box
    And I click on the button labeled "Close" in the dialog box
    Then I see the field identified by "Input[name=integer_field]" turns red
    And I scroll the page to the field identified by "select[name=data_types_complete]"
    And I select "Complete" from the dropdown identified by "select[name=data_types_complete]"
    And I click on the button labeled "Save & Exit Form"
    And I click on the button labeled "Ignore and leave record" in the dialog box
    Then I see a "circle_green" bubble for instrument named "Data Types" and event named "Event 1"

  Scenario: 14 and 15  Execute all rules
    Given I click on the link labeled "Data Quality"
    And I click on the button labeled "All"
    Then All data quality rules are executed 
    And I see "29" Total Discrepancies under Rule "A"
    And I see "1" Total Discrepancies under Rule "B"
    And I see "0" Total Discrepancies under Rule "C"

  Scenario: 16 and 17 View discrapancies and Exclude discrepancies.  
    Given I click "view" Total Discrepancies under Rule "A"
    And I exclude the top "3" rows of discrepancies table identified by "table[id=table-results_table_pd-3]"
    Then I should see "remove exclusion" in the top "3" rows of table identified by "table[id=table-results_table_pd-3]"
    And I click on the button labeled "Close" in the dialog box

  Scenario: 18 Window opens up showing Record 2 that did not have the “Required” field populated
    Given I click "view" Total Discrepancies under Rule "B"
    Then I should see a dialog containing the following text: "Blank values* (required fields only)"
    And Discrepancies for Record "2", should appear in the table identified by "table[id=table-results_table_pd-6]"
    And I click on the button labeled "Close" in the dialog box

  Scenario: 19 Window opens up with Record 2 that had 213 entered as the Integer field
    Given  I click "view" Total Discrepancies under Rule "D"
    Then I should see a dialog containing the following text: "Field validation errors (out of range)"
    And I click on the button labeled "Close" in the dialog box

  Scenario: 20 Reset Rules
    Given I click on the button labeled "Clear"
    Then All rules are reset and I see Execute button available
 
  Scenario: 21 Click on “All Except A&B”.Rules C-I are executed and Rules A&B show “Execute” 
    Given I click on the button labeled "All except A&B"
    Then I should see "Execute" in the top "2" rows of table identified by "table[id=table-rules]"
 
  Scenario: 22 Execute Rules A and B separately 
    Given I click "Execute" Total Discrepancies under Rule "A"
    And I see "26" Total Discrepancies under Rule "A"
    And I click "Execute" Total Discrepancies under Rule "B"
    And I see "1" Total Discrepancies under Rule "B"

  Scenario: 23 Reset Rules
    Given I click on the button labeled "Clear"
    And the AJAX "POST" request at "DataQuality/record_list.php*" tagged by "record_list" is being monitored
    Then All rules are reset and I see Execute button available
    And the AJAX request tagged by "record_list" has completed

  Scenario: 24 Execute  all rules separately 
    And I click "Execute" Total Discrepancies under Rule "C"
    And I see "0" Total Discrepancies under Rule "C"
    And I click "Execute" Total Discrepancies under Rule "D"
    And I see "1" Total Discrepancies under Rule "D"

  Scenario: 25 Reset Rules
    Given I click on the button labeled "Clear"
    Then All rules are reset and I see Execute button available
    Given the AJAX "POST" request at "DataQuality/record_list.php*" tagged by "record_list" is being monitored
    And the AJAX request tagged by "record_list" has completed

  Scenario: 26 Under the “Apply To” drop box select the Record 2 
    Given I select Record "2" from the dropdown list to execute Data Quality rules
    And I click on the button labeled "All"
    Then All data quality rules are executed 

  Scenario: 27 Reset Rules
    Given I click on the button labeled "Clear"
    Then All rules are reset and I see Execute button available
    Given the AJAX "POST" request at "DataQuality/record_list.php*" tagged by "record_list" is being monitored
    And the AJAX request tagged by "record_list" has completed

  Scenario: 28 Select the Record 2 and click All Except A & B
    Given I select Record "2" from the dropdown list to execute Data Quality rules
    And I click on the button labeled "All except A&B"
    Then I should see "Execute" in the top "2" rows of table identified by "table[id=table-rules]"

  Scenario: 29 Reset Rules
    Given I click on the button labeled "Clear"
    Then All rules are reset and I see Execute button available
    Given the AJAX "POST" request at "DataQuality/record_list.php*" tagged by "record_list" is being monitored
    And the AJAX request tagged by "record_list" has completed

  Scenario: 30 Select the Record 2 and execute rules separately
    Given I select Record "2" from the dropdown list to execute Data Quality rules
    And the AJAX "POST" request at "DataQuality/execute_ajax.php*" tagged by "data_quality" is being monitored
    And I click "Execute" Total Discrepancies under Rule "A"
    And the AJAX request tagged by "data_quality" has completed
    Then I see "17" Total Discrepancies under Rule "A"
    And I click "Execute" Total Discrepancies under Rule "B"
    Then I see "1" Total Discrepancies under Rule "B"

  Scenario: 31 Reset Rules
    Given I click on the button labeled "Clear"
    Then All rules are reset and I see Execute button available

  Scenario: 32 Add new rule
    Given I enter "Test" into the field identified by "textarea[id=input_rulename_id_0]"  
    And I click the input element identified by "textarea[id=input_rulelogic_id_0]"
    And I enter "[event_1_arm_1][integer_field]>200" into the field identified by "div[id=rc-ace-editor]"
    And I click on the button labeled "Update & Close Editor" 
    And the AJAX "POST" request at "Design/logic_validate.php*" tagged by "logic_validate" is being monitored
    And I click on the button labeled "Add"
    And the AJAX request tagged by "logic_validate" has completed
    And the AJAX "POST" request at "DataQuality/record_list.php*" tagged by "record_list" is being monitored
    And the AJAX request tagged by "record_list" has completed

  Scenario: 33 Execute and view new rule
    Given the AJAX "POST" request at "DataQuality/execute_ajax.php*" tagged by "data_quality" is being monitored
    And I click "Execute" Total Discrepancies under Rule "Test"
    And the AJAX request tagged by "data_quality" has completed
    Then I see "1" Total Discrepancies under Rule "Test"
    Given  I click "view" Total Discrepancies under Rule "Test"
    Then I should see a dialog containing the following text: "Rule #1: Test"
    And I click on the button labeled "Close" in the dialog box

  Scenario: 34 Reset Rules
    Given I click on the button labeled "Clear"
    Then All rules are reset and I see Execute button available

  Scenario: 35 Edit new rule
    Given I click to edit Rule "Test"
    And I clear text in the field identified by "textarea[class=ace_text-input]"
    And I enter "[event_1_arm_1][integer_field]>201" into the field identified by "div[id=rc-ace-editor]"
    And I click on the button labeled "Update & Close Editor" 
    And the AJAX "POST" request at "Design/logic_validate*" tagged by "logic_validate" is being monitored
    And I click on the button labeled "Save"
    And the AJAX request tagged by "logic_validate" has completed

  Scenario: 36 Execute all rules
    Given I click on the button labeled "All"
    Then All data quality rules are executed 

  Scenario: 37 Reset Rules
    Given I click on the button labeled "Clear"
    Then All rules are reset and I see Execute button available

  Scenario: 38 and 39 Execute All Except A & B
    Given I click on the button labeled "All except A&B"
    Then I should see "Execute" in the top "2" rows of table identified by "table[id=table-rules]"
    Given I click on the button labeled "Clear"
    Then All rules are reset and I see Execute button available

  Scenario: 40 Execute All custom rules
    Given I click on the button labeled "All custom"
    Then I should see "Execute" in the top "9" rows of table identified by "table[id=table-rules]"

  Scenario: 41 Add new rule
    Given I enter "Test2" into the field identified by "textarea[id=input_rulename_id_0]"  
    And I click the input element identified by "textarea[id=input_rulelogic_id_0]"
    And the AJAX "POST" request at "Design/logic_validate.php*" tagged by "logic_validate" is being monitored
    And I enter "[event_1_arm_1][integer_field] > 300" into the field identified by "div[id=rc-ace-editor]"
    And the AJAX request tagged by "logic_validate" has completed
    And I click on the button labeled "Update & Close Editor" 
    And the AJAX "POST" request at "DataQuality/edit_rule_ajax*" tagged by "edit_rule" is being monitored
    And I click on the button labeled "Add"
    And the AJAX request tagged by "edit_rule" has completed

  Scenario: 42 and 43 Execute Test2
    Given the AJAX "POST" request at "DataQuality/execute_ajax.php*" tagged by "data_quality" is being monitored
    And I click "Execute" Total Discrepancies under Rule "Test2"
    And the AJAX request tagged by "data_quality" has completed 
    Then I see "0" Total Discrepancies under Rule "Test2"
    And I click on the button labeled "Clear"
    Then All rules are reset and I see Execute button available

  Scenario: 44 and 45 Execute "All custom"
    And the AJAX "POST" request at "DataQuality/execute_ajax.php*" tagged by "data_quality" is being monitored
    Given I click on the button labeled "All custom"
    And the AJAX request tagged by "data_quality" has completed
    Then I should see "Execute" in the top "9" rows of table identified by "table[id=table-rules]"
    And I see "1" Total Discrepancies under Rule "Test"
    And I see "0" Total Discrepancies under Rule "Test2"

  Scenario: 46 and 47 Delete New rule Test2
    Given I click on the button labeled "Clear"
    And the AJAX "POST" request at "DataQuality/record_list.php*" tagged by "record_list" is being monitored
    Then All rules are reset and I see Execute button available
    And the AJAX request tagged by "record_list" has completed
    And the AJAX "POST" request at "DataQuality/edit_rule_ajax*" tagged by "edit_rule" is being monitored
    Given I click X under new rule named "Test2" to delete it
    And the AJAX request tagged by "edit_rule" has completed
    
  Scenario: 48 Scenario 44 repeated


  Scenario: 48b Logout and login as admin (Deviated from manual test script and added below steps to run Rule H)
    And I logout
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled " My Projects"
    And I click on the link labeled "18_DataQuality_v1115"
    Given I click on the link labeled "Designer"
    And I click on the link labeled "Data Types"
    And the AJAX "GET" request at "Design/edit_field_prefill.php*" tagged by "edit" is being monitored
    And I click on the Edit image for the field named "Calculated Field"
    And the AJAX request tagged by "edit" has completed
    And I click on the element identified by "textarea[name=element_enum]"
    And I clear text in the field identified by "textarea[class=ace_text-input]"
    And I enter "3*[integer_field]" into the hidden field identified by "textarea[class=ace_text-input]"
    And I click on the button labeled "Update & Close Editor" in the dialog box
    And the AJAX "POST" request at "Design/calculation_equation_validate.php*" tagged by "calc_eq" is being monitored
    And I click on the button labeled "Save"
    And the AJAX request tagged by "calc_eq" has completed
    And I should see a dialog containing the following text: "NOTICE: Calculation was changed - Data is affected!"
    And I click on the button labeled "Close" in the dialog box
    
    
  Scenario: 49 Click Add / Edit Records and add New record for the arm selected
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Given I click on a bubble with instrument named "Text Validation" and event named "Event 1"
    Then I should see " Adding new Record ID " 
    And I click on the button labeled "Save & Exit Form"
    Then I see a "circle_red" bubble for instrument named "Text Validation" and event named "Event 1"

  Scenario: 50 and 51 Execute Rule H
    Given I click on the link labeled "Data Quality"
    And the AJAX "POST" request at "DataQuality/execute_ajax.php*" tagged by "data_quality" is being monitored
    And I click "Execute" Total Discrepancies under Rule "H"
    And the AJAX request tagged by "data_quality" has completed

  Scenario: 52 View and fix calcs
    And I see "2" Total Discrepancies under Rule "H"
    And I click "view" Total Discrepancies under Rule "H"
    And I click on the button labeled "Fix calcs now" in the dialog box
    And I close the popup
    Then I see "0" Total Discrepancies under Rule "H"

  Scenario: 53 Edit Test_user rights to 'No Access' for instrument 'Data Types'
    Given I click on the link labeled "User Rights"
    And I click to edit username "test_user (Test User)"
    And the AJAX "POST" request at "UserRights/edit_user.php*" tagged by "edit_user" is being monitored
    And I click on the button labeled "Edit user privileges"
    And the AJAX request tagged by "edit_user" has completed
    And I set Data Viewing Rights to No Access for the instrument "Data Types"
    And I save changes within the context of User Rights

  Scenario: 54 Logout and Admin and login as standard user (Test_user)
    Given I logout
    Given I am a "standard" user who logs into REDCap 
    And I click on the link labeled " My Projects"
    And I click on the link labeled "18_DataQuality_v1115"

  Scenario: 55 Run 'Test' as standard user and confirm Data Quality rules for 'Data Types' returns an error
    Given I click on the link labeled "Data Quality"
    And the AJAX "POST" request at "DataQuality/record_list.php*" tagged by "record_list" is being monitored
    And the AJAX request tagged by "record_list" has completed
    Given the AJAX "POST" request at "DataQuality/execute_ajax*" tagged by "data_quality" is being monitored
    And I click "Execute" Total Discrepancies under Rule "Test"
    #Then All data quality rules are executed 
    And the AJAX request tagged by "data_quality" has completed
    And I click "view" Total Discrepancies under Rule "Test"
    #Then I should see "ERROR: Could not process Rule #1" 
    And I should see a dialog containing the following text: "You do not have access rights to some of the fields used in the logic"
    And I click on the button labeled exactly "Close"

  Scenario: 56 Create new rule
    Given I enter "Name Test" into the field identified by "textarea[id=input_rulename_id_0]"  
    And I click the input element identified by "textarea[id=input_rulelogic_id_0]"
    And the AJAX "POST" request at "Design/logic_validate.php*" tagged by "logic_validate" is being monitored
    And I enter "[ptname_v2_v2]=''" into the field identified by "div[id=rc-ace-editor]"
    And the AJAX request tagged by "logic_validate" has completed
    And I click on the button labeled "Update & Close Editor" 
    And I check the checkbox identified by "input[id='rulerte_id_0']"
    And the AJAX "POST" request at "DataQuality/edit_rule_ajax*" tagged by "edit_rule" is being monitored
    And I click on the button labeled "Add"
    And the AJAX request tagged by "edit_rule" has completed

  Scenario: 57 Add New record for the arm selected
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    And I click on a bubble with instrument named "Text Validation" and event named "Event 1"

  Scenario:58 Name test Rule violated
    Given I should see " Adding new Record ID "
    And I enter "joe@gmail.com" into the field identified by "Input[name=email_v2]"
    And I click on the button labeled "Save & Exit Form"
    Then I should see a dialog containing the following text: "WARNING: Data Quality rules were violated!"
    And I should see "Name Test" rule violation in the table

  Scenario: 59 Exclude rule for Record 5
    Given I click on the link labeled "exclude"
    And I click on the button labeled "Close"
    And I click on the button labeled "Save & Exit Form"

  Scenario: 60 Run rule Name Test
    Given I click on the link labeled "Data Quality"
    Given the AJAX "POST" request at "DataQuality/execute_ajax.php*" tagged by "data_quality" is being monitored
    And I click "Execute" Total Discrepancies under Rule "Name Test"
    And the AJAX request tagged by "data_quality" has completed
    And I see "2" Total Discrepancies under Rule "Name Test"
    And I click "view" Total Discrepancies under Rule "Name Test"
    And I should NOT see Record "5" in the discrepancies table identified by "table[id= table-results_table_3]"
    And I click on the button labeled "Close" in the dialog box

  Scenario: 61 Edit Rule Name Test - same as Rule 35
    Given I click to edit Rule "Name Test"
    And I clear text in the field identified by "textarea[class=ace_text-input]"
    And I enter "[event_1_arm_1][ptname_v2_v2]=''" into the field identified by "div[id=rc-ace-editor]"
    And I click on the button labeled "Update & Close Editor" 
    Given the AJAX "POST" request at "Design/logic_validate*" tagged by "logic_validate" is being monitored
    #And I save the edited Rule "Name Test"
    And I click on the button labeled "Save" 
    And the AJAX request tagged by "logic_validate" has completed

  Scenario: 62 and 63 Run all rules and exclude rule D
    Given I click on the button labeled "Clear"
    And I click on the button labeled "All"
    #Given the AJAX "POST" request at "DataQuality/execute_ajax*" tagged by "data_quality" is being monitored
    Then All data quality rules are executed
    #And the AJAX request tagged by "data_quality" has completed
    And I see "1" Total Discrepancies under Rule "D"
    And I click "view" Total Discrepancies under Rule "D"
    And I exclude the top "1" rows of discrepancies table identified by "table[id=table-results_table_pd-9]"
    Then I should see "remove exclusion" in the top "1" rows of table identified by "table[id=table-results_table_pd-9]"
    #And I close the discrepancies window
    And I click on the button labeled "Close" in the dialog box
    And I click on the button labeled "Clear"
    Then All rules are reset and I see Execute button available

  Scenario: 64 Execute All rules
    Given I click on the button labeled "All"
    Then All data quality rules are executed 
    And I see "0" Total Discrepancies under Rule "D"

  Scenario:65-67 (No discrepancy found for rule D therefore View Link is not displayed.Bug fixed in version 11.1.11 )

  Scenario: 68 Create a DAG and assign User
    Given I logout
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled " My Projects"
    And I click on the link labeled "18_DataQuality_v1115"
    And I click on the link labeled "DAGs"
    And the AJAX "GET" request at "index.php?route=DataAccessGroupsController:getDagSwitcherTable&tablerowsonly*" tagged by "dataAccess" is being monitored
    And I enter "DAG1" into the field identified by "[id=new_group]"
    And the AJAX request tagged by "dataAccess" has completed
    And the AJAX "POST" request at "index.php?route=DataAccessGroupsController:ajax&pid*" tagged by "dataAccess1" is being monitored
    And I click on the button labeled " Add Group"
    And the AJAX request tagged by "dataAccess1" has completed
    And the AJAX "GET" request at "index.php?route=DataAccessGroupsController:ajax&pid*" tagged by "dataAccessUser" is being monitored
    And I select "test_user (Test User)" from the dropdown identified by "select[id=group_users]"
    And the AJAX request tagged by "dataAccessUser" has completed
    #And the AJAX "GET" request at "index.php?route=DataAccessGroupsController:getDagSwitcherTable&tablerowsonly*" tagged by "dataAccess1" is being monitored
    And I select "DAG1" from the dropdown identified by "select[id=groups]"
    #And the AJAX request tagged by "dataAccess1" has completed
    And the AJAX "POST" request at "index.php?route=DataAccessGroupsController:ajax&pid*" tagged by "dataAccessAddUser" is being monitored
    And I click on the button labeled "Assign"
    And the AJAX request tagged by "dataAccessAddUser" has completed
    

  Scenario: 69 Login and confirm DAG assigned to user
    Given I logout
    Given I am an "standard" user who logs into REDCap
    And I click on the link labeled " My Projects"
    And I click on the link labeled "18_DataQuality_v1115"
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record for the arm selected above"
    Given I click on a bubble with instrument named "Text Validation" and event named "Event 1"
    Then I should see " Adding new Record ID 1-1" 
    #And I enter "joe@gmail.com" into the field identified by "Input[name=email_v2]"
    Given I click on the button labeled "Save & Exit Form"

  Scenario: 70 Rule violation alert does not appear when data is entered into Name field
    Then I should see "WARNING: Data Quality rules were violated!"
    Then I should see "Name Test" rule violation in the table
    And  I click on the button labeled "Close"
    And I enter "JOE" into the field identified by "Input[name=ptname_v2_v2]"
    And  I click on the button labeled "Save & Exit Form"
    Then I should NOT see "WARNING: Data Quality rules were violated!"

  Scenario: 71 Execute all rules
    Given I click on the link labeled "Data Quality"
    And I click on the button labeled "All"
    Then All data quality rules are executed 
    And I see "1" Total Discrepancies under Rule "A"
    And I click "view" Total Discrepancies under Rule "A"
    Then Discrepancies for Record "1-1", should appear in the table identified by "table[id=table-results_table_pd-3]"

  Scenario: 72 Login as Admin and confirm Admin sees a higher number of discrepancies
    Given I logout
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled " My Projects"
    Given the AJAX "POST" request at "ProjectGeneral/project_stats*" tagged by "project_stats" is being monitored
    And I click on the link labeled "18_DataQuality_v1115"
    And the AJAX request tagged by "project_stats" has completed
    Given I click on the link labeled "Data Quality"
    Given the AJAX "POST" request at "DataQuality/record_list.php*" tagged by "record_list" is being monitored
    And I click on the button labeled "All"
    And the AJAX request tagged by "record_list" has completed
    And All data quality rules are executed 
    And I see "30" Total Discrepancies under Rule "A"
    And I click "view" Total Discrepancies under Rule "A"
    Then Discrepancies for Record "1-1", should appear in the table identified by "table[id=table-results_table_pd-3]"

  Scenario: 73 and 74 Test User2 should not have access to Data quality rules
    Given I logout
    Given I am a "standard2" user who logs into REDCap 
    And the AJAX "POST" request at "ProjectGeneral/project_stats*" tagged by "project_stats" is being monitored
    And I click on the link labeled " My Projects"
    And the AJAX request tagged by "project_stats" has completed
    And I click on the link labeled "18_DataQuality_v1115"
    And I should NOT see "Data Quality"

  Scenario: 75
    Given I logout

