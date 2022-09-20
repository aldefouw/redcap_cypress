import { Given } from "cypress-cucumber-preprocessor/steps";

Given("I click on the button labeled {string}", (text) => {
    cy.get('button').contains(text).click()
})

Given("I click on the button titled {string} for the {string} category", (text, category) => {
    // Find the cell that contains the Category label and find the parent
    cy.get('td').contains(category).parents('tr').within(() => {
        // Find the button element
        cy.get('button[title="' + text +'"]').click()
    })
})

// For clicking dialog buttons that have a similarly named button outside a dialog
Given("I click on the button labeled {string} in the dialog box", (text) => {
    cy.get('div[role="dialog"]').within(() => {
        cy.get('button').contains(text).click()
    })
    
})

Given("I click on the link labeled {string}", (text) => {
    cy.get('a').contains(text).click()
})

Given("I click on the input button labeled {string}", (text) => {
    cy.get('input[value="' + text + '"]').click()
})

Given("I click on the input checkbox labeled {string}", (text) => {
    cy.get('input[name="' + text + '"]').click()
})

Given("I select the option labeled {string} for the {string} category", (text, category) => {
    // Find the cell that contains the Category label and find the parent
    cy.get('td').contains(category).parents('tr').within(() => {
        cy.contains('select', text).then(($label) => {
            cy.wrap($label).select(text, {force: true})
        })
    })
})

Given("I click on the bubble for the {string} data collection instrument instrument for record ID {string}", (text, record_id) => {
    let link_location = null

    cy.get('table#record_status_table').within(() => {
        cy.get('th').then(($th) => {
            Cypress.$.each($th, (index, th) => {
                if(th.innerText === text){
                    cy.get('tr').then(($tr) => {
                        Cypress.$.each($tr, (tri, tr) => {
                            if(tri > 0) {
                                cy.wrap(tr).within(() => {
                                    cy.get('td').then((td) => {
                                        if(td[0].innerText === record_id){
                                            Cypress.$.each(td, (tdi, $td) => {
                                                if(tdi === index){
                                                    cy.wrap($td).within(() => {
                                                        cy.get('a').then(($a) => {
                                                           link_location = $a
                                                        })
                                                    })
                                                }
                                            })
                                        }
                                    })
                                })
                            }
                        })
                    })
                }
            })
        })
    }).then(() => {
       cy.wrap(link_location).click()
    })
})

Given("I edit the field labeled {string}", (text) => {
    cy.edit_field_by_label(text)
})

Given("I mark the field required", () => {
    cy.get('input#field_req1').click()
})

Given("I save the field", () => {
    cy.save_field()
})

Given("I want to pause", () => {
    cy.pause()
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

Given('I enter {string} into the input field named {string} for the {string} category', (text, label, category) => {
    // Method is because the input on Edit Reports doesn't have a label
    // Find the cell that contains the Category label and find the parent
    cy.get('td').contains(category).parents('tr').within(() => {
        cy.get('input[name="' + label +'"]').type(text)
    })
})

Given('I click on the table cell containing a link labeled {string}', (text) => {
    cy.get('td').contains(text).parent().find('a').click()
})

// Given(/^I should be able to locate and visit the Control Center link labeled and titled "(.*)"?$/, (link_label, title) => {
//     cy.contains_cc_link(link_label, title)
// })