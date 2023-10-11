Feature: User Interface: The system shall allow for the creation of DAGs and the deletion of DAGs if no users or records are assigned to it.

As a REDCap end user
I want to see that Data Access Groups is functioning as expected

Scenario: B.2.10.100.100 Create, Edit & Delete DAGs
#SETUP 
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "B.2.10.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button

When I click on the link labeled "DAGs"
Then I should see "Assign user to a group"
#FUNCTIONAL REQUIREMENT
##ACTION: Create DAG
When I enter "TestGroup3" into the "Enter new group name" input field
And I click on the button labeled "Add Group"
##VERIFY 
Then I should see "TestGroup3"

##ACTION: Edit DAG
When I click on the link labeled "TestGroup3"
And I enter "RenameGroup3" into "Group name" the input field
##VERIFY 
Then I should see "RenameGroup3"

##ACTION: Delete DAG
When I click delete icon for the DAG labeled "RenameGroup3"
And I click on the button labeled "Delete" in the dialog box
##VERIFY 
Then I should see "Data Access Group "TestGroup3" has been deleted!"
And I should NOT see "RenameGroup3"

