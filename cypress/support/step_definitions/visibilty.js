import {Given} from "cypress-cucumber-preprocessor/steps";
require('./parameter_types.js')

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
 * @example I should see the < dropdown | multiselect > field labeled {string} with the option {string} selected
 * @param {string} label - the label of the field
 * @param {string} option - the option selected
 * @description Selects a specific item from a dropdown
 */
Given('I should see the {dropdown_type} field labeled {string} with the option {string} selected', (type, label, option) => {
    let label_selector = `:contains("${label}"):visible`
    let element_selector = `select:has(option:contains("${option}")):visible`
    cy.top_layer(label_selector).within(() => {
        cy.get_labeled_element(element_selector, label).find(':selected').should('have.text', option)
    })
})

/**
 * @module Visibility
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I should see a checkbox labeled {string} that is {check}
 * @param {string} label - the label associated with the checkbox field
 * @param {check} check - state of checkbox (check/unchecked)
 * @description Selects a checkbox field by its label
 */
Given("I should see a checkbox labeled {string} that is {check}", (field_type, label, check) => {
    let label_selector = `:contains("${label}"):visible`
    let element_selector = `input[type=checkbox]:visible`
    cy.top_layer(label_selector).within(() => {
        cy.get_labeled_element(element_selector, label).should(check === "checked" ? "be.checked" : "not.be.checked")
    })
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

/**
 * @module Visibility
 * @author Corey DeBacker <debacker@wisc.edu>
 * @example I should see a < button | link > labeled {string}
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
 * @example I should NOT see a < button | link > labeled {string}
 * @param {string} text - the label of the link that should not be seen on screen (matches partially)
 * @description Verifies that there are no visible elements of the specified type with the label `text`
 */
Given("I should NOT see a {LabeledElement} labeled {string}", (el, text) => {
    // double quotes need to be re-escaped before inserting into :contains() selector
    text = text.replaceAll('\"', '\\\"')
    let subsel = {'link':'a', 'button':'button'}[el]
    let sel = `${subsel}:contains("${text}"):visible` + (el === 'button' ? `,button[value="${text}"]:visible` : '')
    cy.get_top_layer(($e) => {console.log(sel);expect($e.find(sel)).to.have.lengthOf(0)})
})

/**
 * @module Visibility
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I should see {string} in the data entry form field labeled {string}
 * @param {string} text - the text that should be in the field
 * @param {string} label - the label of the field
 * @description Identifies specific text string in a field identified by a label.
 */
Given('I should see {string} in the data entry form field labeled {string}', (text, label) => {
    cy.contains('label', label)
        .invoke('attr', 'id')
        .then(($id) => {
            cy.get('[name="' + $id.split('label-')[1] + '"]').should('have.value', text)
        })
})