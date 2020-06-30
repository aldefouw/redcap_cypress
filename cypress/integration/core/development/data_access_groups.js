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

	    it('Should have the ability to assign data instruments to a specific Data Access Group', () => {
	    	
		})
	})

	    describe('Data Restriction Abilities', () => {
			before(() => {
				cy.visit_version({page: 'UserRights/index.php', params: 'pid=13'})
				cy.get('input#new_username').type('test_admin')
				cy.get('button#addUserBtn').click()
				cy.wait(1000)
				cy.get('button').contains('Add user').click()
				
				cy.wait(1000)
				cy.get('input#new_username').type('test_user2')
				cy.get('button#addUserBtn').click()
				cy.wait(1000)
				cy.get('button').contains('Add user').click()

				cy.visit_version({page: 'DataAccessGroups/index.php', params: 'pid=13'})
				cy.get('input#new_group').type('Gr1')
				cy.get('button#new_group_button').click()
				cy.wait(1000)
				cy.get('input#new_group').type('Gr2')
				cy.get('button#new_group_button').click()
				cy.wait(1000)
				cy.get('select#group_users').select('test_user')
				cy.wait(1000)
				cy.get('select#groups').select('Gr1')
				cy.get('button#user_group_button').click()
				cy.wait(1000)
				cy.get('select#group_users').select('test_user2')
				cy.wait(1000)
				cy.get('select#groups').select('Gr2')
				cy.get('button#user_group_button').click()	
			})

		    it('Should have the ability to restrict a user to the data they entered', () => {
				
		    })

		    it('Should have the ability to restrict a user to the data of the same Data Access Group', () => {
				cy.set_user_type('standard')  
				cy.visit_version({page: 'index.php', params: 'pid=13'})
				cy.get('a').contains("Add / Edit Records").click()
				cy.get('button').contains('Add new record').click()
				cy.get('button#submit-btn-saverecord').click()
				cy.set_user_type('standard2')
				cy.visit_version({page: 'index.php', params: 'pid=13'})
				cy.get('a').contains("Add / Edit Records").click()
				cy.get('button').contains('Add new record').click()
				cy.get('button#submit-btn-saverecord').click()
				cy.get('a').contains('Record Status Dashboard').click()
				cy.get('table#record_status_table').should(($table) => {
					expect($table).not.to.contain('3-1')
					expect($table).to.contain('4-1')
				})
				cy.set_user_type('standard') 
				cy.visit_version({page: 'index.php', params: 'pid=13'})
				cy.get('a').contains('Record Status Dashboard').click()
				cy.get('table#record_status_table').should(($table) => {
					expect($table).not.to.contain('4-1')
					expect($table).to.contain('3-1')
				})
				cy.set_user_type('admin')
				cy.visit_version({page: 'index.php', params: 'pid=13'})
				cy.get('a').contains('Record Status Dashboard').click()
				cy.get('table#record_status_table').should(($table) => {
					expect($table).to.contain('4-1')
					expect($table).to.contain('3-1')
				})
		    })

	    })
	}) 
