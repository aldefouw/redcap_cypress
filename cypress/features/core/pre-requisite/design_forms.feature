Feature: Design Forms using Data Dictionary & Online Designer

  As a REDCap end user
  I want to see that Design Forms using Data Dictionary & Online Designer are functioning as expected

  Scenario: Create a form

    # #Step 1
    Given I am a "standard" user who logs into REDCap
    Then I should see "Welcome to REDCap!"

    When I visit Project ID 13
    # Then I should see "PID 13"
    # And I should see a link labeled "Designer"

    # #Step 2
    When I click on the link labeled 'Project Setup'
    # And I click on the element identified by "#setupEnableSurveysBtn"
    # Then I should see an element identified by "#setupEnableSurveysBtn" containing the text "Enable"
    # And I should see an element identified by "#setupLongiBtn" containing the text "Disable"
    # And I should see an element identified by "[onclick='btnMoveToProd();']" containing the text "Move project to production"

    # #Step 3
    # And I should see an element identified by "#setupChklist-design * button" containing the text "Online Designer"
    # And I should see an element identified by "#setupChklist-design * button" containing the text "Data Dictionary"
    # # Manual test script shows outdated button/link labels so this differs slightly
    # And I should see an element identified by "#setupChklist-design * button" containing the text "REDCap Instrument Library"
    # And I should see an element identified by "#setupChklist-design * a" containing the text "Download PDF of all instruments"
    # And I should see an element identified by "#setupChklist-design * a" containing the text "Download the current Data Dictionary"
    # And I should see an element identified by "#setupChklist-design * a" containing the text "Check For Identifiers"

    #Steps 4-11
    Given I am a "admin" user who logs into REDCap
    
    When I upload a data dictionary located at "core/07_DesignForms_v1115_DataDictionary_1.csv" to project ID 13
    # Then I should see "Changes Made Successfully"

    # When I upload a data dictionary located at "core/07_DesignForms_v1115_DataDictionary_2.csv" to project ID 13
    # Then I should see "The following variable/field names were duplicated...dd_form"

    And I upload a data dictionary located at "core/07_DesignForms_v1115_DataDictionary_3.csv" to project ID 13
    # Then I should see "Changes Made Successfully"

    Then I am a "standard" user who logs into REDCap

    #Step 11
    When I click on the link labeled "Designer"
    And I click on the link labeled "Data Dictionary Form"
    Then I should see "Testing data dictionary upload"

    When I click on the button labeled "Return to list of instruments"

    #Step 12
    #Using selector-based interaction steps to work around multiple matches
    #when getting by label / inner text
    When I click on the element identified by "[onclick*='showAddForm();']"
    And I click on the button labeled "Add instrument here"
    And I enter "Demo Branching" into the field identified by "#new_form-data_dictionary_form"
 
    And I click on the element identified by "[onclick*='addNewForm(']"
    And I download the instrument labeled "Demo Branching" as a PDF
    # And I should see "Demo Branching"
    # And I click on the element identified by "#row_2 > :nth-child(6) > .fc > .formActions > .jqbuttonsm > span"
    # And I click on the link labeled "Rename"