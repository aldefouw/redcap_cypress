Feature: Data Access Groups (DAGs)

  As a REDCap end user
  I want to see that Data Access Groups (DAGs) are functioning as expected

#   Added user test_user3
#   Added the following record in advanced.sql: (8,'test_user3','test_user3@example.com','Test','User', 0, 0, 0, 0, 0, 0)
#   Added the following record in auth.sql: ('test_user3','041a2000c14ebefc3fc334cc02dfce4ca4f3552a48f8e2b37c928089d5f7487c52cdc79c90fde50a0ac3a17d1424681fc82c02d2f56f7bb93e315a2e90b4308f','dnuX#SD.#tCve5IjqYB-ueI~D~NFVyIow!xKbW-vM5-aHASdBdDSAja@3j~jkhWyuerjdt22X$W$o&hEY&bK%ojr-AVr4o*kE6cT',0,0,2)
#   Added standard3 user to cypress.env.json

Scenario: Project Setup - 1
    Given I am an "admin" user who logs into REDCap
    And I create a project named "10_DataAccessGroups_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
    When I click on the link labeled "User Rights"

    And I assign the "Project Design and Setup" user right to the user named "Test User" with the username of "test_user"
    Then I should see "was successfully edited"
    
    And I assign the "Project Design and Setup" user right to the user named "Test User" with the username of "test_user2"
    Then I should see "was successfully edited"
    
    And I assign the "Project Design and Setup" user right to the user named "Test User" with the username of "test_user3"
    Then I should see "was successfully edited"

Scenario: Project Setup - 2   
    When I click on the link labeled "Project Setup"
    When I click on the link labeled "Other Functionality"
    And I click on the button labeled "Erase all data"
    And I click on the button labeled "Erase all data" in the dialog box 
    And I close the popup

    When I click on the link labeled "Project Setup"
    And I enable surveys for the project
    Then I should see that surveys are enabled

    And I disable longitudinal mode
    Then I should see that longitudinal mode is "disabled"

    And I open the dialog box for the Repeatable Instruments and Events module
    And I check the checkbox labeled "Text Validation"
    And I check the checkbox labeled "Data Types"
    And I uncheck the checkbox labeled "Text Validation"
    And I uncheck the checkbox labeled "Data Types"
    And I click on the button labeled "Save" in the dialog box

    And I should see that repeatable instruments are disabled

    When I should see that auto-numbering is "enabled"
    And I should see that the scheduling module is "disabled"
    And I should see that the randomization module is "disabled"
    And I should see that the designate an email field for communications setting is "disabled"

    When I click on the button labeled "Additional customizations"
    And I check the checkbox identified by "[id=custom_record_label_chkbx]"
    And I enter "[name]" into the field identified by "[id=custom_record_label]"
    And I click on the button labeled "Save" in the dialog box

Scenario: 1 - Login as Test User
    Given I am an "admin" user who logs into REDCap

Scenario: 2 - Go to My Projects Page
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "10_DataAccessGroups_v1115"

Scenario: 3 - Upload Data Dictionary
    When I click on the button labeled "Data Dictionary"
    And I upload the data dictionary located at "core/10_DataAccessGroups_v1115_DataDictionary.csv"
    Then I should see "Changes Made Successfully!"

Scenario: 4 - Designate and Email Field 
    When I click on the link labeled "Project Setup"
    Then I should see that the designate an email field for communications setting is "enabled"
    And I should see "email"

Scenario: 5 - Enable Dag Test instrument as survey
    Given I click on the link labeled "Designer"
    Then I should see "Dag Test"
    And I should see the instrument labeled "Dag Test" is not a survey
    And I enable surveys for the data instrument named "Dag Test"
    Then I should see "Your survey settings were successfully saved!"
    Then I should see the instrument labeled "Dag Test" is a survey

Scenario: 6 - DAG Link
   When I click on the link labeled "DAGs"
   Then I should see "Data Access Groups"
   And I should see "[Not assigned to a group]"

Scenario: 7 - Create DAG Data Access 1
   When I enter "Data Access 1" into the field identified by "[id=new_group]"
   And I click on the button labeled "Add Group"
   Then I should see "has been created!"
   And I should see "Data Access 1" in the column named "Data Access Groups"

Scenario: 8 - Assign users to DAG Data Access 1
    Then I should see "Assign user to a group"
    And I should see "Users in group"
    And I select "Data Access 1" from the dropdown identified by "select[id=groups]"
    And I should see the dropdown identified by "select[id=groups]" with the option "Data Access 1" selected
    Then I should see "Assign user to a group"
    And I should see "Users in group"
    And I select "test_user3 (Test User)" from the dropdown identified by "select[id=group_users]"
    Then I should see the dropdown identified by "select[id=group_users]" with the option "test_user3 (Test User)" selected
    And I click on the button labeled "Assign"
    And I wait for 4 seconds
    Then I should see "Assign user to a group"
    And I should see "Users in group"
    Then I should see "has been assigned to Data Access Group"
    And I should see "test_user3 (Test User)" in the column named "Users in group"
    And I should see "test_user3 (Test User)" user in the DAG named "Data Access 1"
  
    Then I should see "Assign user to a group"
    And I should see "Users in group"
    And I select "Data Access 1" from the dropdown identified by "select[id=groups]"
    And I should see the dropdown identified by "select[id=groups]" with the option "Data Access 1" selected
    Then I should see "Assign user to a group"
    And I should see "Users in group"
    And I select "test_user (Test User)" from the dropdown identified by "select[id=group_users]"
    Then I should see the dropdown identified by "select[id=group_users]" with the option "test_user (Test User)" selected
    And I click on the button labeled "Assign"
    And I wait for 4 seconds
    Then I should see "Assign user to a group"
    And I should see "Users in group"
    Then I should see "has been assigned to Data Access Group"
    And I should see "test_user (Test User),test_user3 (Test User)" in the column named "Users in group"
    And I should see "test_user (Test User),test_user3 (Test User)" users in the DAG named "Data Access 1"
   
Scenario: 9 - Create DAG Data Access 2
    And I click on the link labeled "My Projects"
    And I click on the link labeled "10_DataAccessGroups_v1115"
    And I click on the link labeled "DAGs"
    Then I should see "Assign user to a group"
    And I should see "Users in group"
    When I enter "Data Access 2" into the field identified by "[id=new_group]"
    And I click on the button labeled "Add Group"
    Then I should see "has been created!"
    And I should see "Data Access 2" in the column named "Data Access Groups"
 
Scenario: 10 - Assign user to DAG Data Access 2
    When I select "Data Access 2" from the dropdown identified by "select[id=groups]"
    And I should see the dropdown identified by "select[id=groups]" with the option "Data Access 2" selected
    Then I should see "Assign user to a group"
    And I should see "Users in group"
    And I select "test_user2 (Test User)" from the dropdown identified by "select[id=group_users]"
    Then I should see the dropdown identified by "select[id=group_users]" with the option "test_user2 (Test User)" selected
    And I click on the button labeled "Assign"
    And I wait for 4 seconds
    Then I should see "Assign user to a group"
    And I should see "Users in group"
    Then I should see "has been assigned to Data Access Group"
    And I should see "test_user2 (Test User)" in the column named "Users in group"
    And I should see "test_user2 (Test User)" user in the DAG named "Data Access 2"
    
Scenario: 11 - Add a record to DAG 1
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I select "Data Access 1" from the dropdown identified by "select[name=__GROUPID__]"
    And I enter "Record1" into the field identified by "input[name=name]"
    And I enter "record1@abc.com" into the field identified by "input[name=email]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully added"
    And I should see "Data Access 1"
    And I should see "1"
    And I should see "Record1"

Scenario: 12 - Check email in Participant List in Survey Distribution Tools
    Given I click on the link labeled "Survey Distribution Tools"
    Then I click on the link labeled "Participant List"
    And I should see "Email"
    And I should see "Record"
    And I should see "Participant Identifier"
    And I should see "Responded?"
    And I should see "Invitation Scheduled?"
    And I should see "Invitation Sent?"
    And I should see "Link"
    And I should see "Survey Access Code and"
    And I should see "QR Code"
    And I should see "record1@abc.com"
    Then I logout

Scenario: 13 - Add a record to DAG 2 and check email in Participant List in Survey Distribution Tools
    Given I am a "standard2" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "10_DataAccessGroups_v1115"
    Then I click on the link labeled "Record Status Dashboard"
    And I should NOT see "Record1"
    Then I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I enter "Record2" into the field identified by "input[name=name]"
    And I enter "record2@abc.com" into the field identified by "input[name=email]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully added"
    And I should see "Data Access 2"
    And I should see "2"
    And I should see "Record2"
    Then I click on the link labeled "Survey Distribution Tools"
    Then I click on the link labeled "Participant List"
    And I should see "record2@abc.com"
    And I should NOT see "record1@abc.com"
    Then I logout

Scenario: 14 - test_user3 access of records
    Given I am a "standard3" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "10_DataAccessGroups_v1115"
    Then I click on the link labeled "Record Status Dashboard"
    And I should see "Record1"
    And I should NOT see "Record2"
    Then I click on the link labeled "Survey Distribution Tools"
    Then I click on the link labeled "Participant List"
    And I should see "record1@abc.com"
    And I should NOT see "record2@abc.com"
    Then I logout

Scenario: 15 - test_user access of records
    Given I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "10_DataAccessGroups_v1115"
    Then I click on the link labeled "Record Status Dashboard"
    And I should see "Record1"
    And I should NOT see "Record2"
    Then I click on the link labeled "Survey Distribution Tools"
    Then I click on the link labeled "Participant List"
    And I should see "record1@abc.com"
    And I should NOT see "record2@abc.com"
    Then I logout

Scenario: 16 - Add Record3 and check if test_admin can access all records
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "10_DataAccessGroups_v1115"
    Then I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I enter "Record3" into the field identified by "input[name=name]"
    And I enter "record3@abc.com" into the field identified by "input[name=email]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully added"
    And I should see "3"
    Then I click on the link labeled "Record Status Dashboard"
    And I should see "Record1"
    And I should see "Record2"
    And I should see "Record3"
    Then I click on the link labeled "Survey Distribution Tools"
    Then I click on the link labeled "Participant List"
    And I should see "record1@abc.com"
    And I should see "record2@abc.com"
    And I should see "record3@abc.com"

Scenario: 17 - Unassign test_user and test_user3 from DAG1
    Given I click on the link labeled "DAGs"
    And I select "[No Assignment]" from the dropdown identified by "select[id=groups]"
    And I should see the dropdown identified by "select[id=groups]" with the option "[No Assignment]" selected
    Then I should see "Assign user to a group"
    And I should see "Users in group"
    And I select "test_user (Test User)" from the dropdown identified by "select[id=group_users]"
    Then I should see the dropdown identified by "select[id=group_users]" with the option "test_user (Test User)" selected
    And I click on the button labeled "Assign"
    And I wait for 4 seconds
    Then I should see "is no longer assigned to a Data Access Group!"
    And I should see "test_admin (Test User),test_user (Test User)" in the column named "Users in group"
    And I should see "test_admin (Test User),test_user (Test User)" users in the DAG named "[Not assigned to a group]"

    And I select "[No Assignment]" from the dropdown identified by "select[id=groups]"
    And I should see the dropdown identified by "select[id=groups]" with the option "[No Assignment]" selected
    Then I should see "Assign user to a group"
    And I should see "Users in group"
    And I select "test_user3 (Test User)" from the dropdown identified by "select[id=group_users]"
    Then I should see the dropdown identified by "select[id=group_users]" with the option "test_user3 (Test User)" selected
    And I click on the button labeled "Assign"
    And I wait for 4 seconds
    Then I should see "is no longer assigned to a Data Access Group!"
    And I should see "test_admin (Test User),test_user (Test User),test_user3 (Test User)" in the column named "Users in group"
    And I should see "test_admin (Test User),test_user (Test User),test_user3 (Test User)" users in the DAG named "[Not assigned to a group]"

Scenario: 18 -  Assign Record3 to DAG2
    Given I click on the link labeled "Add / Edit Records"
    And I select "2 Record3" from the dropdown identified by "select[id=record]"
    Then I should see "2"
    Then I should see "Record3"
    And I should see "Choose action for record"
    And I click on the button labeled "Choose action for record"
    And I click on the link labeled "Assign to Data Access Group"
    And I select "Data Access 2" from the dropdown identified by "select[id=new-dag-record]"
    And I click on the button labeled "Assign to Data Access Group"
    Then I should see "was successfully assigned to a Data Access Group!"
    And I should see "Record3"
    And I should see "Data Access 2"
    Then I logout

Scenario: 19 - test_user can see all 3 records
    Given I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "10_DataAccessGroups_v1115"
    Then I click on the link labeled "Record Status Dashboard"
    And I should see "Record1"
    And I should see "Record2"
    And I should see "Record3"
    Then I click on the link labeled "Survey Distribution Tools"
    Then I click on the link labeled "Participant List"
    And I should see "record1@abc.com"
    And I should see "record2@abc.com"
    And I should see "record3@abc.com"
    Then I logout

Scenario: 20 - test_user2 can see 2 records
    Given I am a "standard2" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "10_DataAccessGroups_v1115"
    Then I click on the link labeled "Record Status Dashboard"
    And I should NOT see "Record1"
    And I should see "Record2"
    And I should see "Record3"
    Then I click on the link labeled "Survey Distribution Tools"
    Then I click on the link labeled "Participant List"
    And I should NOT see "record1@abc.com"
    And I should see "record2@abc.com"
    And I should see "record3@abc.com"
    Then I logout

Scenario: 21 - Try deleteling DAG2
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "10_DataAccessGroups_v1115"
    Then I click on the link labeled "DAGs"
    And I click on the image "cross" link for the row containing "Data Access 2"
    And I click on the button labeled "Delete"
    And I wait for 2 seconds
    Then I should see "The group could not be deleted because one or more records are still assigned to it."

Scenario: 22 - Try deleteling DAG1
    And I click on the image "cross" link for the row containing "Data Access 1"
    And I click on the button labeled "Delete"
    Then I should see "The group could not be deleted because one or more records are still assigned to it."
    
Scenario: 23 - Delete Record1
    Given I click on the link labeled "Add / Edit Records"
    And I select "1 Record1" from the dropdown identified by "select[id=record]"
    Then I should see "1"
    And I should see "Record1"
    And I should see "Data Access 1"
    And I click on the button labeled "Choose action for record"
    And I select the option labeled "Delete record (all forms)"
    And I click on the button labeled "DELETE RECORD" in the dialog box
    Then I should see 'Record ID "1" was successfully deleted.'
    And I close the popup

Scenario: 24 -  Export data and check DAG name for record
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    Then I should see "Export Data"
    When I export data for the report named "All data" in "csvraw" format
    Then I should see "Data export was successful!"
    Then I should receive a download to a "csv" file
    Then I should have a "csv" file that contains the data "data_access_2" for record ID "2" and fieldname "redcap_data_access_group"
    Then I should have a "csv" file that contains the data "data_access_2" for record ID "2-1" and fieldname "redcap_data_access_group"
    And I click on the button labeled "Close" in the dialog box
    Then I should see "My Reports & Exports"

Scenario: 25 -  Add new record and assign to DAG1. Assign test_user2 to DAG1 and DAG2
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    And I enter "Record4" into the field identified by "input[name=name]"
    And I enter "record4@abc.com" into the field identified by "input[name=email]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully added"
    And I should see "Record4"
    And I should see "Choose action for record"
    And I click on the button labeled "Choose action for record"
    And I click on the link labeled "Assign to Data Access Group"
    And I select "Data Access 1" from the dropdown identified by "select[id=new-dag-record]"
    And I click on the button labeled "Assign to Data Access Group"
    Then I should see "was successfully assigned to a Data Access Group!"
    And I should see "Record4"
    And I should see "Data Access 1"

    Then I click on the link labeled "DAGs"
    And I check the checkbox identified by "input[title='Data Access 1 : test_user2']"
    And I check the checkbox identified by "input[title='Data Access 2 : test_user2']"    
    And I wait for 2 seconds
    And I should see the checkbox identified by "input[title='Data Access 1 : test_user2']", checked
    And I should see the checkbox identified by "input[title='Data Access 2 : test_user2']", checked
    And I logout

Scenario: 26 - Change DAGs with 'Switch' button
    Given I am an "standard2" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "10_DataAccessGroups_v1115"
    Then I click on the link labeled "Record Status Dashboard"
    And I should see "Data Access 2"
    And I should see "Record2"
    And I should see "Record3"
    And I should see a button labeled "Switch"
    Then I click on the button labeled "Switch"
    And I should see the dropdown identified by "select[id=dag-switcher-change-select]" with the option "Data Access 1" selected
    Then I click on the button labeled "Switch"
    Then I should see "Successfully switched"
    Then I click on the button labeled "OK"
    And I should see "Data Access 1"
    And I should see "Record4"
    And I logout

Scenario: 27 - Check test_user2 is in DAG1
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "10_DataAccessGroups_v1115"
    Then I click on the link labeled "DAGs"
    Then I should see "Assign user to a group"
    And I should see "Users in group"
    And I should see "test_user2 (Test User)" in the column named "Users in group"
    And I should see "test_user2 (Test User)" user in the DAG named "Data Access 1"

Scenario: 28 - Remove users and records from DAG and delete DAG
    And I should see "1" in the column named "Number of records in group"
    And I should see "1" record in the DAG named "Data Access 1"
    And I should see "2" in the column named "Number of records in group"
    And I should see "2" records in the DAG named "Data Access 2"

    And I should see "test_user2 (Test User)" user in the DAG named "Data Access 1"
    And I should see "test_admin (Test User),test_user (Test User),test_user3 (Test User)" users in the DAG named "[Not assigned to a group]"

    Then I select "[No Assignment]" from the dropdown identified by "select[id=groups]"
    And I should see the dropdown identified by "select[id=groups]" with the option "[No Assignment]" selected
    Then I should see "Assign user to a group"
    And I should see "Users in group"
    And I select "test_user2 (Test User)" from the dropdown identified by "select[id=group_users]"
    Then I should see the dropdown identified by "select[id=group_users]" with the option "test_user2 (Test User)" selected
    And I click on the button labeled "Assign"
    And I wait for 4 seconds
    Then I should see "is no longer assigned to a Data Access Group!"
    And I should see "test_admin (Test User),test_user (Test User),test_user2 (Test User),test_user3 (Test User)" users in the DAG named "[Not assigned to a group]"
    
    Then I click on the link labeled "Add / Edit Records"
    And I select "2-1 Record2" from the dropdown identified by "select[id=record]"
    And I should see "Record2"
    Then I click on the link labeled "2-1"
    And I should see "Data Access 2"
    And I click on the button labeled "Choose action for record"
    And I select the option labeled "Assign to Data Access Group (or unassign/reassign)"
    And I select "[No Assignment]" from the dropdown identified by "select[id=new-dag-record]"
    And I click on the button labeled "Assign to Data Access Group"
    Then I should see "was successfully unassigned from its Data Access Group!"
    And I should see "Record2"

    Then I click on the link labeled "Add / Edit Records"
    And I select "2 Record3" from the dropdown identified by "select[id=record]"
    And I should see "Record3"
    Then I click on the link labeled "2"
    And I should see "Data Access 2"
    And I click on the button labeled "Choose action for record"
    And I select the option labeled "Assign to Data Access Group (or unassign/reassign)"
    And I select "[No Assignment]" from the dropdown identified by "select[id=new-dag-record]"
    And I click on the button labeled "Assign to Data Access Group"
    Then I should see "was successfully unassigned from its Data Access Group!"
    And I should see "Record3"

    Then I click on the link labeled "Add / Edit Records"
    And I select "3 Record4" from the dropdown identified by "select[id=record]"
    And I should see "Record4"
    Then I click on the link labeled "3"
    And I should see "Data Access 1"
    And I click on the button labeled "Choose action for record"
    And I select the option labeled "Assign to Data Access Group (or unassign/reassign)"
    And I select "[No Assignment]" from the dropdown identified by "select[id=new-dag-record]"
    And I click on the button labeled "Assign to Data Access Group"
    Then I should see "was successfully unassigned from its Data Access Group!"
    And I should see "Record4"

    Then I click on the link labeled "DAGs"
    And I should see "0" in the column named "Number of records in group"
    And I should see "0" record in the DAG named "Data Access 1"
    And I should see "0" record in the DAG named "Data Access 2"
    And I should see "3" records in the DAG named "[Not assigned to a group]"

    And I click on the image "cross" link for the row containing "Data Access 1"
    And I click on the button labeled "Delete"
    And I wait for 2 seconds
    Then I should see "has been deleted!"
    And I click on the link labeled "DAGs"
    And I should see "Data Access 2"
    And I should NOT see "Data Access 1"

Scenario: 29 - Logout
    Then I logout