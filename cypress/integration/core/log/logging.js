const ADMIN 	= 'test_admin'
const STANDARD 	= 'test_user'
const STANDARD2 = 'test_user2'
const PID = 23

describe('Logging', () => {

	before(() => {
		// Prepare project
        cy.set_user_type('admin')
		cy.mysql_db('projects/pristine')
        cy.create_cdisc_project('Logging Test', '0', 'cdisc_files/core/logging.xml', PID)
        cy.add_users_to_project([STANDARD, STANDARD2], PID)
		cy.visit_version({page: 'UserRights/index.php', params: `pid=${PID}`})

		// Add User 1
		cy.get(`a.userLinkInTable[userid="${STANDARD}"]`).should('be.visible').click()
		cy.get('div#tooltipBtnSetCustom').should('be.visible').find('button').click()
		cy.get('input[name="design"]').should('be.visible').check({force: true})	// Enable Design Rights
		cy.get('input[name="user_rights"]').check({force: true})					// Enable User Rights
		cy.get('input[name="data_export_tool"][value="1"]').check({force: true})	// Enable Full Data Export
		cy.get('input[name="data_logging"]').check({force: true})					// Enable Logging
		cy.get('input[name="record_delete"]').check({force: true})					// Enable Delete Records
		cy.get('input[name="lock_record_customize"]').should('not.be.checked')		// Record Locking Customization *Disabled*
		cy.get('input[name="lock_record"][value="2"]').should('not.be.checked') 	// Lock/Unlock Records with E-signature authority *Disabled*
		cy.get('input[name="record_create"]').should('be.checked')					// Create Records *Enabled*
		cy.get('.ui-button').contains(/add user|save changes/i).click()
		
		// Add User 2
		cy.get('div.userSaveMsg').should('not.be.visible')
		cy.get(`a.userLinkInTable[userid="${STANDARD2}"]`).should('be.visible').click()
		cy.get('div#tooltipBtnSetCustom').should('be.visible').find('button').click()
		cy.get('input[name="design"]').should('be.visible').check({force: true})	// Enable Design Rights
		cy.get('input[name="user_rights"]').check({force: true})					// Enable User Rights
		cy.get('input[name="data_export_tool"][value="1"]').check({force: true})	// Enable Full Data Export
		cy.get('input[name="data_logging"]').check({force: true})					// Enable Logging
		cy.get('input[name="record_delete"]').check({force: true})					// Enable Delete Records
		cy.get('input[name="lock_record_customize"]').check({force: true})			// Enable Record Locking Customization
		cy.get('input[name="record_create"]').should('be.checked')					// Create Records *Enabled*
		cy.get('input[name="lock_record"][value="2"]').click()						// Enable Lock/Unlock Records with E-signature authority
		
		// This should be avoided if possible
		cy.focused().should('have.text', 'Close').click()
		
		cy.get('.ui-button').contains(/add user|save changes/i).click()

		// Enable E-Signature
		cy.visit_version({page: '/Locking/locking_customization.php', params: `pid=${PID}`})
		cy.get('#savedEsign-text_validation').closest('td').find('input').check()

		cy.move_project_to_production(PID, false)

		///////////////////////////////////////////////////////////////
		// Take all project actions that will be checked in the logs //
		///////////////////////////////////////////////////////////////
		
		// Steps come from manual testing protocol script #23 (Logging)
		cy.set_user_type('standard')

		// Step 3 - Add record
		cy.visit_version({page: 'DataEntry/record_home.php', params: `pid=${PID}`})
		cy.get('button').contains('Add new record').should('be.visible').click()
		cy.get('input[name="ptname"]').type('Test')
		cy.get('input[name="email"').type('test@test.com')
		cy.get('button#submit-btn-dropdown').first().click()
		.closest('div').find('a#submit-btn-savecontinue').should('be.visible').click()
		
		cy.get('input[name="ptname"]').clear().type('Testing')
		cy.get('button#submit-btn-saverecord').first().click()

		// Step 4 - Add new record
		cy.visit_version({page: 'DataEntry/record_home.php', params: `pid=${PID}`})
		cy.get('button').contains('Add new record').should('be.visible').click()
		cy.get('input[name="ptname"]').type('Test2')
		cy.get('input[name="email"').type('test2@test.com')
		cy.get('button#submit-btn-saverecord').first().click()

		// Step 5 - Add new record
		cy.visit_version({page: 'DataEntry/record_home.php', params: `pid=${PID}`})
		cy.get('button').contains('Add new record').should('be.visible').click()
		cy.get('input[name="ptname"]').type('Delete')
		cy.get('input[name="email"').type('delete@test.com')
		cy.get('button#submit-btn-saverecord').first().click()

		// Step 6 - Delete 3rd record
		cy.get('button#recordActionDropdownTrigger').click()
		cy.get('a').contains('Delete record (all forms)').should('be.visible').click()
		cy.get('button').contains('DELETE RECORD').should('be.visible').click()
		// This should be avoided if possible
		cy.focused().should('have.text', 'Close').click()

		// Step 7 - Create user role
		cy.visit_version({page: "UserRights/index.php", params: `pid=${PID}`})
		cy.get('input#new_rolename').should('be.visible').type('Data')
		cy.get('button#createRoleBtn').click()
		cy.get('div#editUserPopup').should('be.visible').parent().find('button').contains("Create role").should('be.visible').click()
		cy.get('div.userSaveMsg').should('not.be.visible')

		// Step 8 - Edit new role
		cy.get('a[title="Edit role privileges"]').contains('Data').should('be.visible').click()
		cy.get('input[name="design"]').should('be.visible').check()
		cy.get('div#editUserPopup').parent().find('button').contains("Save Changes").should('be.visible').click()
		cy.get('div.userSaveMsg').should('not.be.visible')
		cy.get('div#working').should('not.be.visible')

		// Step 9 - Delete new role
		cy.get('a[title="Edit role privileges"]').contains('Data').should('be.visible').click().then(() => {
			cy.get('button').should(($button) => {
				expect($button).to.contain('Delete role')
			})
			cy.get('button').contains("Delete role").click({ force: true })
			cy.get('div[role="dialog"][aria-describedby!="editUserPopup"]').find('button').contains('Delete role').should('be.visible').click()
			cy.get('div.userSaveMsg').should('not.be.visible')
			cy.get('div#working').should('not.be.visible')
		})

		// Steps 10, 11 - Add and edit new user (completed in project setup)

		// Step 12 - Remove user
		cy.get(`a.userLinkInTable[userid="${STANDARD2}"]`).should('be.visible').click()
		cy.get('div#tooltipBtnSetCustom').should('be.visible').find('button').click()
		cy.get('div#editUserPopup').should('be.visible').parent().find('button').contains("Remove user").should('be.visible').click()
		cy.get('span').contains("Remove user?").should('be.visible').closest('div[role="dialog"]').find('button').contains("Remove user").click()
		cy.get('div.userSaveMsg').should('not.be.visible')

		// Step 14 - Export Data
		cy.set_user_type('standard2')

	})

	it('Should have the ability to export the logs to a CSV file', () => {

	})

	describe('Log of User Actions', () => {

		it('Should keep a record of the time / date of user actions', () => {
			
		})

		it('Should keep a record of when a Data Export is performed', () => {

		})

		it('Should keep a record of E-signature events', () => {

		})

		it('Should keep a record of changes to project instruments (Manage / Design)', () => {

		})

	 	describe('Data Recorded', () => {

	    	it('Should keep a record of the username who performed the action', () => {

	    	})

			it('Should keep a record of the specific data change made', () => { 

			})

	    	describe('Updated Data', () => {

	    		it('Should keep a record of the new value for an updated record', () => {

	    		})

	    		it('Should keep a record of the new value for an updated E-signature', () => {

	    		})

	    		it('Should keep a record of the new value for lock/unlock actions', () => {

	    		})

	    	})

    		it('Should keep a record of the fields exported', () => {

    		})

	    })

		describe('Changes to Records', () => {

		    it('Should keep a record of all create actions', () => {
	            
		    })

		    it('Should keep a record of all update actions', () => {
		            
		    })

		    it('Should keep a record of all delete actions', () => {
		            
		    })

		    it('Should keep a record of all record locks', () => {
		            
		    })

		    it('Should keep a record of all record unlocks', () => {
		            
		    })
		   
		})

		describe('Changes to User Roles', () => {

		    it('Should keep a record of all created user roles', () => {
		            
		    })

		    it('Should keep a record of all updated user roles', () => {
		            
		    })

		    it('Should keep a record of all deleted user roles', () => {
		            
		    })
		})

		describe('Changes to Individual User Permissions', () => {

		    it('Should keep a record of all created user permissions', () => {
		            
		    })

		    it('Should keep a record of all updated user permissions', () => {
		            
		    })

		    it('Should keep a record of all deleted user permissions', () => {
		            
		    })
		})	

	})

	describe('Filtering Options', () => {

		describe('By Event Type', () => {

			it('Should allow filtering on ALL Event Types (excluding Page Views)', () => {

			})

			it('Should allow filtering by Data Export type', () => {

			})

			it('Should allow filtering by Manage/Design type', () => {

			})

			it('Should allow filtering by User or Role (created-updated-deleted)', () => {

			})

			it('Should allow filtering by Record (created-updated-deleted)', () => {

			})

			it('Should allow filtering by Record (created only)', () => {

			})

			it('Should allow filtering by Record (updated only)', () => {

			})

			it('Should allow filtering by Record (deleted only)', () => {

			})

			it('Should allow filtering by Record locking and e-signatures', () => {

			})

			it('Should allow filtering by Page Views', () => {

			})	
		})

		describe('By Specific Username', () => {

			it('Should allow filtering by Username (all users for a given study selectable)', () => {

			})	

		})

		describe('By Specific Record', () => {

			it('Should allow filtering by Record (all records for a given study selectable)', () => {

			})				

		})

	})
})