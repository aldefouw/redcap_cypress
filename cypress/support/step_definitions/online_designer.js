import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I rename the current data instrument named {string} to {string}
 * @param {string} current_name - name of current instrument
 * @param {string} new_name - name to rename the instrument to
 * @description Renames a data collection instrument
 */

Given("I rename the current data instrument named {string} to {string}", (current_name, new_name) => {

    cy.get('table[id=table-forms_surveys]')
        .find('tr').contains(current_name)
        .parents('tr').find('button').contains('Choose action').click()

    cy.get('ul[id=formActionDropdown]').find('a').contains('Rename').click()

    cy.get("input[value='My First Instrument']").clear().type(new_name)

    cy.get("input[value='My First Instrument']").parent().within(() => {
      cy.get('input[type=button]').click()
    })

})

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I delete the data instrument named {string}
 * @param {string} instrument_name - name of current instrument
 * @description Deletes a data collection instrument
 */

Given("I delete the data instrument named {string}", (instrument_name) => {
    cy.intercept({  method: 'GET',
        url: '/redcap_v' + Cypress.env('redcap_version') + '/Design/delete_form.php?*'
    }).as('delete_instrument')

    cy.get('table[id=table-forms_surveys]')
        .find('tr').contains(instrument_name)
        .parents('tr').find('button').contains('Choose action').click()
    cy.get('ul[id=formActionDropdown]').find('a').contains('Delete').click()

    cy.get('button').contains('Yes, delete it').click()

    cy.wait('@delete_instrument')
})
import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module OnlineDesigner
 * @author Corey DeBacker
 * @example I create a new instrument named {string}
 * @param {string} instr_name - the desired name of the new instrument
 * @description From the online designer's instrument list page, creates a new instrument with the given name
 */
Given('I create a new instrument named {string}', (instr_name) => {
    cy.create_instrument(instr_name)
})

/**
 * @module OnlineDesigner
 * @author Corey DeBacker <debacker@wisc.edu>
 * @example I rename the instrument labeled {string} to {string}
 * @param {string} from - the initial name of the instrument
 * @param {string} to - the desired new name of the instrument
 * @description From the online designer's instrument list page, renames the specified instrument
 */
Given('I rename the instrument labeled {string} to {string}', (from, to) => {
    cy.rename_instrument(from, to)
})

/**
 * @module OnlineDesigner
 * @author Corey DeBacker <debacker@wisc.edu>
 * @example I copy the instrument labeled {string} as {string} with variable suffix {string}
 * @param {string} from - the label of the instrument to be copied
 * @param {string} to - the desired label of the newly copied instrument
 * @param {string} suffix - the suffix to be appended to each copied variable's name (required since variable names must be unique)
 * @description Copies an instrument, appending `suffix` to each copied variable's name
 */
Given('I copy the instrument labeled {string} as {string} with variable suffix {string}', (from, to, suffix) => {
    cy.copy_instrument(from, to, suffix)
})

//Not yet implemented (in progress, working out bugs)
Given('I reorder the instrument at position {int} to position {int}', (from, to) => {
    cy.reorder_instrument(from, to)
})

/**
 * @module OnlineDesigner
 * @author Corey DeBacker <debacker@wisc.edu>
 * @example I should see an instrument labeled {string} in row {int} of the instruments table
 * @param {string} label - the label of the instrument to look for
 * @param {int} row_num - the number of the row that the instrument should be in
 * @description With the instruments table visible, asserts that a specific row contains an instrument with the given label
 */
Given('I should see an instrument labeled {string} in row {int} of the instruments table', (label, row_num) => {
    cy.get(`#row_${row_num}`).should('contain.text', label)
})

//Not yet implemented
Given(/^I mark the field as (not )?an identifier/, (not) => {
    let set_identifier = typeof not === 'undefined'
    cy.edit_subfield('is_identifier', set_identifier)
})

//Not yet implemented
Given(/^I mark the field as (not )?required/, (not) => {
    let set_required = typeof not === 'undefined'
    cy.edit_subfield('is_required', set_required)
})

/**
 * @module OnlineDesigner
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I set the {string} subfield to {string}
 * @param {string} subfield the field's metadata to edit -- Valid inputs are Type, Label, Variable Name,
 *  Validation Type, Calculation, and Choices
 * @param {string} value the value to update the subfield to
 * @description Requires the field editing modal window be open (after clicking "Add Field" or edit field button).
 * Sets the value of a specified subfield, without saving and exiting the field editing window.
 */
Given("I set the {string} subfield to {string}", (subfield, value) => {
    cy.edit_subfield(subfield, value)
})

/**
 * @module OnlineDesigner
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I add a new field( at position {int})
 * @param {int} position - (optional) The position to add the field at (e.g. 2 to click the second "Add Field" button)
 * @description Clicks the n'th "Add Field" button where n = `position`.
 *      If `position` is not specified, the last button will be clicked.
 */
Given(/^I add a new field(?: at position (\d*))?/, (position) => {
    if (position === undefined) position = 0 // get last with eq(-1)
    cy.get(':button[value="Add Field"]').eq(position - 1).click();
})