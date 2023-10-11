Feature: Design forms Using Data Dictionary and Online Designer
  Form Creation: The system shall support the ability to delete data collection instruments.

  As a REDCap end user
  I want to see that Project Designer is functioning as expected

  Scenario: B.6.7.500.100 Delete instrument from online designer

    #SETUP
    Given I login to REDCap with the user "Test_Admin"

    # BEGIN: STEPS FOR ATS
    And I click on the link labeled "Control Center"
    # - EMAIL ADDRESS SET FOR REDCAP ADMIN - without it, project request behavior does not work properly
    Given I click on the link labeled "General Configuration"
    Then I should see "General Configuration"
    When I enter "redcap@test.instance" into the input field labeled "Email Address of REDCap Administrator"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed"
    # END: STEPS FOR ATS ###

    And I create a new project named "B.6.7.500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    ##SETUP_PRODUCTION
    When I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far." in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    When I click on the button labeled "Online Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"

    #This establishes what instruments are here initially
    Then I should see a table header and rows containing the following values in a table:
      | Instrument name   | Fields |
      | Text Validation   | 3      |
      | Data Types        | 21     |
      | Survey            | 2      |
      | Consent           | 4      |

    #FUNCTIONAL_REQUIREMENT
    ##ACTION
    #And I want to export a snapshot of this feature here
    Given I click on the first button labeled "Choose action"
    And I click on the link labeled "Delete" in the action popup
    Then I should see a dialog containing the following text: "Delete the selected form?"
    And I click on the button labeled "Yes, delete it" in the dialog box
    Then I should see "The data collection instrument and all its fields have been successfully deleted"

    #This establishes what instruments are here now
    Then I should see a table header and rows containing the following values in a table:
      | Instrument name   | Fields |
      | Data Types        | 21     |
      | Survey            | 2      |
      | Consent           | 4      |

    When I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box

    Given I should see "As an Administrator, you may review and approve changes made to the project. To do so, navigate to the Project Modification Module."
    And I click on the button labeled "Project Modification Module"
    And I click on the button labeled "COMMIT CHANGES"
    Then I should see a dialog containing the following text: "COMMIT CHANGES TO PROJECT?"
    And I click on the button labeled "COMMIT CHANGES" in the dialog box

    #VERIFY_LOG
    When I click on the link labeled "Logging"
    Then I should see a table header and rows containing the following values in the logging table:
      | Username   | Action        | List of Data ChangesOR Fields Exported |
      | test_admin | Manage/Design | Delete data collection instrument |