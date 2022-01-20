import { Given } from "cypress-cucumber-preprocessor/steps";

Given("I visit the public survey URL for Project ID {int}", (project_id) => {
    //Get the public survey URL as an admin so we know survey tools are available
    cy.set_user_type('admin')

    //Visit the project ID specified
    cy.visit_version({page: 'index.php', params: 'pid=' + project_id})

    //Look for the name of the Distribution Tools for a Survey
    cy.get('a').contains('Survey Distribution Tools').click()

    //Get the Public Survey URL block
    cy.get('div').contains('Public Survey URL').parent().find('input').then(($input) => {
        return $input[0].value
    }).then(($url) => {

        //Make sure we aren't logged in
        cy.logout()

        //Now we can visit the URL as an external user
        cy.visit_base({ url: $url })
    })


})

Given("I enter {string} into the {string} survey text input field", (text, field) => {
    cy.get('label').contains(field).then(($label) => {
        let table_row = $label.parentsUntil('tr').parent().first()
        cy.get(table_row).within(($s) => { cy.get('input').type(text) })
    })
})