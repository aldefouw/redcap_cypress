import {Given} from "cypress-cucumber-preprocessor/steps";

/**
 * @module RecordStatusDashboard
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the bubble for the {string} data collection instrument instrument for record ID {string}
 * @param {string} text - the text value of data collection instrument you want to target
 * @param {string} record_id - the value of the record_id you want to target
 * @description Click on a bubble within the Record Status Dashbaord based upon record ID and the data instrument specified.
 */
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