Feature: Field Validation

  As a REDCap end user
  I want to see that Field Validation is functioning as expected

  Scenario: Project Setup - 1
    Given I am an "admin" user who logs into REDCap
    And I create a project named "FirstProject_1115" with project purpose Practice / Just for fun via CDISC XML import from fixture location "cdisc_files/core/07_DesignForms_v1115.xml"
  
  Scenario: Project Setup - 2
    When I click on the link labeled "Control Center"
    And I click on the link labeled "Field Validation Types"
    And I click on the element identified by "#date_dmy > :nth-child(3) > button"
    And I click on the element identified by "#datetime_mdy > :nth-child(3) > button"
    And I click on the element identified by "#datetime_seconds_ymd > :nth-child(3) > button"
    And I click on the element identified by "#email > :nth-child(3) > button"
    And I click on the element identified by "#integer > :nth-child(3) > button"
  #this one detaches 
    #And I click on the element identified by "#number > :nth-child(3) > button"
  #this is already disabled
    #And I click on the element identified by "#number_1dp_comma_decimal > :nth-child(3) > button"
    And I click on the element identified by "#time > :nth-child(3) > button"
    When I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"
    #When I 
      #All data deleted
    And I should see that surveys are Enable
    When I click on the element identified by "[id=setupLongiBtn]"
    And I click on the button labeled "Disable"
    Then I should see that longitudinal mode is Enable 
    And I should see that repeatable instruments are Enable 
    And I should see that auto-numbering is Disable
    And I should see that the scheduling module is Enable
    And I should see that the randomization module is Enable
    And I should see that the designate an email field for communications setting is Enable


  Scenario: 1 - Login as Admin
    Given I am an "admin" user who logs into REDCap

  Scenario: 2 - Go to My Projects Page
    Given I click on the link labeled "My Projects"
    And I click on the link labeled "FirstProject_1115"