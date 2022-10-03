import { Given } from "cypress-cucumber-preprocessor/steps";
import { defineParameterType } from "cypress-cucumber-preprocessor/steps";

/**
 * @module Interactions
 * @example I click on the button labeled {string}
 * @param {string} text - the text on the button element you want to click
 * @description Click on a button element with a specific text label.
 */
Given("I click on the button labeled {string}", (text) => {
    cy.get(`:button:contains(${text}),:button[value="${text}"]`).click()
})

/**
 * @module Interactions
 * @example I click on the link labeled {string}
 * @param {string} text - the text on the anchor element you want to click
 * @description Click on an anchor element with a specific text label.
 */
Given("I click on the link labeled {string}", (text) => {
    cy.get(`a:contains("${text}")`).filter(':visible').first().click()
})

/**
 * @module Interactions
 * @example I click on the input button labeled {string}
 * @param {string} text - the text value of the input element you want to click
 * @description Click on an input element with a specific text label.
 */
Given("I click on the input button labeled {string}", (text) => {
    cy.get('input[value="' + text + '"]').click()
})

/**
 * @module Interactions
 * @example I edit the field labeled {string}
 * @param {string} text - the text value of the label associated with a specific field
 * @description Edit a field in the Online Designer by its specified field label.
 */
Given("I edit the field labeled {string}", (text) => {
    cy.edit_field_by_label(text)
})

/**
 * @module Interactions
 * @example I mark the field required
 * @description Mark a field as required within the Online Designer.
 */
Given("I mark the field required", () => {
    cy.get('input#field_req1').click()
})

/**
 * @module Interactions
 * @example I save the field
 * @description Save a Field within the Online Designer.
 */
Given("I save the field", () => {
    cy.save_field()
})

/**
 * @module Interactions
 * @example I enter {string} into the field labeled {string}
 * @param {string} text - the text to enter into the field
 * @param {string} label - the label of the field
 * @description Enter a specific text string into a field identified by a label.  (NOTE: The field is not automatically cleared.)
 */
Given('I enter {string} into the field labeled {string}', (text, label) => {
    //We locate the label element first.  This isn't always a label which is unfortunate, but this approach seems to work so far.
    cy.contains(label).then(($label) => {
        //We are finding the parent of the label element and then looking for nearest input
        cy.wrap($label).parent().find('input').type(text)
    })
})

/**
 * @module Interactions
 * @example I click on the table cell containing a link labeled {string}
 * @param {string} text - the text in the table cell
 * @description Click on a table cell that is identified by a particular text string specified.
 */
Given('I click on the table cell containing a link labeled {string}', (text) => {
    cy.get('td').contains(text).parent().find('a').click()
})

/**
 * @module Interactions
 * @example I select {string} from the dropdown identified by {string}
 * @param {string} value - the option to select from the dropdown
 * @param {string} label - the label of the dropdown to choose an option from
 * @description Select a dropdown by its label and the option via a specific string.
 */
Given('I select {string} from the dropdown labeled {string}', (value,label) => {
    cy.get(label).select(value, { force: true })
})

/**
 * @module Interactions
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