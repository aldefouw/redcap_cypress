import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module Login
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I am a(n) <standard/admin> user who logs into REDCap
 * @param {string} user_type - the type of user we are (e.g. 'standard' or 'admin' as specified in the cypress.env.json file)
 * @description Logs in to REDCap using a seeded user type.  Built-in options are 'admin', 'standard', and 'standard2'.
 */
Given("I am a(n) {string} user who logs into REDCap", (user_type) => {
    cy.set_user_type(user_type)
})

/**
 * @module Login
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I logout of REDCap
 * @description Logs any currently logged in user out of REDCap.
 */
Given("I logout of REDCap", () => {
    cy.logout()
})