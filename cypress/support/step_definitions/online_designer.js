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
