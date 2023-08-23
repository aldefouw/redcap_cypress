Feature: B.2.10.500 Data Access Groups-DAGs User Interface: The system shall provide the ability to assign records to a DAG from the Record Home page

  As a REDCap end user
  I want to see that Data Access Groups is functioning as expected

  Scenario: B.2.10.500.100 Assign DAG to record
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.10.500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.500.100"
    And I click on the link labeled "Add / Edit Records"
    And I select record ID "2" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    Then I should see "Record Home Page"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Assign Record DAG
    Given I click on the span element labeled "Choose action for record"
    And I click on the link labeled "Assign to Data Access Group"
    Then I should see a dialog containing the following text: "Assign record to a Data Access Group?"

    When I select "TestGroup1" on the dropdown field labeled "Assign record" on the dialog box
    And I click on the button labeled "Assign to Data Access Group" in the dialog box
    Then I should see "Record ID 2 was successfully assigned to a Data Access Group"

    ##VERIFY
    Then I should see "Record Home Page"
    And I should see "TestGroup1"

    ##VERIFY_LOG:
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported    |
      | mm/dd/yyyy hh:mm | test_admin | Update record | Assign record to Data Access Group        |
      | mm/dd/yyyy hh:mm | test_admin | Update record | (redcap_data_access_group = 'testgroup1') |