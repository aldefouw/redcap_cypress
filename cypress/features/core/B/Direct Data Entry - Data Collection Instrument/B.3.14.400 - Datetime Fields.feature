Feature: Creating a Record and Entering Data: The system shall support the ability to use the following on date/time fields: (Date picker widget | Now button | Today button)

As a REDCap end user
I want to see that date/time widget is functioning as expected

Scenario: B.3.14.400.100 Data entry for Date/time validated fields 

#SETUP
Given I login to REDCap with the user "Test_User1"
And I create a new project named "B.3.14.400.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_3.14.xml", and clicking the "Create Project" button 

#SETUP_PRODUCTION
When I click on the link labeled "Project Setup"
And I click on the button labeled "Move project to production" 
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box
Then I should see "Project status: Production"

Given I click the link labeled "Add/Edit Records"
And I click on the button labeled "Add new record for the arm selected above"
And I click the bubble for the "Data Types" longitudinal instrument for event "Event 1"
Then I should see "Adding new Record ID 7."

#FUNCTIONAL REQUIREMENT
##ACTION: Date/time widget icon
When I click on the date picker widget icon for the field labeled "datetime YMD HMSS"
And I select the date "08/01/2023 00:00:00" in the pop up calendar
##VERIFY 
Then I should see the date "2023-08-01 00:00:00" in the field labeled "datetime YMD HMSS"

##ACTION: Now button
When I click on the button labeled "Now" for the field labeled "time HH:MM:SS"
##VERIFY 
Then I should see the exact time in the field labeled "time HH:MM:SS"

##ACTION: Today button
When I click on the button labeled "Today" for the field labeled "date YMD"
##VERIFY 
Then I should see today's date in the field labeled "date YMD"


