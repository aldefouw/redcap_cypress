import { Given } from "cypress-cucumber-preprocessor/steps";

Given("I am a(n) {string} user who logs into REDCap", (user_type) => {
    cy.set_user_type(user_type)
})