//#############################################################################
//# Commands       A B C D E F G H I J K L M N O P Q R S T U V W X Y Z        #
//#############################################################################

Cypress.Commands.add('export_csv_report', () => {
    // This assumes user already has export dialog open
    cy.get('div[role="dialog"]').should('be.visible').find('button').contains('Export Data').click().then(() => {
        cy.get('div[role="dialog"]').should('be.visible').find('td').contains('Click icon(s) to download:').closest('tbody').find('a').first().then(($a) => {
            cy.request($a[0].href).then(({ body, headers }) => {
                expect(headers).to.have.property('content-type', 'application/csv')
                return body
            })
        }).then((csvString) => {
            return cy.task('parseCsv', {csv_string: csvString})
        })
    })
})

Cypress.Commands.add('export_logging_csv_report', () => {
    cy.get('button').should('be.visible').and('be.enabled').contains('All logging').then((b) => {
        cy.window().then((win) => {
            let url = win.eval(b[0].getAttribute('onclick').split('window.location.href=')[1]);
            cy.log(url);
            cy.request(url).then(({ body, headers }) => {
                expect(headers).to.have.property('content-type', 'application/csv')
                return body;
            }).then((body) => {
                return cy.task('parseCsv', {csv_string: body});
            });
        });
    });
})