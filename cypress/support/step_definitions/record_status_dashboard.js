import {Given} from "cypress-cucumber-preprocessor/steps";
require('./parameter_types.js')

/**
 * @module RecordStatusDashboard
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the bubble for the {string} data collection instrument for record ID {string}
 * @param {string} text - the text value of data collection instrument you want to target
 * @param {string} record_id - the value of the record_id you want to target
 * @description Clicks on a bubble within the Record Status Dashboard based upon record ID and the data instrument specified.
 */
Given("I click on the bubble for the {string} data collection instrument for record ID {string}", (text, record_id) => {
    cy.table_cell_by_column_and_row_label(text, record_id).then(($td) => {
        cy.wrap($td).find('a:visible:first').click()
    })
})

/**
 * @module RecordStatusDashboard
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I locate the bubble for the {string} instrument on event {string} for record ID {string} {cell_action}
 * @param {string} instrument - the data collection instrument you want to target
 * @param {string} event - the event name you want to target
 * @param {string} record_id - the value of the record_id you want to target
 * @param {string} cell_action - < and click the new instance link | and click on the bubble | and click the repeating instrument bubble for the (first | second | third) instance >
 * @description Clicks on a bubble within the Record Status Dashboard based upon record ID and the longitudinal data instrument specified within an event.
 */

Given("I locate the bubble for the {string} instrument on event {string} for record ID {string} {cell_action}", (instrument, event, record_id, cell_action) => {
    let link_location = null
    let instrument_location = null
    let event_sections = []
    let event_counter = 0
    let repeating = false

    if(cell_action === "and click the repeating instrument bubble for the first instance" ||
        cell_action === "and click the repeating instrument bubble for the second instance" ||
        cell_action === "and click the repeating instrument bubble for the third instance"){
        repeating = true
    }

    cy.get('table#record_status_table').within(() => {
        cy.get('thead').within(() => {
            cy.get('tr').then(($first_tr) => {
                Cypress.$.each($first_tr, (tri_row, tri_html) => {
                    if(tri_row === 0){
                        Cypress.$(tri_html).children().each(($thi, $th) => {
                            if($thi > 0) { //exclude Record ID
                                event_sections[$th.innerText] = { colspan: $th.colSpan, start: event_counter + 1, end: event_counter + $th.colSpan }
                                event_counter += $th.colSpan
                            }
                        })
                    }
                })
            })
        })

        cy.get('th').then(($th) => {
            Cypress.$.each($th, (index, th) => {
                    cy.get('tr').then(($tr) => {
                        Cypress.$.each($tr, (tri, tr) => {
                            if(tri === 1) {
                                cy.wrap(tr).within(() => {
                                    cy.get('th').then((th) => {
                                        Cypress.$.each(th, (thi, $thi) => {
                                            const current_event = event_sections[event]

                                            // console.log(thi)
                                            // console.log(current_event['start'])
                                            // console.log(current_event['end'])

                                            if($thi.innerText === instrument && thi >= current_event['start'] && thi <= current_event['end']){
                                                instrument_location = thi
                                            }
                                        })

                                    })
                                })

                            } else if (tri > 1) {

                                cy.wrap(tr).within(() => {
                                    cy.get('td').then((td) => {
                                        if (td[0].innerText === record_id) {
                                            Cypress.$.each(td, (tdi, $td) => {

                                                //console.log(tdi)

                                                if (tdi === instrument_location + 1) {
                                                    cy.wrap($td).within(() => {

                                                        if(cell_action === "and click on the bubble" || repeating){
                                                            cy.get('a').then(($a) => {
                                                                link_location = $a
                                                            })
                                                        } else if (cell_action === "and click the new instance link") {
                                                            cy.get('button').then(($button) => {
                                                                link_location = $button
                                                            })
                                                        }

                                                    })
                                                }
                                            })
                                        }
                                    })
                                })

                            }
                        })
                    })
            })
        })
    }).then(() => {
        cy.intercept({
            method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/index.php?*'
        }).as('instance_table')

        cy.wrap(link_location).click()

        if(repeating){
            cy.wait('@instance_table')

            cy.get('#instancesTablePopup').within(() => {
                let instance = null

                if(cell_action === "and click the repeating instrument bubble for the first instance"){
                    instance = 1
                } else if (cell_action === "and click the repeating instrument bubble for the second instance"){
                    instance = 2
                } else if (cell_action === "and click the repeating instrument bubble for the third instance"){
                    instance = 3
                }

                cy.get('td').contains(instance).parent('tr').within(() => {
                    cy.get('a').click()
                })
            })
        }
    })
})

/**
 * @module RecordStatusDashboard
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click the bubble to < add | select > a record for the {string} longitudinal instrument on event {string}
 * @param {string} instrument - the name of the instrument you want to add a record to
 * @param {string} event - the name of the event you want to add a record to
 * @description Clicks on an instrument / event pairing to add / select a record on the Record Home Page
 */

Given("I click the bubble to {add_or_select} a record for the {string} longitudinal instrument on event {string}", (verb, instrument, event) => {
    cy.table_cell_by_column_and_row_label(event, instrument, 'table#event_grid_table').then(($td) => {
        cy.wrap($td).find('a:visible:first').click()
    })
})

/**
 * @module RecordStatusDashboard
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click the bubble to < add | select > a record for the {string} classic instrument
 * @param {string} instrument - the name of the classic instrument you want to add a record to
 * @description Clicks on an instrument to add / select a record on the Record Home Page
 */

Given("I click the bubble to {add_or_select} a record for the {string} classic instrument", (verb, instrument) => {
    cy.table_cell_by_column_and_row_label("Status", instrument, 'table#event_grid_table').then(($td) => {
        cy.wrap($td).find('a:visible:first').click()
    })
})

/**
 * @module RecordStatusDashboard
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I select record ID {string} from arm name {string} on the Add / Edit record page
 * @param {string} record_id - the name of the record ID
 * @param {string} arm_name - name of the arm as displayed in the dropdown menu (e.g. Arm 1: Arm 1)
 * @description Selects a specific record from the Add / Edit record page
 */

Given(/I select record ID "(.*)" from arm name "(.*)" on the Add \/ Edit record page$/, (record_id, arm_name) => {
    cy.get('select#arm_name').select(arm_name)
    cy.get('select#record').select(record_id)
})


/**
 * @module RecordStatusDashboard
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click the X to delete all data related to the event named {string}
 * @param {string} event - name of the event displayed on the Record Home Page
 * @description Activates a pop-up confirming that user wants to delete all data on a specific even within a record
 */

Given("I click the X to delete all data related to the event named {string}", (event) => {
    cy.table_cell_by_column_and_row_label(event, "Delete all data on event").then(($td) => {
        cy.wrap($td).find('a:visible:first').click()
        cy.get('.ui-dialog').should('contain.text', 'DELETE ALL DATA ON THIS EVENT INSTANCE')
    })
})


