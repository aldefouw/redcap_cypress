import { Given } from "cypress-cucumber-preprocessor/steps";

Given("the AJAX {string} request at {string} tagged by {string} is being monitored", (type, request_url, tag) => {
    cy.intercept({
        method: type,
        url: '/redcap_v' + Cypress.env('redcap_version') + "/" + request_url
    }).as(tag)
})

Given("the AJAX request tagged by {string} has completed", (tag) => {
    cy.wait('@' + tag)
})

