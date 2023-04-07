Feature: Design Forms using Data Dictionary & Online Designer

  As a REDCap end user
  I want to see that Design Forms using Data Dictionary & Online Designer are functioning as expected

  Scenario: 0 - Load Design Forms Feature.xml
    Given I am a "standard" user who logs into REDCap
    And I create a project named "Design Forms Feature" with project purpose Operational Support via CDISC XML import from fixture location "cdisc_files/projects/FirstProject_1115.xml"

    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Design Forms Feature"

    Then I should see "Development"
    And I click on the link labeled "Project Setup"
    And I disable surveys for the project
    Then I should see that surveys are disabled
    Then I logout

  Scenario: 1 - Navigate, Login to REDCap, Verify User Rights
    Given I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "Design Forms Feature"
    And I click on the link labeled "User Rights"
    Then I assign the "Project Design and Setup" user right to the user named "Test User" with the username of "test_user"

  Scenario: 2 - Verify Project Settings
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Design Forms Feature"
    Then I should see that surveys are disabled
    And I should see "Development"

  Scenario: 3 - Verify "Design your data collection instruments" Section
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Design Forms Feature"
    And I click on the link labeled "Project Setup"
    Then I should see a button labeled "Online Designer"
    And I should see a button labeled "Data Dictionary"
    And I should see a button labeled "REDCap Instrument Library"
    And I should see a link labeled "Download PDF of all instruments"
    And I should see a link labeled "Download the current Data Dictionary"
    And I should see a link labeled "Check For Identifiers"

  Scenario: 4 - Download and Verify Data Dictionary
    Given I download the data dictionary and save the file as "Design Forms Feature.csv"
    Then the CSV file at path "cypress/downloads/Design Forms Feature.csv" has the headings below
    | "Variable / Field Name" | "Form Name" | "Section Header" | "Field Type" | "Field Label" | "Choices, Calculations, OR Slider Labels" | "Field Note" | "Text Validation Type OR Show Slider Number" | "Text Validation Min" | "Text Validation Max" |  Identifier? | "Branching Logic (Show field only if...)" | "Required Field?" | "Custom Alignment" |  "Question Number (surveys only)" | "Matrix Group Name" | "Matrix Ranking?" | "Field Annotation" |
    Then the CSV file at path "cypress/downloads/Design Forms Feature.csv" has a value "record_id" for column "\"Variable / Field Name\""
    Then the CSV file at path "cypress/downloads/Design Forms Feature.csv" has a value 'ptname' for column "\"Variable / Field Name\""
    Then the CSV file at path "cypress/downloads/Design Forms Feature.csv" has a value 'text2' for column "\"Variable / Field Name\""
    Then the CSV file at path "cypress/downloads/Design Forms Feature.csv" has a value 'ptname_v2' for column "\"Variable / Field Name\""
    Then the CSV file at path "cypress/downloads/Design Forms Feature.csv" has a value 'email' for column "\"Variable / Field Name\""

  Scenario: 5 - Add new field to data dictionary
    Given I add a new variable named "dd_form" in the form named "data_dictionary_form" with the field type "text" and the label "Testing data dictionary upload 1" into the Data Dictionary file at "cypress/downloads/Design Forms Feature.csv"
    Then the CSV file at path "cypress/downloads/Design Forms Feature.csv" has a value 'email' for column "\"Variable / Field Name\""

  Scenario: 6 - Upload Data Dictionary
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Design Forms Feature"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Data Dictionary"
    And I set the input file field named "uploadedfile" to the file at path "cypress/downloads/Design Forms Feature.csv"
    And I click on the button labeled "Upload File"
    Then I should see "Your document was uploaded successfully and awaits your confirmation below."
    And I click on the button labeled "Commit Changes"
    Then I should see "Changes Made Successfully!"

  Scenario: 7 - Add new field to data dictionary
    Given I add a new variable named "dd_form" in the form named "field_validation_form" with the field type "text" and the label "Testing data dictionary upload 2" into the Data Dictionary file at "cypress/downloads/Design Forms Feature.csv"
    Then the CSV file at path "cypress/downloads/Design Forms Feature.csv" has a value 'field_validation_form' for column "\"Form Name\""

  Scenario: 8 - Upload Data Dictionary
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Design Forms Feature"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Data Dictionary"
    And I set the input file field named "uploadedfile" to the file at path "cypress/downloads/Design Forms Feature.csv"
    And I click on the button labeled "Upload File"
    Then I should see "Errors found in your Data Dictionary:"
    And I should see "dd_form"

  Scenario: 9 - Replace bad field in data dictionary
    Given I remove line 8 from a CSV file at path "cypress/downloads/Design Forms Feature.csv"
    Then I add a new variable named "dd_test" in the form named "data_dictionary_form" with the field type "text" and the label "Testing data dictionary upload" into the Data Dictionary file at "cypress/downloads/Design Forms Feature.csv"

  Scenario: 10 - Upload Data Dictionary
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Design Forms Feature"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Data Dictionary"
    And I set the input file field named "uploadedfile" to the file at path "cypress/downloads/Design Forms Feature.csv"
    And I click on the button labeled "Upload File"
    Then I should see "Your document was uploaded successfully and awaits your confirmation below."
    And I click on the button labeled "Commit Changes"
    Then I should see "Changes Made Successfully!"

  Scenario: 11 - Verify Fields Exist
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Design Forms Feature"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Online Designer"
    Then I should see "Data Dictionary Form"
    And I click on the link labeled "Data Dictionary Form"
    Then I should see "dd_form"
    And I should see "dd_test"

  Scenario: 12 - Create new instrument
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Design Forms Feature"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Online Designer"
    And I create a new data collection instrument called "Demo Branching"
    Then I should see "Demo Branching"

  Scenario: 13 - Rename My First Instrument
    Given I click on the Instrument Action "Rename" for the instrument named "My First Instrument"
    And I rename the current data instrument named "My First Instrument" to "Data Types"
    Then I should see "Data Types"

  Scenario: 14 - Copy My First Instrument 2
    Given I click on the Instrument Action "Copy" for the instrument named "My First Instrument 2"
    Then I should see a dialog containing the following text: "New instrument name:"
    And I clear field and enter "Text Validation" into the input field labeled "New instrument name:"
    And I click on the button labeled "Copy instrument" in the dialog box
    Then I should see "Text Validation"

  Scenario: 15 - Verify Text Validation Copied
    Given I click on the link labeled "Text Validation"
    Then I should see "ptname_v2_v2"
    Then I should see "email_v2"

  Scenario: 16 - Delete My First Instrument 2
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Design Forms Feature"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Online Designer"
    And I delete the data instrument named "My First Instrument 2"
    Then I should see "Deleted!"
    And I should see "The data collection instrument and all its fields have been successfully deleted!"

  Scenario: 17 - Drag Text Validation to the Top of the List
    Given I drag on the instrument named "Text Validation" to position 0
    #The item below always passes when Saved! is hidden
    Then I should see "Saved!"
    #Verify "Text Validation" is at the top

  Scenario: 18 - Add all instruments to Event 1
    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Designate Instruments for My Events"
    And I click on the button labeled "Begin Editing"
    And I add an instrument named "Text Validation" to the event named "Event 1"
    And I add an instrument named "Data Dictionary Form" to the event named "Event 1"
    And I add an instrument named "Demo Branching" to the event named "Event 1"
    Then I click on the button labeled "Save" on the Designate Instruments for My Events page

  Scenario: 19 - Open Data Types Form
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Design Forms Feature"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Online Designer"
    And I click on the link labeled "Data Types"

  Scenario: 20 - Verify Add Field Types
    Given I click on the Add Field input button below the field named "Text2"
    Then I should see "Add New Field"
    Then I should see the dropdown identified by "select[name=field_type]" with the options below
    | Text Box | Notes Box | Calculated Field | Multiple Choice - Drop-down List | Multiple Choice - Radio Buttons | Checkboxes | Signature | File Upload | Descriptive Text | Begin New Section |

  Scenario: 21 - Verify Metadata Field Types
    Given I select "text" from the dropdown identified by "select[name=field_type]"
    Then I should see the element identified by "textarea[name=field_label]"
    And I should see the element identified by "input[name=field_name]"
    And I should see the element identified by "select[name=val_type]"
    And I should see the element identified by "input[id=field_req0]"
    And I should see the element identified by "input[id=field_req1]"
    And I should see the element identified by "input[id=field_phi0]"
    And I should see the element identified by "input[id=field_phi1]"
    And I should see the element identified by "input[id=field_phi0]"
    And I should see the element identified by "select[name=custom_alignment]"
    And I should see the element identified by "input[name=field_note]"
    And I click on the button labeled "Cancel" in the dialog box
  
  Scenario: 22 - Add Text Box
    Given I add a new Text Box field labeled "Text Box" with variable name "textbox"
    Then I should see "textbox"

  Scenario: 23 - Test illegal variables
    Given the AJAX "GET" request at "Design/edit_field_prefill.php*" tagged by "edit" is being monitored
    And I click on the Edit image for the field named "Text Box"
    And the AJAX request tagged by "edit" has completed
    And I clear the field identified by "input[name=field_name]"
    And I enter "2" into the field identified by "input[name=field_name]"
    And I click on the element identified by "textarea[name=field_label]"
    And I should see the input field identified by "input[name=field_name]" with the value ""
    And I clear the field identified by "input[name=field_name]"
    And I enter "2ABC" into the field identified by "input[name=field_name]"
    And I click on the element identified by "textarea[name=field_label]"
    And I should see the input field identified by "input[name=field_name]" with the value "abc"
    And I clear the field identified by "input[name=field_name]"
    And I enter "ABC#2" into the field identified by "input[name=field_name]"
    And I click on the element identified by "textarea[name=field_label]"
    And I should see the input field identified by "input[name=field_name]" with the value "abc_2"
    And I clear the field identified by "input[name=field_name]"
    And I enter "A2bc" into the field identified by "input[name=field_name]"
    And I click on the element identified by "textarea[name=field_label]"
    And I should see the input field identified by "input[name=field_name]" with the value "a2bc"
    And I clear the field identified by "input[name=field_name]"
    And I enter "textbox" into the field identified by "input[name=field_name]"
    And I click on the button labeled "Save" on the Online Designer page
    Then I should see "textbox"    
  
  Scenario: 24 - Add Notes Box
    Given I add a new Notes Box field labeled "Notes Box" with variable name "notesbox"
    Then I should see "notesbox"

  Scenario: 25 - Add Calculated Field
    Given I add a new Calculated Field field labeled "Calculated Field" with variable name "calculated_field"
    And I edit the field labeled "Calculated Field"
    And I enter the equation "3*2" into Calculation Equation of the open "Edit Field" dialog box
    And I save the field
    Then I should see "calculated_field"

  Scenario: 26 - Add Multiple Choice - Drop-down Auto
    Given I click on the Add Field input button below the field named "Calculated Field"
    And I select "select" from the dropdown identified by "select[name=field_type]"
    Then I should see "Choices (one choice per line)"
    And I enter "Multiple Choice Dropdown Auto" into the field identified by "textarea[name=field_label]"
    And I enter "DDChoice1{enter}DDChoice2{enter}DDChoice3" into the field identified by "textarea[name=element_enum]"
    And I click on the element identified by "input[name=field_name]"
    Then I should see "Raw values for choices were added automatically"
    And I click on the button labeled "Close" in the dialog box
    Then I should see the input field identified by "textarea[name=element_enum]" with the value "1, DDChoice1\n2, DDChoice2\n3, DDChoice3"
    And I enter "multiple_dropdown_auto" into the field identified by "input[name=field_name]"
    And I click on the element identified by "textarea[name=field_label]"
    And I click on the button labeled "Save" on the Online Designer page
    Then I should see "multiple_dropdown_auto"

  Scenario: 27 - Add Multiple Choice - Drop-down Manual
    Given I click on the Add Field input button below the field named "Multiple Choice Dropdown Auto"
    And I select "select" from the dropdown identified by "select[name=field_type]"
    Then I should see "Choices (one choice per line)"
    And I enter "Multiple Choice Dropdown Manual" into the field identified by "textarea[name=field_label]"
    And I enter "5, DDChoice5{enter}7, DDChoice6{enter}6, DDChoice7" into the field identified by "textarea[name=element_enum]"
    And I enter "multiple_dropdown_manual" into the field identified by "input[name=field_name]"
    And I click on the element identified by "textarea[name=field_label]"
    And I click on the button labeled "Save" on the Online Designer page
    Then I should see "multiple_dropdown_manual"

  Scenario: 28 - Add Multiple Choice - Radio Auto
    Given I click on the Add Field input button below the field named "Multiple Choice Dropdown Manual"
    And I select "radio" from the dropdown identified by "select[name=field_type]"
    Then I should see "Choices (one choice per line)"
    And I enter "Radio Button Auto" into the field identified by "textarea[name=field_label]"
    And I enter "Choice1{enter}Choice2{enter}Choice.3" into the field identified by "textarea[name=element_enum]"
    And I click on the element identified by "input[name=field_name]"
    Then I should see "Raw values for choices were added automatically"
    And I click on the button labeled "Close" in the dialog box
    Then I should see the input field identified by "textarea[name=element_enum]" with the value "1, Choice1\n2, Choice2\n3, Choice.3"
    And I enter "radio_button_auto" into the field identified by "input[name=field_name]"
    And I click on the element identified by "textarea[name=field_label]"
    And I click on the button labeled "Save" on the Online Designer page
    Then I should see "radio_button_auto"

  Scenario: 29 - Add Multiple Choice Radio Manual
    Given I click on the Add Field input button below the field named "Radio Button Auto"
    And I select "radio" from the dropdown identified by "select[name=field_type]"
    Then I should see "Choices (one choice per line)"
    And I enter "Radio Button Manual" into the field identified by "textarea[name=field_label]"
    And I enter "9..9, Choice99{enter}100, Choice100{enter}101, Choice101" into the field identified by "textarea[name=element_enum]"
    And I click on the element identified by "input[name=field_name]"
    And I enter "radio_button_manual" into the field identified by "input[name=field_name]"
    And I click on the element identified by "textarea[name=field_label]"
    And I click on the button labeled "Save" on the Online Designer page
    Then I should see "radio_button_manual"

  Scenario: 30 - Edit Radio Button
    Given the AJAX "GET" request at "Design/edit_field_prefill.php*" tagged by "edit" is being monitored
    And I click on the Edit image for the field named "Radio Button Manual"
    And the AJAX request tagged by "edit" has completed
    Then I should see the input field identified by "textarea[name=element_enum]" with the value "9..9, Choice99\n100, Choice100\n101, Choice101"
    Then I click on the button labeled "Cancel"

  Scenario: 31 - Add Checkbox
    Given I click on the Add Field input button below the field named "Radio Button Manual"
    And I select "checkbox" from the dropdown identified by "select[name=field_type]"
    And I enter "Checkbox" into the field identified by "textarea[name=field_label]"
    And I enter "1, Checkbox{enter}2, Checkbox2{enter}3, Checkbox3" into the field identified by "textarea[name=element_enum]"
    And I enter "checkbox" into the field identified by "input[name=field_name]"
    And I click on the element identified by "textarea[name=field_label]"
    And I click on the button labeled "Save" on the Online Designer page
    Then I should see "checkbox"
    
  Scenario: 32 - Add Signature
    Given I click on the Add Field input button below the field named "Checkbox"
    And I select "Signature (draw signature with mouse or finger)" from the dropdown identified by "select[name=field_type]"
    And I enter "Signature" into the field identified by "textarea[name=field_label]"
    And I enter "signature" into the field identified by "input[name=field_name]"
    And I click on the element identified by "textarea[name=field_label]"
    And I click on the button labeled "Save" on the Online Designer page
    Then I should see a link labeled "Add signature"
    Then I should see "signature"

  Scenario: 33 - Add File Upload
    Given I click on the Add Field input button below the field named "Signature"
    And I select "File Upload (for users to upload files)" from the dropdown identified by "select[name=field_type]"
    And I enter "File Upload" into the field identified by "textarea[name=field_label]"
    And I enter "file_upload" into the field identified by "input[name=field_name]"
    And I click on the element identified by "textarea[name=field_label]"
    And I click on the button labeled "Save" on the Online Designer page
    Then I should see a link labeled "Upload file"
    Then I should see "file_upload"

  Scenario: 34 - Add Descriptive Text With File
    Given I click on the Add Field input button below the field named "File Upload"
    And I select "descriptive" from the dropdown identified by "select[name=field_type]"
    And I enter "Descriptive Text with File" into the field identified by "textarea[name=field_label]"
    And I enter "descriptive_file_text" into the field identified by "input[name=field_name]"
    And I click on the element identified by "textarea[name=field_label]"
    And I click on the element identified by "a[onclick='openAttachPopup();']"
    And I set the input file field named "myfile" to the file at path "cypress/fixtures/import_files/core/7_image_v913.jpg"
    And I click on the button labeled "Upload file" in the dialog box
    And I should see "Upload in progress..."
    And I should see "Document was successfully uploaded"
    And I click on the button labeled "Close" in the dialog box
    And I click on the button labeled "Save" on the Online Designer page
    Then I should see "descriptive_file_text"

  Scenario: 35 - Add Descriptive Text
    Given I click on the Add Field input button below the field named "Descriptive Text with File"
    And I select "descriptive" from the dropdown identified by "select[name=field_type]"
    And I enter "Descriptive Text" into the field identified by "textarea[name=field_label]"
    And I enter "descriptive_text" into the field identified by "input[name=field_name]"
    And I click on the element identified by "textarea[name=field_label]"
    And I click on the button labeled "Save" on the Online Designer page
    Then I should see "descriptive_text"

  Scenario: 36 - Confirm Descriptive Text exists
    Given I click on the link labeled "Add / Edit Records"
    And I select "1" on the dropdown field labeled "Choose an existing Record ID"
    And I click the bubble to select a record for the "Data Types" longitudinal instrument on event "Event 1"
    And I should see "Descriptive Text with File"
    And I should see "Attachment:"
    And I should see "7_image_v913.jpg"
    And I should see "(0.01 MB)"

  Scenario: 37 - Review image upload
    Given I download a file by clicking on the link labeled "7_image_v913.jpg"
    #Open image?
    #Verify image contents
    Then I click on the button labeled "Save & Exit Form"

  Scenario: 38 - Add New Section
    Given I click on the link labeled "Designer"
    And I click on the link labeled "Data Types"
    And I click on the Add Field input button below the field named "Descriptive Text"
    And I select "section_header" from the dropdown identified by "select[name=field_type]"
    And I enter "Section Break" into the field identified by "textarea[name=field_label]"
    And I click on the button labeled "Save" on the Online Designer page
    Then I should see "Sorry, but Section Headers cannot be the last field on a data entry form." in an alert box
    And I should NOT see "Section Break"

  Scenario: 39 - Add New Section
    Given I click on the Add Field input button below the field named "File Upload"
    And I select "section_header" from the dropdown identified by "select[name=field_type]"
    And I enter "Section Break" into the field identified by "textarea[name=field_label]"
    And I click on the button labeled "Save" on the Online Designer page
    Then I should see ""

  Scenario: 40 - Add Identifier
    Given I add a new Descriptive Text field labeled "Identifier" with variable name "identifier"
    Then I should see "identifier"

  Scenario: 41 - Add Required Field
    Given I add a new Text Box field labeled "Required" with variable name "required"
    And I edit the Data Collection Instrument field labeled "Required"
    And I mark the field required
    And I save the field
    Then I should see "required"
    Then I should see "must provide value"

  Scenario: 42 - Drag and drop required field to indentifier field
    Given the AJAX "POST" request at "Design/update_field_order.php*" tagged by "update" is being monitored
    And I drag on the field named "required" to position 14
    And the AJAX request tagged by "update" has completed
    Then I should see a the field named "Required" before field named "Identifier"

  Scenario: 44 - Move Field to Other Instrument
    And I move the field named "Radio Button Auto" after the field named "Radio Button Manual"
    Then I should see "Successfully moved"

  Scenario: 45 - Edit moved field
    Given I click on the button labeled "Return to list of instruments"
    And I click on the link labeled "Data Dictionary Form"
    Given the AJAX "GET" request at "Design/edit_field_prefill.php*" tagged by "edit" is being monitored
    And I click on the Edit image for the field named "Testing data dictionary upload"
    And the AJAX request tagged by "edit" has completed
    And I select "text" from the dropdown identified by "select[name=field_type]"
    And I clear the field identified by "textarea[name=field_label]"
    And I clear the field identified by "input[name=field_name]"
    And I enter "Edit Field" into the field identified by "textarea[name=field_label]"
    And I enter "edit_field" into the field identified by "input[name=field_name]"
    And I click on the button labeled "Save" on the Online Designer page
    Then I should see "edit_field"

  #This is intentionally out of order because it makes no sense to delete this field before we move it
  Scenario: 43 - Delete field
    Given I click on the button labeled "Return to list of instruments"
    And I click on the link labeled "Data Dictionary Form"
    And I delete the field named "Testing data dictionary upload"
    Then I should NOT see "dd_test"

  Scenario: 46 - Copy Field, Cancel
    Given I click on the button labeled "Return to list of instruments"
    And I click on the link labeled "Data Types"
    Given I click on the Copy image for the field named "Identifier"
    And I click on the button labeled "Cancel" in the dialog box
    Then I should NOT see "identifier_2"
 
  Scenario: 47 - Copy Field, Confirm
    Given I click on the Copy image for the field named "Identifier"
    And the AJAX "GET" request at "Design/online_designer_render_fields.php*" tagged by "render" is being monitored
    And I click on the button labeled "Copy field" in the dialog box
    And the AJAX request tagged by "render" has completed
    Then I should see "identifier_2"

  Scenario: 48 - Logout
    Given I logout