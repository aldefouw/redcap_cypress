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
    When I select record ID "3" from arm name "event_1_arm_1" on the Add / Edit record page
    Then I should see the "Record Home Page"
    When I select "Assign to a Data Access Group" from the dropdown "Choose action for record"
    And I assign Data Access Group "TestGroup1"
    Then I should see the "Record Home Page"
    And I should see the "TestGroup1"
    When I select record ID "4" from arm name "event_1_arm_1" on the Add / Edit record page
    Then I should see the "Record Home Page"
    When I select "Assign to a Data Access Group" from the dropdown "Choose action for record"
    And I assign Data Access Group "TestGroup2"
    Then I should see the "Record Home Page"
    And I should see the "TestGroup2"

    ##VERIFY_DE
    When I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "View Report"
    Then I should see "TestGroup1" within the column labeled "Data Access Group" for record 3
    And I should see "TestGroup2" within the column labeled "Data Access Group" for record 4
