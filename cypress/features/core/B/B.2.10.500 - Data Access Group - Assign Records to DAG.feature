Feature: B.2.10.500 Data Access Groups-DAGs User Interface: The system shall provide the ability to assign records to a DAG from the Record Home page

  As a REDCap end user
  I want to see that Data Access Groups is functioning as expected

  Scenario: B.2.10.500.100 Assign DAG to record
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.10.500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml" and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.500.100"
    And I select record ID "2" from arm name "event_1_arm_1" on the Add / Edit record page
    Then I should see the "Record Home Page"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Assign Record DAG
    When I select "Assign to a Data Access Group" from the dropdown "Choose action for record"
    And I assign Data Access Group "TestGroup1"

    ##VERIFY
    Then I should see "Record Home Page"
    And I should see "TestGroup1"

    ##VERIFY_LOG:
    When I click on the link labeled "Logging"
    Then I should see "Assign record to Data Access Group” in the logging table