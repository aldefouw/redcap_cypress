Design forms Using Data Dictionary and Online Designer
    Form Creation: The system shall support the creation of unique new data collection instruments using the Data Dictionary.

    As a REDCap end user
    I want to see that project Designer is functioning as expected

    Scenario: B.6.7.100.100 Data dictionary export/import function

    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.6.7.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing "Empty project", and clicking the "Create Project" button

    #FUNCTIONAL_REQUIREMENT
    ##ACTION: Download data dictionary
    When I click on the link labeled "Dictionary"
    And I click on the link labeled "Download the current Data Dictionary"
    And I save the file as "B.6.7.100.100.csv"
    And I open the file labeled "B.6.7.100.100.csv"
    ##VERIFY
    Then I should see the field name "record_id"

    ##ACTION: Upload data dictionary
    When I click on the link labeled "Dictionary"
    And I click on the button labeled "Choose File"
    And I select the file labeled "Project1xml_DataDictionary.csv"
    And I click on the button labeled "Upload File"
    ##VERIFY
    Then I should see "Your document was uploaded successfully and awaits your confirmation below."

    When I click on the button labeled "Commit Changes"
    Then I should see "Changes Made Successfully!"

    When I click on the button labeled “Online Designer”
    Then I should see “Text Validation”
    And I should see “Consent”

    #VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see “Upload data dictionary” in the logging table

    ##ACTION: Upload data dictionary with removed form and Reordered form (#B.6.7.500.200 & B.6.7.600.200)
    When I click on the link labeled "Dictionary"
    And I click on the button labeled "Choose File"
    And I select the file labeled "Data Dictionary File 2.csv"
    And I click on the button labeled "Upload File"
    ##VERIFY
    Then I should see "Your document was uploaded successfully and awaits your confirmation below."

    When I click on the button labeled "Commit Changes"
    Then I should see "Changes Made Successfully!"

    When I click on the button labeled “Online Designer”
    Then I should see “Text Validation”
    And I should NOT see “Consent”

    #VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see “Upload data dictionary” in the logging table

    ##ACTION: Unable to upload data dictionary with Errors
    When I click on the link labeled "Dictionary"
    And I click on the button labeled "Choose File"
    And I select the file labeled "Data Dictionary File 3.csv"
    And I click on the button labeled "Upload File"
    ##VERIFY
    Then I should see "Errors found in your Data Dictionary: "
    And I click on the button labeled "RETURN TO PREVIOUS PAGE"
    Then I should see "Steps for making project changes"

    #VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see “Upload data dictionary” in the logging table
