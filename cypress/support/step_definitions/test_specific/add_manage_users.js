import {Given} from "cypress-cucumber-preprocessor/steps";

/**
 * @module AddManageUsers
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I wait for {integer} minute(s)
 * @description Waits for specified number of minutes before allowing anything else to happen
 */
Given("I wait for (another ){int} minute(s)", (minutes) => {
    cy.wait(minutes * 60000)
})