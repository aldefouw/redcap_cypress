import {defineParameterType, Given} from "cypress-cucumber-preprocessor/steps";

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
 * @example I upload import data from the data import file located at {string} to project ID {int}
 * @param {string} import_file - the path to the desired data import file located within the /fixtures/import_files/ folder.
 * @param {int} pid - the Project ID where the data dictionary should be upploaded (e.g. 13)
 * @description Imports well-formed REDCap data import file to a specific project given a Project ID.
 */
Given("I upload import data from the data import file located at {string} to project ID {int}", (import_file, pid) => {
    cy.import_data_file(import_file, pid)
})

/**
 * @module DataImport
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I upload a {string} format file located at {string}, by clicking {string} to select the file, and clicking {string} to upload the file
 * @param {string} format - the format of the file that is being uploaded (e.g. csv)
 * @param {string} file_location - the location of the file being uploaded (e.g. import_files/core/filename.csv)
 * @param {string} upload_selector - the selector of the upload field (e.g. input[name=fname])
 * @param {string} button_selector - the selector of the button to push in order to upload the specified file (e.g. input[name=submit])
 * @description Imports well-formed REDCap data import file (of specific type) to a specific project given a Project ID.
 */
Given("I upload a {string} format file located at {string}, by clicking {string} to select the file, and clicking {string} to upload the file", (format, file_location, upload_selector, button_selector) => {
    cy.upload_file(file_location, format, upload_selector).then(() => {
        cy.get(button_selector).click()
    })
})

defineParameterType({
    name: 'project_type',
    regexp: /Practice \/ Just for fun|Operational Support|Research|Quality Improvement|Other/
})

/**
 * @module DataImport
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I create a project named {string} with project purpose <Practice / Just for fun | Operational Support | Research | Quality Improvement | Other> via CDISC XML import from fixture location {string}
 * @param {string} project_name - the desired name for the project
 * @param {string} project_type - the project purpose specified when the project is created
 * @param {string} cdisc_file - the fixture path to the CDISC XML file (relative path; fixtures are located in /cypress/fixtures/)
 * @description Creates a project from a CDISC XML fixture file given a project name and project purpose.
 */
Given("I create a project named {string} with project purpose {project_type} via CDISC XML import from fixture location {string}", (project_name, project_type, cdisc_file) => {
    cy.create_cdisc_project(project_name, project_type, cdisc_file)
})