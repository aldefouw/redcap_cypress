import { Given } from "cypress-cucumber-preprocessor/steps";
require('./parameter_types.js')

/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I < disable | enable > longitudinal mode
 * @description Disables or enables longitudinal mode for the project in view.
 */
 Given("I {toggleAction} longitudinal mode", (action) => {
     cy.intercept({  method: 'POST',
         url: '/redcap_v' + Cypress.env('redcap_version') + '/ProjectSetup/modify_project_setting_ajax.php*'
     }).as('longitudinal_mode')

    let want_enabled = action === 'enable'
    let expected_text = want_enabled ? 'Enable' : 'Disable'
    cy.get('#setupLongiBtn').then(($button) => {

        if ($button.text().trim() === expected_text) { //action needed
            cy.wrap($button).click().then(() => {
                if(want_enabled) {
                    cy.get('#setupLongiBtn').should('contain.text', 'Disable')
                } else { //need to confirm disabling within dialog box
                    cy.get('[role=dialog] button:contains("Disable")').click().then(() => {
                        cy.get('#setupLongiBtn').should('contain.text', 'Enable')
                    })
                }
            })
            cy.wait('@longitudinal_mode')
        } else {
            cy.log("Warning: Longitudinal mode is already " + expected_text.toLowerCase() + "d!")
        }
    })
})

/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I should see that surveys are < enabled | disabled >
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
Given('I should see that longitudinal mode is "{status}"', (state) => {
    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.get('#setupLongiBtn').should('contain.text', expected_text);
})

/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I should see that repeatable instruments are < enabled | disabled | modifiable >
 * @param {string} state the state of the button
 * @description Visually verifies Repeatable Instrument functionality is enabled or disabled in the project.
 */
Given("I should see that repeatable instruments are {repeatability}", (state) => {
    let expected_text = ''
    switch (state.toLowerCase()) {
        case 'enabled':
            expected_text = "Disable"
            break;
        case 'disabled':
            expected_text = "Enable"
            break;
        case 'modifiable':
            expected_text = "Modify"
            break;
    }

    cy.get('#enableRepeatingFormsEventsBtn').should('contain.text', expected_text);
})

/**
 * @module ProjectSetup
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I open the dialog box for the Repeatable Instruments and Events module
 * @description Opens the dialog box for the Repeatable Instruments and Events module on the Project Setup page.
 */
Given("I open the dialog box for the Repeatable Instruments and Events module", () => {
    cy.get('#enableRepeatingFormsEventsBtn').click();
    cy.get('div.ui-dialog').should(($div) => {
        expect($div).to.contain('Repeat')
        expect($div).to.contain('Instrument')
    })
})

/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I should see that auto-numbering is < enabled | disabled >
 * @param {string} state the state of the button
 * @description Visually verifies Auto Numbering functionality is enabled or disabled in the project.
 */
Given('I should see that auto-numbering is "{status}"', (state) => {
    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.contains('Auto-numbering for records').within($div => {
        cy.get('button').should('contain.text', expected_text);
    })
})

/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I should see that the scheduling module is < enabled | disabled >
 * @param {string} state the state of the button
 * @description Visually verifies Scheduling functionality is enabled or disabled in the project.
 */
Given('I should see that the scheduling module is "{status}"', (state) => {
    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.contains('Scheduling module').within($div => {
        cy.get('button').should('contain.text', expected_text);
    })
})

/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I should see that the randomization module is < enabled | disabled >
 * @param {string} state the state of the button
 * @description Visually verifies Randomization functionality is enabled or disabled in the project.
 */
Given('I should see that the randomization module is "{status}"', (state) => {
    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.contains('Randomization module').within($div => {
        cy.get('button').should('contain.text', expected_text);
    })
})

/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I should see that the designate an email field for communications setting is < enabled | disabled >
 * @param {string} state the state of the button
 * @description Visually verifies that "Designate an Email" functionality is enabled or disabled in the project.
 */
Given('I should see that the designate an email field for communications setting is "{status}"', (state) => {
    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable');
    cy.contains('Designate an email field for communications').within($div => {
        cy.get('button').should('contain.text', expected_text);
    })
})

/**
 * @module ProjectSetup
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I < enable | disable > designation of an email field for communications setting
 * @param {string} action the action desired on this
 * @description Enables or disables the "Designate an Email" functionality in the project.
 */
Given("I {toggleAction} designation of an email field for communications setting", (action) => {
    let want_enabled = action === 'enable'
    let expected_text = want_enabled ? 'Enable' : 'Disable'
    cy.get('#enableSurveyPartEmailFieldBtn').then(($button) => {
        if ($button.text().trim() === expected_text) { //action needed
            cy.wrap($button).click()
        } else {
            cy.log("Warning: Designated email field already " + expected_text.toLowerCase() + "d!")
        }
    })
})

/**
 * @module Interactions
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I move the project to production by selection option {string}
 * @param {string} text - option - keep all data or delete all data
 * @description Move project to production
 */
Given("I move the project to production by selection option {string}", (text) => {
    cy.move_project_to_production(text)
})