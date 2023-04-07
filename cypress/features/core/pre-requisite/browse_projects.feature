Feature: Browse Projects

  As a REDCap end user
  I want to see that I have the ability to access, search, and filter projects

  Scenario: 0 - Project Setup Steps
    Given I am an "admin" user who logs into REDCap
    And I create a project named "FirstProject_1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/projects/FirstProject_1115.xml"

    When I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    And I click on the link labeled "User Rights"
    And I enter "test_user" into the input field labeled "Add with custom rights"
    And I click on the button labeled "Add with custom rights"
    Then I should see 'Adding new user "test_user"'
    And I save changes within the context of User Rights

  Scenario: 1 - View all non-archived projects
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Projects"
    When I click on the button labeled "View all projects"
    Then I should see 13 rows displayed in the projects table
    And I should see "FirstProject_1115"

  Scenario: 2a - Search for a project by "Project Title"
    When I enter "First" into the input field labeled "Search project title by keyword(s):"
    And I click on the button labeled "Search project title"
    Then I should see "FirstProject_1115"
    And I should see 1 row displayed in the projects table

  Scenario: 2b - Search for a project using Project Filter field
    When I click on the link labeled "Browse Projects"
    And I click on the button labeled "View all projects"
    And I enter "First" into the filter projects field
    Then I should see "FirstProject_1115"
    And I should see 1 row displayed in the projects table

  Scenario: 3a - Sort the projects by "Project Title" column
    When I click on the button labeled "View all projects"
    Then I should see projects sorted correctly when I click on "Project Title" to sort in either direction

  Scenario: 3b - Sort the projects by "Records" column
    And I should see projects sorted correctly when I click on "Records" to sort in either direction

  Scenario: 3c - Sort the projects by "Fields" column
    And I should see projects sorted correctly when I click on "Fields" to sort in either direction

  Scenario: 3d - Sort the projects by "Instrument" column
    And I should see projects sorted correctly when I click on "Instrument" to sort in either direction

  Scenario: 3e - Sort the projects by "Type" column
    And I should see projects sorted correctly when I click on "Type" to sort in either direction

  Scenario: 3f - Sort the projects by "Status" column
    And I should see projects sorted correctly when I click on "Status" to sort in either direction

  Scenario: 4 - View all projects with user rights assigned to a user with a specific name
    When I enter "Test User" into the input field labeled "Viewing projects accessible by user:"
    And I click on the input element labeled "Viewing projects accessible by user:"
    And I click on the list item element labeled "test_user@example.com"
    Then I should see 1 rows displayed in the projects table
    And I should see "FirstProject_1115"

  Scenario: 5 - View all projects with user rights assigned to a user with a specific username
    Given I clear the field labeled "Viewing projects accessible by user:"
    And I enter "test_user" into the input field labeled "Viewing projects accessible by user:"
    And I click on the button labeled exactly "View"
    Then I should see 1 rows displayed in the projects table
    And I should see "FirstProject_1115"

  Scenario: 6 - View no projects when a user has no user rights assigned to any projects
    Given I clear the field labeled "Viewing projects accessible by user:"
    And I enter "test_user2" into the input field labeled "Viewing projects accessible by user:"
    And I click on the button labeled exactly "View"
    Then I should see "There are no projects to display"