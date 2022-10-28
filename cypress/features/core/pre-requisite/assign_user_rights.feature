Feature: Assign User Rights

  As a REDCap end user
  I want to see that Assign User Rights is functioning as expected

  Scenario: Temporary test
    Given I am a "admin" user who logs into REDCap
    And I visit Project ID 13
    #And I want to assign the "Project Design and Setup" user right to the user named "Test User" with the username of "test_user" on project ID 13
    #And I want to assign an expiration date to user "Test User" with username of "test_user" on project ID 13
    #And I want to verify user rights are available for "standard" user type on the path "UserRights" on project ID 13
    #And I want to remove the expiration date to user "Test User" with username of "test_user" on project ID 13
    #And I want to remove the "Project Design and Setup" user right to the user named "Test User" with the username of "test_user" on project ID 13
    #Not working yet - And I want to verify user rights are unavailable for "standard" user type on the path "UserRights" on project ID 13

  Scenario: Project Setup - 1 
    Given I am an "admin" user who logs into REDCap
    And I create a project named "SecondProject_1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"

  Scenario: Project Setup - 2
    When I click on the element identified by "[id=setupEnableSurveysBtn]"
    And I click on the element identified by "[id=setupLongiBtn]"
    And I click on the element identified by ".ui-dialog-buttonset > :nth-child(2)"
    And I click on the button labeled "Additional customizations"
    Then I should see "You may use the options below to make customizations to the project"
    And I click on the checkbox identified by "[id=data_resolution_enabled_chkbx]"
    And I click on the button labeled "Save"

  Scenario: 1 - Add test_user to SecondProject_1115
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    And I click on the link labeled "User Rights"
    And I enter "test_user" into the field identified by "[id=new_username]"
    And I click on the button labeled "Add with custom rights"
    And I click on the checkbox identified by "[name=reports]"
    And I click on the checkbox identified by "[name=graphical]" 
    And I click on the checkbox identified by "[name=participants]" 
    And I click on the checkbox identified by "[name=calendar]" 
    And I click on the checkbox identified by "[name=file_repository]" 
    #And I click on the input element labeled " No Access" 
    #And I click on the input element labeled " Disabled"
    And I click on the button labeled "Add user"
    Then I should see "was successfully added"
    When I click on the link labeled "My Projects"
    Then I should see "Listed below are the REDCap projects"
    Given I logout
    And I am a "standard" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    Then I should see a link labeled "Project Home"
    And I should see a link labeled "Codebook"
    And I should see a link labeled "Record Status Dashboard"
    And I should see a link labeled "Add / Edit Records"
    And I should see a link labeled "Calendar"
    And I should see a link labeled "Data Exports, Reports, and Stats"
    And I should see a link labeled "Field Comment Log"
    And I should see a link labeled "File Repository"
    Given I logout

  Scenario: 2 - Add expiration data for test_user
    Given I am an "admin" user who logs into REDCap
    And I click on the link labeled "My Projects"
    And I click on the link labeled "SecondProject_1115"
    And I click on the link labeled "User Rights"
    #And after the next step, I will cancel a confirmation window containing the text "Save Changes"
    And I want to assign an expiration date to user "Test User" with username of "test_user" on project ID 14
    And I click on the link labeled "test_user"
    Then I should see "User actions:"
    When I click on the button labeled "Edit user privileges"
    And I enter "10/27/2022" into the field identified by "[name=expiration]"
    And I click on the button labeled "Save Changes"
    Then I should see a link labeled "10/27/2022"
    Given I logout
    And I am a "standard" user who logs into REDCap
    Then I should see "Your access to this particular REDCap project has expired."
    When I click on the link labeled "My Projects"
    Given I logout









