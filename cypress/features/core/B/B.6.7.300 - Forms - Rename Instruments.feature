Design forms Using Data Dictionary and Online Designer
Form Creation: The system shall support the ability to rename data collection instruments.

As a REDCap end user
I want to see that Project Designer is functioning as expected

Scenario: B.6.7.300.100 Unique instrument name

##SETUP_DEV
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "B.6.7.300.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

When I click on the link labeled "My Projects"
And I click on the link labeled "B.6.7.300.100”
#FUNCTIONAL_REQUIREMENT
##ACTION: Verify unique instrument variable name
When I click on the link labeled “Codebook”
##VERIFY_CODEBOOK
Then I should see “Instrument:Text Validation(text_validation)”

##ACTION: Rename instrument and instrument variable name
When I click on the button labeled "Online Designer"
And I select "Rename" from the dropdown labeled "Choose action" for the instrument labeled "Text Validation"
And I rename the data instrument to "Text Validation Rename"
And I click on the button labeled "Save"
Then I should see the data instrument labeled "Text Validation Rename"

##VERIFY_CODEBOOK
When I click on the link labeled “Codebook”
Then I should see “Instrument:Text Validation Rename (text_validation_rename)”

#VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table row containing the following values in the logging table:
| test_admin | Manage/Design | Rename data collection instrument |

##SETUP_PRODUCTION
When I click on the button labeled "Project Setup"
And I click on the button labeled "Move project to production"
And I click on the radio button labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project Status: Production"

#FUNCTIONAL REQUIREMENT
When I click on the button labeled "Online Designer"
And I click on the button labeled "Enter Draft Mode"
Then I should see "The project is now in Draft Mode"

##ACTION: Rename instrument and Keep old instrument variable name
When I select "Rename" from the dropdown labeled "Choose action" for the instrument labeled "Text Validation Rename"
And I rename the data instrument to "Text Validation Rename 2"
And I click on the button labeled "Save"
Then I should see the data instrument labeled "Text Validation Rename 2"

When I click on the button labeled "Submit Changes for Review"
And I click on the button labeled "Submit" in the dialog box
Then I should see "Changes Were Made Automatically"
When I click on the button labeled "Close" in the dialog box

##VERIFY_CODEBOOK
When I click on the link labeled “Codebook”
Then I should see “Instrument:Text Validation Rename 2 (text_validation_rename)”

#VERIFY_LOG
When I click on the link labeled "Logging"
Then I should see a table row containing the following values in the logging table:
| test_admin | Manage/Design | Rename data collection instrument |

