Feature: User Interface: The logging module shall provide the ability to filter by the following:
  • Event
  • Username
  • Record
  • DAG
  • Time Range

  As a REDCap end user
  I want to see that Logging Module is functioning as expected

  Scenario: B.2.23.300.100 Logging module filter function
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.23.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.23.300.100"

    #SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far." in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Logging Module
    When I click on the link labeled "Logging"

    ##VERIFY
    Then I should see "Filter by event"
    And I should see "Filter by user name"
    And I should see "Filter by record"
    And I should see "Filter by records in a DAG"
    And I should see "Filter by time range from"
    And I should see "Displaying events"
