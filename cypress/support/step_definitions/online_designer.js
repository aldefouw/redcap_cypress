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
    cy.rename_instrument(current_name, new_name)
})

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I delete the data instrument named {string}
 * @param {string} instrument_name - name of current instrument
 * @description Deletes a data collection instrument
 */

Given("I delete the data instrument named {string}", (instrument_name) => {
    cy.delete_instrument(instrument_name)
})


/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enable surveys for the data instrument named {string}
 * @param {string} instrument_name - name of current instrument
 * @description Enables a data collection instrument as a survey
 */

Given("I enable surveys for the data instrument named {string}", (instrument_name) => {
    cy.enable_surveys(instrument_name)
})
