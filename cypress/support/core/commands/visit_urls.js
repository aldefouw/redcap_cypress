//#############################################################################
//# Commands       A B C D E F G H I J K L M N O P Q R S T U V W X Y Z        #
//#############################################################################

Cypress.Commands.add('visit_base', (options) => {
    const url = options['url']
    if ('url' in options) cy.visit(url)
})

Cypress.Commands.add('visit_version', (options) => {
    let version = Cypress.env('redcap_version')
    let url = ''

    if('params' in options){
        url = '/redcap_v' + version + '/' + options['page'] +  '?' + options['params']
        cy.visit(url)
    } else {
        url = '/redcap_v' + version + '/' + options['page']
        cy.visit(url)
    }

})