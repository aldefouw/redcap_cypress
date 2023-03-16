//#############################################################################
//# Commands       A B C D E F G H I J K L M N O P Q R S T U V W X Y Z        #
//#############################################################################

Cypress.Commands.add('add_users_to_data_access_groups', (groups = [], usernames = [], project_id) => {
    cy.visit_version({page: 'DataAccessGroups/index.php', params: 'pid=' + project_id})
    cy.server()

    //Add each access for ecah user group specified
    for (var i = 0; i < groups.length; i++) {

        let cur_group = groups[i]
        let cur_user = usernames[i]

        cy.get('input#new_group').type(cur_group)
        cy.get('button#new_group_button').click()
        cy.get('table#table-dags_table').should(($table) => {
            expect($table).to.contain(cur_group)
        })

        cy.route({method: 'GET',
            url: '**/DataAccessGroups/data_access_groups_ajax.php?pid=' + project_id + '&action=select_group&user=' + cur_user}).as('user_ajax')

        cy.get('select#group_users').select(cur_user)

        //Wait for the query to finish first before we proceed
        cy.wait('@user_ajax')

        cy.route({method: 'GET',
            url: '**/DataAccessGroups/data_access_groups_ajax.php?pid=' + project_id + '&action=add_user&user=' + cur_user + '&group_id=*'}).as('group_ajax')


        cy.get('select#groups').select(cur_group)
        cy.get('button#user_group_button').click()

        //Wait for the query to finish first before we proceed
        cy.wait('@group_ajax')
    }
})

Cypress.Commands.add('add_users_to_project', (usernames = [], project_id) => {
    cy.visit_version({page: 'UserRights/index.php', params: 'pid=' + project_id})

    //Add each username specified
    for(var username of usernames){
        cy.get('input#new_username',).type(username, {force: true})
        cy.get('button#addUserBtn').click({force: true})
        cy.get('div#editUserPopup').should(($div) => {
            expect($div).to.be.visible
        })

        let button_label = /(Save Changes|Add user)/

        cy.get('button').contains(button_label).click()
        cy.get('div#working').should(($div) => {
            expect($div).to.not.be.visible
        })
    }
})

Cypress.Commands.add('assign_basic_user_right', (username, proper_name, rights_to_assign, project_id , assign_right = true, user_type = 'admin', selector = 'input', value = null) => {
    let user_has_rights_assigned = Cypress.$("a:contains(" + JSON.stringify(username + ' (' + proper_name + ')') + ")");

    if (!user_has_rights_assigned.length){
        cy.get('input#new_username', {force: true}).clear({force: true}).type(username, {force: true}).then((element) => {
            cy.get('button', {force: true}).contains('Add with custom rights').click({force: true}).then(() => {
                cy.get('div[role="dialog"]', {force: true}).find('button').contains(/add user|save changes/i).click().then(() => {
                    cy.get('table#table-user_rights_roles_table').should(($e) => {
                        expect($e[0].innerText).to.contain(username)
                    })
                })
            })
        })
    }

    cy.get('a').contains(username + ' (' + proper_name + ')').click()

    cy.get('button').contains('Edit user privileges').click()

    cy.get('div').should(($div) => { expect($div).to.contain('Editing existing user') })

    if(rights_to_assign === "Expiration Date"){

        console.log("VALUE: " + assign_right)

        if(assign_right === true){
            cy.get('input.hasDatepicker').click()
            cy.get('table.ui-datepicker-calendar').should('be.visible')
            cy.get('a.ui-state-highlight').click()

            let date = new Date()
            let day = String(date.getDate()).padStart(2, "0");
            let month = String(date.getMonth()+1).padStart(2, "0");
            let year = date.getFullYear();
            let expired_year = String(year - 1); //We are subtracting one year, so we know it's expired
            let fullDate = `${month}/${day}/${year}`;

            //Validate that we set today's date by clicking on highlight in datepicker
            cy.get('input#expiration').should(($expiration) => {
                expect($expiration).to.have.value(fullDate)
            })

            cy.get('table.ui-datepicker-calendar').should('not.be.visible')

            cy.get('input.hasDatepicker').click()

            cy.get('table.ui-datepicker-calendar').should('be.visible')

            cy.get('select.ui-datepicker-year').scrollIntoView().should('be.visible').select(expired_year)

            //Select the first date from the month we are on
            cy.get('.ui-state-default').first().click()

            let expiredDate = `${month}/01/${expired_year}`;

            //Validate that we set an expired date
            cy.get('input#expiration').should(($expiration) => {
                expect($expiration).to.have.value(expiredDate)
            })

            cy.get('button').contains(/add user|save changes/i).click()

            cy.get('body').should(($body) => {
                expect($body).to.contain('User "' + username + '" was successfully edited')
            })

            //Should not be visible before we start our next test
            cy.get('div').contains('User "' + username + '" was successfully edited').should('not.be.visible')

            cy.get('body').should(($body) => {
                expect($body).to.contain(expiredDate)
            })

        } else {

            console.log('Remove expiration date')

            cy.get('input.hasDatepicker').click().clear()
            cy.get('input#expiration').should(($expiration) => {
                expect($expiration).to.have.value("")
            })
            cy.get('button').contains(/add user|save changes/i).click()
            cy.get('body').should(($body) => {
                expect($body).to.contain('User "' + username + '" was successfully edited')
            })
            //Should not be visible before we start our next test
            cy.get('div').contains('User "' + username + '" was successfully edited').should('not.be.visible')
        }

    } else {

        function check_or_uncheck_right($obj, rights_to_assign, assign_right){
            let check_info = ' RIGHT: ' + rights_to_assign + " | " + 'CHECKED? ' + Cypress.$($obj).is(":checked") + ' | ASSIGN RIGHT: ' + assign_right

            //If value is NOT checked and we want to assign the right
            if(!Cypress.$($obj).is(":checked") && assign_right){
                console.log('VALUE NOT CHECKED |' + check_info)
                $obj.click()
                //If value is checked and we want to REMOVE the right
            }else if(Cypress.$($obj).is(":checked") && !assign_right){
                console.log('VALUE CHECKED |' + check_info)
                $obj.click()
            } else {
                console.log('OTHER CONDITION |' + check_info)
            }

        }

        if(value !== null) selector = `${selector}[value='${value}']`

        cy.get('td').contains(rights_to_assign).then(($element) => {

            if($element.length > 0){

                //If we're in the TD cell, we can shortcut to the selector we're looking for
                if($element[0].tagName === 'TD'){

                    check_or_uncheck_right($element.next('td').find(selector), rights_to_assign, assign_right)

                    //If we're NOT in the TD cell, let's move out until TR and then find the selector in the next TD
                } else {
                    check_or_uncheck_right($element.parentsUntil('tr').next('td').find(selector), rights_to_assign, assign_right)
                }
            }
        })
    }

    if(rights_to_assign !== "Expiration Date") {

        console.log('Save changes non expiration date')

        cy.get('button').contains(/add user|save changes/i).click()

        cy.get('body').should(($body) => {
            expect($body).to.contain('User "' + username + '" was successfully edited')
        })

        //Should not be visible before we start our next test
        cy.get('div').contains('User "' + username + '" was successfully edited').should('not.be.visible')
    }
})

Cypress.Commands.add('assign_form_rights', (pid, username, form, rights_level) => {
    //Visit the version specified
    cy.visit_version({page:'index.php', params: 'pid=' + pid})
    cy.get('a').contains('User Rights').click()

    //Click on the user's name
    cy.get('table#table-user_rights_roles_table').within(() => {
        cy.get('a').contains(username).click()
    })

    //Edit the user's privileges
    cy.get('div').contains('User actions:').parent().within(() => {
        cy.get('button').contains('Edit user privileges').click()
    })

    //Should not display "Working"
    cy.get('div').contains('Working').should('not.be.visible')

    //Assign User Rights
    cy.get('table#form_rights').within(() => {
        let input_value = null;

        if(rights_level === "No Access"){
            input_value = 0;
        } else if (rights_level === "Read Only") {
            input_value = 2;
        } else if (rights_level === "View & Edit") {
            input_value = 1;
        } else {
            alert(`You set the rights level to ${rights_level} for #assign_form_rights.  This is invalid.  Please use 'No Access', 'Read Only', or 'View & Edit'`)
        }

        cy.get('td').contains(form).parent().find(`input[value=${input_value}]`).click()
    })

    //Click Save
    cy.get('button').contains('Save Changes').click()

    //User was successfully edited
    cy.get('body').should(($body) => {
        expect($body).to.contain('User "' + username + '" was successfully edited')
    })

    //Should not be visible before we start our next step or test
    cy.get('div').contains('User "' + username + '" was successfully edited').should('not.be.visible')
})

Cypress.Commands.add('assign_expiration_date_to_user', (username, proper_name) => {
    cy.assign_basic_user_right(username, proper_name, "Expiration Date", null, true)
})

Cypress.Commands.add('change_survey_edit_rights', (pid, username, form) => {
    //Visit the version specified
    cy.visit_version({page:'index.php', params: 'pid=' + pid})
    cy.get('a').contains('User Rights').click()

    //Click on the user's name
    cy.get('table#table-user_rights_roles_table').within(() => {
        cy.get('a').contains(username).click()
    })

    //Edit the user's privileges
    cy.get('div').contains('User actions:').parent().within(() => {
        cy.get('button').contains('Edit user privileges').click()
    })

    //Should not display "Working"
    cy.get('div').contains('Working').should('not.be.visible')

    //Assign User Rights
    cy.get('table#form_rights').within(() => {
        cy.get('td').contains(form).parent().find(`input[type=checkbox]`).click()
    })

    //Click Save
    cy.get('button').contains('Save Changes').click()

    //User was successfully edited
    cy.get('body').should(($body) => {
        expect($body).to.contain('User "' + username + '" was successfully edited')
    })

    //Should not be visible before we start our next step or test
    cy.get('div').contains('User "' + username + '" was successfully edited').should('not.be.visible')
})

Cypress.Commands.add('remove_basic_user_right', (username, proper_name, rights_to_assign, user_type = 'admin', selector = 'input', value = null) => {
    cy.assign_basic_user_right(username, proper_name, rights_to_assign, null, false, user_type, selector, value)
})

Cypress.Commands.add('remove_expiration_date_from_user', (username, proper_name) => {
    cy.assign_basic_user_right(username, proper_name, "Expiration Date", null, false)
})

Cypress.Commands.add('remove_users_from_project', (usernames = [], project_id) => {
    cy.visit_version({page: 'UserRights/index.php', params: `pid=${project_id}`}).then(() => {
        for (let username of usernames) {
            cy.get(`a.userLinkInTable[userid="${username}"]`).should('be.visible').click().then(() => {

                cy.get('div#tooltipBtnSetCustom').should('be.visible').find('button').click().then(() => {

                    cy.get('button:contains("Remove user")').should('be.visible').click().then(() => {

                        cy.get('span').contains('Remove user?').parent().parent().find('button:contains("Remove user")').should('be.visible').click({force: true})

                        cy.get('div#working').should(($div) => {
                            expect($div).to.not.be.visible
                        })

                    })
                })
            })
        }
    })
})

Cypress.Commands.add('verify_user_rights_available', (user_type, path, pid) => {
    //Set user type we're checking permissions for
    cy.set_user_type(user_type)

    //Attempt to go to the path
    cy.visit_version({page: path + '/index.php', params: 'pid=' + pid})

    //We should be able to visit it
    cy.url().should('include', `/redcap_v${Cypress.env('redcap_version')}/${path}/index.php?pid=${pid}`)
})

Cypress.Commands.add('verify_user_rights_unavailable', (user_type, path, pid, redirect = true) => {
    //Set user type we're checking permissions for
    cy.set_user_type(user_type)

    //Attempt to go to the path
    cy.visit_version({page: path + '/index.php', params: 'pid=' + pid})

    //But ensure that we're actually redirect to index.php
    if(redirect){
        cy.url().should('include', `/redcap_v${Cypress.env('redcap_version')}/index.php?pid=`+ pid)

        //Otherwise do we get access denied?
    } else {
        cy.get('body').should(($body) => {
            expect($body).to.contain('ACCESS DENIED')
        })
    }

})