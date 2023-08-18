Feature: B.2.6.500 Assign user rights Project Level:  The system shall support adding and removing users from user roles.

  As a REDCap end user
  I want to see that assign user rights is functioning as expected

  Scenario: B.2.6.500.100 Cancel, Assign, Re-assign, & Remove User Roles
    #SETUP
    Given I login to REDCap with the user "Test_Admin"
    And I create a new project named "B.2.6.500.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml" and clicking the "Create Project" button
    When I click on the link labeled "My Projects"
    And I click on the link labeled "B.2.6.500.100"
    And I click on the link labeled "User Rights"
    And I select "Upload users (CSV)" from the dropdown "Upload or download users, roles, and assignments"
    And I choose file "User_list_for_Project_1" and click the "Upload" button
    And I click the button "Upload"
    Then I should see "Test_User1"

    #FUNCTIONAL REQUIREMENT
    ##ACTION: Cancel assign to role
    When I click on the link labeled "Test_User1"
    And I click on the button labeled "Assign to role"
    And I should see the dropdown field labeled "Assign to role" with the option "TestRole" selected
    And I click on the button labeled "Cancel"
    ##VERIFY
    Then I should see "Test_User1" user assigned "-" role

    ##ACTION: Assign to role
    When I click on the link labeled "Test_User1"
    And I click on the button labeled "Assign to role"
    And I should see the dropdown field labeled "Select Role" with the option "TestRole" selected
    And I click on the button labeled "Assign"
    ##VERIFY
    Then I should see "Test_User1" user assigned "TestRole" role

    ##ACTION: Re-assign to role
    When I click on the link labeled "Test_User1"
    And I click on the button labeled "Re-assign to role"
    And I should see the dropdown field labeled "Select Role" with the option "1_FullRights" selected
    And I click on the button labeled "Assign"
    ##VERIFY
    Then I should see "Test_User1" user assigned "1_FullRights" role

    ##ACTION: Remove from role
    When I click on the link labeled "Test_User1"
    And I click on the button labeled "Remove from role"
    ##VERIFY
    Then I should see "Test_User1" user assigned "-" role