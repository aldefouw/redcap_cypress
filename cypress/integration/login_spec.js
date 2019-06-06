describe('Login Page', function () {

    const users = Cypress.env("users");
    const username = users['standard']['user'];
    const password = users['standard']['pass'];

    beforeEach(() => {
        cy.clearCookies()
    })

    it('Should log you in with a valid username and password', ()=>{

        cy.visit('/index.php?logout=1').then(() => {
            cy.get('input#username').type(username)
            cy.get('input#password').type(password)
            cy.contains('button', 'Log In').click().then(()=> {
                cy.server()
                cy.route({method: 'POST', url: '**/ProjectGeneral/project_stats_ajax.php', response: 0})
                cy.get('body').contains('Logged in as')
                cy.visit('/index.php?logout=1')
            })
        })
    })

    it('Should require a username', ()=>{
        cy.visit('/index.php?logout=1').then(() => {
            cy.get('input#password').type(`${password}{enter}`)
            cy.contains('ERROR: You entered an invalid user name or password!')
             cy.visit('/index.php?logout=1')
        })        
    })

    it('Should require a password', ()=>{
        cy.visit('/index.php?logout=1').then(() => {
            cy.get('input#username').type(`${username}{enter}`)
            cy.contains('ERROR: You entered an invalid user name or password!')
            cy.visit('/index.php?logout=1')
        })
    })
    
})