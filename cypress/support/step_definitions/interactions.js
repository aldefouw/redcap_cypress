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

Given('I enter {string} into the field labeled {string}', (text, label) => {
    //We locate the label element first.  This isn't always a label which is unfortunate, but this approach seems to work so far.
    cy.contains(label).then(($label) => {
        //We are finding the parent of the label element and then looking for nearest input
        cy.wrap($label).parent().find('input').type(text)
    })
})

// Given(/^I should be able to locate and visit the Control Center link labeled and titled "(.*)"?$/, (link_label, title) => {
//     cy.contains_cc_link(link_label, title)
// })