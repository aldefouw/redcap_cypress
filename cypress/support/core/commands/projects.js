//#############################################################################
//# Commands       A B C D E F G H I J K L M N O P Q R S T U V W X Y Z        #
//#############################################################################

Cypress.Commands.add('delete_project_permanently', () => {
    cy.intercept({
        method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + "/ProjectGeneral/delete_project.php?*"
    }).as('delete_project')

    cy.get('button').contains('Delete the project').click()
    cy.get('input#delete_project_confirm').should('be.visible').type('DELETE').then((input) => {
        cy.get(input).closest('div[role="dialog"]').find('button').contains('Delete the project').click()
        cy.get('button').contains('Yes, delete the project').click()
    })

    cy.wait('@delete_project')
})

Cypress.Commands.add('move_project_to_production', (text) => {
    cy.intercept({
        method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + '/ProjectGeneral/change_project_status.php*'
    }).as('production_status')

    cy.get('span').contains(text).click()
    cy.get('button').contains('Production Status').click()
    cy.get('div#actionMsg').should('be.visible')

    cy.wait('@production_status')
})

Cypress.Commands.add('move_project_to_development', () => {
    cy.intercept({  method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + '/ProjectGeneral/change_project_status*'
    }).as('change_project_status')

    cy.get('button').contains('Move back to Development status').click()

    cy.wait('@change_project_status')
})