Feature: Assign User Rights

  As a REDCap end user
  I want to see that Assign User Rights is functioning as expected

  Scenario: Temporary test
    Given I am a "admin" user who logs into REDCap
    And I visit Project ID 13
    And I want to assign the "Project Design and Setup" user right to the user named "Test User" with the username of "test_user" on project ID 13
    And I want to assign an expiration date to user "Test User" with username of "test_user" on project ID 13
    And I want to verify user rights are available for "standard" user type on the path "UserRights" on project ID 13
    And I want to remove the expiration date to user "Test User" with username of "test_user" on project ID 13
    And I want to remove the "Project Design and Setup" user right to the user named "Test User" with the username of "test_user" on project ID 13
    #Not working yet - And I want to verify user rights are unavailable for "standard" user type on the path "UserRights" on project ID 13