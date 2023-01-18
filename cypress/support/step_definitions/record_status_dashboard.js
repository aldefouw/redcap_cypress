import {Given} from "cypress-cucumber-preprocessor/steps";

/**
 * @module RecordStatusDashboard
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the bubble for the {string} data collection instrument for record ID {string}
 * @param {string} text - the text value of data collection instrument you want to target
 * @param {string} record_id - the value of the record_id you want to target
 * @description Clicks on a bubble within the Record Status Dashboard based upon record ID and the data instrument specified.
 */
Given("I click on the bubble for the {string} data collection instrument for record ID {string}", (text, record_id) => {
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

/**
 * @module RecordStatusDashboard
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the bubble for the {string} longitudinal data collection instrument on event {string} for record ID {string}
 * @param {string} instrument - the data collection instrument you want to target
 * @param {string} event - the event name you want to target
 * @param {string} record_id - the value of the record_id you want to target
 * @description Clicks on a bubble within the Record Status Dashboard based upon record ID and the longitudinal data instrument specified within an event.
 */
Given("I click on the bubble for the {string} longitudinal data collection instrument on event {string} for record ID {string}", (instrument, event, record_id) => {
    let link_location = null
    let instrument_location = null
    let event_sections = []
    let event_counter = 0

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
            })
        })
    }).then(() => {
        cy.wrap(link_location).click()
    })
})

/**
 * @module RecordStatusDashboard
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click the bubble to add a record for the {string} longitudinal instrument on event {string}
 * @param {string} instrument - the name of the instrument you want to add a record to
 * @param {string} event - the name of the event you want to add a record to
 * @description Clicks on an instrument / event pairing to add a record on the Record Home Page
 */

Given("I click the bubble to add a record for the {string} longitudinal instrument on event {string}", (instrument, event) => {
    let link_location = null

    cy.get('table#event_grid_table').within(() => {
        cy.get('th').then(($th) => {
            Cypress.$.each($th, (index, th) => {
                if(th.innerText === event){
                    cy.get('tr').then(($tr) => {
                        Cypress.$.each($tr, (tri, tr) => {
                            if(tri > 0) {
                                cy.wrap(tr).within(() => {
                                    cy.get('td').then((td) => {
                                        if(td[0].innerText === instrument){
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