describe('Add / Manage Users', () => {

	before(() => {
		cy.set_user_type('admin')
		cy.mysql_db('projects/pristine')
	})

	describe('Control Center', () => {

		describe('Users', () => {

			before(() => {
				cy.visit_version({page: 'ControlCenter/create_user.php'})
			})

			it('Should have the ability to create an individual user', () => {
				cy.get('input#username').type('TestUser1')
				cy.get('input#user_firstname').type('Test')
				cy.get('input#user_lastname').type('User')
				cy.get('input#user_email').type('user@email.com')
				cy.get('input[type="submit"]').click()
				cy.get('div').should(($div) => {
					expect($div).to.contain('User has been successfully saved')
				})

			})

			it('Should have the ability to suspend an individual user', () => {
				cy.visit_version({page: 'ControlCenter/view_users.php'})
				cy.get('input#user_search').type('testuser1')
				cy.get('button#user_search_btn').click()
				cy.get('input[value="Suspend user account"]').click()

				//Check for the telltale signs of the appropriate pop up window
				cy.get('div.ui-dialog').should(($div) => {
					expect($div).to.contain('Success! The user has now been suspended')					
				})

				cy.get('button').contains('Close').click()
				cy.get('a').contains('View User List By Criteria').click()
				cy.get('select#activity-level').select('Suspended users')
				cy.get('button').contains('Display User List').click()
				cy.get('table#sponsorUsers-table').should(($t) => {
					expect($t).to.contain('testuser1')
				})
			})

			it('Should have the ability to unsuspend an individual user', () => {
				cy.visit_version({page: 'ControlCenter/view_users.php'})
				cy.get('input#user_search').type('testuser1')
				cy.get('button#user_search_btn').click()

				//Check to make sure the page has refreshed with user info
				cy.get('table').should(($table) => {
					expect($table).to.contain('User information for')
				})

				cy.get('a').contains('unsuspend user').click()

				//Check for the telltale signs of the appropriate pop up window
				cy.get('div.ui-dialog').should(($div) => {
					expect($div).to.contain('Success! The user has now been unsuspended')					
				})

				cy.get('button').contains('Close').click()
				cy.get('a').contains('View User List By Criteria').click()
				cy.get('select#activity-level').select('Non-suspended users')
				cy.get('button').contains('Display User List').click()
				cy.get('table#sponsorUsers-table').should(($t) => {
					expect($t).to.contain('testuser1')
				})
			})

			

			it('Should have the ability to view all users in a tabular form', () => {
				cy.visit_version({page: 'ControlCenter/view_users.php'})
				cy.get('a').contains('View User List By Criteria').click()
				cy.get('button').contains('Display User List').click()
			})

			it('Should have the ability to search for an individual user', () => {
				cy.visit_version({page: 'ControlCenter/view_users.php'})
				cy.get('input#user_search').type('user-search')
			})

			it('Should have the ability to delete an individual user', () => {
				cy.visit_version({page: 'ControlCenter/create_user.php'})
				cy.get('input#username').type('testuser2')
				cy.get('input#user_firstname').type('test')
				cy.get('input#user_lastname').type('user')
				cy.get('input#user_email').type('user2@email.com')
				cy.get('input[type="submit"]').click()
				
				cy.visit_version({page: 'ControlCenter/view_users.php'})
				cy.get('input#user_search').type('testuser2')
				cy.get('button#user_search_btn').click()

				//Check to make sure the page has refreshed with user info
				cy.get('table').should(($table) => {
					expect($table).to.contain('User information for')
				})

				cy.get('span').contains('Delete user from system').click()

				//Check for the telltale signs of the appropriate pop up window
				cy.get('div.ui-dialog').should(($div) => {
					expect($div).to.contain('has now been removed and deleted')					
				})

				cy.get('button').contains('Close').click()
				cy.get('a').contains('View User List By Criteria').click()
				cy.get('button').contains('Display User List').click()
				cy.get('table#sponsorUsers-table').should(($t) => {
					expect($t).not.to.contain('testuser2')
				})
			})
		})

		describe('Security & Authentication', () => { 

			it('Should have the ability to lock out users after a certain number of failed login attempts', () => {
				cy.visit_version({page: 'ControlCenter/security_settings.php'})
				cy.get('form#form').should(($f) => {
					expect($f).to.contain('Number of failed login attempts before user is locked out')
				})
			})

			it('Should have the ability to specify the amount of time a user will be locked out after failed login attempts', () => {
				cy.visit_version({page: 'ControlCenter/security_settings.php'})
				cy.get('tr#logout_fail_window-tr').within(($tr) => {
					cy.get('input').type('25')
				})
				cy.get('input[value="Save Changes"]').click()
			})
		})
	})
})
