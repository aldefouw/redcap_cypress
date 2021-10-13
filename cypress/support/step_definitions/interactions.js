import { Given } from "cypress-cucumber-preprocessor/steps";

Given("I click on the button labeled {string}", (text) => {
    cy.get('button').contains(text).click()
})

Given("I click on the link labeled {string}", (text) => {
    cy.get('a').contains(text).click()
})

Given("I click on the bubble for the {string} data collection instrument", (text) => {
    cy.get('td').contains(text).then(($td) => {
        let table_row = $td.parent('tr')
        cy.get(table_row).within(($s) => { cy.get('a').click() })
    })
})

Given("I visit Project ID {int}", (id) => {
    cy.visit_version({page: 'index.php', params: 'pid=' + id})
})

Given(/^I should be able to locate and visit the Control Center link labeled "(.*)"(?: and see the title "(.*)")?$/, (link_label, title) => {
    if(title !== undefined){
        cy.contains_cc_link(link_label, title)
    } else {
        cy.contains_cc_link(link_label)
    }
})

// Given(/^I should be able to locate and visit the Control Center link labeled and titled "(.*)"?$/, (link_label, title) => {
//     cy.contains_cc_link(link_label, title)
// })