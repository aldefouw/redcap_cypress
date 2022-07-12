import { Given } from "cypress-cucumber-preprocessor/steps";

Given("I upload a data dictionary located at {string} to project ID {int}", (data_dictionary, pid) => {
    cy.upload_data_dictionary(data_dictionary, pid, "DMY")
})

Given("I upload import data from the data import file located at {string} to project ID {int}", (import_file, pid) => {
    cy.import_data_file(import_file, pid)
})