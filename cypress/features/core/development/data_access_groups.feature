Feature: Data Access Groups (DAGs)

  As a REDCap end user
  I want to see that Data Access Groups (DAGs) are functioning as expected

Scenario: Project Setup - 1
    Given I am an "admin" user who logs into REDCap
    And I create a project named "10_DataAccessGroups_v1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
    When I click on the link labeled "User Rights"
    And I enter "test_user" into the field identified by "[id=new_username]"
    And I click on the button labeled "Add with custom rights"
    And I click on the checkbox identified by "[name=design]"
    And I click on the checkbox identified by "[name=user_rights]"
    And I click on the checkbox identified by "[name=data_access_groups]"
    And I click on the button labeled "Add user"

Scenario: Project Setup - 2   
    When I click on the link labeled "Project Setup"
    When I click on the link labeled "Other Functionality"
    And I click on the button labeled "Erase all data"
    And I click on the button labeled "Erase all data" in the dialog box 
    And I close popup

    When I click on the link labeled "Project Setup"
    When I click on the element identified by "[id=setupEnableSurveysBtn]"
    Then I should see that surveys are enabled

    When I click on the element identified by "[id=setupLongiBtn]"
    And I click on the button labeled "Disable" in the dialog box
    Then I should see that longitudinal mode is "disabled"

    When I click on the element identified by "[id=enableRepeatingFormsEventsBtn]"
    And I click on the checkbox identified by "[name=repeat_form-41-data_types]"
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
    Given I upload a data dictionary located at "core/10_DataAccessGroups_v1115_DataDictionary.csv" to project ID 14
    #fails because project is not in production (and not in draft mode) so box reads "Changes Made Successfully!" and not "Changes to the DRAFT have been made successfully!"
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
    When I click on the link labeled "DAGs"

Scenario: 7 - Create Data Access 1 Group
    When I enter "Data Access 1" into the field identified by "[id=new_group]"
    And I click on the button labeled "Add Group"

Scenario: 8 - 

   



