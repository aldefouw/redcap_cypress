import { Given } from "cypress-cucumber-preprocessor/steps";

Given(/^I should see an element identified by "(.*?)"(?: containing the text "(.*)")?$/, (sel, text = '') => {
    // Using expect and language chainers
    // cy.get(sel).should(($e) => {
    //     expect($e).to.contain(text).and.be.visible
    // })

    // New implementation without using Chai getter chainers
    // Issue: instead of selecting one element that contains the text and
    // ensuring it is visible, this selects all matched elements, and checks
    // to see if any of them contain the text, then checks if any (or all?) of them
    // is/are visible. Not exactly what is intended, but does the job in most cases
    // cy.get(sel).should('contain', text).and('be.visible')
    
    // This fixes the previous problem, using the JQuery extension :contains()
    cy.get(`${sel}:contains("${text}")`).should('be.visible')
})