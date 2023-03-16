//#############################################################################
//# Commands       A B C D E F G H I J K L M N O P Q R S T U V W X Y Z        #
//#############################################################################

Cypress.Commands.add('fetch_login', () => {
    let user = window.user_info.get_current_user()
    let pass = window.user_info.get_current_pass()

    cy.login({ username: user, password:  pass })

    window.user_info.set_previous_user_type()
})

Cypress.Commands.add('login', (options) => {
    cy.logout()
    cy.visit('/')
    cy.intercept('POST', '/').as('loginStatus')
    cy.get('input[name=username]').invoke('attr', 'value', options['username'])
    cy.get('input[name=password]').invoke('attr', 'value', options['password'])
    cy.get('button').contains('Log In').click()
})

Cypress.Commands.add('logout', () => {
    cy.clearCookie('PHPSESSID')
    cy.visit_version({page: "", parameters: "action=logout"})
    cy.get('html').should('contain', 'Log In')
})

Cypress.Commands.add('set_user_type', (user_type) => {
    window.user_info.set_user_type(user_type)
})

Cypress.Commands.add('set_user_info', (users) => {
    if(users !== undefined){
        window.user_info.set_users(users)
    } else {
        alert('users, which defines what users are in your seed database, is missing from cypress.env.json.  Please configure it before proceeding.')
    }
})