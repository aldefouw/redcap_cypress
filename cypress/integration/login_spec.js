describe('Login Page', function () {

    const users = Cypress.env("users");
    const username = users['standard']['user'];
    const password = users['standard']['pass'];

    beforeEach(() => {
        cy.clearCookies()
    })

    it('sets auth cookie when logging in via form submission', ()=>{
        cy.visit('?logout=1').then(() => {
            cy.get('input#username').type(username)
            cy.get('input#password').type(`${password}{enter}`).then(() => {
                cy.getCookies()
                  .then((cookies) => {
                    expect(cookies.length).to.be(1)
                  })
            }) 
        })       
    })

    it('requires a valid username and password', ()=>{
        cy.visit('?logout=1').then(() => {
            cy.clearCookies()
            cy.get('input#username').type(username)
            cy.get('input#password').type(password)
            cy.contains('button', 'Log In').click().then(()=> {
                cy.get('body').contains('Logged in as')
            })
        })
    })

    it('requires a username', ()=>{
        cy.visit('?logout=1').then(() => {
            cy.get('input#password').type(`${password}{enter}`)
            cy.contains('ERROR: You entered an invalid user name or password!')
        })        
    })

    it('requires a password', ()=>{
        cy.visit_v({page: '?logout=1'}).then(() => {
            cy.get('input#username').type(`${username}{enter}`)
            cy.contains('ERROR: You entered an invalid user name or password!')
        })
    })
    
})