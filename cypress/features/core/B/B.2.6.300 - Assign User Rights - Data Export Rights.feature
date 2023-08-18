Feature: B.2.6.300 The system shall allow instrument level data export rights to be (No Access, De-Identified, Remove All Identifier Fields, Full Data Set)

  As a REDCap end user
  I want to see that data export rights is functioning as expected

  Scenario: B.2.6.300.100 Data Export Rights
    #SETUP_PRODUCTION
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.6.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml" and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.300.100"

    When I click on the link labeled “Project Setup”
    And I click on the button labeled "Move project to production"
    And I click on the radio button labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I see " Project status:  Production"

    ##USER_RIGHTS
    And I click on the link labeled "User Rights"
    And I select "Upload users (CSV)" from the dropdown "Upload or download users, roles, and assignments"
    And I choose file "User_list_for_Project_1" and click the "Upload" button
    And I click the button "Upload"
    Then I should see "Test_User1"
    Given I logout
    Then I should see "Please log in"

    Given I login to REDCap with the user "Test_User1"
    Then I should see "Logged in as"
    #FUNCTIONAL REQUIREMENT Export Full Data Set
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.300.100"
    And I click on the link labeled "Data Exports, Reports, and Stats"
    ##ACTION:
    And I click on the button labeled "Export Data"
    Then I should see "All data (all records and fields)"

    When I click on the link labeled "CSV / Microsoft Excel (raw data) "
    And I click on the button labeled "Export Data"
    Then I should see "Data export was successful!"

    When I click on the button labeled "Excel CSV"
    And I click the button labeled "Close"
    ##VERIFY_DE:
    And I open the Excel CSV File
    Then I should see "text_validation_complete"
    And I should see "ptname"
    And I should see "identifier"
    And I should see "identifier2"
    And I should see "data_types_complete"

    When I click on the button labeled “Logging”
    Then I should see “Update user test_user1” in the logging table
    And I see “Data export” in the logging table

    #SETUP
    Given I logout
    Then I should see "Please log in"
    Given I login to REDCap with the user "Test_User2"
    Then I should see "Logged in as"

    #FUNCTIONAL REQUIREMENT Export remove all identifier fields
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.300.100"
    And I click on the link labeled "Data Exports, Reports, and Stats"
    ##ACTION:
    And I click on the button labeled "Export Data"
    Then I should see "All data (all records and fields)"

    When I click on the link labeled "CSV / Microsoft Excel (raw data)"
    And I click on the button labeled "Export Data"
    Then I should see "Data export was successful!"

    When I click on the button labeled "Excel CSV"
    And I click the button labeled "Close"
    ##VERIFY_DE:
    And I open the Excel CSV File
    Then I should see "text_validation_complete"
    And I should see "ptname"
    And I should NOT see "identifier"
    And I should NOT see "identifier2"
    And I should see "data_types_complete"

    #SETUP
    Given I logout
    Then I should see "Please log in"
    Given I login to REDCap with the user "Test_User3"
    Then I should see "Logged in as"

    #FUNCTIONAL REQUIREMENT: Export Deidentified
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.300.100"
    And I click on the link labeled "Data Exports, Reports, and Stats"
    And I click on the button labeled "Export Data"
    Then I should see "All data (all records and fields) "

    When I click on the link labeled "CSV / Microsoft Excel (raw data)"
    ##ACTION:
    And I click on the button labeled "Export Data"
    Then I should see "Data export was successful! "

    When I click on the button labeled "Excel CSV"
    And I click the button labeled "Close"
    ##VERIFY_DE:
    And I open the Excel CSV File
    Then I should see "text_validation_complete"
    And I should NOT see "ptname"
    And I should NOT see "identifier"
    And I should NOT see "identifier2"
    And I should see "data_types_complete"

    #SETUP
    Given I logout
    Then I should see "Please log in"
    Given I login to REDCap with the user "Test_User4"
    Then I should see "Logged in as"

    #FUNCTIONAL REQUIREMENT: Export No Access
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.300.100"
    ##ACTION:
    And I click on the link labeled "Data Exports, Reports, and Stats"
    ##VERIFY
    Then I should NOT see "Export Data"