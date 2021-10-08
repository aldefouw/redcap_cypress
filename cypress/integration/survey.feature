Feature: Survey

  As a standard user
  I want to see that public surveys work

  Scenario: A standard user enters data into the a public survey

    Given a admin user logs into REDCap
    And they visit the public survey URL for Project ID 3
    And I see "Example Survey" in the title
    And they click the "Submit" button
    Then they should see "Thank you for taking the survey"
