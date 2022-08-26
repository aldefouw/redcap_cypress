Feature: Design Forms using Data Dictionary & Online Designer **

  As a REDCap end user
  I want to see that Design Forms using Data Dictionary & Online Designer are functioning as expected

  Scenario: Create a form

    #Step 1
    Given I am a "standard" user who logs into REDCap
    Then I should see "Welcome to REDCap!"

    When I visit Project ID 13
    Then I should see "PID 13"
    And I should see a link labeled "Designer"

    #Step 2
    When I click on the link labeled 'Project Setup'
    And I click on the element identified by "#setupEnableSurveysBtn"
    Then I should see an element identified by "#setupEnableSurveysBtn" containing the text "Enable"
    And I should see an element identified by "#setupLongiBtn" containing the text "Disable"
    And I should see an element identified by "[onclick='btnMoveToProd();']" containing the text "Move project to production"

    #Step 3
    And I should see an element identified by "#setupChklist-design * button" containing the text "Online Designer"
    And I should see an element identified by "#setupChklist-design * button" containing the text "Data Dictionary"
    # Manual test script shows outdated button/link labels so this differs slightly
    And I should see an element identified by "#setupChklist-design * button" containing the text "REDCap Instrument Library"
    And I should see an element identified by "#setupChklist-design * a" containing the text "Download PDF of all instruments"
    And I should see an element identified by "#setupChklist-design * a" containing the text "Download the current Data Dictionary"
    And I should see an element identified by "#setupChklist-design * a" containing the text "Check For Identifiers"

    #Step 4
    #When I click on the link labeled "Download the current Data Dictionary"
    When I download the data dictionary
    And 