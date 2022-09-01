import { Given } from "cypress-cucumber-preprocessor/steps";
import { defineParameterType } from "cypress-cucumber-preprocessor/steps";

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the button labeled {string}
 * @param {string} text - the text on the button element you want to click
 * @description Clicks on a button element with a specific text label.
 */
Given("I click on the button labeled {string}", (text) => {
    cy.get('button').contains(text).click()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the link labeled {string}
 * @param {string} text - the text on the anchor element you want to click
 * @description Clicks on an anchor element with a specific text label.
 */
Given("I click on the link labeled {string}", (text) => {
    cy.get('a').contains(text).click()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the input button labeled {string}
 * @param {string} text - the text value of the input element you want to click
 * @description Clicks on an input element with a specific text label.
 */
Given("I click on the input button labeled {string}", (text) => {
    cy.get('input[value="' + text + '"]').click()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I edit the field labeled {string}
 * @param {string} text - the text value of the label associated with a specific field
 * @description Edits a field in the Online Designer by its specified field label.
 */
Given("I edit the field labeled {string}", (text) => {
    cy.edit_field_by_label(text)
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I mark the field required
 * @description Marks a field as required within the Online Designer.
 */
Given("I mark the field required", () => {
    cy.get('input#field_req1').click()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I save the field
 * @description Saves a Field within the Online Designer.
 */
Given("I save the field", () => {
    cy.save_field()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enter {string} into the field labeled {string}
 * @param {string} text - the text to enter into the field
 * @param {string} label - the label of the field
 * @description Enters a specific text string into a field identified by a label.  (NOTE: The field is not automatically cleared.)
 */
Given('I enter {string} into the field labeled {string}', (text, label) => {
    //We locate the label element first.  This isn't always a label which is unfortunate, but this approach seems to work so far.
    cy.contains(label).then(($label) => {
        //We are finding the parent of the label element and then looking for nearest input
        cy.wrap($label).parent().find('input').type(text)
    })
})


Given('I clear the field labeled {string}', (label) => {
    cy.contains(label).then(($label) => {
        cy.wrap($label).parent().find('input').clear()
    })
})


/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the table cell containing a link labeled {string}
 * @param {string} text - the text in the table cell
 * @description Clicks on a table cell that is identified by a particular text string specified.
 */
Given('I click on the table cell containing a link labeled {string}', (text) => {
    cy.get('td').contains(text).parent().find('a').click()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I select {string} from the dropdown identified by {string}
 * @param {string} value - the option to select from the dropdown
 * @param {string} label - the label of the dropdown to choose an option from
 * @description Selects a dropdown by its label and the option via a specific string.
 */
Given('I select {string} from the dropdown identified by {string}', (value,label) => {
    cy.get(label).select(value, { force: true })
})


Given("I click on the element identified by {string}", (sel) => {
    cy.get(sel).click()
})

Given("I click on the checkbox identified by {string}", (sel) => {
    cy.get(sel).click()
})

Given("I enter {string} into the field identified by {string}", (text, sel) => {
    cy.get(sel).clear().type(text)
})


/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example after the next step, I will <accept/cancel> a confirmation window containing the text {string}
 * @param {string} action - valid choices are 'accept' OR 'cancel'
 * @param {string} window_text - text that is expected to appear in the confirmation window
 * @description Pre-emptively tell Cypress what to do about a confirmation window.  NOTE: This step must come BEFORE step that clicks button.
 */

defineParameterType({
    name: 'confirmation',
    regexp: /accept|cancel/
})

Given('after the next step, I will {confirmation} a confirmation window containing the text {string}', (action, window_text) => {
    cy.on('window:confirm', (str) => {
        expect(str).to.contain(window_text)
        action === "accept"
    })
})
