describe('Data Quality', () => {

    before(() => {
        cy.mysql_db('projects/pristine')
        cy.set_user_type('admin')
        cy.visit_version({page: 'DataQuality/index.php', params: 'pid=13'})
    })

    it('Should have default rules available after installation', () => {
        cy.get('table#table-rules').should(($t) => {
            expect($t).to.contain('Missing values*')
            expect($t).to.contain('Field validation errors (out of range)')
            expect($t).to.contain('Incorrect values for calculated fields')
        })

    })

    it('Should have the ability to create a data quality rule', () => {
        cy.get('textarea#input_rulename_id_0').type("new rule")
        cy.get('textarea#input_rulelogic_id_0').type('![my_first_instrument_complete]')
        cy.get('button').contains("Add").click()
        /*
        cy.get('div#rulename_1').should(($div) => {
                expect($div).to.contain('new rule')
            })
        */

        cy.get('table#table-rules').should(($t) => {
            expect($t).to.contain('new rule')
        })

    })

    it('Should have the ability to execute a data quality rule', () => {
        cy.get('div#rulename_1').parent().parent().parent().within(($tr) => {
            cy.get('button').contains('Execute').click()
            cy.get('div#ruleexe_1').should(($div) => {
                expect($div).not.to.contain('Execute')
            })
        })
    })

    it('Should have the ability to execute all data quality rules at the same time', () => {
        cy.get('button').contains('All').click()
        cy.get('table#table-rules').within(($t) => {
            cy.get('div.exebtn').should(($d) => {
                expect($d).not.to.contain('Execute')
            })
        })

    })

    it('Should have the ability to view the discrepancies found during rule execution', () => {
        //cy.get('div#rulename_pd-10').parent().parent().parent().within(($tr) => {
        //  cy.get('button').contains('Execute').click()
        //})
        cy.get('div#rulename_pd-10').parent().parent().parent().within(($d) => {
            cy.get('a').click()
        })
        cy.get('div.ui-dialog').should(($s) => {
            expect($s).to.contain('Discrepancies')
        })

    })

    it('Should have the ability to support the removal of exclusion of discrepancies', () => {
        cy.visit_version({page: 'DataEntry/record_home.php', params: 'pid=13'})
        cy.get('button').contains('Add new record').click()
        //cy.get('select').contains('Incomplete').parent().parent().select()
        cy.get('button#submit-btn-saverecord').first().click()
        cy.visit_version({page: 'DataQuality/index.php', params: 'pid=13'})
        cy.get('div').contains('new rule').parent().parent().parent().within(($d) => {
            cy.get('button').contains('Execute').click()
        })
        cy.wait(100)
        cy.get('div').contains('new rule').parent().parent().parent().within(($d) => {
            cy.get('a').contains('view').should('be.visible').click()
        })



        cy.get('a').contains('exclude').click().then(() => {
            cy.get('table#table-results_table_1').should(($t) => {
                expect($t).to.contain('remove exclusion')
            })

            cy.get('table#table-results_table_1').then(($t) => {
                cy.wrap($t).find('a').contains('remove exclusion').click().then(() => {
                    cy.wrap($t).find('tr').should('have.css', 'background', 'rgb(239, 246, 232) none repeat scroll 0% 0% / auto padding-box border-box')
                })
            })
        })

        cy.get('tr td div a').contains('exclude').click()

        cy.get('button').contains('Close').click()
    })

    it('Should have the ability to clear discrepancies from executed rules', () => {
        cy.get('div').contains('Working').should('not.be.visible')

        cy.get('div').contains('new rule').parent().parent().parent().within(($d) => {
            expect($d).to.contain('Execute')
        })
    })

    it('Should have the ability to limit the viewing of a rule to a specific Data Access Group', () => {

    })

    it('Should have the ability to limit a rule viewing that references a Field for which users do not have User Rights', () => {

    })

    it('Should have the ability to delete a user defined rule', () => {
        cy.get('div#ruledel_1').click().then(() => {
            cy.get('table#table-rules').should(($t) => {
                expect($t).not.to.contain('![my_first_instrument_complete]')
            })
        })

    })

    it('Should have the ability to validate a unique event name used in custom rules for longitudinal projects', () => {
        cy.visit_version({page: 'Design/define_events.php', params: 'pid=13'})
        cy.get('input#descrip').type("new event")
        cy.get('input#addbutton').click()
        cy.wait(100)
        cy.get('input#descrip').type("new event2")
        cy.get('input#addbutton').click()

        cy.visit_version({page: 'Design/designate_forms.php', params: 'pid=13'})
        cy.get('button').contains('Begin editing').click()
        cy.get('input#my_first_instrument--41').check()
        cy.get('button#save_btn').click()
        cy.visit_version({page: 'DataQuality/index.php', params: 'pid=13'})
        cy.get('textarea#input_rulename_id_0').type("event rule")
        cy.get('textarea#input_rulelogic_id_0').type('[new_event_arm_1]')
        cy.get('button').contains("Add").click()
        cy.get('table#table-rules').should(($t) => {
            expect($t).to.contain('event rule')
        })
    })

    it('Should have the ability to execute a custom data quality rule in real time', () => {
        cy.visit_version({page: 'DataQuality/index.php', params: 'pid=13'})
        cy.get('textarea#input_rulename_id_0').parent().parent().parent().parent().should(($tr) => {
            expect($tr).to.contain('Execute in real time')
        })
    })

})