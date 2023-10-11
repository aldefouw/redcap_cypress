Feature: B.2.10.100 Data Access Groups-DAGs User Interface: The system shall allow for the creation of DAGs and the deletion of DAGs if no users or records are assigned to it.

  As a REDCap end user
  I want to see that Data Access Groups is functioning as expected

  Scenario: B.2.10.100.100 Create, Edit & Delete DAGs
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.10.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.100.100"
    And I click on the link labeled "DAGs"
    Then I should see "Assign user to a group"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Create DAG
    When I enter "TestGroup3" into the field with the placeholder text of "Enter new group name"
    And I click on the button labeled "Add Group"

    ##VERIFY
    Then I should see a table header and rows containing the following values in data access groups table:
      | Data Access Groups      |
      | TestGroup1              |
      | TestGroup2              |
      | TestGroup3              |

    ##ACTION: Edit DAG
    When I click on a table cell containing the text "TestGroup3" in the data access groups table and clear field and enter "RenameGroup3"

    ##VERIFY
    Then I should see a table header and rows containing the following values in data access groups table:
      | Data Access Groups      |
      | TestGroup1              |
      | TestGroup2              |
      | RenameGroup3            |

    ##ACTION: Delete DAG
    Given I click the X to delete the data access group named "RenameGroup3"
    Then I should see a dialog containing the following text: "Delete group?"
    When I click on the button labeled "Delete" on the dialog box

    ##VERIFY
    Then I should see a table header and rows containing the following values in data access groups table:
      | Data Access Groups      |
      | TestGroup1              |
      | TestGroup2              |
    Then I should NOT see "RenameGroup3"