Feature: B.2.6.200 Assign user rights Project Level:  The system shall allow data entry form user access to be (No Access / Read Only / View & Edit / Edit survey responses)

    As a REDCap end user
    I want to see that data entry rights is functioning as expected

    Scenario: B.2.6.200.100 Data Viewing Rights

      #SETUP
      Given I login to REDCap with the user "Test_Admin"
      And I create a new project named "B.2.6.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button


      When I click on the link labeled "My Projects"
      And I click on the link labeled "B.2.6.200.100"
      And I click on the link labeled "Project Setup"
      And I click on the button labeled "Move project to production"
      And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
      And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
      Then I should see Project status: "Production"

      When I click on the link labeled "User Rights"
      And I click on the button labeled "Upload or download users, roles, and assignments"
      Then I should see "Upload users (CSV)"

      When I click on the link labeled "Upload users (CSV)"
      Then I should see a dialog containing the following text: "Upload users (CSV)"

      Given I upload a "csv" format file located at "import_files/user list for project 1.csv", by clicking the button near "Select your CSV" to browse for the file, and clicking the button labeled "Upload" to upload the file
      Then I should see a dialog containing the following text: "Upload users (CSV) - Confirm"
      And I should see a table header and rows containing the following values in a table:
        | username   |
        | test_user1 |
        | test_user2 |
        | test_user3 |
        | test_user4 |

      Given I click on the button labeled "Upload"
      Then I should see a dialog containing the following text: "SUCCESS!"
      And I close the popup

      And I should see a table header and rows containing the following values in a table:
        |Role name                | Username            |
        | —                       | test_admin          |
        | —                       | test_user1          |
        | —                       | test_user2          |
        | —                       | test_user3          |
        | —                       | test_user4          |
        | 1_FullRights            | [No users assigned] |
        | 2_Edit_RemoveID         | [No users assigned] |
        | 3_ReadOnly_Deidentified | [No users assigned] |
        | 4_NoAccess_Noexport     | [No users assigned] |

      When I click on the link labeled "Test User1"
      And I click on the button labeled "Edit user privileges"
      Then I should see a dialog containing the following text: "Editing existing user"

      #FUNCTIONAL REQUIREMENT
      ##ACTION: Set user access to No Access

      When I set Data Viewing Rights to No Access for the instrument "Text Validation"
      And I save changes within the context of User Rights

      ##VERIFY_LOG: Verify Update user rights
      And I click on the link labeled "Logging"
      Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action   | List of Data ChangesOR Fields Exported  |
        | mm/dd/yyyy hh:mm | test_admin | Add user | user = 'test_user1'                     |

      ##ACTION #CROSS-FEATURE B.2.23.100: Verify Logging Filter by user name
      When I select the "test_admin" option from the Filter by username dropdown field

      ##VERIFY_LOG #CROSS-FEATURE: Verify Logging Filter by user name
      Then I should see a table header and rows containing the following values in the logging table:
        | Time / Date      | Username   | Action      | List of Data ChangesOR Fields Exported  |
        | mm/dd/yyyy hh:mm | test_admin | Update user | user = 'test_user1'                     |
      And I logout

      Given I login to REDCap with the user "Test_User1"
      And I click on the link labeled "My Projects"
      And I click on the link labeled "B.2.6.200.100"
      ##VERIFY: No access to Instrument
      And I click on the link labeled "Record Status Dashboard"
      Then I should NOT see "Text Validation"

      Given I click on the link labeled "User Rights"
      And I click on the link labeled "Test User1"
      And I click on the button labeled "Edit user privileges"
      Then I should see a dialog containing the following text: "Editing existing user"

      ##ACTION: Set user access to Read Only
      When I set Data Viewing Rights to Read Only for the instrument "Text Validation"
      And I save changes within the context of User Rights

      Given I click on the link labeled "Add / Edit Records"
      And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
      Then I should see "Record Home Page"

      ##VERIFY: Read Only for the instrument
      When I click the bubble to select a record for the "Text Validation" longitudinal instrument on event "Event 1"
      Then I should see "Text Validation"
      And I should NOT see a button labeled "Save & Exit Form"

      Given I click on the link labeled "User Rights"
      And I click on the link labeled "Test User1"
      And I click on the button labeled "Edit user privileges"
      Then I should see a dialog containing the following text: "Editing existing user"

      ##ACTION: Set user access to View & Edit + Edit survey responses
      When I set Data Viewing Rights to View & Edit with Edit survey responses checked for the instrument "Survey"
      And I save changes within the context of User Rights

      Given I click on the link labeled "Add / Edit Records"
      And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
      Then I should see "Record Home Page"

      ##VERIFY: Create survey record and then try to edit survey response for the instrument
      When I click the bubble to select a record for the "Survey" longitudinal instrument on event "Event Three"
      And I click on the button labeled "Survey options"

      #This opens the survey
      When I click on the survey option label containing "Open survey" label
      #We are submitting the survey
      And I click on the button labeled "Submit"

      Given I logout
      And I login to REDCap with the user "Test_User1"
      And I click on the link labeled "My Projects"
      And I click on the link labeled "B.2.6.200.100"
      Given I click on the link labeled "Add / Edit Records"
      And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
      Then I should see "Record Home Page"

      When I click the bubble to select a record for the "Survey" longitudinal instrument on event "Event Three"
      Then I should see "Survey response is editable"

      When I click on the button labeled "Edit response"
      Then I should see "now editing"

      When I clear field and enter "Edited Name" into the data entry form field labeled "Name"
      And I select the submit option labeled "Save & Stay" on the Data Collection Instrument
      Then I should see "successfully edited"

      Given I click on the link labeled "User Rights"
      And I click on the link labeled "Test User1"
      And I click on the button labeled "Edit user privileges"
      Then I should see a dialog containing the following text: "Editing existing user"

      ##ACTION: Remove user access to Edit survey responses
      When I set Data Viewing Rights to View & Edit with Edit survey responses unchecked for the instrument "Survey"
      And I save changes within the context of User Rights

      ##VERIFY: Not able to edit survey responses for the instrument
      Given I click on the link labeled "Add / Edit Records"
      And I select record ID "1" from arm name "Arm 1: Arm 1" on the Add / Edit record page
      Then I should see "Record Home Page"
      When I click the bubble to select a record for the "Survey" longitudinal instrument on event "Event Three"
      Then I should see "Survey response is read-only"
      And I should NOT see a button labeled "Save"
