Feature: A.1.5.100 Browse Projects

  As a REDCap end user
  I want to see that I have the ability to access, search, and filter projects

  Scenario: A.1.5.100.100 Search/Sort project and Locate by User
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.1.5.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Projects"
    Then I should see "Viewing projects accessible by user:"

    When I click on the button labeled "View all projects"
    Then I should see "A.1.5.100.100"

    When I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Projects"
    Then I should see "Viewing projects accessible by user:"

    When I enter "A.1.5.100.100" into the input field labeled "Search project title by keyword(s):"
    And I click on the button labeled "Search project title"
    Then I should see a row labeled "A.1.5.100.100" in the projects table

    When I click on the link labeled "Browse Projects"
    Then I should see "Viewing projects accessible by user:"

    When I click on the button labeled "View all projects"
    Then I should see "A.1.5.100.100"

    When I click on the table heading column labeled "Project Title"
    Then I should see projects sorted correctly when I click on "Project Title" to sort in either direction

    When I click on the table heading column labeled "Records"
    Then I should see projects sorted correctly when I click on "Records" to sort in either direction

    When I click on the table heading column labeled "Fields"
    Then I should see projects sorted correctly when I click on "Fields" to sort in either direction

    When I click on the table heading column labeled "Instruments"
    Then I should see projects sorted correctly when I click on "Instruments" to sort in either direction

    When I click on the table heading column labeled "Type"
    Then I should see projects sorted correctly when I click on "Type" to sort in either direction

    When I click on the table heading column labeled "Status"
    Then I should see projects sorted correctly when I click on "Status" to sort in either direction

    When I click on the table heading column labeled "PID"
    Then I should see projects sorted correctly when I click on "PID" to sort in either direction

    When I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Projects"
    Then I should see "Viewing projects accessible by user:"

    When I enter "Test_Admin" into the input field labeled "Viewing projects accessible by user:"
    And I click on the button labeled exactly "View"
    Then I should see "A.1.5.100.100"
