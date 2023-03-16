import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module Seeds
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example the {string} folder seed {string} has been run
 * @param {string} folder - the folder the seed exists in
 * @param {string} filename - the filename of the seed to run
 * @description Runs a seeds file that is within the test_db folder.
 */
Given("the {string} folder seed {string} has been run", (folder, filename) => {
    cy.mysql_db(folder + '/' + filename)
})