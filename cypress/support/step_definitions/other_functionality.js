import {Given} from "cypress-cucumber-preprocessor/steps";

/**
 * @module OtherFunctionality
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I move the project back to development mode
 * @description Move project back to development mode
 */

Given("I move the project back to development mode via the Other Functionality page", (text) => {
    cy.get('button').contains('Move back to Development status').click()
})