describe('Data Access Groups (DAGs)', () => {

	before(() => {
		cy.set_user_type('standard')
		cy.mysql_db('projects/pristine')
	})

	describe('User Interface', () => {
		
		before(() => {
			cy.set_user_type('admin')
			cy.visit_version({page: 'DataAccessGroups/index.php', params: 'pid=1'})
		})

		it('Should have the ability to create Data Access Groups', () => {
			cy.get('input#new_group').type('Test Group')
			cy.get('button#new_group_button').click()
			cy.get('div#dags_table').should(($div) => {
				expect($div).to.contain('Test Group')
			})
	    })

	    it('Should have the ability to delete Data Access Groups', () => {
	        cy.get('tr').contains('Test Group').parent().parent().parent().within(($tr) => {
				cy.get('img').click()
			})
			cy.get('button').contains('Delete').click()
			cy.get('div#dags_table').should(($div) => {
				expect($div).not.to.contain('Test Group')
			})
	    })

	    it('Should have the ability to provide a unique Data Access Group name in the data export CSV or label', () => {
			cy.visit_version({page: 'DataAccessGroups/index.php', params: 'pid=13'})
			cy.get('input#new_group').type('t1')
			cy.get('button#new_group_button').click()
			// cy.get('input#new_group').type('Gr2')
			// cy.get('button#new_group_button').click()
			cy.visit_version({page: 'DataExport/index.php', params: 'pid=13'})
			cy.get('button').contains('Export Data').click()
			cy.get('form#exportFormatForm').should(($form) => {
				expect($form).to.contain('Export Data Access Group name for each record (if record is in a group)?')
			})
		})
	})

	describe('Data Restriction Abilities', () => {
		before(() => {
			cy.add_users_to_project(['test_user', 'test_user2'], '13')
			cy.add_users_to_data_access_groups(['Group 1', 'Group 2'], ['test_user', 'test_user2'], '13')
		})

		it('Should have the ability to restrict a user to the data of the same Data Access Group', () => {
			cy.intercept('/redcap_v'+ Cypress.env('redcap_version') +'/DataEntry/index.php?*').as('data_entry')
			cy.intercept('/redcap_v'+ Cypress.env('redcap_version') +'/index.php?*').as('project_setup')

			cy.set_user_type('standard')
			cy.visit_version({page: 'index.php', params: 'pid=13'})
			cy.wait('@project_setup')

			cy.get('a').contains("Add / Edit Records").click()
			
			cy.get('button').contains('Add new record').click()

			cy.wait('@data_entry')

			cy.get('button#submit-btn-saverecord').first().click()

			cy.set_user_type('standard2')
			cy.visit_version({page: 'index.php', params: 'pid=13'})
			cy.get('a').contains("Add / Edit Records").click()
			cy.get('button').contains('Add new record').click()

			cy.get('button#submit-btn-saverecord').click()

			cy.wait('@data_entry')

			cy.get('a').contains('Record Status Dashboard').click()

			cy.get('table#record_status_table').should(($table) => {
				expect($table).not.to.contain('3-1')
				expect($table).to.contain('4-1')
			})

			cy.set_user_type('standard')
			cy.visit_version({page: 'index.php', params: 'pid=13'})
			cy.wait('@project_setup')

			cy.get('a').contains('Record Status Dashboard').click()

			cy.get('table#record_status_table').should(($table) => {
				expect($table).not.to.contain('4-1')
				expect($table).to.contain('3-1')
			})

			cy.set_user_type('admin')
			cy.visit_version({page: 'index.php', params: 'pid=13'})
			cy.wait('@project_setup')

			cy.get('a').contains('Record Status Dashboard').click()

			cy.get('table#record_status_table').should(($table) => {
				expect($table).to.contain('4-1')
				expect($table).to.contain('3-1')
			})

		})
	})
})