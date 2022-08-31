import { Given } from "cypress-cucumber-preprocessor/steps";

Given("I should see that surveys are {string}", (state) => {

    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.get('#setupEnableSurveysBtn').should('contain.text', expected_text);

})

Given("I should see that longitudinal mode is {string}", (state) => {

    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.get('#setupLongiBtn').should('contain.text', expected_text);

})

Given("I should see that repeatable instruments are {string}", (state) => {

    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.get('#enableRepeatingFormsEventsBtn').should('contain.text', expected_text);

})

Given("I should see that auto-numbering is {string}", (state) => {

    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.contains('Auto-numbering for records').within($div => {
        cy.get('button').should('contain.text', expected_text);
    })

})

Given("I should see that the scheduling module is {string}", (state) => {

    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.contains('Scheduling module').within($div => {
        cy.get('button').should('contain.text', expected_text);
    })

})

Given("I should see that the randomization module is {string}", (state) => {

    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.contains('Randomization module').within($div => {
        cy.get('button').should('contain.text', expected_text);
    })

})

Given("I should see that the designate an email for communications setting is {string}", (state) => {

    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.contains('Designate an email for communications').within($div => {
        cy.get('button').should('contain.text', expected_text);
    })

})

Given("I should see that the optional module {string} is {string}", (mod_text, state) => {

    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.get('#setupChklist-modules > table > tbody > tr > > > div')
        .contains(mod_text, {matchCase: false}).within($div => {
            cy.get('button').should('contain.text', expected_text);
        })

})