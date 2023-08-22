Feature: B.2.10.400 Data Access Groups-DAGs User Interface: The system shall provide the ability to restrict a user who has been assigned to a DAG to: * data they entered * data entered by any member of the same DAG * files uploaded in the File Repository

  As a REDCap end user
  I want to see that Data Access Groups is functioning as expected

  Scenario: B.2.10.400.100 User restriction for records in DAGs

    #SETUP_NOTE: Will reference unique Group ID numbers located on DAG page. These numbers are specific the PID

    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.10.400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.400.100"
    And I click on the link labeled "User Rights"
    And I select "Upload users (CSV) " from the dropdown "Upload or download users, roles, and assignments"
    And I choose file "User_list_for_Project_1" and click the "Upload" button
    And I click the button "Upload"
    Then I should see "Test_User1"

    When I click on the link labeled "DAGs"
    Then I should see "Assign user to a group"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Assign User to DAG
    When I select "Test_User3" from "Assign User" dropdown
    And I select "TestGroup1" from "DAG" dropdown
    And I click on the button labeled "Assign"
    Then I should see "Test_User3" assigned to "TestGroup1"

    When I select "Test_User1" from "Assign User" dropdown
    And I select "TestGroup1" from "DAG" dropdown
    And I click on the button labeled "Assign"
    Then I should see "Test_User1" assigned to "TestGroup1"

    When I select "Test_User4" from "Assign User" dropdown
    And I select "TestGroup2" from "DAG" dropdown
    Then I should see "Test_User4" assigned to "TestGroup2"


    When I select "Test_User2" from "Assign User" dropdown
    And I select "TestGroup2" from "DAG" dropdown
    Then I should see "Test_User2" assigned to "TestGroup2"
    And I logout

    ##VERIFY
    Given I login to REDCap with the user "Test_User3"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.400.100"
    And I click the link labeled "Record Status Dashboard"
    ##VERIFY_RSD:
    Then I should see "3"
    And I should NOT see "4"
    ##VERIFY
    When I click the link "Add / Edit Records"
    And I select record ID "3" from arm name "event_1_arm_1" on the Add / Edit record page
    Then I should see the "Record Home Page"

    ##ACTION: Add record while in a DAG
    And I click on the link labeled "Add new record for the arm selected above"
    And I click the bubble for the instrument labeled "Text Validation for event "Event 1"
    And I click the button "Save and Exit Form"
    And I click the bubble for the instrument labeled "Consent"  for "Event Three"
    And I click the dropdown labeled "Survey options"
    And I select the dropdown option labeled "Open Survey"
    And I click on the button labeled "Next Page"
    And I select the checkbox "I certify"
    And I click on the button labeled "Submit"
    And I click on the button labeled "Close survey"
    And I click on the button labeled "Leave without saving changes" in the dialog box
    Then I should see "Record Home Page"

    ##VERIFY_LOG:
    And I click on the link labeled “Logging”
    Then I see “Create record [DAG_GROUP_ID_TESTGROUP1]-1” in the logging table
    ##VERIFY_RSD:
    When I click the link labeled "Record Status Dashboard"
    Then I should see "3"
    And I should see “[DAG_GROUP_ID_TESTGROUP1]-1 "
    ##VERIFY_FR:
    When I click the link labeled "File Repository"
    And I click on the link “PDF Survey Archive”
    Then I should see “[DAG_GROUP_ID_TESTGROUP1]-1”
    And I logout

    ##ACTION: Another user from same DAG has access to same DAG records
    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.400.100"
    ##VERIFY_RSD:
    When I click the link labeled "Record Status Dashboard"
    Then I should see "3"
    And I should see “[DAG_GROUP_ID_TESTGROUP1]-1"
    And I should NOT see "4"
    ##VERIFY_FR:
    When I click the link labeled "File Repository"
    And I click on the link “PDF Survey Archive”
    Then I should see “[DAG_GROUP_ID_TESTGROUP1]-1”
    And I logout

    ##ACTION: Separate User DAG
    Given I login to REDCap with the user "Test_User4"
    And I click on the link labeled "B.2.10.400.100"
    ##VERIFY
    When I click the link "Add / Edit Records"
    And I select record ID "4" from arm name "event_1_arm_1" on the Add / Edit record page
    Then I should see the "Record Home Page"
    When I click the link "Add / Edit Records"
    ##ACTION: Add record while in a DAG
    And I click on the link labeled "Add new record"
    And I click the bubble for the instrument labeled "Text Validation" for event "Event 1"
    And I click the button labeled "Save and Exit Form"
    And I click the bubble for the instrument labeled "Consent" for event "Event Three"
    And I click the dropdown labeled "Survey options" and I select the dropdown option labeled "Open Survey"
    And I click on the button labeled "Next Page"
    And I select the checkbox "I certify"
    And I click on the button labeled "Submit"
    And I click on the button labeled "Close survey"
    And I click on the button labeled "Leave without saving changes" in the dialog box
    Then I should see "Record Home Page"

    ##VERIFY_RSD:
    And I click the link labeled "Record Status Dashboard"
    Then I should see "4"
    And I should see “[DAG_GROUP_ID_TESTGROUP2]-1"
    And I should NOT see "3"
    And I should NOT see “[DAG_GROUP_ID_TESTGROUP1]-1”
    ##VERIFY_FR:
    When I click the link labeled "File Repository"
    And I click on the link “PDF Survey Archive”
    Then I should see “[DAG_GROUP_ID_TESTGROUP2]-1"
    And I should NOT see “[DAG_GROUP_ID_TESTGROUP1]-1”
    And I logout

    ##ACTION: Another user from same DAG has access to same DAG records
    Given I login to REDCap with the user "Test_User2"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.10.400.100"
    ##VERIFY_RSD:
    When I click the link labeled "Record Status Dashboard"
    Then I should see "4"
    And I should see “[DAG_GROUP_ID_TESTGROUP2]-1"
    And I should NOT see "3"
    And I should NOT see “[DAG_GROUP_ID_TESTGROUP1]-1"
    ##VERIFY_FR:
    When I click the link labeled "File Repository"
    And I click on the link “PDF Survey Archive”
    Then I should see “[DAG_GROUP_ID_TESTGROUP2]-1”
    And I should NOT see “[DAG_GROUP_ID_TESTGROUP1]-1”
    And I logout