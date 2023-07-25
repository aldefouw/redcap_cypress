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

Given("I click the bubble to {add_or_select} a record for the {string} longitudinal instrument on event {string}{cell_action}", (verb, instrument, event, cell_action) => {
    cy.table_cell_by_column_and_row_label(event, instrument, 'table#event_grid_table').then(($td) => {
        cy.wrap($td).find('a:visible:first').click()
    })
})