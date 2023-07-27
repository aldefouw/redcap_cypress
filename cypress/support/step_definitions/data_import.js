import {Given} from "cypress-cucumber-preprocessor/steps";
require('./parameter_types.js')

/**
 * @module DataImport
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I upload the data dictionary located at {string}
 * @param {string} data_dictionary - the path to the desired data dictionary located within the /fixtures/dictionaries/ folder.
 * @description Uploads a data dictionary to a specific project given a Project ID.
 */
Given("I upload the data dictionary located at {string}", (data_dictionary) => {
    cy.upload_data_dictionary(data_dictionary, "DMY")
})

/**
 * @module DataImport
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I upload a {string} format file located at {string}, by clicking the button near {string} to browse for the file, and clicking the button labeled {string} to upload the file
 * @param {string} format - the format of the file that is being uploaded (e.g. csv)
 * @param {string} file_location - the location of the file being uploaded (e.g. import_files/core/filename.csv)
 * @param {string} uplaod_label - text near the upload label
 * @param {string} button_label - text on the button you click to upload
 * @description Imports well-formed REDCap data import file (of specific type) to a specific project given a Project ID.
 */
Given("I upload a {string} format file located at {string}, by clicking the button near {string} to browse for the file, and clicking the button labeled {string} to upload the file", (format, file_location, upload_text, button_label) => {
    cy.upload_file(file_location, format, '', button_label, upload_text)
})

/**
 * @module DataImport
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I upload a file located at {string} to the File Repository
 * @param {string} file_location - the location of the file being uploaded (e.g. import_files/core/filename.csv)
 * @description Imports file (of specific type) to the File Repository.
 */
Given("I upload a file located at {string} to the File Repository", (file_location) => {
    cy.file_repo_upload(file_location).then(() => {
        cy.get(`button:contains("Select files to upload"):visible`).invoke('attr', 'onclick', "").click()
    })
})

/**
 * @module DataImport
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I create a new project named {string} by clicking on "New Project" in the menu bar, selecting "{string}" from the dropdown, choosing file {string}, and clicking the "Create Project" button
 * @param {string} project_name - the desired name for the project
 * @param {string} project_purpose - Practice / Just for fun | Operational Support | Research | Quality Improvement | Other
 * @param {string} cdisc_file - the fixture path to the CDISC XML file (relative path; fixtures are located in /cypress/fixtures/cdisc_files/)
 * @description Creates a project from a CDISC XML fixture file given a project name and project purpose.
 */
Given('I create a new project named {string} by clicking on "New Project" in the menu bar, selecting "{project_type}" from the dropdown, choosing file {string}, and clicking the "{moveToProductionButton}" button', (project_name, project_type, cdisc_file, button_label) => {
    cy.create_cdisc_project(project_name, project_type, cdisc_file, button_label)
})