Feature: A.6.4.300 Manage project creation, deletion, and settings

  Manage project creation, deletion, and settings
  Control Center: The system shall allow production Draft Mode changes to be approved automatically under certain conditions.

  Scenario: A.6.4.400.100 User’s ability to approve draft changes without administrative approval

    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.6.4.400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml" and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.100"
    And I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Assign to role"
    And I should see the dropdown field labeled "Select Role"
    When I assign "1_FullRights" on dropdown field labeled "Select Role"
    And I click on the button labeled "Assign"
    Then I should see "Test_User1" user assigned "1_FullRights" role

    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio button labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project Status"
    And I should see "Production"
    And I click on the button labeled "Logging"
    Then I should see "Move project to Production status"
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
    And I click on the button labeled "Logging"
    Then I should see "Enter draft mode"

    When I click on the link labeled "Designer"
    When I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Submit" in the dialog box
    Then I should see "Awaiting review of project changes"
    And I click on the button labeled "Logging"
    Then I should see "Request approval for production project modifications"
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.100"
    And I click on the link labeled "Designer"
    Then I should see "REVIEW CHANGES?"

    When I click on the button labeled "Project Modification Module"
    And I click on the button labeled "Reject Changes"
    And I click on the button labeled "Reject Changes" in the dialog box
    Then I should see "Project Changes Rejected/User Notified"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.100"
    And I click on the button labeled "Logging"
    Then I should see "Reject production project modifications"

    And I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "Success! The project is now in Draft Mode"

    When I click on the button labeled "Submit Changes for Review"
    And I click "Submit" in the dialog box
    Then I should see "Awaiting review of project changes"
    And I click on the button labeled "Logging"
    Then I should see "Request approval for production project modifications"
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.100"
    And I click on the link labeled "Designer"
    Then I should see "REVIEW CHANGES?"

    When I click on the button labeled "Project Modification Module"
    And I click on the button labeled "COMMIT CHANGES"
    And I click on the button labeled "COMMIT CHANGES" in the dialog box
    Then I should see "Project Changes Committed/User Notified"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.100"
    And I click on the button labeled "Logging"
    Then I see "Approve production project modifications"
    And I click on the link labeled "Designer"
    Then I should see "Enter Draft Mode"


  Scenario: A.6.4.400.200 User’s ability to approve draft changes without administrative approval if no existing fields were modified
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.6.4.400.200" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml" and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.200"
    And I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Assign to role"
    And I should see the dropdown field labeled "Select Role"
    When I assign "1_FullRights" on dropdown field labeled "Select Role"
    And I click on the button labeled "Assign"
    Then I should see "Test_User1" user assigned "1_FullRights" role

    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio button labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project Status"
    And I should see "Production"

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
    Then I should see "Success! The project is now in Draft Mode"

    When I click on the instrument labeled "Data Types"
    And I click on the Edit image for the field labeled "Radio Button Manual"
    And I enter "102, Choice102" on the fourth row of the input field labeled "Choices (one choice per line)"
    And I click on the button labeled "Save"
    And I click on the button labeled "Submit Changes for Review"
    And I click "Submit" in the dialog box
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.200"
    And I click on the link labeled "Designer"
    Then I should "REVIEW CHANGES?"

    When I click on the button labeled "Project Modification Module"
    And I click on the button labeled "Remove All Drafted Changes"
    And I click on the button labeled "Remove All Drafted Changes " in the dialog box
    Then I should see "Project Changes Rejected/User Notified"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.00"
    And I click on the button labeled "Logging"
    Then I see "Remove production project modifications"

    And I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "Success! The project is now in Draft Mode"

    When I click on the instrument labeled "Data Types"
    And I add a new Text Box field labeled "Text Box 2" with the variable name "textbox_2"
    And I click on the button labeled "Save"
    Then I should see the field labeled "Text Box 2"

    When I click on the button labeled "Submit Changes for Review"
    And I click "Submit" in the dialog box
    Then I should see "Changes Were Made Automatically"
    And I click on the button labeled "Close" in the dialog box
    And I click on the button labeled "Logging"
    Then I see "Approve production project modifications (automatic)"
    And I see "Create project field"


  Scenario: A.6.4.400.300 User’s ability to approve draft changes without administrative approval if no critical issues exist
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "A.6.4.400.300" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml" and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.300"
    And I click on the link labeled "User Rights"
    And I enter "Test_User1" into the input field labeled "Assign to role"
    And I should see the dropdown field labeled "Select Role"
    When I assign "1_FullRights" on dropdown field labeled "Select Role"
    And I click on the button labeled "Assign"
    Then I should see "Test_User1" user assigned "1_FullRights" role

    Given I click on the link labeled "Project Setup"
    And I click on the button labeled "Move project to production"
    And I click on the radio button labeled "Keep ALL data saved so far" in the dialog box
    And I click on the button labeled "YES, Move to Production Status" in the dialog box
    Then I should see "Project Status"
    And I should see "Production"

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
    Then I should see "Success! The project is now in Draft Mode"

    When I click on the button labeled "Submit Changes for Review"
    And I click on the button labeled "Save" in the dialog box
    Then I should see "Changes Were Made Automatically"

    And I click on the button labeled And I click on the button labeled "Enter Draft Mode"
    Then I should see "Success! The project is now in Draft Mode"
    And I click on the button labeled "Close" in the dialog box
    And I click on the button labeled "Logging"
    Then I see "Approve production project modifications (automatic)"

    When I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "Success! The project is now in Draft Mode"

    When I click on the instrument labeled "Data Types"
    And I click on the Edit image for the field labeled "Radio Button Manual"
    And I delete the third option "101, Choice101” on the third row of the input field labeled "Choices (one choice per line)"
    And I edit the second option from "100, Choice100" to "101, Choice100" on the second row of the input field labeled "Choices (one choice per line)"
    And I click on the button labeled "Save"
    And I click on the button labeled "Submit Changes for Review"
    And I click "Submit" in the dialog box
    Then I should see "Awaiting review of project changes"
    And I click on the button labeled "Logging"
    Then I see " Request approval for production project modifications”
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.300"
    And I click on the link labeled "Designer"
    Then I should "REVIEW CHANGES?"

    When I click on the button labeled "Project Modification Module"
    Then I should see "Total potentially critical issues: 1"
    And I click on the button labeled "Remove All Drafted Changes"
    And I click on the button labeled "Remove All Drafted Changes " in the dialog box
    Then I should see "Project Changes Rejected/User Notified"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.300"
    And I click on the button labeled "Logging"
    Then I see "Reject production project modifications"

    And I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "Success! The project is now in Draft Mode"

    When I click on the instrument labeled "Data Types"
    And I click on the Edit image for the field labeled "Radio Button Manual"
    And I delete the third option "101, Choice101” on the third row of the input field labeled "Choices (one choice per line)"
    And I edit the second option from "100, Choice100" to "101, Choice100" on the second row of the input field labeled "Choices (one choice per line)"
    And I click on the button labeled "Save"
    And I click on the button labeled "Submit Changes for Review"
    And I click "Submit" in the dialog box
    Then I should see "Awaiting review of project changes"
    And I click on the button labeled "Logging"
    Then I see "Request approval for production project modifications"
    Given I logout

    Given I login to REDCap with the user "Test_Admin"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.300"
    And I click on the link labeled "Designer"
    Then I should "REVIEW CHANGES?"

    When I click on the button labeled "Project Modification Module"
    Then I should see "Total potentially critical issues: 1"
    And I click on the button labeled "COMMIT CHANGES"
    And I click on the button labeled "COMMIT CHANGES" in the dialog box
    Then I should see "Project Changes Committed/User Notified"
    Given I logout

    Given I login to REDCap with the user "Test_User1"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "A.6.4.400.300"
    And I click on the button labeled "Logging"
    Then I see "Approve production project modifications"

    And I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "Success! The project is now in Draft Mode"

    When I click on the instrument labeled "Data Types"
    And I click on the Edit image for the field labeled "Radio Button Manual"
    Then I should see "101, Choice100"
    And I click on the link labeled "Data Export, Reports, and Stats"
    Then I should see "A All data (records and fields)"
    And I click the button labeled "View Report"
    Then I should see "Choice100 (101)"

    When I click on the link labeled "Designer"
    And I click on the button labeled "Enter Draft Mode"
    Then I should see "Success! The project is now in Draft Mode"

    When I click on the instrument labeled "Data Types"
    And I click on the Edit image for the field labeled "Radio Button Manual"
    And I enter "102, Choice102" on the third row of the input field labeled "Choices (one choice per line)"
    And I click on the button labeled "Save"
    And I click on the button labeled "Submit Changes for Review"
    And I click "Submit" in the dialog box
    Then I should see "Changes Were Made Automatically"
    And I click on the button labeled "Close" in the dialog box
