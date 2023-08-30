Feature: A.6.4.400 Manage project creation, deletion, and settings

  Manage project creation, deletion, and settings
  Control Center: The system shall allow production Draft Mode changes to be approved automatically under certain conditions.

  Scenario: A.6.4.400.100 User’s ability to approve draft changes without administrative approval

    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.6.4.400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

    # BEGIN: STEPS FOR ATS
    # - EMAIL ADDRESS SET FOR REDCAP ADMIN - without it, project request behavior does not work properly
    Given I click on the link labeled "Control Center"
    And I click on the link labeled "General Configuration"
    Then I should see "General Configuration"

    When I enter "redcap@test.instance" into the input field labeled "Email Address of REDCap Administrator"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed"
    # END: STEPS FOR ATS ###

    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.100"

    And I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        |  List of Data ChangesOR Fields Exported |
      | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Move project to Production status       |

    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    When I select "Never (always require an admin to approve changes)" on the dropdown field labeled "Allow production Draft Mode changes to be approved automatically under certain conditions?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.100"
    And I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"
    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Enter draft mode                        |

    When I click on the link labeled "Designer"
    When I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box
    Then I should see "Awaiting review of project changes"
    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported               |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Request approval for production project modifications |

    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.100"
    And I click on the link labeled "Designer"
    Then I should see "REVIEW CHANGES?"

    When I click on the button labeled "Project Modification Module"
    And I click on the button labeled "Reject Changes"
    And I click on the button labeled "Reject Changes" in the dialog box
    Then I should see "Project Changes Rejected / User Notified"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.100"
    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported |
      | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Reject production project modifications |

    And I click on the link labeled "Designer"
    #THE PROJECT STAYS IN DRAFT MODE IF THE CHANGES ARE REJECTED SO DRAFT MODE BUTTON DOES NOT APPEAR
    #And I click on the button labeled "Enter Draft Mode"
    #Then I should see "The project is now in Draft Mode"

    When I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box
    Then I should see "Awaiting review of project changes"
    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported               |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Request approval for production project modifications |

    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.100"
    And I click on the link labeled "Designer"
    Then I should see "REVIEW CHANGES?"

    When I click on the button labeled "Project Modification Module"
    And I click on the button labeled "COMMIT CHANGES"
    And I click on the button labeled "COMMIT CHANGES" in the dialog box
    Then I should see "Project Changes Committed / User Notified"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.100"
    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported  |
      | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Approve production project modifications |

    And I click on the link labeled "Designer"
    Then I should see "Enter Draft Mode"


  Scenario: A.6.4.400.200 User’s ability to approve draft changes without administrative approval if no existing fields were modified
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.6.4.400.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.200"

    And I click on the link labeled "User Rights"
    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    When I select "Yes, if no existing fields were modified" on the dropdown field labeled "Allow production Draft Mode changes to be approved automatically under certain conditions?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.200"
    And I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"

    When I click on the link labeled "Data Types"
    And I click on the Edit image for the field named "Radio Button Manual"
    And I enter Choices of "102, Choice102" into the open "Edit Field" dialog box
    And I click on the button labeled "Save"
    And I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.200"
    And I click on the link labeled "Designer"
    Then I should see "REVIEW CHANGES?"

    When I click on the button labeled "Project Modification Module"
    And I click on the button labeled "Remove All Drafted Changes"
    And I click on the button labeled "Remove All Drafted Changes" in the dialog box
    Then I should see "Project Changes Removed / User Notified"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.200"
    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported |
      | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Remove production project modifications |

    And I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"

    When I click on the link labeled "Data Types"
    And I add a new Text Box field labeled "Text Box 2" with variable name "textbox_2" and click on the "Save" button
    Then I should see "Text Box 2"

    When I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box
    Then I should see "Changes Were Made Automatically"
    And I click on the button labeled "Close" in the dialog box
    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported                |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Approve production project modifications (automatic)  |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Create project field                                  |

  Scenario: A.6.4.400.300 User’s ability to approve draft changes without administrative approval if no critical issues exist
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.6.4.400.300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.300"
    And I click on the link labeled "User Rights"

    And I enter "Test_User1" into the field with the placeholder text of "Assign new user to role"
    And I click on the button labeled "Assign to role"
    And I select "1_FullRights" on the dropdown field labeled "Select Role" on the role selector dropdown
    When I click on the button labeled exactly "Assign" on the role selector dropdown
    Then I should see "Test User1" within the "1_FullRights" row of the column labeled "Username" of the User Rights table

    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box to request a change in project status
    Then I should see Project status: "Production"

    When I click on the link labeled "Control Center"
    And I click on the link labeled "User Settings"
    Then I should see "System-level User Settings"
    When I select "Yes, if project has no records OR if has records and no critical issues exist" on the dropdown field labeled "Allow production Draft Mode changes to be approved automatically under certain conditions?"
    And I click on the button labeled "Save Changes"
    Then I should see "Your system configuration values have now been changed!"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.300"
    And I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"

    When I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box
    Then I should see "Changes Were Made Automatically"
    And I click on the button labeled "Close" in the dialog box

    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"

    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Approve production project modifications (automatic) |

    When I click on the link labeled "Designer"

    #We were already in DRAFT MODE.  See line 231.
    #And I click on the button labeled "Enter Draft Mode"
    #Then I should see "The project is now in Draft Mode"

    When I click on the link labeled "Data Types"
    And I click on the Edit image for the field named "Radio Button Manual"

    #We are deleting the third option and renaming "100, Choice100" to "101, Choice100" in one step
    And I clear field and enter Choices of "9..9, Choice99{enter}101, Choice100" into the open "Edit Field" dialog box

    And I click on the button labeled "Save"
    And I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box
    Then I should see "Awaiting review of project changes"
    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported               |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Request approval for production project modifications |

    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.300"
    And I click on the link labeled "Designer"
    Then I should see "REVIEW CHANGES?"

    When I click on the button labeled "Project Modification Module"
    Then I should see "Total potentially critical issues: 1"
    And I click on the button labeled "Remove All Drafted Changes"
    And I click on the button labeled "Remove All Drafted Changes" in the dialog box
    Then I should see "Project Changes Removed / User Notified"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.300"
    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported |
      | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Remove production project modifications |

    And I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"

    When I click on the link labeled "Data Types"
    And I click on the Edit image for the field named "Radio Button Manual"

    #We are deleting the third option and renaming "100, Choice100" to "101, Choice100" in one step
    And I clear field and enter Choices of "9..9, Choice99{enter}101, Choice100" into the open "Edit Field" dialog box

    And I click on the button labeled "Save"
    And I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box
    Then I should see "Awaiting review of project changes"
    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported               |
      | mm/dd/yyyy hh:mm | test_user1 | Manage/Design | Request approval for production project modifications |

    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.300"
    And I click on the link labeled "Designer"
    Then I should see "REVIEW CHANGES?"

    When I click on the button labeled "Project Modification Module"
    Then I should see "Total potentially critical issues: 1"
    And I click on the button labeled "COMMIT CHANGES"
    And I click on the button labeled "COMMIT CHANGES" in the dialog box
    Then I should see "Project Changes Committed / User Notified"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.300"
    And I click on the link labeled "Logging"

    Then I should see a table header and rows containing the following values in the logging table:
      | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported   |
      | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Approve production project modifications  |

    And I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "The project is now in Draft Mode"

    When I click on the link labeled "Data Types"
    And I click on the Edit image for the field named "Radio Button Manual"
    Then I should see a dialog containing the following text: "Edit Field"
    When I verify Choice of "101, Choice100" in the open "Edit Field" dialog box
    Then I click on the button labeled "Cancel" in the dialog box

    When I click on the link labeled "Data Exports, Reports, and Stats"

    Given I see a table rows containing the following values in the reports table:
      | A | All data (all records and fields)  |
      | B | Selected instruments and/or events |

    And I click on the button labeled "View Report"

    # The manual step: Then I should see "Choice100 (101)"
    # IMPORTANT: The above is NOT what we would expect to see
    # The data entered in this project was entered BEFORE we made these changes to the Radio Button Manual field
    # Thus, because we have unmapped the original value (100) from the label of Choice100 ...
    # We would expect to see ONLY the raw value (100) in the report data table

    Given I see a table header and rows containing the following values in the report data table:
      | Record ID | Repeat Instrument      | Event Name             | Radio Button Manual |
      | 1         | Data Types             | Event 1 (Arm 1: Arm 1) |                     |
      | 2         | Data Types             | Event 1 (Arm 1: Arm 1) | (100)               |
      | 3         | Data Types             | Event 1 (Arm 1: Arm 1) | (100)               |
      | 4         | Data Types             | Event 1 (Arm 1: Arm 1) | (100)               |

    When I click on the link labeled "Designer"

    When I click on the link labeled "Data Types"
    And I click on the Edit image for the field named "Radio Button Manual"

    #We are adding the third option of "102, Choice102"
    And I clear field and enter Choices of "9..9, Choice99{enter}101, Choice100{enter}102, Choice102" in the open "Edit Field" dialog box

    And I click on the button labeled "Save"
    And I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box
    Then I should see "Changes Were Made Automatically"
    And I click on the button labeled "Close" in the dialog box
