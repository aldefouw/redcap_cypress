describe('Assign Super Users / Account Managers', () => {

	before(() => {
		cy.set_user_type('admin')
	})

	describe('Control Center', () => {

		it('Should have the ability to view all current administrators and account managers', () => {
			cy.visit_version({page:''}).then(() => {
				cy.get('a').contains('Control Center').click().then(() => {
					cy.get('div').should(($div) => {
						expect($div).to.contain('Control Center Home')
						expect($div).to.contain('Dashboard')
						expect($div).to.contain('Projects')
						expect($div).to.contain('Users')
						expect($div).to.contain('Miscellaneous Modules')
						expect($div).to.contain('Technical / Developer Tools')
						expect($div).to.contain('System Configuration')
					})
					cy.get('a').contains('Administrators & Acct Managers').click().then(() => {
						cy.get('td').contains('Current Administrators')
						cy.get('td').contains('Current Account Managers')
					})
				})
			})
		})

		it('Should have the ability to grant and revoke administrators and account manager access to the system for individual users', () => {
			cy.visit_version({page: 'ControlCenter/superusers.php'}).then(() => {
				cy.get('#new_super_user').select('test_user').then(() => {
					cy.get('#add_super_user_btn').click().then(() => {
						cy.get('table').should(($table) => {
							expect($table).to.contain('Test User')
						})
					})
				})
			})

			cy.set_user_type('standard').then(() => {
				// LogOut and login again to check if standard user got admin rights
				cy.visit_version({page:''}).then(() => {
					cy.get('a').contains('Control Center').click().then(() => {
						cy.get('a').contains('Administrators & Acct Managers')
					})
				})
			})
	
			cy.set_user_type('admin').then(() => {
				// LogOut and login again as admin to assign to revoke admin rights and give account manager rights
				cy.visit_version({page:'ControlCenter/superusers.php'}).then(() => {
					cy.get('td').contains('test_user').next().click().then(() => {
						cy.get('table').contains('td', 'test_user').should('not.exist')
					})
				})
			})

			cy.set_user_type('standard').then(() => {
				// Login as standard user to check after removing admin access
				cy.visit_version({page:''}).then(() => {
					cy.get('a').should(($a) => {
						expect($a).to.not.contain('Control Center')

					})
				})
			})

			cy.set_user_type('admin').then(() => {
				// Login as admin to assign account manager rights
				cy.visit_version({page:'ControlCenter/superusers.php'}).then(() => {
					cy.get('#new_account_manager').select('test_user').then(() => {
						cy.get('#add_account_manager_btn').click().then(() => {
							cy.get('table').should(($table) => {
								expect($table).to.contain('Test User')
							})
						})
					})
				})
			})

			cy.set_user_type('standard').then(() => {
				// Login to see if account manager rights
				cy.visit_version({page:''}).then(() => {
					cy.get('a').contains('Control Center').click().then(() => {
						cy.get('div').should(($div) => {
							expect($div).to.contain('Browse Users')
							expect($div).to.contain('Add Users')
							expect($div).to.contain('User Whitelist')
							expect($div).to.contain('Email Users')
						})
					})
				})
			})

			cy.set_user_type('admin').then(() => {
				// Login as admin to remove account manager rights
				cy.visit_version({page:'ControlCenter/superusers.php'}).then(() => {
					cy.get('a[onclick="remove_account_manager(\'test_user\');"]').click().then(() => {
						cy.get('tr').contains('Current Account Managers').parent().contains('td', 'Test User').should('not.exist')
					})
				})
			})

			cy.set_user_type('standard').then(() =>{
				// Login as admin to check if user has neither admin rights nor account manager rights
				cy.visit_version({page:''}).then(() => {
					cy.get('a').should(($a) => {
						expect($a).to.not.contain('Control Center')

					})
				})
			})

		})
	})
})