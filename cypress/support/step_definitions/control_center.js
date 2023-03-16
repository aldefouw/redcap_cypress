import {Given} from "cypress-cucumber-preprocessor/steps";
require('./parameter_types.js')

/**
 * @module ControlCenter
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enable the Field Validation Type named {string} within the Control Center
 * @param {string} field_validation_type - the label of the Field Validation type
 * @description Enables a specific Field Validation Type (for all projects) within the Control Center
 */
Given('I enable the Field Validation Type named {string} within the Control Center', (field_validation_type) => {
    cy.toggle_field_validation_type(field_validation_type)
})

/**
 * @module ControlCenter
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I disable the Field Validation Type named {string} within the Control Center
 * @param {string} field_validation_type - the label of the Field Validation type
 * @description Disables a specific Field Validation Type (for all projects) within the Control Center
 */
Given('I disable the Field Validation Type named {string} within the Control Center', (field_validation_type) => {
    cy.toggle_field_validation_type(field_validation_type, 'Disable')
})

/**
 * @module ControlCenter
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I < enable | disable > the Administrator Privilege {string} for the administrator {string}
 * @param {string} privilege - the label of the privilege you want for the user
 * @param {string} admin_user - the name of the user you are setting the privilege for
 * @description Enables the privilege for the administrator based upon user
 */
Given('I {toggle} the Administrator Privilege {string} for the administrator {string}', (action, privilege, admin_user) => {
    cy.intercept({ method: 'POST', url: '*saveAdminPriv*'}).as('admin_privileges')

    cy.get('table#admin-rights-table').within(($table) => {
        cy.get('th').contains(privilege).then(($th) => {
            $th.parents('tr').children('th').each((thi, th) => {
                if(th.innerText.includes(privilege)){
                    cy.get('td').contains(admin_user).parentsUntil('td').parent().then(($td) => {
                        $td.parent('tr').children('td').each((tdi, td) => {
                            //If we're in the correct row and column
                            if(tdi === thi){
                                const element = Cypress.$(td).find('input')
                                if(element.length){
                                    //Do nothing for cases where we request same thing we already have
                                    if( (element[0].checked && action === 'enable') || (!element[0].checked && action === 'disable') ) {

                                    //check and wait for the XHR request to finish
                                    } else if (!element[0].checked && action === 'enable') {
                                        cy.wrap(element[0]).check()
                                        cy.wait('@admin_privileges')

                                    //uncheck and wait for the XHR request to finish
                                    } else if (element[0].checked && action === 'disable') {
                                        cy.wrap(element[0]).uncheck()
                                        cy.wait('@admin_privileges')
                                    }
                                }
                            }
                        })
                    })
                }
            })
        })
    })

})

/**
 * @module ControlCenter
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enable the Administrator Privilege {string} for a new administrator
 * @param {string} privilege - the label of the privilege you want for the user
 * @description Enables the privilege for the administrator based upon user
 */
Given('I enable the Administrator Privilege {string} for a new administrator', (privilege) => {
    cy.get('table#admin-rights-table').within(($table) => {
        cy.get('th').contains(privilege).then(($th) => {
            $th.parents('tr').children('th').each((thi, th) => {
                if(th.innerText.includes(privilege)){
                    cy.get('input#user_search').parentsUntil('td').parent().then(($td) => {
                        $td.parent('tr').children('td').each((tdi, td) => {
                            if(tdi === thi){
                                const element = Cypress.$(td).find('input')
                                if(element.length){
                                    cy.wrap(element[0]).check()
                                }
                            }
                        })
                    })
                }
            })
        })
    })
})


