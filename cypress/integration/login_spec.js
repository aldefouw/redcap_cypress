describe('Login Page', function () {

    const users = Cypress.env("users");
    const username = users['standard']['user'];
    const password = users['standard']['pass'];

    beforeEach(()=>{
        cy.visit('/?logout=1')
        cy.visit('/')
    })

    it('sets auth cookie when logging in via form submission', ()=>{
        cy.get('input#username').type(username)
        cy.get('input#password').type(`${password}{enter}`).then(() => {
            cy.getCookies()
              .then((cookies) => {
                expect(cookies.length).to.equal(1)
              })
        })
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
    })
    
})