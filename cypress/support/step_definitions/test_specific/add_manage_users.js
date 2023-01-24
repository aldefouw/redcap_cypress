import {Given} from "cypress-cucumber-preprocessor/steps";

/**
 * @module AddManageUsers
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I wait for one minute
 * @description Waits for a minute before allowing anything else to happen
 */
Given("I wait for one minute", () => {
    cy.wait(60000)
})