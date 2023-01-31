import {Given} from "cypress-cucumber-preprocessor/steps";

/**
 * @module TestSpecific/ProjectStatus
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the button labeled {string} in the project status dialog box
 * @param {string} text - the text on the button element you want to click
 * @description Clicks on a button element with a specific text label in a dialog box.
 */

Given('I click on the button labeled {string} in the project status dialog box', (text) => {
    cy.intercept({
        method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + "/ProjectGeneral/change_project_status.php?*"
    }).as('project_status')

    cy.click_on_dialog_button(text)

    cy.wait('@project_status')
})