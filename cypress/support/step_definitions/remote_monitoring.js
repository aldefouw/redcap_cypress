import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module RequestMonitoring
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example the AJAX {string} request at {string} tagged by {string} is being monitored
 * @param {string} type - the type of request to monitor (e.g. GET, POST, etc.)
 * @param {string} request_url - the URL to monitor (e.g. Design/online_designer_render_fields.php?*)
 * @param {string} tag - the specified name within Cypress we will use to keep track of this request
 * @description Monitors a specific HTTP request happening within REDCap.  Generally used to track a request that we need to WAIT for.
 */
Given("the AJAX {string} request at {string} tagged by {string} is being monitored", (type, request_url, tag) => {
    cy.intercept({
        method: type,
        url: '/redcap_v' + Cypress.env('redcap_version') + "/" + request_url
    }).as(tag)
})

/**
 * @module RequestMonitoring
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example the AJAX request tagged by {string} has completed
 * @param {string} tag - the specified name within Cypress we will use to keep track of this request
 * @description Waits until the tagged request we monitored is finished.
 */
Given("the AJAX request tagged by {string} has completed", (tag) => {
    cy.wait('@' + tag)
})

