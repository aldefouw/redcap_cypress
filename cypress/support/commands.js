// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --

Cypress.Commands.add("login", (options) => {
    cy.request({
        method: 'POST',
        url: '/', // baseUrl is prepended to url
        form: true, // indicates the body should be form urlencoded and sets Content-Type: application/x-www-form-urlencoded headers
        body: {
            'username': options['username'],
            'password': options['password'],
            'submitted': 1,
            'redcap_login_a38us_09i85':'redcap_login_a38us_09i85'
        }
    })
});

Cypress.Commands.add("visit_v", (options) => {
    const redcap_version = Cypress.env("redcap_version");
    cy.visit('/redcap_v' + redcap_version + '/' + options['page'] + '?' + options['params'])
});

Cypress.Commands.add("mysql_db", (type, replace = '') => {
    const mysql = Cypress.env("mysql");

    const cmd = 'sh test_db/db.sh' +
        ' ' + mysql['path'] +
        ' ' + mysql['host'] +
        ' ' + mysql['port'] +
        ' ' + mysql['db_name'] +
        ' ' + mysql['db_user'] +
        ' ' + mysql['db_pass'] +
        ' ' + type +
        ' ' + replace;

    console.log(cmd);

    cy.exec(cmd);
});

Cypress.Commands.add("find_online_designer_field", (name, timeout = 10000) => {
    cy.contains('label', name, { timeout: timeout });
});


Cypress.Commands.add("save_field", () => {
    cy.get('input#field_name').then(() => {
        cy.contains('button', 'Save').click();
    });
});

//
//
// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This is will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })
