//#############################################################################
//# Commands       A B C D E F G H I J K L M N O P Q R S T U V W X Y Z        #
//#############################################################################

Cypress.Commands.add('get_record_status_dashboard', (event, instrument, record_id, repeating) => {

    // TODO: This is badly in need a refactor using pseudo-selectors but haven't had time yet

    let link_location = null
    let instrument_location = null
    let event_sections = {}
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

        //console.log(event_sections)
        //console.log(event_counter)

        cy.get('th').then(($th) => {
            Cypress.$.each($th, (index, th) => {
                cy.get('tr').then(($tr) => {
                    Cypress.$.each($tr, (tri, tr) => {

                        //console.log(tri)

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

                            //console.log(instrument_location)

                        } else if (tri > 1) {

                            //console.log('in here')

                            cy.wrap(tr).within(() => {
                                cy.get('td').then((td) => {

                                    //console.log(td[0].innerText.length)
                                    //console.log(td[0].innerText.trim().length)

                                    //Here is where we locate the reocrd we're interested in
                                    if (td[0].innerText.trim() === record_id) {
                                        Cypress.$.each(td, (tdi, $td) => {

                                            //console.log(tdi)

                                            if (tdi === instrument_location + 1) {

                                                //console.log('instrument location reached')
                                                //console.log($td)

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
    })

})