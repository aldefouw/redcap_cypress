Feature: Design Forms using Data Dictionary & Online Designer

  As a REDCap end user
  I want to see that Design Forms using Data Dictionary & Online Designer are functioning as expected
# ~ indicates the step makes an assertion that relies on some (likely) trivial assumption
#   - e.g. assume that the visibility of a link labeled "Designer" implies the user has design rights

# ^ indicates the step is particularly prone to breaking if seed data or fixture files change
#   - e.g. seeded project settings change, and test verifies and/or modifies settings (see Step 2)

# * indicates the step is not completed exactly according to the manual script.
#   - e.g. test looks for a string anywhere on the page, rather than in a specific location (could produce false positives)

  Scenario: Create a form

    #Step 1
    Given I am a "standard" user who logs into REDCap
    Then I should see "Welcome to REDCap!"
    When I visit Project ID 13
    Then I should see "PID 13"
    And I should see a link labeled "Designer"

    #TODO: replace steps using selectors with steps not using selectors
    #Step 2^
    When I click on the link labeled 'Project Setup'
    And I click on the element identified by "#setupEnableSurveysBtn"
    Then I should see an element identified by "#setupEnableSurveysBtn" containing the text "Enable"
    And I should see an element identified by "#setupLongiBtn" containing the text "Disable"
    And I should see an element identified by "[onclick='btnMoveToProd();']" containing the text "Move project to production"

    #Step 3*
    And I should see "Online Designer"
    And I should see "Data Dictionary"
    And I should see "REDCap Instrument Library"
    And I should see "Download PDF of all instruments"
    And I should see "Download the current Data Dictionary"
    And I should see "Check For Identifiers"

    #Steps 4-10* - data dictionary upload step definition does not upload via GUI, and no prompts are displayed. 
    Given I am a "admin" user who logs into REDCap

    When I upload a data dictionary located at "core/07_DesignForms_v1115_DataDictionary_1.csv" to project ID 13
    # Then I should see "Changes Made Successfully"

    # When I upload a data dictionary located at "core/07_DesignForms_v1115_DataDictionary_2.csv" to project ID 13
    # Then I should see "The following variable/field names were duplicated...dd_form"

    And I upload a data dictionary located at "core/07_DesignForms_v1115_DataDictionary_3.csv" to project ID 13
    # Then I should see "Changes Made Successfully"

    Then I am a "standard" user who logs into REDCap

    #Step 11^*
    When I click on the link labeled "Designer"
    And I click on the link labeled "Data Dictionary Form"
    Then I should see "Testing data dictionary upload"
    When I click on the button labeled "Return to list of instruments"
    Then I should see "Data Collection Instruments"

    #Step 12*
    When I create a new instrument named "Demo Branching"
    Then I should see "Demo Branching"

    #Step 13*
    When I rename the instrument labeled "Demo Branching" to "Data Types"
    Then I should see "Data Types"

    #Step 14
    When I copy the instrument labeled "Data Dictionary Form" as "Text Validation" with variable suffix "_v2"
    Then I should see "SUCCESS! The instrument was successfully copied."

    #Step 15^
    When I click on the link labeled "Text Validation"
    Then I should see "dd_test_v2"
    When I click on the button labeled "Return to list of instruments"

    #Step 16
    #Script step involves deleting an instrument that doesn't exist, presumably due to differing initial project state

    #Step 17
    # When I reorder the instrument at position 3 to position 1
    # Then I should see an instrument labeled "Text Validation" in row 1 of the instruments table

    #Step 18
    # When I click on the link labeled "Project Setup"
    #--Initial project state doesn't allow for designating instruments to events, since only 1 is defined
    #--so I am skipping the step to designate instruments

    #Step 19*
    When I click on the link labeled "Data Types"
    # Then I should see "Current instrument: Data Types" --phrase is split across two spans, so isn't found

    #Step 20
    When I click on the button labeled "Add Field"
    Then The field types specified in step 20 of script 07 should be available

    #Step 21* - Does not verify subfields have default values, just that they appear
    When I select "Text Box (Short Text, Number, Date/Time, ...)" from the dropdown identified by "select#field_type"
    Then I should see "Field Label"
    And I should see "Variable Name"
    And I should see "Validation?"
    And I should see "Required?"
    And I should see "Identifier?"
    And I should see "Custom Alignment"
    And I should see "Field Note"

    #Step 22
    When I set the "type" subfield to "Yes - No"

# Field Label
# Variable Name
# Validation  (None)
# Required  (No)
# Identifier  (No)
# Custom Alignment  (RV)
# Field Note (null)