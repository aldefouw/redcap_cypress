// ***********************************************************
// This example support/index.js is processed and
// loaded automatically before your test files.
//
// This is a great place to put global configuration and
// behavior that modifies Cypress.
//
// You can change the location of this file or turn off
// automatically serving support files with the
// 'supportFile' configuration option.
//
// You can read more here:
// https://on.cypress.io/configuration
// ***********************************************************

// Import commands.js using ES2015 syntax:
import './commands'

function UserInfo() {

    let u = ''
    let u_t = ''
    let p_u_t = ''

    let user = ''
    let pass = ''

    this.set_users = (users) => {
        u = users;
    }

    this.get_users = () => {
        return u
    }

    this.set_previous_user_type = () => {
        p_u_t = u_t
    }

    this.get_previous_user_type= () => {
        return p_u_t
    }

    this.set_user_type = (user_type) => {
        u_t = user_type        
        this.set_current_user()
        this.set_current_pass()
    }

    this.get_user_type = () => {
        return u_t
    }

    this.set_current_user = () => {
        user = u[u_t]['user'];
    }

    this.get_current_user = () => {
        return user
    }

    this.set_current_pass = () => {
        pass = u[u_t]['pass'];
    }

    this.get_current_pass = () => {
        return pass
    }

}

window.user_info = new UserInfo();


//Set the Base URL in the REDCap Configuration Database
// if(Cypress.config('baseUrl') !== null){
    const base_url = 'BASE_URL/' + Cypress.config('baseUrl').replace('http://', 'http\\:\\\\/\\\\/')
// } else {
//     alert('baseUrl, which tells REDCap Cypress what URL your REDCap test server is at, is missing from cypress.json.  Please configure it before proceeding.')
// }

before(() => {

    //Cypress Users
    cy.set_user_info(Cypress.env('users'))

    //By default, we are going to login as a standard user
    cy.set_user_type('standard')

    //Create the initial database structure
    cy.mysql_db('structure').then(() => {

        console.log(base_url)

        //Seeds the database
        cy.mysql_db('/versions/' + Cypress.env('redcap_version'), base_url).then(() => {

            if(Cypress.env('redcap_hooks_path') != undefined){
                const redcap_hooks_path = "REDCAP_HOOKS_PATH/" + Cypress.env('redcap_hooks_path').replace(/\//g, "\\\\/");
                cy.mysql_db('hooks_config', redcap_hooks_path) //Fetch the hooks SQL seed data
            }

            //Clear out all cookies
            cy.clearCookies()
        })
    })  
})

beforeEach(() => {  
    cy.maintain_login()
})

Cypress.on("uncaught:exception", (err, runnable) => {
  console.debug(">> uncaught:exception disabled in cypress/support/index.js");
  return false;  // prevents Cypress from failing the test
});