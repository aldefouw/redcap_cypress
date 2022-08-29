import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module VisitURLs
 * @example  I visit the {string} page with parameter string of {string}
 * @param {string} label the label on an anchor tag
 * @description Instruct Cypress to visit a REDCap route with optional parameters.
 */
Given(/^I visit the "(.*)" page(?: with parameter string of "(.*)")?$/, (base_folder, params) => {
    if(params !== undefined){
        cy.visit_version({page: base_folder.split(" ").join("") + "/index.php", params: params})
    } else {
        cy.visit_version({page: base_folder.split(" ").join("") + "/index.php"})
    }
})

/**
 * @module VisitURLs
 * @example I visit Project ID {int}
 * @param {int} pid - the URL of the Project you want to visit.
 * @description Visits the root of the Project ID specified.
 */
Given("I visit Project ID {int}", (pid) => {
    cy.visit_version({page: 'index.php', params: 'pid=' + pid})
})