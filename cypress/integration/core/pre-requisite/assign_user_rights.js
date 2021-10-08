describe('Assign User Rights', () => {

	before(() => {
		cy.set_user_type('admin')
		cy.visit_version({page:'index.php', params: 'pid=1'})
	})

	describe('Project Level Abilities', () => {

		describe('Add, Edit, and Delete Core User Privileges', () => {

			it('Should have the ability to assign an Expiration Date to User Privileges', () => {
				//Set the test user's access to expire within the admin role
				cy.get('a').contains('User Rights').click()
				cy.get('a').contains('test_user (Test User)').click()
				cy.get('button').contains('Edit user privileges').click()

				cy.get('input.hasDatepicker').click()
				cy.get('a.ui-state-highlight').click()

				cy.get('input#expiration').should(($expiration) => {
					let date = new Date()
					let day = String(date.getDate()).padStart(2, "0");
					let month = String(date.getMonth()+1).padStart(2, "0");
					let year = date.getFullYear();
					let fullDate = `${month}/${day}/${year}`;

					expect($expiration).to.have.value(fullDate)
				})

				cy.get('button').contains('Save Changes').click()

				cy.get('body').should(($body) => {
					expect($body).to.contain('User "test_user" was successfully edited')
				})

				//Now let's login as a standard user and ensure that the expiration did expire
				cy.set_user_type('standard')

				cy.visit_version({page:'index.php', params: 'pid=1'})

				cy.get('html').should(($html) => {
					expect($html).contain('Your access to this particular REDCap project has expired.')
				})

				//Clean up after ourselves by resetting the expiration date
				cy.set_user_type('admin')

				cy.visit_version({page:'index.php', params: 'pid=1'})

				cy.get('a').contains('User Rights').click()
				cy.get('a').contains('test_user (Test User)').click()
				cy.get('button').contains('Edit user privileges').click()

				cy.get('input.hasDatepicker').click().clear()

				cy.get('input#expiration').should(($expiration) => {
					expect($expiration).to.have.value("")
				})

				cy.get('button').contains('Save Changes').click()

				cy.get('body').should(($body) => {
					expect($body).to.contain('User "test_user" was successfully edited')
				})
			})

			describe('Permissions / Abilities', () => {

				it('Should have the ability to grant Project Design / Setup permission to a user', () => {
					//Set the test user's access to expire within the admin role
					cy.get('a').contains('User Rights').click()
					cy.get('a').contains('test_user (Test User)').click()
					cy.get('button').contains('Edit user privileges').click()

					//This will tell us the pop up is there
					cy.get('div').should(($div) => {
						expect($div).to.contain('Editing existing user')
					})

					//Click the Project Design and Setup to uncheck it
					cy.get('td').contains('Project Design and Setup').next().find('input').click()

					cy.get('button').contains('Save Changes').click()

					cy.get('body').should(($body) => {
						expect($body).to.contain('User "test_user" was successfully edited')
					})

					//Now let's login as a standard user and see that we cannot access Project Setup
					cy.set_user_type('standard')

					//Go to the Project Setup page URL
					cy.visit_version({page:'/ProjectSetup/index.php', params: 'pid=1'})

					//But ensure that we're actually redirect to index.php
					cy.url().should('include', `/redcap_v${Cypress.env('redcap_version')}/index.php?pid=1`) // => true
					

					//Clean up after ourselves by resetting the expiration date
					cy.set_user_type('admin')

					cy.visit_version({page:'index.php', params: 'pid=1'})

					cy.get('a').contains('User Rights').click()
					cy.get('a').contains('test_user (Test User)').click()
					cy.get('button').contains('Edit user privileges').click()

					cy.get('input.hasDatepicker').click().clear()

					cy.get('input#expiration').should(($expiration) => {
						expect($expiration).to.have.value("")
					})

					cy.get('button').contains('Save Changes').click()

					cy.get('body').should(($body) => {
						expect($body).to.contain('User "test_user" was successfully edited')
					})
				})

				it('Should have the ability to grant User Rights permission to a user', () => {
					
				})

				it('Should have the ability to grant Data Access Groups permission to a user', () => {
					
				})

				it('Should have the ability to grant Data Export Tool permission to a user', () => {
					
				})

				it('Should have the ability to grant Add/Edit Reports permission to a user', () => {
					
				})

				it('Should have the ability to grant Manage Survey Participants permission to a user', () => {
					
				})

				it('Should have the ability to grant Data Import Tool permissio to a user', () => {
					
				})

				it('Should have the ability to grant Data Comparison Tool permission to a user', () => {
					
				})

				it('Should have the ability to grant Logging permission to a user', () => {
					
				})

				it('Should have the ability to grant Data Quality Tool permission to a user', () => {
					
				})

				it('Should have the ability to grant Create Records permission to a user', () => {
					
				})

				it('Should have the ability to grant Rename Records permission to a user', () => {
					
				})

				it('Should have the ability to grant Delete Records permission to a user', () => {
					
				})

				it('Should have the ability to grant Record Locking Customization permission to a user', () => {
					
				})

				it('Should have the ability to grant Lock/Unlock Records permission to a user', () => {
					
				})

				it('Should have the ability to grant "Allow Locking of All Forms at once" for a given record to a user', () => {
					
				})
			})
		})

		describe('Data Entry Form Access Permissions', () => {

			it('Should have the ability to grant No Access on a per user basis for a given form', () => {
				
			})

			it('Should have the ability to grant Read Only Access on a per user basis for a given Form', () => {
				
			})

			it('Should have the ability to grant View & Edit Access on a per user basis for a given Form', () => {
				
			})

			it('Should have the ability to grant permission to Edit Survey Response on a per user basis for a given form', () => {
				
			})
		})

		describe('User Roles', () => {

			it('Should have the ability to Create a User Role', () => {
				
			})

			it('Should have the ability to Copy a User Role', () => {
				
			})

			it('Should have the ability to Remove a User Role', () => {
				
			})

			it('Should have the ability to Add a User to a User Role', () => {
				
			})

			it('Should have the ability to Remove a User from a User Role', () => {
				
			})
		})
	})
})
