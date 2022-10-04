import { defineParameterType, Given } from "cypress-cucumber-preprocessor/steps";

defineParameterType({
    name: 'status',
    regexp: /enabled|disabled/
})


/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I should see that surveys are <enabled/disabled>
 * @param {string} state the state of the button
 * @description Visually verifies whether Survey functionality is enabled or disabled in the project.
 */
Given("I should see that surveys are {status}", (state) => {
    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.get('#setupEnableSurveysBtn').should('contain.text', expected_text);
})

/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I should see that longitudinal mode is <enabled/disabled>
 * @param {string} state the state of the button
 * @description Visually verifies whether Longitudinal functionality is enabled or disabled in the project.
 */
Given("I should see that longitudinal mode is {string}", (state) => {
    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.get('#setupLongiBtn').should('contain.text', expected_text);
})

/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I should see that repeatable instruments are <enabled/disabled>
 * @param {string} state the state of the button
 * @description Visually verifies Repeatable Instrument functionality is enabled or disabled in the project.
 */
Given("I should see that repeatable instruments are {string}", (state) => {
    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.get('#enableRepeatingFormsEventsBtn').should('contain.text', expected_text);
})

/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I should see that auto-numbering is <enabled/disabled>
 * @param {string} state the state of the button
 * @description Visually verifies Auto Numbering functionality is enabled or disabled in the project.
 */
Given("I should see that auto-numbering is {string}", (state) => {
    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.contains('Auto-numbering for records').within($div => {
        cy.get('button').should('contain.text', expected_text);
    })
})

/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I should see that the scheduling module is <enabled/disabled>
 * @param {string} state the state of the button
 * @description Visually verifies Scheduling functionality is enabled or disabled in the project.
 */
Given("I should see that the scheduling module is {string}", (state) => {
    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.contains('Scheduling module').within($div => {
        cy.get('button').should('contain.text', expected_text);
    })
})

/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I should see that the randomization module is <enabled/disabled>
 * @param {string} state the state of the button
 * @description Visually verifies Randomization functionality is enabled or disabled in the project.
 */
Given("I should see that the randomization module is {string}", (state) => {
    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.contains('Randomization module').within($div => {
        cy.get('button').should('contain.text', expected_text);
    })
})

/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I should see that the designate an email for communications setting is <enabled/disabled>
 * @param {string} state the state of the button
 * @description Visually verifies that "Designate an Email" functionality is enabled or disabled in the project.
 */
Given("I should see that the designate an email field for communications setting is {string}", (state) => {
    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.contains('Designate an email field for communications').within($div => {
        cy.get('button').should('contain.text', expected_text);
    })
})