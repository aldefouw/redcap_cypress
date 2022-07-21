import { Given } from "cypress-cucumber-preprocessor/steps";

Given("I upload a data dictionary located at {string} to project ID {int}", (data_dictionary, pid) => {
    cy.upload_data_dictionary(data_dictionary, pid, "DMY")
})

Given("I upload import data from the data import file located at {string} to project ID {int}", (import_file, pid) => {
    cy.import_data_file(import_file, pid)
})

Given("I upload a {string} format file located at {string}, by clicking {string} to select the file, and clicking {string} to upload the file", (format, file_location, upload_selector, button_selector) => {
    cy.upload_file(file_location, format, upload_selector).then(() => {
        cy.wait(1000)
        cy.get(button_selector).click()
    })
})
