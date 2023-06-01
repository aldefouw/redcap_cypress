Feature: A.1.5.100 Browse Projects

  As a REDCap end user
  I want to see that I have the ability to access, search, and filter projects

  Scenario: A.1.5.100.100 Search/Sort project and Locate by User
    Given I login to REDCap with the user "Test_Admin"
    And I create a “New Project” named "A.1.5.100.100", select “Practice / Just for Fun from the dropdown, choose file “Project_1” and click on the "Create Project" button
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Projects"
    Then I should see "Viewing projects accessible by user: "

    When I click on the button labeled "View all projects"
    Then I should see "A.1.5.100.100"

    When I click on the link "Control Center"
    And I click on the link labeled "Browse Projects"
    Then I should see "Viewing projects accessible by user:"

    When I enter "Project" into the input field labeled "Search project title by keyword(s):"
    And I click on the button labeled "Search project title"
    Then I should see "A.1.5.100.100"

    When I click on the link labeled "Browse Projects"
    Then I should see "Viewing projects accessible by user:"

    When I click on the button labeled "View all projects"
    Then I should see "A.1.5.100.100"

    When I click the element containing the following text: "Project Title"
    Then I should see projects sorted correctly when I click on "Project Title" to sort in either direction

    When I click the element containing the following text: "Records"
    Then I should see projects sorted correctly when I click on "Records" to sort in either direction

    When I click the element containing the following text: "Fields"
    Then I should see projects sorted correctly when I click on "Fields" to sort in either direction

    When I click the element containing the following text: "Instrument"
    Then I should see projects sorted correctly when I click on "Instrument" to sort in either direction

    When I click the element containing the following text: "Type"
    Then I should see projects sorted correctly when I click on "Type" to sort in either direction

    When I click the element containing the following text: "Status"
    Then I should see projects sorted correctly when I click on "Status" to sort in either direction

    When I click the element containing the following text: "PID"
    Then I should see projects sorted correctly when I click on "PID" to sort in either direction

    When I click on the link labeled "Control Center" page
    And I click on the link labeled "Browse Projects"
    Then I should see "Viewing projects accessible by user: "

    When I enter "Test_User1" into the input field labeled "Viewing projects accessible by user:"
    Then I should see "A.1.5.100.100"
