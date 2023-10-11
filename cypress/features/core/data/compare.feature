Feature: Data Comparison Tool / DDE Module

  As a REDCap end user
  I want to see that the Data Comparison Tool and DDE Module are functioning as expected
  
  Scenario: Project Setup 1 - Create Project 17_DataComparisonTool_DDE_v1115
    Given I am a "standard" user who logs into REDCap
    And I create a project named "17_DataComparisonTool_DDE_v1115" with project purpose Operational Support via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
   
  Scenario: Project Setup 2 - Disable Longitudinal data collection and Repeating instruments and change Validation type of textbox
    Given I click on the link labeled "Project Setup"
    And I disable longitudinal mode
    And I open the dialog box for the Repeatable Instruments and Events module
    And I click on the checkbox labeled "Data Types" for repeating instrument setup
    And I click on the button labeled "Save"
    Then I should see "Your settings for repeating instruments and/or events have been successfully saved. (The page will now reload.)"
    And I close the popup
    Then I should see that repeatable instruments are disabled
    And I click on the link labeled "Designer"
    And I click on the table cell containing a link labeled "Data Types"
    And the AJAX "GET" request at "Design/edit_field_prefill.php*" tagged by "edit" is being monitored
    And I click on the Edit image for the field named "Text Box"
    And the AJAX request tagged by "edit" has completed
    And I select "Date (M-D-Y)" from the dropdown identified by "[id=val_type]"
    Then I click on the button labeled "Save"

  Scenario: 1 - Add 2 records and compare
    # Add first record
    Given I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    Then I click on the image "circle_gray" link for the row containing "Text Validation"
    And I enter "Rolling Stones" into the field identified by "input[name=ptname_v2_v2]"
    And I enter "rs@noreply.edu" into the field identified by "input[name=email_v2]"
    And I select "Complete" from the dropdown identified by "select[name=text_validation_complete]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully added"
    Then I click on the image "circle_gray" link for the row containing "Data Types"
    And I enter "Mick Jagger" into the field identified by "input[name=ptname]"
    And I enter "singer" into the field identified by "input[name=text2]"
    And I enter "07/26/1943" into the field identified by "input[name=textbox]"
    And I select "DDChoice5" from the dropdown identified by "select[name=multiple_dropdown_manual]"
    And I click on the element identified by "input[id=opt-radio_button_auto_1]"
    And I check the checkbox identified by "input[id='id-__chk__checkbox_RC_1']"
    And I enter "75" into the field identified by "input[name=required]"
    And I select "Complete" from the dropdown identified by "select[name=data_types_complete]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully edited"
    # Add second record
    Then I click on the link labeled "Add / Edit Records"
    And I click on the button labeled "Add new record"
    Then I click on the image "circle_gray" link for the row containing "Text Validation"
    And I enter "Guns N' Roses" into the field identified by "input[name=ptname_v2_v2]"
    And I enter "gnr@noreply.edu" into the field identified by "input[name=email_v2]"
    And I select "Complete" from the dropdown identified by "select[name=text_validation_complete]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully added"
    Then I click on the image "circle_gray" link for the row containing "Data Types"
    And I enter "Axl Rose" into the field identified by "input[name=ptname]"
    And I enter "singer" into the field identified by "input[name=text2]"
    And I enter "02/06/1962" into the field identified by "input[name=textbox]"
    And I select "DDChoice5" from the dropdown identified by "select[name=multiple_dropdown_manual]"
    And I click on the element identified by "input[id=opt-radio_button_auto_2]"
    And I check the checkbox identified by "input[id='id-__chk__checkbox_RC_1']"
    And I enter "57" into the field identified by "input[name=required]"
    And I select "Complete" from the dropdown identified by "select[name=data_types_complete]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully edited"
    # Compare the records
    When I click on the link labeled "Data Comparison Tool"
    And I select "2" from the dropdown identified by "select[id=record1]"
    And I select "3" from the dropdown identified by "select[id=record2]"
    And I click on the button labeled "Compare"
    Then I see "ptname_v2_v2"
    And I see "email_v2"
    And I see "ptname"
    And I see "textbox"
    And I see "radio_button_auto"
    And I see "required"
    And I should NOT see "text2"
    And I should NOT see "multiple_dropdown_manual"
    And I should NOT see "Checkbox"

  # ATS Comment: Not required for ATS testing. Not a core feature.
  # Scenario: 2 - Print page
  #   Given I print the page

  Scenario: 3 - Change Required field from 75 to 57 and compare
    Given I click on the text "75" of Record ID "2"
    Then I should see " Required"
    # Need to add .focus to the step definition
    And I clear the field and enter "57" into the "required" text input field
    And I click on the button labeled "Save & Exit Form"
    Then I should see "successfully edited"
    #  Compare the records
    When I click on the link labeled "Data Comparison Tool"
    And I select "2" from the dropdown identified by "select[id=record1]"
    And I select "3" from the dropdown identified by "select[id=record2]"
    And I click on the button labeled "Compare"
    Then I should NOT see "required"

  Scenario: 4 - Delete the name of Record ID 3 and compare
    #  Compare the records
    Given I click on the link labeled "Data Comparison Tool"
    And I select "2" from the dropdown identified by "select[id=record1]"
    And I select "3" from the dropdown identified by "select[id=record2]"
    And I click on the button labeled "Compare"
    And I click on the text "Guns N' Roses" of Record ID "3"
    Then I should see "Name"
    And I clear the field identified by "input[name=ptname_v2_v2]"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "successfully edited"
    #  Compare the records
    When I click on the link labeled "Data Comparison Tool"
    And I select "2" from the dropdown identified by "select[id=record1]"
    And I select "3" from the dropdown identified by "select[id=record2]"
    And I click on the button labeled "Compare"
    Then I should see the value "" in the field name "ptname_v2_v2" for Record ID "3"
    And I should see the value "Rolling Stones" in the field name "ptname_v2_v2" for Record ID "2"

  Scenario: 5 - Make the data of Record ID 3 the same as that of Record ID 2 and compare.
    #  Compare the records
    Given I click on the link labeled "Data Comparison Tool"
    And I select "2" from the dropdown identified by "select[id=record1]"
    And I select "3" from the dropdown identified by "select[id=record2]"
    And I click on the button labeled "Compare"
    And I click on the text "gnr@noreply.edu" of Record ID "3"
    Then I enter "Rolling Stones" into the field identified by "input[name=ptname_v2_v2]"
    And I clear the field and enter "rs@noreply.edu" into the "email_v2" text input field
    And I click on the button labeled "Save & Exit Form"
    Then I should see "successfully edited"
    Then I click on the image "circle_green" link for the row containing "Data Types"
    And I clear the field and enter "Mick Jagger" into the "ptname" text input field
    And I clear the field and enter "singer" into the "text2" text input field
    And I clear the field and enter "07/26/1943" into the "textbox" text input field
    And I click on the element identified by "input[id=opt-radio_button_auto_1]"
    And I click on the button labeled "Save & Exit Form"
    Then I should see "successfully edited"
    When I click on the link labeled "Data Comparison Tool"
    And I select "2" from the dropdown identified by "select[id=record1]"
    And I select "3" from the dropdown identified by "select[id=record2]"
    And I click on the button labeled "Compare"
    Then I should see "No differences were found."
    Then I logout

  Scenario: 6 - Enable Double Data Entry Module
    Given I am an "admin" user who logs into REDCap
    And  I click on the link labeled "Control Center"
    And  I click on the link labeled "Browse Projects"
    And I wait for 0.5 seconds
    And I enter "17_DataComparisonTool_DDE_v1115" into the field identified by "input[id=project_search]"
    And I click on the button labeled "Search project title"
    Then I click on the link labeled "17_DataComparisonTool_DDE_v1115"
    And I click on the link labeled "Edit project settings"
    Then I should see "Edit a Project's Settings"
    And I scroll the page to the field identified by "select[name=double_data_entry]"
    Then I select "Enabled" from the dropdown identified by "select[name=double_data_entry]"
    And I click on the button labeled "Save Changes"
    Then I should see "Your changes have been saved!"
    When I click on the link labeled "17_DataComparisonTool_DDE_v1115"
    Then I should see "Project Home"
    And I should see "17_DataComparisonTool_DDE_v1115"

  Scenario: 7a - Assign Double Data Entry roles to users - test_user and test_user2
    # Make test_user as Person1
    Given I click on the link labeled "User Rights"
    And the AJAX "POST" request at "Messenger/messenger.php*" tagged by "render" is being monitored
    And I click to edit username "test_user (Test User)"
    Then I click on the button labeled "Edit user privileges"
    And I click on the element identified by "input[name=double_data][value=1]"
    And I click on the button labeled "Save Changes"
    Then I should see "was successfully edited"
    # Make test_user2 as Person2
    Then I enter "test_user2" into the field identified by "input[id=new_username]"
    And the AJAX "POST" request at "UserRights/edit_user.php*" tagged by "render" is being monitored
    And I click on the button labeled "Add with custom rights"
    And the AJAX request tagged by "render" has completed
    And I click on the element identified by "input[name=double_data][value=2]"
    Then I click on the button labeled "Add user"
    Then I should see "was successfully added"
    
  Scenario: 7b - Assign Double Data Entry roles to users - test_admin
    # Make test_admin as reviewer
    Then I enter "test_admin" into the field identified by "input[id=new_username]"
    And the AJAX "POST" request at "UserRights/edit_user.php*" tagged by "render" is being monitored
    And I click on the button labeled "Add with custom rights"
    And the AJAX request tagged by "render" has completed
    And I click on the element identified by "input[name=double_data][value=0]"
    And I check the User Right named "Data Comparison Tool"
    And the AJAX "POST" request at "UserRights/edit_user.php*" tagged by "render" is being monitored
    Then I click on the button labeled "Add user"
    Then I should see "was successfully added"
    Then I logout
  
  Scenario: 8a - Login as test_user and create record 5
    # Add first record as user1
    Given I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "17_DataComparisonTool_DDE_v1115"
    And I click on the link labeled "Add / Edit Records"
    And the AJAX "GET" request at "DataEntry/record_home.php*" tagged by "render" is being monitored
    Then I enter "5" into the field identified by "input[id=inputString]"
    # The below step is to get the focus away from the above step
    And I click on the element identified by "input[id=search_query]"
    And the AJAX request tagged by "render" has completed
    Then I click on the image "circle_gray" link for the row containing "Text Validation"
    And I enter "Beatles" into the field identified by "input[name=ptname_v2_v2]"
    And I enter "beatles@noreply.edu" into the field identified by "input[name=email_v2]"
    And I select "Complete" from the dropdown identified by "select[name=text_validation_complete]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully added"
    Then I click on the image "circle_gray" link for the row containing "Data Types"
    And I enter "Paul McCartney" into the field identified by "input[name=ptname]"
    And I enter "singer" into the field identified by "input[name=text2]"
    And I enter "06/18/1943" into the field identified by "input[name=textbox]"
    And I select "DDChoice5" from the dropdown identified by "select[name=multiple_dropdown_manual]"
    And I click on the element identified by "input[id=opt-radio_button_auto_2]"
    And I check the checkbox identified by "input[id='id-__chk__checkbox_RC_1']"
    And I enter "77" into the field identified by "input[name=required]"
    And I select "Complete" from the dropdown identified by "select[name=data_types_complete]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully edited"
    Then I logout
  
  Scenario: 8b - Login as test_user2 and create record 5
    # Add second record as user2
    Given I am a "standard2" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "17_DataComparisonTool_DDE_v1115"
    And I click on the link labeled "Add / Edit Records"
    And the AJAX "GET" request at "DataEntry/record_home.php*" tagged by "render" is being monitored
    Then I enter "5" into the field identified by "input[id=inputString]"
    # The below step is to get the focus away from the above step
    And I click on the element identified by "input[id=search_query]"
    And the AJAX request tagged by "render" has completed
    Then I click on the image "circle_gray" link for the row containing "Text Validation"
    And I enter "Beatles" into the field identified by "input[name=ptname_v2_v2]"
    And I enter "beatles@noreply.edu" into the field identified by "input[name=email_v2]"
    And I select "Complete" from the dropdown identified by "select[name=text_validation_complete]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully added"
    Then I click on the image "circle_gray" link for the row containing "Data Types"
    And I enter "Paul McCartney" into the field identified by "input[name=ptname]"
    And I enter "singer" into the field identified by "input[name=text2]"
    And I enter "06/18/1943" into the field identified by "input[name=textbox]"
    And I select "DDChoice5" from the dropdown identified by "select[name=multiple_dropdown_manual]"
    And I click on the element identified by "input[id=opt-radio_button_auto_2]"
    And I check the checkbox identified by "input[id='id-__chk__checkbox_RC_1']"
    And I enter "77" into the field identified by "input[name=required]"
    And I select "Complete" from the dropdown identified by "select[name=data_types_complete]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully edited"
    Then I logout

  Scenario: 8c - Login as test_admin and create record 5 (combining 2 records)
    # Review the 2 records
    Given I am an "admin" user who logs into REDCap
    And  I click on the link labeled "Control Center"
    And  I click on the link labeled "Browse Projects"
    And I wait for 0.5 seconds
    And I enter "17_DataComparisonTool_DDE_v1115" into the field identified by "input[id=project_search]"
    And I click on the button labeled "Search project title"
    Then I click on the link labeled "17_DataComparisonTool_DDE_v1115"
    When I click on the link labeled "Data Comparison Tool"
    And I select "5" from the dropdown identified by "select[id=record1]"
    And I click on the button labeled "Compare selected record"
    Then I should see "are identical. No differences were found"
    And the AJAX "POST" request at "/index.php*" tagged by "render" is being monitored
    Then the form should have a redcap_csrf_token
    And I click on the button labeled "Create Record 5"
    Then I should see "RECORD CREATED!"
    And I should see "has now been created by merging the values you selected from records 5--1 and 5--2"
    Then I logout

  Scenario: 9a - Login as test_user and create record 10
    # Add first record as user1
    Given I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "17_DataComparisonTool_DDE_v1115"
    And I click on the link labeled "Add / Edit Records"
    And the AJAX "GET" request at "DataEntry/record_home.php*" tagged by "render" is being monitored
    Then I enter "10" into the field identified by "input[id=inputString]"
    # The below step is to get the focus away from the above step
    And I click on the element identified by "input[id=search_query]"
    And the AJAX request tagged by "render" has completed
    Then I click on the image "circle_gray" link for the row containing "Text Validation"
    And I enter "Beatles" into the field identified by "input[name=ptname_v2_v2]"
    And I enter "beatles@noreply.edu" into the field identified by "input[name=email_v2]"
    And I select "Complete" from the dropdown identified by "select[name=text_validation_complete]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully added"
    Then I click on the image "circle_gray" link for the row containing "Data Types"
    And I enter "Paul McCartney" into the field identified by "input[name=ptname]"
    And I enter "singer" into the field identified by "input[name=text2]"
    And I enter "06/18/1943" into the field identified by "input[name=textbox]"
    And I select "DDChoice5" from the dropdown identified by "select[name=multiple_dropdown_manual]"
    And I click on the element identified by "input[id=opt-radio_button_auto_2]"
    And I check the checkbox identified by "input[id='id-__chk__checkbox_RC_1']"
    And I enter "77" into the field identified by "input[name=required]"
    And I select "Complete" from the dropdown identified by "select[name=data_types_complete]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully edited"
    Then I logout
  
  Scenario: 9b - Login as test_user2 and create record 10
    # Add second record as user2
    Given I am a "standard2" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "17_DataComparisonTool_DDE_v1115"
    And I click on the link labeled "Add / Edit Records"
    And the AJAX "GET" request at "DataEntry/record_home.php*" tagged by "render" is being monitored
    Then I enter "10" into the field identified by "input[id=inputString]"
    # The below step is to get the focus away from the above step
    And I click on the element identified by "input[id=search_query]"
    And the AJAX request tagged by "render" has completed
    Then I click on the image "circle_gray" link for the row containing "Text Validation"
    And I enter "Beatles" into the field identified by "input[name=ptname_v2_v2]"
    And I enter "beatles@noreply.edu" into the field identified by "input[name=email_v2]"
    And I select "Complete" from the dropdown identified by "select[name=text_validation_complete]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully added"
    Then I click on the image "circle_gray" link for the row containing "Data Types"
    And I enter "Paul" into the field identified by "input[name=ptname]"
    And I enter "vocalist" into the field identified by "input[name=text2]"
    And I enter "06/18/1943" into the field identified by "input[name=textbox]"
    And I select "DDChoice5" from the dropdown identified by "select[name=multiple_dropdown_manual]"
    And I click on the element identified by "input[id=opt-radio_button_auto_2]"
    And I check the checkbox identified by "input[id='id-__chk__checkbox_RC_1']"
    And I enter "77" into the field identified by "input[name=required]"
    And I select "Complete" from the dropdown identified by "select[name=data_types_complete]"
    Then I click on the button labeled "Save & Exit Form"
    Then I should see "successfully edited"
    Then I logout

    Scenario: 9c - Login as test_admin and create record 10 (combining 2 records)
    # Review the 2 records
    Given I am an "admin" user who logs into REDCap
    And  I click on the link labeled "Control Center"
    And  I click on the link labeled "Browse Projects"
    And I wait for 0.5 seconds
    And I enter "17_DataComparisonTool_DDE_v1115" into the field identified by "input[id=project_search]"
    And I click on the button labeled "Search project title"
    Then I click on the link labeled "17_DataComparisonTool_DDE_v1115"
    When I click on the link labeled "Data Comparison Tool"
    And I select "10" from the dropdown identified by "select[id=record1]"
    And I click on the button labeled "Compare selected record"
    Then I should see "Differences were found between the two records named"
    And the AJAX "POST" request at "/index.php*" tagged by "render" is being monitored
    And the form should have a redcap_csrf_token
    And I click on the link labeled "click here to merge them"
    And I click on the radio option labeled "vocalist" in the data comparison tool to merge records
    And I click on the button labeled "Merge Records"
    Then I should see "RECORD CREATED!"
    And I should see "has now been created by merging the values you selected from records 10--1 and 10--2"
    Then I logout

   Scenario: 10 - Disable Double Data Entry Module
    Given I am an "admin" user who logs into REDCap
    And  I click on the link labeled "Control Center"
    And  I click on the link labeled "Browse Projects"
    And I wait for 0.5 seconds
    And I enter "17_DataComparisonTool_DDE_v1115" into the field identified by "input[id=project_search]"
    And I click on the button labeled "Search project title"
    Then I click on the link labeled "17_DataComparisonTool_DDE_v1115"
    And I click on the link labeled "Edit project settings"
    Then I should see "Edit a Project's Settings"
    And I scroll the page to the field identified by "select[name=double_data_entry]"
    Then I select "Disabled" from the dropdown identified by "select[name=double_data_entry]"
    And I click on the button labeled "Save Changes"
    Then I should see "Your changes have been saved!"
    When I click on the link labeled "17_DataComparisonTool_DDE_v1115"
    Then I should see "Project Home"
    And I should see "17_DataComparisonTool_DDE_v1115"
    Then I logout