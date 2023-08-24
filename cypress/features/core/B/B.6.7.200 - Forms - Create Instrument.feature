Feature: Design forms Using Data Dictionary and Online Designer
  Form Creation: The system shall support the creation of new data collection instruments via the Online Designer.

  As a REDCap end user
  I want to see that Online Designer is functioning as expected

  Scenario: B.6.7.200.100 Create form with Online Designer

  #SETUP
  Given I login to REDCap with the user "Test_Admin"
  And I create a new project named "B.6.7.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
  When I click on the link labeled "My Projects"
  And I click on the link labeled "B.6.7.200.100"
  And I click on the link labeled "Project Setup"
  And I click on the button labeled "Online Designer"
  Then I should see "Data Collection Instruments"

  #FUNCTIONAL_REQUIREMENT
  ##ACTION: Create new form
  #Oddly, we need the space before this button because otherwise we match on "Create snapshot of instruments"
  When I click on the button labeled exactly " Create"
  And I click on the last button labeled "Add instrument here"
  Then I should see "New instrument name:"
  When I enter "New Form" into the input field labeled "New instrument name:" within the data collection instrument list
  And I click on the last button labeled "Create"
  Then I should see "SUCCESS!"

  Given I click on the button labeled "Close" in the dialog box

  #VERIFY
  Then I should see a table header and rows containing the following values in a table:
    | Instrument name | Fields |
    | Text Validation | 3      |
    | Data Types      | 21     |
    | Survey          | 2      |
    | Consent         | 4      |
    | New Form        | 0      |

  #VERIFY_LOG
  When I click on the link labeled "Logging"
  Then I should see a table header and rows containing the following values in the logging table:
    | Time / Date      | Username   | Action        | List of Data ChangesOR Fields Exported    |
    | mm/dd/yyyy hh:mm | test_admin | Manage/Design | Create data collection instrument         |