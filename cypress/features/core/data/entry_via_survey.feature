Feature: Data Entry through the Survey

  As a REDCap end user
  I want to see that Data Entry through the Survey is functioning as expected

  Scenario: Step 1 - Create the Project
    Given I am an "admin" user who logs into REDCap

    And I create a project named "Entry Via Survey Feature" with project purpose Operational Support via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"

    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Entry Via Survey Feature"
    And I click on the link labeled "Project Setup"

    And I enable surveys for the project
    And I enable longitudinal mode
    And I should see that longitudinal mode is "enabled"

    Then I should see "Survey Distribution Tools"
    And I should see a button labeled "Designate Instruments for My Events"

    Then I click on the button labeled "Designate Instruments for My Events"

    #Arm 1
    Then I should see "Arm name: "
    Given I verify the Data Collection Instrument named "Text Validation" is enabled for the Event named "Event 1"


    And I click on the link labeled "User Rights"
    And I assign the "Project Design and Setup" user right to the user named "Test User" with the username of "test_user"

  Scenario: An external user visits a public survey
    And I am a "standard" user who logs into REDCap
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "Entry Via Survey Feature"

    And I click on the button labeled "Online Designer"
    And I enable surveys for the data instrument named "Text Validation"
    Then I should see "Data Collection Instruments"

#  Scenario: A standard user enters data into a public survey
#    Given I visit the public survey URL for the current project
#    Then I should see "Text Validation" in the title
#    And I enter "user1@yahoo.com" into the "Email" survey text input field
#    When I click on the button labeled "Submit"
#    Then I should see "Thank you for taking the survey"
#
#  Scenario: A standard user disables survey functionality
#    Given I click on the link labeled "My Projects"
#
#    When I visit the "Data Entry" page with parameter string of "pid=9&id=1&page=prescreening_survey"
#    Then I should see that the "E-mail address" field contains the value of "user1@yahoo.com"
#
#  Scenario: A standard user distributes a survey to a list of users
#    Given I click on the link labeled "My Projects"
#    And I enable surveys for Project ID 9
#
#    When I visit the "Surveys/invite_participants.php" page with parameter string of "pid=9"
#    And I click on the link labeled "Participant List"
#    Then I should see "Email"
#
#  Scenario: A standard user generates a survey from within a participant record using Log Out + Open Survey
#    Given I click on the link labeled "My Projects"
#    And I click on the link labeled "Add / Edit Records"
#    And I click on the button labeled "Add new record"
#    And I click on the table cell containing a link labeled "Pre-Screening Survey"
#    And I click on the button labeled "Save & Exit Form"
#    And I click on the table cell containing a link labeled "Pre-Screening Survey"
#    And I click on the button labeled "Survey options"
#
#    When I click on the survey option label containing "Log out" label and want to track the response with a tag of "logout_open_survey"
#    Then I should see the survey open exactly once by watching the tag of "logout_open_survey"
#
#  Scenario: A standard user is prompted to leave the survey to avoid overwriting survey responses when opening surveys from data entry form
#    Given I click on the link labeled "My Projects"
#    And I click on the link labeled "Add / Edit Records"
#    And I click on the button labeled "Add new record"
#    And I click on the table cell containing a link labeled "Pre-Screening Survey"
#    And I click on the button labeled "Save & Exit Form"
#    And I click on the table cell containing a link labeled "Pre-Screening Survey"
#    And I click on the button labeled "Survey options"
#
#    When I click on the survey option label containing "Open survey" label
#    Then I should see "Leave without saving changes"
#    And I should see "Stay on page"
#
#  Scenario: A participant can enter data in a data collection instrument enabled and distributed as a survey
#    Given I click on the link labeled "My Projects"
#    And I click on the link labeled "Project Setup"
#    And I click on the button labeled "Online Designer"
#    Then I should see "Draft Mode"
#
#    When I click on the button labeled "Enter Draft Mode"
#    Then I should see "The project is now in Draft Mode"
#
#    And I click on the link labeled "Pre-Screening Survey"
#    And I edit the field labeled "Date of birth"
#
#    Given the AJAX "GET" request at "Design/online_designer_render_fields.php?*" tagged by "save_field" is being monitored
#    And I mark the field required
#    And I save the field
#    And the AJAX request tagged by "save_field" has completed
#
#    And I click on the button labeled "Submit Changes for Review"
#    And I should see "SUBMIT CHANGES FOR REVIEW"
#    And I click on the button labeled "Submit"
#    Then I should see "Changes Were Made Automatically"
#
#    And I click on the button labeled "Close"

#    When I click on the link labeled "Record Status Dashboard"
#    And I click on the bubble for the "Pre-Screening Survey" data collection instrument for record ID "1"
#
#
