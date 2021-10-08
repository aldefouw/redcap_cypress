import { Then } from "cypress-cucumber-preprocessor/steps";

Then(`I see {string} in the title`, (title) => {
    cy.title().should('include', title)
})

Given("a admin user logs into REDCap", () => {
    cy.set_user_type('admin')
})

And("they visit the public survey URL for Project ID {int}", (project_id) => {
    cy.visit_version({page: 'index.php', params: "pid=" + project_id})
    cy.get('a').contains('Survey Distribution Tools').click()
    cy.get('div').contains('Public Survey URL').parent().find('input').then(($input) => {
        cy.visit_base({ url: $input[0].value })
    })
})

And("they enter {string} into the {string} survey field", (text, field) => {
    cy.get('tr#email-tr').within(($t) => {
        cy.get('input').type(text)
    })
})

And("they click the {string} button", (text) => {
    cy.get('button').contains(text).click()
})

Then("they should see {string}", (text) => {
    cy.get('html').then(($html) => {
        expect($html).to.contain(text)
    })
})