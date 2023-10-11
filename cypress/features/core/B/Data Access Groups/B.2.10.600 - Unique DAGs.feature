Feature: B.2.10.600 Data Access Groups-DAGs User Interface: The system shall provide the DAG unique group names in the data export raw CSV file and the label in the CSV labels data file of the same DAG

  As a REDCap end user
  I want to see that Data Access Groups is functioning as expected

  Scenario: B.2.10.600.100 Unique DAGs
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.10.600.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.600.100"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Record assigned DAG
    Given I click on the link labeled "Add / Edit Records"
    When I select record ID "3" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    Then I should see "Record Home Page"

    Given I click on the span element labeled "Choose action for record"
    And I click on the link labeled "Assign to Data Access Group"
    Then I should see a dialog containing the following text: "Assign record to a Data Access Group?"

    When I select "TestGroup1" on the dropdown field labeled "Assign record" on the dialog box
    And I click on the button labeled "Assign to Data Access Group" in the dialog box
    Then I should see "Record ID 3 was successfully assigned to a Data Access Group"

    Then I should see "Record Home Page"
    And I should see "TestGroup1"

    Given I click on the link labeled "Add / Edit Records"
    When I select record ID "4" from arm name "Arm 1: Arm 1" on the Add / Edit record page
    Then I should see "Record Home Page"

    Given I click on the span element labeled "Choose action for record"
    And I click on the link labeled "Assign to Data Access Group"
    Then I should see a dialog containing the following text: "Assign record to a Data Access Group?"

    When I select "TestGroup2" on the dropdown field labeled "Assign record" on the dialog box
    And I click on the button labeled "Assign to Data Access Group" in the dialog box
    Then I should see "Record ID 4 was successfully assigned to a Data Access Group"

    Then I should see "Record Home Page"
    And I should see "TestGroup2"

    ##VERIFY_DE
    Given I click on the link labeled "Data Exports, Reports, and Stats"
    Then I see a table rows containing the following values in the reports table:
      | A | All data (all records and fields)  |
      | B | Selected instruments and/or events |

    When I click on the button labeled "View Report"
    Then I should see a table header and rows containing the following values in the report data table:
      | Record ID | Data Access Group      |
      | 1         |                        |
      | 2         |                        |
      | 3         | TestGroup1             |
      | 4         | TestGroup2             |
