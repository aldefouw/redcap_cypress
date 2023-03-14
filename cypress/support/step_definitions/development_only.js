import {Given} from "cypress-cucumber-preprocessor/steps";

/**
 * @module DevelopmentOnly
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I want to pause
 * @description Pauses the Cypress session. NOTE: Should only be used during development of tests.
 */
Given("I want to pause", () => {
    cy.pause()
})

/**
 * @module Visibility
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should NOT see {string}
 * @param {string} selector - the selector that identifies an element
 * @description Visually verifies that element exists and is not visible OR does not exist
 */
Given("I should no longer see the element identified by {string}", (selector) => {
    if(Cypress.$(selector).length)
        cy.get(selector).should('not.be.visible')
    else
        cy.get(selector).should('not.exist')
})