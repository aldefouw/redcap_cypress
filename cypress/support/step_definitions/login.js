import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module Login
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I login to REDCap with the user {string}
 * @param {string} user - the user we are logging in as (e.g. 'Test_User1' or 'Test_Admin' as specified in the cypress.env.json file)
 * @description Logs in to REDCap using a seeded user type.
 */
Given("I login to REDCap with the user {string}", (user) => {
    cy.logout()
    cy.set_user_type(user)
    cy.fetch_login()
})

/**
 * @module Login
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I logout
 * @description Logs a given user out of REDCap
 */
Given("I logout", () => {
    cy.logout()
})