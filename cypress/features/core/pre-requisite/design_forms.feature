Feature: Design Forms using Data Dictionary & Online Designer

  As a REDCap end user
  I want to see that Design Forms using Data Dictionary & Online Designer are functioning as expected
# ~ Indicates the step makes an assertion that relies on some assumption
#   - e.g. assume that a user has design rights if and only if a link labeled "Designer" is visible

# ^ Indicates the step is prone to breaking if seed data or fixture files change
#   - e.g. seeded project settings change, and test verifies and/or modifies settings (see Step 2)

# * Indicates the step is not completed exactly according to the manual script.
#   - e.g. manual script says to delete an instrument that does not exist due to different seed state

  Scenario: Create a form

    #Setup
    # Given I am a "admin" user who logs into REDCap
    # And I create a project named "FirstProject_1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"

    # Step 1
    Given I am a "standard" user who logs into REDCap
    # ^ Uncomment when project setup allows for standard user to access project
    Then I should seee "Welcome to REDCap!"
    When I visit Project ID 13
    Then I should seee "PID 13"
    # When I visit Project ID 14
    # Then I should seee "PID 14"
    And I should see a link labeled "Designer"

    # #TODO: replace steps using selectors with steps not using selectors
    # Step 2^
    When I click on the link labeled "Project Setup"
    And I click on the element identified by "#setupEnableSurveysBtn"
    Then I should see an element identified by "#setupEnableSurveysBtn" containing the text "Enable"
    And I should see an element identified by "#setupLongiBtn" containing the text "Disable"
    And I should see an element identified by "[onclick='btnMoveToProd();']" containing the text "Move project to production"

    # Step 3*
    And I should seee "Online Designer"
    And I should seee "Data Dictionary"
    And I should seee "REDCap Instrument Library"
    And I should seee "Download PDF of all instruments"
    And I should seee "Download the current Data Dictionary"
    And I should seee "Check For Identifiers"

    # Steps 4-10* - data dictionary upload step definition does not upload via GUI, and no prompts are displayed. 
    Given I am a "admin" user who logs into REDCap

    When I upload a data dictionary located at "core/07_DesignForms_v1115_DataDictionary_1.csv" to project ID 13
    # Then I should seee "Changes Made Successfully"

    # When I upload a data dictionary located at "core/07_DesignForms_v1115_DataDictionary_2.csv" to project ID 13
    # Then I should seee "The following variable/field names were duplicated...dd_form"

    And I upload a data dictionary located at "core/07_DesignForms_v1115_DataDictionary_3.csv" to project ID 13
    # Then I should seee "Changes Made Successfully"

    Then I am a "standard" user who logs into REDCap
    And I visit Project ID 13

    # Step 11^*
    When I click on the link labeled "Designer"
    And I click on the link labeled "Data Dictionary Form"
    Then I should seee "Testing data dictionary upload"
    When I click on the button labeled "Return to list of instruments"
    Then I should seee "Data Collection Instruments"

    # Step 12*
    When I create a new instrument named "Demo Branching"
    Then I should seee "Demo Branching"

    # Step 13*
    When I rename the instrument labeled "Demo Branching" to "Data Types"
    Then I should seee "Data Types"

    # Step 14
    When I copy the instrument labeled "Data Dictionary Form" as "Text Validation" with variable suffix "_v2"
    Then I should seee "SUCCESS! The instrument was successfully copied."

    # Step 15^
    When I click on the link labeled "Text Validation"
    Then I should seee "dd_test_v2"
    When I click on the button labeled "Return to list of instruments"

    # Step 16
    #Script step involves deleting an instrument that doesn't exist, presumably due to differing initial project state

    # Step 17
    # When I reorder the instrument at position 3 to position 1
    # Then I should see an instrument labeled "Text Validation" in row 1 of the instruments table

    # Step 18
    # When I click on the link labeled "Project Setup"
    #--Initial project state doesn't allow for designating instruments to events, since only 1 is defined
    #--so I am skipping the step to designate instruments

    # Step 19*
    When I click on the link labeled "Data Types"
    # Then I should seee "Current instrument: Data Types" --phrase is split across two spans, so isn't found

    # Step 20
    When I add a new field at position 1
    Then The field types specified in step 20 of script 07 should be available

    # Step 21* - Does not verify subfields have default values, just that they appear
    When I set the "field type" subfield to "Text Box (Short Text, Number, Date/Time, ...)"
    Then I should seee "Field Label"
    And I should seee "Variable Name"
    And I should seee "Validation?"
    And I should seee "Required?"
    And I should seee "Identifier?"
    And I should seee "Custom Alignment"
    And I should seee "Field Note"

    # Step 22  
    When I set the "field label" subfield to "Text Box"
    And I set the "VARIABLE name " subfield to "textbox"
    And I click on the button labeled "Save"
    Then I should seee "Text Box"
    And I should seee "Variable: textbox"

    # Step 23
    When I edit the field labeled "Text Box"
    And I set the "variable name" subfield to "2"
    And I click on the button labeled "Save"
    Then I should seee "Please enter a value for the variable name."
    Then I should seee "Please enter a value for the variable name."
    
    When I click on the button labeled "Close"
    And I set the "variable name" subfield to "2ABC"
    And I click on the button labeled "Save"
    Then I should seee "Variable: abc"

    When I edit the field labeled "Text Box"
    And I set the "variable name" subfield to "ABC#2"
    And I click on the button labeled "Save"
    Then I should seee "Variable: abc_2"

    When I edit the field labeled "Text Box"
    And I set the "variable name" subfield to "A2bc"
    And I click on the button labeled "Save"
    Then I should seee "Variable: a2bc"

    When I edit the field labeled "Text Box"
    And I set the "variable name" subfield to "textbox"
    And I click on the button labeled "Save"
    Then I should seee "Variable: textbox"

    # Step 24
    When I add a new field at position 2
    And I set the "field type" subfield to "Notes Box (Paragraph Text)"
    And I set the "field label" subfield to "Notes Box"
    And I set the "variable name" subfield to "notesbox"
    And I click on the button labeled "Save"
    Then I should seee "Variable: notesbox"

    # Step 25
    When I add a new field at position 3
    And I set the "field type" subfield to "Calculated Field"
    And I set the "field label" subfield to "Calculated Field"
    And I set the "variable name" subfield to "calculated_field"
    And I set the "calculated field" subfield to "3 * 2"
    And I click on the button labeled "Save"
    Then I should seee "Variable: calculated_field"
    And I should seee "View equation"

    # Step 26* - does not verify "the three choices exist", i.e. that the new field has expected options after save
    When I add a new field at position 4
    And I set the "field type" subfield to "Multiple Choice - Drop-down List (Single Answer)"
    And I set the "field label" subfield to "Multiple Choice Dropdown Auto"
    And I set the "choices" subfield to "DDChoice1{enter}DDChoice2{enter}DDChoice3"
    Then I should seee "Raw values for choices were added automatically"
    And I should seee "1 was set as the raw value for DDChoice1"

    When I click on the button labeled "Close" in the dialog box
    And I set the "variable name" subfield to "multiple_dropdown_auto"
    And I click on the button labeled "Save"
    Then I should seee "Variable: multiple_dropdown_auto"

    # Step 27
    When I add a new field at position 5
    And I set the "field type" subfield to "Multiple Choice - Drop-down List (Single Answer)"
    And I set the "field label" subfield to "Multiple Choice Dropdown Manual"
    And I set the "choices" subfield to "5, DDChoice5{enter}7, DDChoice6{enter}6, DDChoice7"
    And I set the "variable name" subfield to "multiple_dropdown_manual"
    And I click on the button labeled "Save"
    Then I should seee "Variable: multiple_dropdown_manual"

    # Step 28
    When I add a new field at position 6
    And I set the "field type" subfield to "Multiple Choice - Radio Buttons (Single Answer)"
    And I set the "field label" subfield to "Radio Button Auto"
    And I set the "choices" subfield to "Choice1{enter}Choice2{enter}Choice.3{enter}"
    Then I should seee "3 was set as the raw value for Choice.3"

    When I click on the button labeled "Close" in the dialog box
    And I set the "variable name" subfield to "multiple_radio_auto"
    And I click on the button labeled "Save"
    Then I should seee "Variable: multiple_radio_auto"

    # Step 29
    When I add a new field at position 7
    And I set the "field type" subfield to "Multiple Choice - Radio Buttons (Single Answer)"
    And I set the "field label" subfield to "Radio Button Manual"
    And I set the "choices" subfield to "9..9, Choice99{enter}100, Choice100{enter}101, Choice101"
    And I set the "variable name" subfield to "radio_button_manual"
    And I click on the button labeled "Save"
    Then I should seee "Variable: radio_button_manual"

    # Step 30* - Looks for choices on the edit instrument page instead of inside of the field editing modal
    Then I should see that the choice "Choice99" for the field "radio_button_manual" is coded as "9..9"
    And I should see that the choice "Choice100" for the field "radio_button_manual" is coded as "100"
    And I should see that the choice "Choice101" for the field "radio_button_manual" is coded as "101"

    # Step 31
    #pos 2/8
    When I add a new field at position 8
    And I set the "field type" subfield to "Checkboxes (Multiple Answers)"
    And I set the "field label" subfield to "Checkbox"
    And I set the "choices" subfield to "1, Checkbox1{enter}2, Checkbox2{enter}3, Checkbox3"
    And I set the "variable name" subfield to "checkbox"
    And I click on the button labeled "Save"
    Then I should see that the choice "Checkbox1" for the field "checkbox" is coded as "1"
    And I should see that the choice "Checkbox2" for the field "checkbox" is coded as "2"
    And I should see that the choice "Checkbox3" for the field "checkbox" is coded as "3"

    # Step 32
    #pos 3/9
    When I add a new field at position 9
    And I set the "field type" subfield to "Signature (draw signature with mouse or finger)"
    And I set the "field label" subfield to "Signature"
    And I set the "variable name" subfield to "signature"
    And I click on the button labeled "Save"
    Then I should seee "Variable: signature"
    And I should see a link labeled "Add signature"

    # Step 33
    #pos 4/10
    When I add a new field at position 10
    And I set the "field type" subfield to "File Upload (for users to upload files)"
    And I set the "field label" subfield to "File Upload"
    And I set the "variable name" subfield to "file_upload"
    And I click on the button labeled "Save"
    Then I should seee "Variable: file_upload"
    And I should see a link labeled "Upload file"

    # Step 34
    #pos 5/11
    When I add a new field at position 11
    And I set the "field type" subfield to "Descriptive Text (with optional Image/Video/Audio/File Attachment)"
    And I set the "field label" subfield to "Descriptive Text with File"
    And I set the "variable name" subfield to "descriptive_text_file"
    Then I should see a link labeled "Upload file"
    # ^ false positive prone, since it matches a different link underneath dialog box

    When I click on the link labeled "Upload file"
    # When I click on the element identified by "#div_attach_upload_link > a"
    # ^ delete after z-index fix
    And I upload a "image/jpeg" format file located at "import_files/core/7_image_v1115.jpeg", by clicking "#myfile" to select the file, and clicking "button:contains(Upload file)" to upload the file
    # ^ uses selectors, not user-friendly for non-technical gherkin writers
    Then I should seee "Document was successfully uploaded!"

    When I click on the button labeled "Close" in the dialog box
    And I click on the button labeled "Save"
    Then I should seee "Variable: descriptive_text_file"
    And I should seee "7_image_v1115.jpeg"

    # Step 35
    #pos 6/12
    When I add a new field at position 12
    And I set the "field type" subfield to "Descriptive Text (with optional Image/Video/Audio/File Attachment)"
    And I set the "field label" subfield to "Descriptive Text"
    And I set the "variable name" subfield to "descriptive_text"
    And I click on the button labeled "Save"
    Then I should seee "Variable: descriptive_text"

    # Step 36
    # Step requires that a record already exists, so I have to create one
    When I click on the link labeled "Record Status Dashboard"
    And I click on the button labeled "Add new record"
    # And I click on the element identified by "a[href*=data_types]:visible"
    # Need step to choose instrument when creating new record when multiple instruments exist
    And I click on the button labeled "Save & Exit Form"
    And I click on the link labeled "Record Status Dashboard"
    And I click on the bubble for the "Data Types" data collection instrument instrument for record ID "1"
    Then I should see a link labeled "7_image_v1115.jpeg"
    #Script says to view the image, skipping

    # Step 37
    When I click on the button labeled "Save & Exit Form"
    Then I should seee "Record Home Page"

    # Step 38
    When I click on the link labeled "Designer"
    And I click on the link labeled "Data Types"
    And I add a new field at position 13
    And I set the "field type" subfield to "Begin New Section (with optional text)"
    And I set the "field label" subfield to "Section Break"
    And I click on the button labeled "Save"
    # Then I should see alert with text