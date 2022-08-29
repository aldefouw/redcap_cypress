import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module DataImport
 * @example I upload a data dictionary located at {string} to project ID {int}
 * @param {string} data_dictionary - the path to the desired data dictionary located within the /fixtures/dictionaries/ folder.
 * @param {int} pid - the Project ID where the data dictionary should be upploaded (e.g. 13)
 * @description Uploads a data dictionary to a specific project given a Project ID.
 */
Given("I upload a data dictionary located at {string} to project ID {int}", (data_dictionary, pid) => {
    cy.upload_data_dictionary(data_dictionary, pid, "DMY")
})

/**
 * @module DataImport
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
 * @example I upload a {string} format file located at {string}, by clicking {string} to select the file, and clicking {string} to upload the file
 * @param {string} format - the format of the file that is being uploaded (e.g. csv)
 * @param {string} file_location - the location of the file being uploaded (e.g. import_files/core/filename.csv)
 * @param {string} upload_selector - the selector of the upload field (e.g. input[name=fname])
 * @param {string} button_selector - the selector of the button to push in order to upload the specified file (e.g. input[name=submit])
 * @description Imports well-formed REDCap data import file (of specific type) to a specific project given a Project ID.
 */
Given("I upload a {string} format file located at {string}, by clicking {string} to select the file, and clicking {string} to upload the file", (format, file_location, upload_selector, button_selector) => {
    cy.upload_file(file_location, format, upload_selector).then(() => {
        cy.wait(1000)
        cy.get(button_selector).click()
    })
})
