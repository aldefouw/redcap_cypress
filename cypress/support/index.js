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

//Set base URL from the environment variable that was set
Cypress.config("baseUrl", Cypress.env("baseUrl"));

before(() => {

    //Make the setup as fast as possible.  
    //Cypress restarts to set this window.  This appears to prevent the tests from failing first time through as well.
    cy.visit('/')

    //Set the Base URL in the REDCap Configuration Database
    const base_url = 'BASE_URL/' + Cypress.env('baseUrl').replace('http://', 'http\\:\\\\/\\\\/')
    const version = Cypress.env('redcap_version')

    //Create the initial database structure
    cy.mysql_db('structure').then(() => {

        //Seeds the database
        cy.mysql_db('/versions/' + version, base_url).then(() => {

            //Clear out all cookies
            cy.clearCookies()

            const users = Cypress.env("users");
            const admin_user = users['admin']['user'];
            const admin_pass = users['admin']['pass'];

            //Login initially
            cy.login({ username: admin_user, password: admin_pass})

        })

    })
   
})

beforeEach(() => {

   //This should preserve our session because the cookie will be preserved
   cy.maintain_login()

})

Cypress.on("uncaught:exception", (err, runnable) => {
  console.debug(">> uncaught:exception disabled in cypress/support/index.js");
  return false;  // prevents Cypress from failing the test
});