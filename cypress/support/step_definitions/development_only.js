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

/**
 * @module Interactions
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I click on the < element | checkbox > identified by {string}
 * @param {string} element_type - valid choices are 'element' OR 'checkbox'
 * @param {string} selector - the selector of the element to click on
 * @description Clicks on an element identified by specific selector
 */
Given("I click on the {element_type} identified by {string}", (type, selector) => {
    cy.get(selector).click()
})

/**
 * @module Visibility
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the checkbox identified by {string}, {check}
 * @param {string} selector - the selector that identifies a checkbox
 * @param {string} check - valid choices are 'checked' OR 'unchecked'
 * @description Visually verifies that a specified checkbox is checked or uncheck
 */
Given("I should see the checkbox identified by {string}, {check}", (sel, check) => {
    //Really only added this to delay cypress cause sometimes it was moving forward without being checked
    //ATTN: Function no longer needed, can probably delete if no one needs it
    check === 'checked' ? cy.get(sel).should('be.checked') : cy.get(sel).should('not.be.checked')
})

/**
 * @module Interactions
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I select {string} from the dropdown identified by {string} labeled {string}
 * @param {string} value - the option to select from the dropdown
 * @param {string} selector - the selector of the dropdown to choose an option from
 * @param {string} label - the label of the dropdown to choose and option from
 * @description Selects a dropdown by its table row name, label, and the option via a specific string.
 */
Given("I select {string} from the dropdown identified by {string} labeled {string}", (value, selector, label) => {
    // Find the cell that contains the label and find the parent
    cy.get('td').contains(label).parents('tr').within(() => {
        //cy.get(sel).contains(value).parents("select").select(value, { force: true })
        cy.contains(selector, value).then(($label) => {
            cy.wrap($label).select(value, {force: true})
        })
    })
})