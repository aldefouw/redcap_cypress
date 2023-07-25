import {Given} from "cypress-cucumber-preprocessor/steps";
require('./parameter_types.js')

/**
 * @module RecordHomePage
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click the bubble to < add | select > a record for the {string} longitudinal instrument on event {string}
 * @param {string} instrument - the name of the instrument you want to add a record to
 * @param {string} event - the name of the event you want to add a record to
 * @description Clicks on an instrument / event pairing to add a record on the Record Home Page
 */

Given("I click the bubble to {add_or_select} a record for the {string} longitudinal instrument on event {string}{cell_action}", (verb, instrument, event, cell_action = '') => {
    let repeating = false

    if(cell_action === " and click the repeating instrument bubble for the first instance" ||
        cell_action === " and click the repeating instrument bubble for the second instance" ||
        cell_action === " and click the repeating instrument bubble for the third instance"){
        repeating = true
    }

    cy.table_cell_by_column_and_row_label(event, instrument, 'table#event_grid_table').then(($td) => {
        cy.wrap($td).find('a:visible:first').click()
    }).then(() => {
        cy.intercept({
            method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/index.php?*'
        }).as('instance_table')

        if(repeating){
            cy.wait('@instance_table')

            cy.get('#instancesTablePopup').within(() => {
                let instance = null

                if(cell_action === " and click the repeating instrument bubble for the first instance"){
                    instance = 1
                } else if (cell_action === " and click the repeating instrument bubble for the second instance"){
                    instance = 2
                } else if (cell_action === " and click the repeating instrument bubble for the third instance"){
                    instance = 3
                }

                cy.get('td').contains(instance).parent('tr').within(() => {
                    cy.get('a').click()
                })
            })
        }

    })



})