import { Given } from "cypress-cucumber-preprocessor/steps";

//View PDF|Enable as survey|Rename|Copy|Delete|Download instrument ZIP/
//TODO: Add documentation
Given('I download the instrument labeled {string} as a PDF', (label) => {
    cy.download_instr_pdf(label)
})

Given('I download the instrument labeled {string} as a ZIP', (label) => {

})

Given('I click on the {instr_action} action for the instrument labeled {string}', (action, label) => {

})