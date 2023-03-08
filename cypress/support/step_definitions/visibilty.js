import {defineParameterType, Given} from "cypress-cucumber-preprocessor/steps";

defineParameterType({
    name: 'see',
    regexp: /should see|see/
})

/**
 * @module Visibility
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I (should) see {string}
 * @param {string} text the text visually seen on screen
 * @description Visually verifies that text exists within the HTML object. NOTE: "should" is optional for readability.
 */
Given("I {see} {string}", (see, text) => {
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
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should NOT see {string}
 * @param {string} selector - the selector that identifies an element
 * @description Visually verifies that element exists and is visible
 */
Given("I should see the element identified by {string}", (selector) => {
    cy.get(selector).should('exist').and('be.visible')
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
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see a button labeled {string}
 * @param {string} label the label on a button
 * @description Visually verifies that there is a button with a specific label.
 */
Given("I should see a button labeled {string}", (label) => {
    cy.get('button').contains(label)
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
 * @example I should see a new dialog box named {string}
 * @param {string} text the id of the new dialog box
 * @description Visually verifies that there is a new dialog box with the id text
 */
Given("I should see a new dialog box named {string}", (text) => {
    // Need to make this more specific for dialog boxes dialog, simpleDialog, etc
    cy.get('div[id="' + text + '"]', { timeout: 10000 }).should('be.visible')
})

/**
 * @module Visibility
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the checkbox identified by {string}, {check}
 * @param {string} selector - the selector that identifies a checkbox
 * @param {string} check - valid choices are 'checked' OR 'unchecked'
 * @description Visually verifies that a specified checkbox is checked or uncheck
 */
defineParameterType({
    name: 'check',
    regexp: /checked|unchecked/
})
 Given("I should see the checkbox identified by {string}, {check}", (sel, check) => {
    //Really only added this to delay cypress cause sometimes it was moving forward without being checked
    //ATTN: Function no longer needed, can probably delete if no one needs it
    check == 'checked' ? cy.get(sel).should('be.checked') : cy.get(sel).should('not.be.checked')
})

/**
 * @module Visibility
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the input field identified by {string} with the value {string}
 * @param {string} selector the selector that identifies an input field
 * @param {string} text the text that the input field should be set to
 * @description Visually verifies that a specified input field is set to text
 */

Given("I should see the input field identified by {string} with the value {string}", (selector, text) => {
    text = text.replaceAll('\\n', '\n')
    cy.get(selector).should("have.value", text)
})

/**
 * @module Visibility
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the dropdown identified by {string} with the options below
 * @param {string} selector the selector that identifies a dropbox
 * @param {DataTable} options the Data Table of selectable options
 * @description Visibility - Visually verifies that the element selector has the options listed
 */
Given("I should see the dropdown identified by {string} with the options below", (selector, options) => {
    for(let i = 0; i < options.rawTable[0].length; i++){
        cy.get(selector).should('contain', options.rawTable[0][i])
    }
})

/**
 * @module Visibility
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the dropdown identified by {string} with the option {string} selected
 * @param {string} selector the selector that identifies a checkbox
 * @param {string} option the option that should be selected
 * @description Visually verifies that a specified dropdown has the option selected
 */
Given("I should see the dropdown identified by {string} with the option {string} selected", (selector, option) => {
    //cy.get(selector).invoke('val').should('eq', option)
    cy.get(selector).find(':selected').should('have.text', option)
})

/**
 * @module Visibility
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see {string} in an alert box
 * @param {string} text - the text that should be displayed in an alert box
 * @description Visually verifies that the alert box contains text
 */
Given("I should see {string} in an alert box", (text) => {

    cy.on('window:alert',(txt)=>{
        //Mocha assertions
        expect(txt).to.contains(text);
    })
    cy.on('window:confirm', () => true)

})

defineParameterType({
    name: 'select',
    regexp: /selected|unselected/
})

/**
 * @module Visibility
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I should see the radio labeled {string} <checked|unchecked>
 * @param {string} label - the text that should be displayed in an alert box
 * @param {string} text - the text that should be displayed in an alert box
 * @description Visually verifies that the alert box contains text
 */
Given("I should see the radio labeled {string} with option {string} {select}", (label, option, selected) => {
    cy.select_radio_by_label(label, option, false, selected === 'selected')
})

/**
 * @module Visibility
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I should see a dialog containing the following text: {string}
 * @param {string} text - the text that should be displayed in a dialog box
 * @description Visually verifies that the dialog box contains text
 */
Given("I should see a dialog containing the following text: {string}", (text) => {
    cy.verify_text_on_dialog(text)
})

defineParameterType({
    name: 'LabeledElement',
    regexp: /button|link/
})

/**
 * @module Visibility
 * @author Corey DeBacker <debacker@wisc.edu>
 * @example I should see a {LabeledElement} labeled {string}
 * @param {LabeledElement} el - type of element, in {link, button}
 * @param {string} text - the label of the link that should be seen on screen (matches partially)
 * @description Verifies that a visible element of the specified type containing `text` exists
 */
Given("I should see a {LabeledElement} labeled {string}", (el, text) => {
    // double quotes need to be re-escaped before inserting into :contains() selector
    text = text.replaceAll('\"', '\\\"')
    let subsel = {'link':'a', 'button':'button'}[el]
    let sel = `${subsel}:contains("${text}"):visible` + (el === 'button' ? `,button[value="${text}"]` : '')
    cy.get_top_layer(($e) => {expect($e.find(sel).length).to.be.above(0)})
})

/**
 * @module Visibility
 * @author Corey DeBacker <debacker@wisc.edu>
 * @example I should NOT see a {LabeledElement} labeled {string}
 * @param {LabeledElement} el - type of element, in {link, button}
 * @param {string} text - the label of the link that should not be seen on screen (matches partially)
 * @description Verifies that there are no visible elements of the specified type with the label `text`
 */
Given("I should NOT see a {LabeledElement} labeled {string}", (el, text) => {
    // double quotes need to be re-escaped before inserting into :contains() selector
    text = text.replaceAll('\"', '\\\"')
    let subsel = {'link':'a', 'button':'button'}[el]
    let sel = `${subsel}:contains("${text}"):visible` + (el == 'button' ? `,button[value="${text}"]:visible` : '')
    cy.get_top_layer(($e) => {console.log(sel);expect($e.find(sel)).to.have.lengthOf(0)})
})