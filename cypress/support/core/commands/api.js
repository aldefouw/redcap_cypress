//#############################################################################
//# Commands       A B C D E F G H I J K L M N O P Q R S T U V W X Y Z        #
//#############################################################################

Cypress.Commands.add('add_api_user_to_project', (username, pid) => {
    cy.visit_version({ page: 'UserRights/index.php', params: 'pid=' + pid}).then(($e) => {

        cy.get('html').should('contain', 'User Rights')

        cy.get('#user_rights_roles_table').then(($r) => {

            //If username has already been added to the project
            if($r[0].innerText.indexOf(username) !== -1){

                cy.access_api_token(pid, username).then(($request) => {
                    return { token: $request }
                })

            } else {

                cy.get('input#new_username', {force: true}).clear({force: true}).type(username, {force: true}).then((element) => {
                    cy.get('button', {force: true}).contains('Add with custom rights').click({force: true}).then(() => {
                        cy.get('input[name=api_export]', {force: true}).click()
                        cy.get('input[name=api_import]', {force: true}).click()

                        cy.get('.ui-button', {force: true}).contains(/add user|save changes/i).click().then(() => {
                            cy.get('table#table-user_rights_roles_table').should(($e) => {
                                expect($e[0].innerText).to.contain(username)
                            })
                        })
                    })
                })

            }
        })
    })
})

Cypress.Commands.add('access_api_token', (pid, user) => {
    // This assumes user already has API token created
    cy.fetch_login().then(($r) => {
        cy.request({ url: `/redcap_v${Cypress.env('redcap_version')}/ControlCenter/user_api_ajax.php?action=viewToken&api_pid=${pid}&api_username=${user}`})
            .then(($token) => {
                return cy.wrap(Cypress.$($token.body).children('div')[0].innerText);
            })
    })
})