Feature: User Interface: General: The system shall support the ability to copy the project, all users, and all data.

  As a REDCap end user
  I want to see that Project Setup is functioning as expected

  Scenario: B.6.4.1000.100 Copy a project with all users and all data

    # BEGIN: STEPS FOR ATS
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    # - EMAIL ADDRESS SET FOR REDCAP ADMIN - without it, project request behavior does not work properly
    # - CUSTOM MESSAGE SET - Makes the dialog box pop up when requesting a project
    Given I click on the link labeled "General Configuration"
    Then I should see "General Configuration"

    When I enter "redcap@test.instance" into the input field labeled "Email Address of REDCap Administrator"
    And I enter "You are now creating a test project" into the textarea field labeled "Custom message when creating/copying project"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed"

    #ALSO NEED TO ALLOW REGULAR USERS TO MOVE TO PRODUCTION, OTHERWISE NONE OF THIS STUFF WORKS ...
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    When I select "Yes, normal users can move projects to production" on the dropdown field labeled "Allow normal users to move projects to production?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"

    And I logout
    # END: STEPS FOR ATS ###


    #SETUP_DEV
    Given I login to REDCap with the user "Test_User1"
    And I create a new project named "B.6.4.1000.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    And I click on the button labeled "I Agree" in the dialog box

    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.4.1000.100"
    And I click on the link labeled "Other Functionality"
    Then I should see a button labeled "Copy the Project"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Copy original in development mode
    When I click on the button labeled "Copy the Project"
    And I enter "B.6.4.1000.100.DEV" into the input field labeled "Project title:"
    And I click on the link labeled "Select All"
    And I click on the button labeled "Copy project"
    And I click on the button labeled "I Agree" in the dialog box
    Then I should see "COPY SUCCESSFUL!"

    ##VERIFY_UR
    When I click on the link labeled "User Rights"
    Then I should see a table header and rows containing the following values in a table:
      |Role name                | Username            |
      | —                       | test_user1          |
      | 1_FullRights            | [No users assigned] |
      | 2_Edit_RemoveID         | [No users assigned] |
      | 3_ReadOnly_Deidentified | [No users assigned] |
      | 4_NoAccess_Noexport     | [No users assigned] |
      | TestRole                | [No users assigned] |

    ##VERIFY_RSD
    When I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 1         |
      | 2         |
      | 3         |
      | 4         |

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username    | Action                  | List of Data ChangesOR Fields Exported  |
      | test_user1  | Add user                | user = 'test_user1'                     |
      | test_user1  | Manage/Design           | Copy project from                       |

    #SETUP_PRODUCTION
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.4.1000.100"
    And I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Copy original in production mode
    When I click on the link labeled "Other Functionality"
    Then I should see a button labeled "Copy the Project"

    When I click on the button labeled "Copy the Project"
    And I enter "B.6.4.1000.100.PROD" into the input field labeled "Project title:"
    And I click on the link labeled "Select All"
    And I click on the button labeled "Copy project"
    And I click on the button labeled "I Agree" in the dialog box
    Then I should see "COPY SUCCESSFUL!"

    ##VERIFY_UR
    When I click on the link labeled "User Rights"
    Then I should see a table header and rows containing the following values in a table:
      |Role name                | Username            |
      | —                       | test_user1          |
      | 1_FullRights            | [No users assigned] |
      | 2_Edit_RemoveID         | [No users assigned] |
      | 3_ReadOnly_Deidentified | [No users assigned] |
      | 4_NoAccess_Noexport     | [No users assigned] |
      | TestRole                | [No users assigned] |

    ##VERIFY_RSD
    When I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 1         |
      | 2         |
      | 3         |
      | 4         |

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
    | Username   |        Action           | List of Data ChangesOR Fields Exported |
    | test_user1  | Add user              | user = 'test_user1'|
    | test_user1  | Manage/Design | Copy project from |

    #SETUP_ANALYSIS
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.4.1000.100"
    And I click on the link labeled "Other Functionality"
    And I click on the button labeled "Move to Analysis/Cleanup status"
    And I click on the button labeled "YES, Move to Analysis/Cleanup Status"
    #Then I should see "The project has now been set to ANALYSIS/CLEANUP" in an alert box
    And I should see Project status: "Analysis/Cleanup"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Copy original in analysis mode
    Given I click on the button labeled "Copy the Project"
    And I enter "B.6.4.1000.100.ANALYSIS" into the input field labeled "Project title:"
    And I click on the link labeled "Select All"
    And I click on the button labeled "Copy project"
    And I click on the button labeled "I Agree" in the dialog box
    Then I should see "COPY SUCCESSFUL!"

    ##VERIFY_UR
    When I click on the link labeled "User Rights"
    Then I should see a table header and rows containing the following values in a table:
      |Role name                | Username            |
      | —                       | test_user1          |
      | 1_FullRights            | [No users assigned] |
      | 2_Edit_RemoveID         | [No users assigned] |
      | 3_ReadOnly_Deidentified | [No users assigned] |
      | 4_NoAccess_Noexport     | [No users assigned] |
      | TestRole                | [No users assigned] |

    ##VERIFY_RSD
    When I click on the link labeled "Record Status Dashboard"
    Then I should see a table header and rows containing the following values in the record status dashboard table:
      | Record ID |
      | 1         |
      | 2         |
      | 3         |
      | 4         |

    ##VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   |        Action           | List of Data ChangesOR Fields Exported |
      | test_user1  | Add user              | user = 'test_user1'|
      | test_user1  | Manage/Design | Copy project from |

    #And I want to export a snapshot of this feature here
    #And I want to pause

    #SETUP_COMPLETED
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "B.6.4.1000.100"
    And I click on the link labeled "Other Functionality"
    And I click on the button labeled "Mark project as Completed"
    And I click on the button labeled "Mark project as Completed" in the dialog box

    #TODO: Need to verify with Manual Validation why this is here.  Is it supposed to redirect to the My Projects page?  Shrug.
    Then I should see "My Projects"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: UNABLE to Copy original in complete mode as User
    When I click on the link labeled "Show Completed Projects"
    And I click on the link labeled "B.6.4.1000.100"
    ##VERIFY
    Then I should see a dialog containing the following text: "NOTICE: Project was marked as Completed"
    And I click on the button labeled "Return to My Projects page" in the dialog box
    And I logout

    ##ACTION: UNABLE to Copy original in complete mode as Admin
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Browse Projects"
    And I enter "B.6.4.1000.100" into the input field labeled "Search project title by keyword(s):"
    And I click on the button labeled "Search project title"
    And I click on the link labeled "B.6.4.1000.100"
    ##VERIFY
    Then I should see "NOTICE: Project was marked as Completed"
    And I click on the button labeled "Return to My Projects page"
