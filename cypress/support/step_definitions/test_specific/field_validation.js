import {Given} from "cypress-cucumber-preprocessor/steps";

//Checks whether a given field validation type is enabled/disabled for all projects
//on /ControlCenter/validation_type_setup.php
Given('I should see that the {string} validation type is {string}', (type, state) => {
    
    //if enabled, button label will be 'Disable', else label will be 'Enable'
    let expected_text = ((state.toLowerCase() === 'enabled') ? 'Disable' : 'Enable')
    cy.get(`button[onclick*="${type}"]`).should('contain.text', expected_text)

})

