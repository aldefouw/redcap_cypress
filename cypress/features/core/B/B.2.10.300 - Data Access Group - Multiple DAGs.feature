Feature: B.2.10.300 Data Access Groups-DAGs User Interface: The system shall allow a user to be added to more than one DAG.

  As a REDCap end user
  I want to see that Data Access Groups is functioning as expected

  Scenario: B.2.10.300.100 Assign user multiple DAGs and DAG Switcher
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.10.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml" and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.300.100"
    And I click on the link labeled "User Rights"
    And I select "Upload users (CSV) " from the dropdown "Upload or download users, roles, and assignments"
    And I choose file "User_list_for_Project_1" and click the "Upload" button
    And I click the button "Upload"
    Then I should see "Test_User1"

    When I assign the "1_FullRights" user role to the username "Test_User1"
    And I click on the link labeled "DAGs"
    Then I should see "Assign user to a group"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Assign DAG
    When I select "Test_User1" from "Assign User" dropdown
    And I select "TestGroup1" from "DAG" dropdown
    And I click on the link labeled "Assign"

    ##VERIFY
    Then I should see "TestGroup1" assigned to "Test_User1"user

    ##ACTION: Assign DAG
    When I select "Test_User1" from "Assign User" dropdown
    And I select "TestGroup2" from "DAG" dropdown
    And I click on the link labeled "Assign"

    ##VERIFY
    Then I should see "TestGroup2" assigned to "Test_User1" user

    ##ACTION: Assign DAG Switcher
    When I select "TestGroup1" for user "Test_User1" in the DAG Switcher
    And I select "TestGroup2" for user "Test_User1" in the DAG Switcher
    Then I should see a checkbox labeled "TestGroup1" that is checked for user "Test_User1"
    And I should see a checkbox labeled "TestGroup2" that is checked for user "Test_User1"

    When I logout
    Given I login to REDCap with the use "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "Project_1"
    ##VERIFY
    Then I should see "Current Data Access Group"

    ##ACTION: Switch DAG
    When I click on the link labeled "Switch"
    And I select "TestGroup1" from the Switch dropdown of the open "Switch Data Access Group " dialog box
    And I click on the link labeled "Switch"

    ##VERIFY
    Then I should see "TestGroup1"

    ##VERIFY_RSD:
    When I click the link labeled "Record Status Dashboard"
    Then I should see "3"

    ##VERIFY
    When I select "TestGroup1" from the Switch dropdown of the open "Switch Data Access Group" dialog box
    And I click on the link labeled "Switch"
    Then I should see "TestGroup2"

    ##VERIFY_RSD:
    When I click the link labeled "Record Status Dashboard"
    Then I should see "4" 