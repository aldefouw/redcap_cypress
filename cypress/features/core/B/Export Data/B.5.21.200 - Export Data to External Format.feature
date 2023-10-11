Feature: User Interface: The system shall allow data to be exported in the following formats: CSV, SPSS, SAS, R, STATA, and CDISC ODM (XML).

As a REDCap end user
I want to see that export data is functioning as expected

#Scenario: B.5.21.200.100 Export data format
#
##SETUP
#Given I login to REDCap with the user "Test_Admin"
#And I create a new project named "B.5.21.200.100" by clicking on "New Project" in the menu bar, selecting "Practice / Just for fun" from the dropdown, choosing file "Project_1.xml", and clicking the "Create Project" button
#
##FUNCTIONAL_REQUIREMENT
###ACTION: export CSV raw
#When I click on the link labeled "Data Exports, Reports, and Stats"
#Then I should see a table row containing the following values in the reports table:
#| A | All data (all records and fields) |
#
#Given I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
#And I click on the radio labeled "CSV / Microsoft Excel (raw data)" in the dialog box
#And I click on the button labeled "Export Data" in the dialog box
#Then I should see a dialog containing the following text: "Data export was successful!"
#
#Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (raw data)" format in the dialog box
#Then I should have a csv file with the extension .csv within the downloads folder
##Manual Close file
#
#And I click on the button labeled "Close" in the dialog box
#
##FUNCTIONAL_REQUIREMENT
###ACTION: export CSV (labels)
#Given I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
#And I click on the radio labeled "CSV / Microsoft Excel (labels)" in the dialog box
#And I click on the button labeled "Export Data" in the dialog box
#Then I should see a dialog containing the following text: "Data export was successful!"
#
#Given I click on the download icons to receive the files for the "CSV / Microsoft Excel (labels)" format in the dialog box
#Then I should have a csv file with the extension .csv within the downloads folder
##Manual Close file
#
#And I click on the button labeled "Close" in the dialog box
#
##FUNCTIONAL_REQUIREMENT
###ACTION: export SPSS
#Given I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
#And I click on the radio labeled "SPSS Statistical Software" in the dialog box
#And I click on the button labeled "Export Data" in the dialog box
#Then I should see a dialog containing the following text: "Data export was successful!"
#
#Given I click on the download icons to receive the files for the "SPSS Statistical Software" format in the dialog box
#Then I should have a sps file with the extension .sps within the downloads folder
##Manual Close file
#
#And I click on the button labeled "Close" in the dialog box
#
##FUNCTIONAL_REQUIREMENT
###ACTION: export SAS
#Given I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
#And I click on the radio labeled "SAS Statistical Software" in the dialog box
#And I click on the button labeled "Export Data" in the dialog box
#Then I should see a dialog containing the following text: "Data export was successful!"
#
#Given I click on the download icons to receive the files for the "SAS Statistical Software" format in the dialog box
#Then I should have a sas file with the extension .sas within the downloads folder
##Manual Close file
#
#And I click on the button labeled "Close" in the dialog box
#
##FUNCTIONAL_REQUIREMENT
###ACTION: export R
#Given I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
#And I click on the radio labeled "R Statistical Software" in the dialog box
#And I click on the button labeled "Export Data" in the dialog box
#Then I should see a dialog containing the following text: "Data export was successful!"
#
#Given I click on the download icons to receive the files for the "R Statistical Software" format in the dialog box
#Then I should have an r file with the extension .r within the downloads folder
##Manual Close file
#
#And I click on the button labeled "Close" in the dialog box
#
##FUNCTIONAL_REQUIREMENT
###ACTION: export STATA
#Given I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
#And I click on the radio labeled "Stata Statistical Software" in the dialog box
#And I click on the button labeled "Export Data" in the dialog box
#Then I should see a dialog containing the following text: "Data export was successful!"
#
#Given I click on the download icons to receive the files for the "Stata Statistical Software" format in the dialog box
#Then I should have a STATA file with the extension .do within the downloads folder
##Manual Close file
#
#And I click on the button labeled "Close" in the dialog box
#
##FUNCTIONAL_REQUIREMENT
###ACTION: export XML
#Given I click on the "Export Data" button for "All data (all records and fields)" report in the My Reports & Exports table
#And I click on the radio labeled "CDISC ODM (XML)" in the dialog box
#And I click on the button labeled "Export Data" in the dialog box
#Then I should see a dialog containing the following text: "Data export was successful!"
#
#Given I click on the download icons to receive the files for the "CDISC ODM" format in the dialog box
#Then I should have a CDISX ODM file with the extension .xml within the downloads folder
##Manual Close file
#
#And I click on the button labeled "Close" in the dialog box

