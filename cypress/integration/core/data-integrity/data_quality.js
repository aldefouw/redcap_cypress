describe('Data Quality', () => {

    before(() => {
        cy.mysql_db('projects/pristine')
        cy.set_user_type('admin')
        cy.visit_version({page: 'DataQuality/index.php', params: 'pid=13'})
    })

    it('Should have default rules available after installation', () => {
        cy.get('table#table-rules').should(($t) => {
            expect($t).to.contain('Missing values*')
            expect($t).to.contain('Missing values* (required fields only)')
            expect($t).to.contain('Field validation errors (incorrect data type)')
            expect($t).to.contain('Field validation errors (out of range)')
            expect($t).to.contain('Outliers for numerical fields')
            expect($t).to.contain('Hidden fields that contain values***')
            expect($t).to.contain('Multiple choice fields with invalid values')
            expect($t).to.contain('Incorrect values for calculated fields')
        })

    })

    it('Should have the ability to create a data quality rule', () => {
        cy.intercept({  method: 'POST',
                        url: '/redcap_v' + Cypress.env('redcap_version') + '/DataQuality/edit_rule_ajax.php?pid=13'
                     }).as('add_rule')

        cy.get('div').contains('name for new rule').parentsUntil('td').find('textarea').type('new rule')
        cy.get('div').contains('logic for new rule').parentsUntil('td').find('textarea').type('![my_first_instrument_complete]')
        cy.get('button').contains("Add").click()

        cy.wait('@add_rule')

        cy.get('table#table-rules').should(($t) => {
            expect($t).to.contain('new rule')
        })
    })

    it('Should have the ability to execute a data quality rule', () => {
        cy.intercept({  method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/DataQuality/execute_ajax.php?pid=13'
        }).as('execute_rule')

        cy.get('table#table-rules').within(($t) => {
            cy.get('div').contains('new rule').parentsUntil('tr').last().parent().find('button').contains('Execute').click()
            cy.wait('@execute_rule')
            expect($t).to.contain(0)
        })
    })

    it('Should have the ability to execute all data quality rules at the same time', () => {
        cy.intercept({  method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/DataQuality/execute_ajax.php?pid=13'
        }).as('execute_rule')

        //Execute all of the rules
        cy.get('button').contains('All').click()

        //Cycle through number of rows
        cy.get('table#table-rules').find('tr').each(($tr, index, $list) => {

            cy.wrap($tr).within((tr) => {

                if(index < ($list.length - 1)) {
                    //Check that the AJAX request is done on every single instance of execution
                    cy.wait('@execute_rule')

                    //Make sure the execute button goes away and is replaced by the number of detected quality issues
                    cy.get('div.exebtn').should(($d) => {
                        expect($d).not.to.contain('Execute')
                        expect($d).to.contain('0')
                    })
                }

            })
        })

    })

    it('Should have the ability to view the discrepancies found during rule execution', () => {
        cy.visit_version({page: 'DataEntry/record_home.php', params: 'pid=13'})
        cy.get('button').contains('Add new record').click()

        cy.get('button#submit-btn-saverecord').first().click()

        cy.visit_version({page: 'DataQuality/index.php', params: 'pid=13'})

        //Execute the rules
        cy.get('button').contains('All').click()

        //Make sure that the 1 discrepancy is found and that we can view a window with discrepancies
        cy.get('div').contains('new rule').parent().parent().parent().within(($d) => {

            cy.get('div.exebtn').should(($d) => {
                expect($d).to.contain('1')
            })

            cy.get('a').contains('view').should('be.visible').click()
        })

        //Let's see the discrepancies
        cy.get('div.ui-dialog').should(($s) => {
            expect($s).to.contain('Discrepancies')
        })
    })

    it('Should have the ability to support the removal of exclusion of discrepancies', () => {
        cy.intercept({  method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/DataQuality/execute_ajax.php?pid=13'
        }).as('execute_rule')

        cy.intercept({  method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/DataQuality/exclude_result_ajax.php?pid=13&instance=0&repeat_instrument='
        }).as('exclude_result')

        cy.get('div').contains('new rule').parent().parent().parent().within(($d) => {

            cy.get('div.exebtn').should(($d) => {
                expect($d).not.to.contain('Execute')
                expect($d).to.contain('1')
                expect($d).to.contain('view')
            }).then(() => {
                cy.get('a').contains('view').click({force: true})
            })
        })

        cy.get('a').contains('exclude').click().then(() => {
            cy.get('table#table-results_table_1').should(($t) => {
                expect($t).to.contain('remove exclusion')
            })

            cy.get('table#table-results_table_1').then(($t) => {
                cy.wrap($t).find('a').contains('remove exclusion').click().then(() => {
                    cy.wrap($t).find('tr').should('have.css', 'background', 'rgb(239, 246, 232) none repeat scroll 0% 0% / auto padding-box border-box')
                })

                cy.wrap($t).find('a').contains('exclude').click()
            })
        })

        cy.get('button').contains('Close').click()

        //Make sure the last test is completed
        cy.wait('@exclude_result')
    })

    it('Should have the ability to clear discrepancies from executed rules', () => {
        cy.intercept({  method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/DataQuality/execute_ajax.php?pid=13'
        }).as('execute_rule')

        //Check the rules table and find there is still 1 discrepancy
        cy.get('div').contains('new rule').parent().parent().parent().within(($d) => {
            cy.get('div.exebtn').should(($d) => {
                expect($d).to.contain('1')
            })
        })

        //Clear the rules
        cy.get('button').contains('Clear').click()

        //Execute all of the rules
        cy.get('button').contains('All').click()

        //Cycle through number of rows and find there are no discrepancies now
        cy.get('table#table-rules').find('tr').each(($tr, index, $list) => {

            cy.wrap($tr).within((tr) => {

                if(index < ($list.length - 1)) {
                    //Check that the AJAX request is done on every single instance of execution
                    cy.wait('@execute_rule')

                    //Make sure the execute button goes away and is replaced by the number of detected quality issues
                    cy.get('div.exebtn').should(($d) => {
                        expect($d).not.to.contain('Execute')
                        expect($d).to.contain('0')
                    })
                }

            })
        })
    })

    it('Should have the ability to limit a rule viewing that references a Field for which users do not have User Rights', () => {

        // === START: Setup of User Rights
        cy.intercept({  method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/UserRights/edit_user.php?*'
        }).as('user_rights')

        cy.intercept({  method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/DataQuality/execute_ajax.php?*'
        }).as('execute_rule')

        cy.visit_version({page: 'UserRights/index.php', params: 'pid=13'})
        cy.get('a').contains('Test User').click()
        cy.get('button').contains('Edit user privileges').click()

        cy.wait('@user_rights')

        cy.get('div').should('contain', 'Editing existing user "test_user')

        cy.get('td').contains('My First Instrument').parent().find('input[type=radio]').first().click()
        cy.get('button').contains('Save Changes').click()
        cy.get('body').should(($body) => {
            expect($body).to.contain('User "test_user" was successfully edited')
        })
        // === END: Setup of User Rights

        //Set the user to be a standard user
        cy.set_user_type('standard')

        //Visit the Data Quality page as standard user
        cy.visit_version({page: 'DataQuality/index.php', params: 'pid=13'})

        //If we execute this rule we should get an ERROR because we do not have rights to this as the standard user
        cy.get('table#table-rules').within(($t) => {
            cy.get('div').contains('new rule').parentsUntil('tr').last().parent().find('button').contains('Execute').click()
            cy.wait('@execute_rule')
        })

        //Check to see that ERROR is present in the table
        cy.get('div').contains('new rule').parent().parent().parent().within(($d) => {
            cy.get('div.exebtn').should(($d) => {
                expect($d).to.contain('ERROR')
            })

            //Click view to trigger the table
            cy.get('a').contains('view').should('be.visible').click()

        }).then(() => {
            cy.get('div#results_table_1').contains('You do not have access rights to some of the fields used in the logic')
            cy.set_user_type('admin')
        })

    })

    it('Should have the ability to delete a user defined rule', () => {
        cy.visit_version({page: 'DataQuality/index.php', params: 'pid=13'})

        cy.get('table#table-rules').
            find('div').
            contains('new rule').
            parentsUntil('tr').
            last().
            parent().
            find('img').last().click().then(() => {
                cy.get('table#table-rules').should(($t) => {
                    expect($t).not.to.contain('![my_first_instrument_complete]')
                })
        })

    })

    it('Should have the ability to limit the viewing of a rule to a specific Data Access Group', () => {

        // === START: Setup of DAG
        cy.intercept({  method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/DataQuality/execute_ajax.php?pid=13'
        }).as('execute_rule')

        cy.visit_version({page: 'DataAccessGroups/index.php', params: 'pid=13'})
        cy.get('input#new_group').type('Test DAG Group')
        cy.get('button#new_group_button').click()
        cy.get('div#dags_table').should(($div) => {
            expect($div).to.contain('Test DAG Group')
        })

        cy.visit_version({page: 'DataEntry/record_home.php', params: "pid=13&page=my_first_instrument&id=1&event_id=41&auto=1"}).then(() => {
            cy.get('div').contains('Assign record to a Data Access Group?').find('select').select('1')
            cy.get('button').contains('Save & Exit Form').click()
        })
        // === END: Setup of DAG

        //Go back to the Data Quality page
        cy.visit_version({page: 'DataQuality/index.php', params: 'pid=13'})

        //See that we have a column that contains Test DAG Group
        cy.get('tr').contains('Test DAG Group')

        //Re-execute the tests
        cy.get('button').contains('All').click()

        //Check to see that zeroes are showing up within that column
        cy.get('table#table-rules').find('tr').each(($tr, index, $list) => {

            cy.wrap($tr).within((tr) => {

                if(index < ($list.length - 1)) {
                    //Check that the AJAX request is done on every single instance of execution
                    cy.wait('@execute_rule')

                    //Make sure the execute button goes away and is replaced by the number of detected quality issues
                    cy.get('[id^=ruleexe]').should(($d) => {
                        expect($d).to.contain('0')
                    })
                }

            })
        })
    })

    it('Should have the ability to validate a unique event name used in custom rules for longitudinal projects', () => {
        cy.intercept({  method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/DataQuality/edit_rule_ajax.php?pid=13'
        }).as('add_rule')

        cy.intercept({  method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/DataQuality/execute_ajax.php?pid=13'
        }).as('execute_rule')

        cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/Design/designate_forms_ajax.php').as('designate_forms')

        cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/Design/define_events_ajax.php?*').as('define_events')

        cy.visit_version({page: 'Design/define_events.php', params: 'pid=13'})

        cy.get('input#descrip').type('Event 2')
        cy.get('input#addbutton').click()
        cy.wait('@define_events')

        cy.visit_version({page: 'Design/designate_forms.php', params: 'pid=13'})

        cy.get('body').should(($body) => {
            expect($body).to.contain('Begin Editing')
        })

        cy.get('button').contains('Begin Editing').click().then(() => {
            cy.get('td').contains('My First Instrument').parent().within(() => {
                cy.get('input#my_first_instrument--41').check()
            })

            cy.get('button#save_btn').click().then(() => {

                cy.wait('@designate_forms')

                cy.get('tr td').contains('My First Instrument').parent().within(($p) => {
                    cy.wrap($p).find('img#img--my_first_instrument--41')
                })
            })
        })

        cy.visit_version({page: 'DataQuality/index.php', params: 'pid=13'})
        cy.get('textarea#input_rulename_id_0').type("event rule")

        cy.get('textarea#input_rulelogic_id_0').type('[event_2_arm_1][record_id] != 0')
        cy.get('button').contains("Add").click()

        cy.wait('@add_rule')

        cy.get('table#table-rules').should(($t) => {
            expect($t).to.contain('event rule')
        })

        cy.get('div').contains('event rule').parentsUntil('tr').last().parent().find('button').contains('Execute').click()

        cy.wait('@execute_rule')
    })

    it('Should have the ability to execute a custom data quality rule in real time', () => {
        cy.visit_version({page: 'DataQuality/index.php', params: 'pid=13'})
        cy.get('textarea#input_rulename_id_0').parent().parent().parent().parent().should(($tr) => {
            expect($tr).to.contain('Execute in real time')
        })
    })

})