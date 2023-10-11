Feature: Control Center: The system shall provide the ability to enable/disable sharing of files via a public link.    

As a REDCap end user 
 I want to see that file repository is functioning as expected    

Scenario: C.3.26.100.100 Enable/Disable file repository public links via Control Center    
#SETUP
Given I login to REDCap with the user "Test_Admin"
And I create a new project named "A.3.26.100.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
And I click on the link labeled "My Projects"
And I click on the link labeled "A.3.26.100.100"      
And I click the link labeled "Designer"  
And I click the button labeled "Survey Settings" for the instrument "Consent"  
And I click on the button labeled "Auto-Archiver enabled + e-Consent Framework"  
Then I click the button labeled "Save Changes"    

##SETUP_PRODUCTION  
When I click on the link labeled "Project Setup"  
And I click on the button labeled "Move project to production"   
And I click on the radio labeled "Keep ALL data saved so far" in the dialog box
And I click on the button labeled "YES, Move to Production Status" in the dialog box  
Then I see "Project status:  Production"    

##ACTION Upload to top tier file repo (all users will see file) - using the Select files to upload button  
When I click on the link labeled "File Repository"  
When I upload a "csv" format file located at "import_files/testusers_bulk_upload.csv", by clicking the button near "Select files to upload" to browse for the file, and clicking the button labeled "Open" to upload the file    
##VERIFY_FiRe file uploaded in folder  
Then I should see "testusers_bulk_upload.csv"    

#FUNCTIONAL_REQUIREMENT  
##ACTION: Disable File Repository Module  
When I click on the link labeled "Control Center"   
And I click on the link labeled "File Upload Settings "  
Then I should see "Configuration Option for Various Types of Stored Files"    

When I select the dropdown option labeled "Disabled" on the dropdown field labeled "File Repository: Users are able to share files via public links"  
And I click on the button labeled "Save Changes"  

##VERIFY File Repository Module Disabled  
Then I should see "Your system configuration values have now been changed!"    
##VERIFY Project settings share ability in File Repository  
When I click on the link labeled "My Projects"    
And I click on the link labeled "A.3.26.100.100"    
When I click on the link labeled "File Repository."  
And I click on the file share icon for "testusers_bulk_upload.csv"  
Then I should see "Send the file securely using Send-It"  
And I should NOT see "Share a public link to view the file"    

#FUNCTIONAL_REQUIREMENT  
##ACTION: Enable File Repository Module  
When I click on the link labeled "Control Center"   
And I click on the link labeled "File Upload Settings"   
And I select the dropdown option labeled "Enabled" on the dropdown field labeled "File Repository: Users are able to share files via public links"  
And I select the button "Save Changes"  
 ##VERIFY File Repository Module Enabled  
Then I should see "Your system configuration values have now been changed!"    
##VERIFY Project settings shareability in File Repository  
When I click on the link labeled "My Projects"    
And I click on the link labeled "A.3.26.100.100"   
And I click on the link labeled "File Repository."  
And I click on the file share icon for "testusers_bulk_upload.csv"  
Then I should see Send the file securely using Send-It"  
And I should see "Share a public link to view the file"  
And I click on the button labeled "Close" in the dialog box
