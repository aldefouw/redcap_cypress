Feature: Data Access Groups (DAGs)

  As a REDCap end user
  I want to see that Data Access Groups (DAGs) are functioning as expected

Scenario: Project Setup - 1
    Given I am an "admin" user who logs into REDCap
    And I create a project named "10_DataAccessGroups_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
    When I click on the link labeled "User Rights"
    And I assign the "Project Design and Setup" user right to the user named "Test User" with the username of "test_user"

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
    And I enter "testuser" into the field identified by "[id=custom_record_label]"

Scenario: 1 - Login as Test User
    Given I am a "standard" user who logs into REDCap

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

Scenario: 5 - DagTest instrument
    When I click on the link labeled "Designer"
    And I click on the button labeled "Enable"
    And I click on the button labeled "Save Changes"

Scenario: 6 - DAG Link
#    When I click on the link labeled "DAGs"

Scenario: 7 - Create Data Access 1 Group
#    When I enter "Data Access 1" into the field identified by "[id=new_group]"
#    And I click on the button labeled "Add Group"

Scenario: 8 - 

   



