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

Cypress.Commands.add('move_project_to_production', (project_id, keep_data = true) => {
    cy.visit_version({page: 'ProjectSetup/index.php', params: `pid=${project_id}`})
    cy.get('button').contains('Move project to production').should('be.visible').click()
    cy.get(`input#${keep_data ? "keep_data" : "delete_data"}`).check()
    cy.get('button').contains('YES, Move to Production Status').should('be.visible').click()
})