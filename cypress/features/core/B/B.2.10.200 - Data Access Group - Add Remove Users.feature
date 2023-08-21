Feature: B.2.10.200 Data Access Groups-DAGs User Interface: The system shall support adding and removing users from DAGs.

  As a REDCap end user
  I want to see that Data Access Groups is functioning as expected

  Scenario: B.2.10.200.100 Assign & Remove User to DAG
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.10.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml" and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.200.100"
    And I click on the link labeled "User Rights"
    And I select "Upload users (CSV)" from the dropdown "Upload or download users, roles, and assignments"
    And I choose file "User_list_for_Project_1" and click the "Upload" button
    And I click the button "Upload"
    Then I should see "Test_User1"
    And I click on the link labeled "DAGs"
    Then I should see "Assign user to a group"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Assign User to DAG
    When I select "Test_User1" from "Assign User" dropdown
    And I select "TestGroup1" from "DAG" dropdown
    And I click on the link labeled "Assign"
    ##VERIFY: DAG assignment
    Then I should see "TestGroup1" assigned to "Test_User1" user
    ##VERIFY_LOG:
    When I click on the button labeled "Logging"
    Then I should see “Assign user to data access group” in the logging table
    And I logout
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.200.100"
    ##VERIFY: Access to DAG Module restricted
    And I click on the link labeled "Data Access Group"
    Then I should see "RESTRICTED:"
    ##VERIFY_UR: DAG assignment
    When I click on “User Rights”
    Then I should see "TestGroup1" assigned to "Test_User1"user
    ##VERIFY_RSD:
    When I click on "Record Status Dashboard"
    Then I should see "3"
    And I should NOT see "1"

    #SETUP
    And I logout
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.200.100"
    And I click on the link labeled "DAGs"
    Then I should see "Assign user to a group"
    ##ACTION: Remove DAG
    When I select "Test_User1" from "Assign User" dropdown
    And I select "[No Assignment]" from "DAG" dropdown
    And I click on the link labeled "Assign"
    ##VERIFY
    Then I should see "[No Assignment]" assigned to "Test_User1" user
    And I logout
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.200.100"
    ##VERIFY: Access to DAG Module
    And I click on the link labeled "Data Access Group"
    Then I should see "Assign user to a group"
    ##VERIFY_UR
    When I click on “User Rights”
    Then I should see "-" assigned to "Test_User1"user
    ##VERIFY_RSD:
    When I click on "Record Status Dashboard"
    Then I should see "3"
    And I should see "1"
