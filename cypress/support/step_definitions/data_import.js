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
    let submit_button_selector = `input[type=submit][value*="${button_label}"]:visible,:button:contains("${button_label}"):visible`
    cy.upload_file(file_location, format, '', button_label, upload_text).then(() => {
        cy.get(submit_button_selector).click()
    })
})

/**
 * @module DataImport
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I create a project named {string} with project purpose <project_purpose> via CDISC XML import from fixture location {string}
 * @param {string} project_name - the desired name for the project
 * @param {string} project_purpose - Practice / Just for fun | Operational Support | Research | Quality Improvement | Other
 * @param {string} cdisc_file - the fixture path to the CDISC XML file (relative path; fixtures are located in /cypress/fixtures/)
 * @description Creates a project from a CDISC XML fixture file given a project name and project purpose.
 */
Given("I create a project named {string} with project purpose {project_type} via CDISC XML import from fixture location {string}", (project_name, project_type, cdisc_file) => {
    cy.create_cdisc_project(project_name, project_type, cdisc_file)
})