import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module Visibility
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I should see {string}
 * @param {string} text the text visually seen on screen
 * @description Visually verifies that text exists within the HTML object.
 */
Given("I should see {string}", (text) => {
    cy.get('html').should(($html) => { expect($html).to.contain(text) })
})

/**
 * @module Visibility
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I should NOT see {string}
 * @param {string} text the text visually seen on screen
 * @description Visually verifies that text does NOT exist within the HTML object.
 */
Given("I should NOT see {string}", (text) => {
    cy.get('html').then(($html) => { expect($html).to.not.contain(text) })
})

/**
 * @module Visibility
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I should see {string} in the title
 * @param {string} title the HTML page title
 * @description Visually verifies that text does exist in the HTML page title.
 */
Given("I should see {string} in the title", (title) => {
    cy.title().should('include', title)
})

/**
 * @module Visibility
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I should see a link labeled {string}
 * @param {string} label the label on an anchor tag
 * @description Visually verifies that there is a link with a specific label.
 */
Given("I should see a link labeled {string}", (label) => {
    cy.get('a').contains(label)
})

/**
 * @module Visibility
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the checkbox identified by {string}, {check}
 * @param {string} text the selector that identifies a checkbox
 * @param {string} check - valid choices are 'checked' OR 'unchecked'
 * @description Visually verifies that a specified checkbox is checked or uncheck
 */
 defineParameterType({
    name: 'check',
    regexp: /checked|unchecked/
})
 Given("I should see the checkbox identified by {string}, {check}", (sel, check) => {
    //Really only added this to delay cypress cause sometimes it was moving forward without being checked
    check == 'checked' ? cy.get(sel).should('be.checked') : cy.get(sel).should('not.be.checked')
})