import { Given } from "cypress-cucumber-preprocessor/steps";

Given('I create a new instrument named {string}', (instr_name) => {
    cy.create_instrument(instr_name)
})

//View PDF|Enable as survey|Rename|Copy|Delete|Download instrument ZIP/
//TODO: Add documentation
Given('I download the instrument labeled {string} as a PDF', (label) => {
    cy.download_instr_pdf(label)
})

Given('I download the instrument labeled {string} as a ZIP', (label) => {

})

Given('I rename the instrument labeled {string} to {string}', (from, to) => {
    cy.rename_instrument(from, to)
})

Given('I click on the {string} action for the instrument labeled {string}', (action, label) => {

})