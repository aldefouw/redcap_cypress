describe('Login Page', function () {

    const users = Cypress.env("users");
    const username = users['standard']['user'];
    const password = users['standard']['pass'];
    const admin_user = users['admin']['user'];
    const admin_pass = users['admin']['pass'];

    beforeEach(()=>{
        cy.clearCookie('PHPSESSID')
        cy.visit('/')
    })

    it('sets auth cookie when logging in via form submission', ()=>{
        cy.get('input#username').type(username)
        cy.get('input#password').type(`${password}{enter}`)
        cy.getCookie('PHPSESSID').should('exist')
    })

    it('requires a username', ()=>{
        cy.get('input#password').type(`${password}{enter}`)
        cy.contains('ERROR: You entered an invalid user name or password!')
    })

    it('requires a password', ()=>{
        cy.get('input#username').type(`${username}{enter}`)
        cy.contains('ERROR: You entered an invalid user name or password!')
    })

    it('requires a valid username and password', ()=>{
        cy.get('input#username').type(username)
        cy.get('input#password').type(password)
        cy.contains('button', 'Log In').click()
        cy.contains('Listed below are the REDCap projects to which you currently have access.')
    })

    after(() => {
        cy.login( { username: admin_user, password: admin_pass } )
    })
    
})