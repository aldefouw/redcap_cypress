Feature: Browse Projects

  As an administrator
  I want to see that I have the ability to access, search, and filter projects

  Background:
    Given I am an "admin" user who logs into REDCap
    And I visit the "Control Center"
    And I click on the link labeled "Browse Projects"

  Scenario: View all non-archived projects
    When I click on the button labeled "View all projects"
    Then I should see 13 rows displayed in the projects table

  Scenario: Search for a project by "Project Title"
    When I enter "Piping Example" into the field labeled "Search project title by keyword(s):"
    And I click on the button labeled "Search project title"
    Then I should see "Piping Example Project"
    And I should see 1 row displayed in the projects table

  Scenario: Sort the projects by "Project Title" column
    When I click on the button labeled "View all projects"
    Then I should see projects sorted correctly when I click on "Project Title" to sort in either direction

  Scenario: Sort the projects by "Records" column
    When I click on the button labeled "View all projects"
    Then I should see projects sorted correctly when I click on "Records" to sort in either direction

  Scenario: Sort the projects by "Fields" column
    When I click on the button labeled "View all projects"
    Then I should see projects sorted correctly when I click on "Fields" to sort in either direction

  Scenario: Sort the projects by "Type" column
    When I click on the button labeled "View all projects"
    Then I should see projects sorted correctly when I click on "Type" to sort in either direction

  Scenario: Sort the projects by "Status" column
    When I click on the button labeled "View all projects"
    Then I should see projects sorted correctly when I click on "Status" to sort in either direction

  Scenario: View all projects with user rights assigned to a user with a specific username
    When I enter "test_user" into the field labeled "Viewing projects accessible by user:"
    And I click on the button labeled "View"
    Then I should see 13 rows displayed in the projects table

  Scenario: View no projects when a user has no user rights assigned to any projects
    When I enter "test_user2" into the field labeled "Viewing projects accessible by user:"
    And I click on the button labeled "View"
    And I should see "There are no projects to display"
