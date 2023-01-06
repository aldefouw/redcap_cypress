import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module LongitudinalEvents
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I change the current Event Name from {string} to {string}
 * @param {string} current_name - the name of the event when this step is reached
 * @param {string} proposed_name - the name of the event to change the current event name to
 * @description Changes the name of an event on the "Define My Events" page for a Longitudinal Project
 */
Given("I change the current Event Name from {string} to {string}", (current_name, proposed_name) => {
   cy.change_event_name(current_name, proposed_name)
})

/**
 * @module LongitudinalEvents
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I delete the Event Name of {string}
 * @param {string} event_name - the name of the event to delete
 * @description Deletes a specific named event on the "Define My Events" page for a Longitudinal Project
 */
Given("I delete the Event Name of {string}", (event_name) => {
   cy.delete_event_name(event_name)
})

/**
 * @module LongitudinalEvents
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enable the Data Collection Instrument named {string} for the Event named {string}
 * @param {string} instrument_name - the name of the Data Collection Instrument we are enabling for a specific event
 * @param {string} event_name - the name of the event to enable the Data Collection Instrument for
 * @description Enables a Data Collection Instrument for a specific Event within a Longitudinal Project.  (Assumption: User is on "Designate Instruments for My Events" page.)
 */
Given("I enable the Data Collection Instrument named {string} for the Event named {string}", (instrument_name, event_name) => {
   cy.adjust_or_verify_instrument_event(instrument_name, event_name)
})

/**
 * @module LongitudinalEvents
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I disable the Data Collection Instrument named {string} for the Event named {string}
 * @param {string} instrument_name - the name of the Data Collection Instrument we are disabling for a specific event
 * @param {string} event_name - the name of the event to disable the Data Collection Instrument for
 * @description Disables a Data Collection Instrument for a specific Event within a Longitudinal Project. (Assumption: User is on "Designate Instruments for My Events" page.)
 */
Given("I disable the Data Collection Instrument named {string} for the Event named {string}", (instrument_name, event_name) => {
   cy.adjust_or_verify_instrument_event(instrument_name, event_name, true)
})

/**
 * @module LongitudinalEvents
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I verify the Data Collection Instrument named {string} is enabled for the Event named {string}
 * @param {string} instrument_name - the name of the Data Collection Instrument we are disabling for a specific event
 * @param {string} event_name - the name of the event to disable the Data Collection Instrument for
 * @description Verifies a Data Collection Instrument is enabled for a specific Event within a Longitudinal Project. (Assumption: User is on "Designate Instruments for My Events" page.)
 */
Given("I verify the Data Collection Instrument named {string} is enabled for the Event named {string}", (instrument_name, event_name) => {
   cy.adjust_or_verify_instrument_event(instrument_name, event_name, true, false)
})

/**
 * @module LongitudinalEvents
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I verify the Data Collection Instrument named {string} is disabled for the Event named {string}
 * @param {string} instrument_name - the name of the Data Collection Instrument we are disabling for a specific event
 * @param {string} event_name - the name of the event to disable the Data Collection Instrument for
 * @description Verifies a Data Collection Instrument is disabled for a specific Event within a Longitudinal Project. (Assumption: User is on "Designate Instruments for My Events" page.)
 */
Given("I verify the Data Collection Instrument named {string} is disabled for the Event named {string}", (instrument_name, event_name) => {
   cy.adjust_or_verify_instrument_event(instrument_name, event_name, false, false)
})
