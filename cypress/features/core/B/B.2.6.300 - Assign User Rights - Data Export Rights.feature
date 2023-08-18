Feature: B.2.6.300 The system shall allow instrument level data export rights to be (No Access, De-Identified, Remove All Identifier Fields, Full Data Set)

  As a REDCap end user
  I want to see that data export rights is functioning as expected

  Scenario: B.2.6.300.100 Data Export Rights
    #SETUP_PRODUCTION
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.6.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.300.100"

    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    ##USER_RIGHTS
    When I click on the link labeled "User Rights"
    And I click on the button labeled "Upload or download users, roles, and assignments"
    Then I should see "Upload users (CSV)"

    When I click on the link labeled "Upload users (CSV)"
    Then I should see a dialog containing the following text: "Upload users (CSV)"

    Given I upload a "csv" format file located at "import_files/user list for project 1.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
    Then I should see a dialog containing the following text: "Upload users (CSV) - Confirm"
    And I should see a table header and rows containing the following values in the a table:
      | username   |
      | test_user1 |
      | test_user2 |
      | test_user3 |
      | test_user4 |

    Given I click on the button labeled "Upload"
    Then I should see a dialog containing the following text: "SUCCESS!"
    And I close the popup
    And I logout

    Given I login to REDCap with the user "Test_User1"
    Then I should see "Logged in as"

    #FUNCTIONAL REQUIREMENT Export Full Data Set
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.300.100"
    And I click on the link labeled "Data Exports, Reports, and Stats"

    ##ACTION:
    Then I should see a table header and rows containing the following values in the reports table:
      | A | All data (all records and fields) |

    Given I click on the "Export Data" button for the "All data (all records and fields)" report in the My Reports & Exports table
    And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
    And I click on the button labeled "Export Data" in the dialog box
    Then I should see a dialog containing the following text: "Data export was successful!"

    Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
    Then I should have a "csv" file that contains the headings below
      | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | redcap_survey_identifier | name | email | text_validation_complete | ptname | text2 | textbox | notesbox | calculated_field | multiple_dropdown_auto | multiple_dropdown_manual | multiple_radio_auto | radio_button_manual | checkbox___1 | checkbox___2 | checkbox___3 | signature | file_upload | required | identifier | identifier_2 | edit_field | date_ymd | time_hhmmss | datetime_ymd_hmss | data_types_complete | survey_timestamp | name_survey | email_survey | survey_complete | consent_timestamp | name_consent | email_consent | dob | signature_consent | consent_complete |

    And I click on the button labeled "Close" in the dialog box

    ##VERIFY_LOG:
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action      | List of Data ChangesOR Fields Exported  |
      | mm/dd/yyyy hh:mm | test_user1 | Data export | Download exported data file (CSV raw)   |
      | mm/dd/yyyy hh:mm | test_admin | Add user    | user = 'test_user1'                     |

    #SETUP
    Given I logout
    Then I should see "Please log in"
    Given I login to REDCap with the user "Test_User2"
    Then I should see "Logged in as"

    #FUNCTIONAL REQUIREMENT Export remove all identifier fields
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.300.100"
    And I click on the link labeled "Data Exports, Reports, and Stats"

    ##ACTION:
    Then I should see a table header and rows containing the following values in the reports table:
      | A | All data (all records and fields) |

    Given I click on the "Export Data" button for the "All data (all records and fields)" report in the My Reports & Exports table
    And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
    And I check the checkbox labeled "Remove All Identifier Fields"
    And I click on the button labeled "Export Data" in the dialog box
    Then I should see a dialog containing the following text: "Data export was successful!"

    ##VERIFY_DE:
    Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box

    #NOTE: Notice how there is no identifier or identifier_2 fields when removing de-identifiers.  Still want to see ptname.
    Then I should have a "csv" file that contains the headings below
      | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | name | email | text_validation_complete | ptname | text2 | textbox | notesbox | calculated_field | multiple_dropdown_auto | multiple_dropdown_manual | multiple_radio_auto | radio_button_manual | checkbox___1 | checkbox___2 | checkbox___3 | signature | file_upload | required | edit_field | date_ymd | time_hhmmss | datetime_ymd_hmss | data_types_complete | survey_timestamp | name_survey | email_survey | survey_complete | consent_timestamp | name_consent | email_consent | dob | signature_consent | consent_complete |

    #SETUP
    Given I logout
    Then I should see "Please log in"
    Given I login to REDCap with the user "Test_User3"
    Then I should see "Logged in as"

    #FUNCTIONAL REQUIREMENT: Export Deidentified
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.300.100"
    And I click on the link labeled "Data Exports, Reports, and Stats"

    ##ACTION:
    Then I should see a table header and rows containing the following values in the reports table:
      | A | All data (all records and fields) |

    Given I click on the "Export Data" button for the "All data (all records and fields)" report in the My Reports & Exports table
    And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
    And I check the checkbox labeled "Remove All Identifier Fields" in the dialog box
    And I check the checkbox labeled "Hash the Record ID field" in the dialog box
    And I click on the button labeled "Export Data" in the dialog box
    Then I should see a dialog containing the following text: "Data export was successful!"

    ##VERIFY_DE:
    Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box

    #NOTE: Notice how there is no ptname, identifier, or identifier_2 fields when removing de-identifiers AND hashing Record ID
    Then I should have a "csv" file that contains the headings below
        | record_id | redcap_event_name | redcap_repeat_instrument | redcap_repeat_instance | redcap_data_access_group | email | text_validation_complete | calculated_field | multiple_dropdown_auto | multiple_dropdown_manual | multiple_radio_auto | radio_button_manual | checkbox___1 | checkbox___2 | checkbox___3 | signature | file_upload | date_ymd | time_hhmmss | datetime_ymd_hmss | data_types_complete | survey_timestamp | email_survey | survey_complete | consent_timestamp | email_consent | dob | signature_consent | consent_complete |

    #SETUP
    Given I logout
    Then I should see "Please log in"
    Given I login to REDCap with the user "Test_User4"
    Then I should see "Logged in as"

    #FUNCTIONAL REQUIREMENT: Export No Access
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.300.100"

    ##ACTION:
    And I click on the link labeled "Data Exports, Reports, and Stats"

    ##VERIFY
    Then I should NOT see a button labeled "Export Data"