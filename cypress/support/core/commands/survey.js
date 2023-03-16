//#############################################################################
//# Commands       A B C D E F G H I J K L M N O P Q R S T U V W X Y Z        #
//#############################################################################

Cypress.Commands.add('enable_surveys', (instrument_name) => {
    cy.get('table[id=table-forms_surveys]').within(() => {
        cy.get('tr').contains(instrument_name).parents('tr').find(':button').contains('Enable').click()
    })

    cy.get(`:button:contains("Save Changes"):visible:first`).click()

    cy.get('html').should('contain', 'Your survey settings were successfully saved!')
})