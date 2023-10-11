Feature: User Interface: The system shall support a My Project dashboard page containing the following information: Project Title (only projects the user has access to will be displayed) |  Records (number of records currently in the database for a project) | Fields (number of fields currently in the database for a project) | Instruments (forms and/or surveys) |  Type (classic, longitudinal) |  Status (Development, Production, Inactive or Archived)

  As a REDCap end user
  I want to see that My Project is functioning as expected

  Scenario:  B.6.13.100.100 My Project dashboard
    #FUNCTIONAL_REQUIREMENT
    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    Then I should see a table header and rows containing the following values in the a table:
      | Project Title                           | PID | Records | Fields | Instruments | Type | Status |
      | You do not have access to any projects  |     |         |        |             |      |        |
