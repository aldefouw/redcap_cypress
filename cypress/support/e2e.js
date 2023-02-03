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

import { core } from './core/index'
import { hooks } from './hooks/index'
import { modules } from './modules/index'
import { plugins } from './plugins/index'
import { projects } from './projects/index'

const sed_lite = require('sed-lite').sed;

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
window.base_url = 'BASE_URL/' + Cypress.config('baseUrl').replace(/\//g, "\\/")

// console.log(`s/${window.base_url}/`)
// console.log('s/BASE_URL/http:\\/\\/localhost:8401/')

//var change_db_name = sed_lite(`s/${window.base_url}/`);

// var change_db_name = sed_lite(`s/${window.base_url}/`)
// console.log(change_db_name("BASE_URL"));

//Set the Base URL in the REDCap Configuration Database
// if(Cypress.config('baseUrl') !== null){
//     const base_url = 'BASE_URL/' + Cypress.config('baseUrl').replace('http://', 'http\\:\\\\/\\\\/')
// } else {
//     alert('baseUrl, which tells REDCap Cypress what URL your REDCap test server is at, is missing from cypress.json.  Please configure it before proceeding.')
// }

before(() => {
    Cypress.Cookies.defaults({
        preserve: ['PHPSESSID', 'redcap_external_module_csrf_token']
    })

    //Intercept all requests sent to Vanderbilt
    cy.intercept({ method: 'GET', url: 'https://redcap.vanderbilt.edu/consortium/collect_stats.php?*'}, []).as('Collect Stats')
    cy.intercept({ method: 'GET', url: '*/consortium/collect_stats.php?*'}, []).as('Stats')
    cy.intercept({ method: 'GET', url: '*/ControlCenter/check_server_ping.php'}, []).as('Ping')
    cy.intercept({ method: 'GET', url: '*/ControlCenter/report_site_stats.php'}, []).as('Control Center Stats')

    //Clear out the cookies
    window.lastCookie = []

    //Cypress Users
    cy.set_user_info(Cypress.env('users'))

    //By default, we are going to login as a standard user
    cy.set_user_type('standard')

    //Create the initial database structure
    cy.base_db_seed()

    // Import the bootstrapping from these files:
    core()          // /support/core/index.js
    hooks()         // /support/hooks/index.js
    modules()       // /support/modules/index.js
    plugins()       // /support/plugins/index.js
    projects()      // /support/projects/index.js
})

beforeEach(() => {
    //Cypress.Cookies.debug()
})

Cypress.on("uncaught:exception", (err, runnable) => {
  console.debug(">> uncaught:exception disabled in cypress/support/e2e.js");
  return false;  // prevents Cypress from failing the test
});

if (Cypress.config('hideXHR')) {
    const app = window.top;

    if (
        app &&
        !app.document.head.querySelector('[data-hide-command-log-request]')
    ) {
        const style = app.document.createElement('style');
        style.innerHTML =
            '.command-name-request, .command-name-xhr { display: none }';
        style.setAttribute('data-hide-command-log-request', '');

        app.document.head.appendChild(style);
    }
}