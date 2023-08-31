Feature: B.2.10.300 Data Access Groups-DAGs User Interface: The system shall allow a user to be added to more than one DAG.

  As a REDCap end user
  I want to see that Data Access Groups is functioning as expected

  Scenario: B.2.10.300.100 Assign user multiple DAGs and DAG Switcher
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.10.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.300.100"
    And I click on the link labeled "User Rights"
    And I click on the button labeled "Upload or download users, roles, and assignments"
    Then I should see "Upload users (CSV)"

    When I click on the link labeled "Upload users (CSV)"
    Then I should see a dialog containing the following text: "Upload users (CSV)"

    Given I upload a "csv" format file located at "import_files/user list for project 1.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see a dialog containing the following text: "Upload users (CSV) - Confirm"
    And I should see a table header and rows containing the following values in a table:
      | username   |
      | test_user1 |
      | test_user2 |
      | test_user3 |
      | test_user4 |

    Given I click on the button labeled "Upload"
    Then I should see a dialog containing the following text: "SUCCESS!"

    When I close the popup
    Then I should see a table header and rows containing the following values in a table:
      |Role name                | Username            |
      | —                       | test_admin          |
      | —                       | test_user1          |
      | —                       | test_user2          |
      | —                       | test_user3          |
      | —                       | test_user4          |
      | 1_FullRights            | [No users assigned] |
      | 2_Edit_RemoveID         | [No users assigned] |
      | 3_ReadOnly_Deidentified | [No users assigned] |
      | 4_NoAccess_Noexport     | [No users assigned] |
      | TestRole                | [No users assigned] |

    When I click on the link labeled "DAGs"
    Then I should see "Assign user to a group"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Assign DAG
    When I select "test_user1 (Test User1)" on the dropdown field labeled "Assign user"
    When I select "TestGroup1" on the dropdown field labeled "to"
    And I click on the button labeled "Assign"

    ##VERIFY
    Then I should see a table header and rows containing the following values in data access groups table:
      | Data Access Groups      | Users in group |
      | TestGroup1              | test_user1     |
      | TestGroup2              |                |

    ##ACTION: Assign DAG
    When I select "test_user1 (Test User1)" on the dropdown field labeled "Assign user"
    When I select "TestGroup2" on the dropdown field labeled "to"
    And I click on the button labeled "Assign"

    ##VERIFY
    Then I should see a table header and rows containing the following values in data access groups table:
      | Data Access Groups      | Users in group |
      | TestGroup1              |                |
      | TestGroup2              | test_user1     |

    ##ACTION: Assign DAG Switcher
    When I check "TestGroup1" for user "test_user1" in the DAG Switcher
    And I check "TestGroup2" for user "test_user1" in the DAG Switcher

    #ASSIGN RECORDS TO SPECIFIC DAGs
    # -- Record ID 3 - TestGroup1 --
    Given I click on the link labeled "Add / Edit Records"
    And I select "3" on the dropdown field labeled "Choose an existing Record ID"
    Then I should see "Record ID 3"

    Given I click on the span element labeled "Choose action for record"
    And I click on the link labeled "Assign to Data Access Group"
    Then I should see a dialog containing the following text: "Assign record to a Data Access Group?"
    
    When I select "TestGroup1" on the dropdown field labeled "Assign record" on the dialog box
    And I click on the button labeled "Assign to Data Access Group" in the dialog box
    Then I should see "Record ID 3 was successfully assigned to a Data Access Group"

    # -- Record ID 4 - TestGroup2 --
    Given I click on the link labeled "Add / Edit Records"
    And I select "4" on the dropdown field labeled "Choose an existing Record ID"
    Then I should see "Record ID 4"

    Given I click on the span element labeled "Choose action for record"
    And I click on the link labeled "Assign to Data Access Group"
    Then I should see a dialog containing the following text: "Assign record to a Data Access Group?"

    When I select "TestGroup2" on the dropdown field labeled "Assign record" on the dialog box
    And I click on the button labeled "Assign to Data Access Group" in the dialog box
    Then I should see "Record ID 4 was successfully assigned to a Data Access Group"


    When I logout
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.300.100"
    And I click on the link labeled "Record Status Dashboard"

    ##VERIFY
    Then I should see "Current Data Access Group"

    ##ACTION: Switch DAG
    When I click on the button labeled "Switch"
    Then I should see a dialog containing the following text: "Switch Data Access Group"

    When I select "TestGroup1" on the dropdown field labeled "Select the Data Access Group" on the dialog box
    Then I click on the button labeled "Switch" in the dialog box
    And I should see a dialog containing the following text: "Successfully switched"

    #This is problematic for ATS because this button AUTOMATICALLY disappears ...
    #And I click on the button labeled "OK" in the dialog box

    ##VERIFY
    Then I should see "Data Collection—TestGroup1"

    ##VERIFY_RSD:
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID             |
      | 3  TestGroup1   |

    ##VERIFY
    When I click on the button labeled "Switch"
    Then I should see a dialog containing the following text: "Switch Data Access Group"

    When I select "TestGroup2" on the dropdown field labeled "Select the Data Access Group" on the dialog box
    Then I click on the button labeled "Switch" in the dialog box
    And I should see a dialog containing the following text: "Successfully switched"

    #This is problematic for ATS because this button AUTOMATICALLY disappears ...
    #And I click on the button labeled "OK" in the dialog box

    Then I should see "Data Collection—TestGroup2"

    ##VERIFY_RSD:
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID           |
      | 4  TestGroup2 |