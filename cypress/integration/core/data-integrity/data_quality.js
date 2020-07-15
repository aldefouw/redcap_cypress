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
        cy.get('table#table-rules').should(($t) => {
            expect($t).to.contain('new rule')
        })
        cy.get('div#rulename_1').should(($div) => {
            expect($div).to.contain('new rule')
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
        cy.get('div#ruleexe_pd-10').within(($d) => {
            cy.get('a').click()
        })
        cy.wait(500)
        cy.get('span#ui-id-1').should(($s) => {
            expect($s).to.contain('Discrepancies found:')
        })

    })

	it('Should have the ability to support the removal of exclusion of discrepancies', () => {
            
    })

    it('Should have the ability to clear discrepancies from executed rules', () => {
            
    })

	it('Should have the ability to limit the viewing of a rule to a specific Data Access Group', () => {
            
    })

	it('Should have the ability to limit a rule viewing that references a Field for which users do not have User Rights', () => {
            
    })

	it('Should have the ability to delete a user defined rule', () => {
            
    })

	it('Should have the ability to validate a unique event name used in custom rules for longitudinal projects', () => {
            
    })

	it('Should have the ability to execute a custom data quality rule in real time', () => {
            
    })

})