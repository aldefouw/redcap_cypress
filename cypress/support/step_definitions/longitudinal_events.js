import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module LongitudinalEvents
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I change the current Event Name of {string} to {string}
 * @param {string} current_name - the name of the event when this step is reached
 * @param {string} proposed_name - the name of the event to change the current event name to
 * @description Changes the name of an event on the "Define My Events" page for a Longitudinal Project
 */
Given("I change the current Event Name of {string} to {string}", (current_name, proposed_name) => {
   cy.change_event_name(current_name, proposed_name)
})

/**
 * @module LongitudinalEvents
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I delete the current Event Name of {string}
 * @param {string} event_name - the name of the event to delete
 * @description Deletes a specific named event on the "Define My Events" page for a Longitudinal Project
 */
Given("I delete the current Event Name of {string}", (event_name) => {
   cy.delete_event_name(event_name)
})
