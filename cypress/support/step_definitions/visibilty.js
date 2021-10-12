import { Given } from "cypress-cucumber-preprocessor/steps";

Given("I should see {string}", (text) => {
    cy.get('html').then(($html) => { expect($html).to.contain(text) })
})

Given("I should NOT see {string}", (text) => {
    cy.get('html').then(($html) => { expect($html).to.not.contain(text) })
})

Given("I should see {string} in the title", (title) => {
    cy.title().should('include', title)
})