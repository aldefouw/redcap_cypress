import { Given } from "cypress-cucumber-preprocessor/steps";

Given('I create a new instrument named {string}', (instr_name) => {
    cy.create_instrument(instr_name)
})

Given('I rename the instrument labeled {string} to {string}', (from, to) => {
    cy.rename_instrument(from, to)
})

Given('I copy the instrument labeled {string} as {string} with variable suffix {string}', (from, to, suffix) => {
    cy.copy_instrument(from, to, suffix)
})

Given('I reorder the instrument at position {int} to position {int}', (from, to) => {
    cy.reorder_instrument(from, to)
})

//TODO: ask Adam if this should be its own Cypress command
Given('I should see an instrument labeled {string} in row {int} of the instruments table', (label, row_num) => {
    cy.get(`#row_${row_num}`).should('contain.text', label)
})