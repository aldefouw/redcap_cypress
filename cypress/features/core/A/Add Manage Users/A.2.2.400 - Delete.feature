Feature: A.2.2.400 Add/Manage users

  As a REDCap end user
  I want to see that Delete Users is functioning as expected.

  Scenario: A.2.2.400.100 Delete User Function
    Given I login to REDCap with the user "Test_Admin"
    And I click on the link labeled "Control Center"
    And I click on the link labeled "Add Users (Table-based Only)"
    Then I should see "Create single user"

    #SETUP_USER
    When I enter "Delete_User" into the input field labeled "Username:"
    And I enter "User_firstname" into the input field labeled "First name:"
    And I enter "User_lastname" into the input field labeled "Last name:"
    And I enter "Delete_User@test.edu" into the input field labeled "Primary email:"
    And I click on the button labeled "Save"
    Then I should see "User has been successfully saved."

    When I click on the link labeled "Browse Users"
    Then I should see "User Search: Search for user by username, first name, last name, or primary email"

    When I enter "Delete_User" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    Then I should see "Editable user attributes"
    And I should see "Delete_User"

    #FUNCTIONAL REQUIREMENT
    ##ACTION Cancel delete user
    Given I click on the button labeled "Delete user from system" and cancel the confirmation window
    Then I should NOT see "The user 'Delete_User' has now been removed and deleted from all REDCap projects"

    When I click on the link labeled "Browse Users"
    Then I should see "User Search: Search for user by username, first name, last name, or primary email"

    #VERIFY User exists
    When I enter "Delete_User" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    Then I should see "Editable user attributes"
    And I should see "Delete_User"

    #FUNCTIONAL REQUIREMENT
    ##ACTION Delete user
    When I click on the button labeled "Delete user from system" and accept the confirmation window
    Then I should see "The user 'Delete_User' has now been removed and deleted from all REDCap projects"
    And I click on the button labeled "Close"

    #VERIFY User does not exist
    When I click on the link labeled "Browse Users"
    Then I should see "User Search: Search for user by username, first name, last name, or primary email"

    When I enter "Delete_User" into the input field labeled "User Search: Search for user by username, first name, last name, or primary email"
    And I click on the button labeled "Search"
    Then I should see "User does not exist!"