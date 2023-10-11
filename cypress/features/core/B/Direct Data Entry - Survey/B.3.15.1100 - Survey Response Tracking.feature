Feature: User Interface: Survey Project Settings: The system shall support tracking responders and non-responders to surveys when using the participant list.

As a REDCap end user
I want to see that Survey Feature is functioning as expected

Scenario: B.3.15.1100.100 Tracking survey responders


#SETUP
Given I login to REDCap with the user "Test_User1"
And I create a new project named "B.3.15.1100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button 

#SETUP_PRODUCTION
When I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production" 
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project status: Production"

##VERIFY_SDT
Given I click on the link labeled "Survey Distribution Tools"  
And I click on the button labeled "Participant List"
Then I should see "Participant List"

Given I select "Survey" from the dropdown labeled "Participant List belonging to"
Then I should see a grey bubble for the column labeled "Responded?" for record "1"
And I should see a grey bubble for the column labeled "Responded?" for record "2"

#FUNCTIONAL_REQUIREMENT
##ACTION
When I click the link icon for record "1"
And I click on the button labeled "Survey Options"
And I click on the dropdown option labeled "Open survey"
And I click on the button labeled "Submit"
And I click on the button labeled "Close survey"
And I click on the button labeled "Leave without saving changes" in the dialog box
And I click on the link labeled "Survey Invitation Log"
And I click on the button labeled "Participant List"
And I select "Survey" from the dropdown labeled "Participant List belonging to"
Then I should see a green checkmark for the column labeled "Responded?" for record "1"
