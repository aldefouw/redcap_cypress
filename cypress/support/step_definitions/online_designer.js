import { Given } from "cypress-cucumber-preprocessor/steps";

defineParameterType({
    name: 'instr_action',
    regexp: /View PDF|Enable as survey|Rename|Copy|Delete|Download instrument ZIP/
})

Given('I download the instrument labeled {string} as a PDF', label => {
    cy.download_instr_pdf(label)
})

Given('I click on the {instr_action} action for the instrument labeled {string}', (action, label) => {

})