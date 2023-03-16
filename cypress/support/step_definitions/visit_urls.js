import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module VisitUrls
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I visit the version URL {string}
 * @param {string} url the URL without the version folder
 * @description Instructs Cypress to visit specific URL
 */
Given("I visit the version URL {string}", (url) => {
    cy.visit_version({page: url})
})