describe('Assign User Rights', () => {
	const project_id = 1

	before(() => {
		cy.set_user_type('admin')
	})

	// describe('Project Level Abilities', () => {
	//
	// 	describe('Add, Edit, and Delete Core User Privileges', () => {
	//
	// 		it('Should have the ability to assign an Expiration Date to User Privileges', () => {
	// 			//Set the test user's access to expire within the admin role
	// 			cy.assign_expiration_date_to_user('test_user', 'Test User', project_id)
	//
	// 			//Now let's login as a standard user and ensure that the expiration did expire
	// 			cy.set_user_type('standard')
	// 			cy.visit_version({page:'index.php', params: 'pid=' + project_id})
	// 			cy.get('html').should(($html) => {
	// 				expect($html).contain('Your access to this particular REDCap project has expired.')
	// 			})
	//
	// 			//Clean up after ourselves by resetting the expiration date
	// 			cy.set_user_type('admin')
	// 			cy.visit_version({page:'index.php', params: 'pid=' + project_id})
	// 			cy.remove_expiration_date_from_user('test_user', 'Test User', project_id)
	// 		})
	//
	// 		describe('Permissions / Abilities', () => {
	//
	// 			it('Should have the ability to grant/restrict Project Design / Setup permission to a user', () => {
	// 				//Remove Project Setup Rights and Verify They're Unavailable
	// 				cy.remove_basic_user_right('test_user', 'Test User', 'Project Design and Setup', project_id)
	// 				cy.verify_user_rights_unavailable('standard', 'ProjectSetup', project_id)
	//
	// 				//Assign User Rights and Verify They're Available
	// 				cy.assign_basic_user_right('test_user', 'Test User', 'Project Design and Setup', project_id)
	// 				cy.verify_user_rights_available('standard', 'ProjectSetup', project_id)
	// 			})
	//
	// 			it('Should have the ability to grant/restrict User Rights permission to a user', () => {
	// 				//Remove Project Setup Rights and Verify They're Unavailable
	// 				cy.remove_basic_user_right('test_user', 'Test User', 'User Rights', project_id)
	// 				cy.verify_user_rights_unavailable('standard', 'UserRights', project_id, false)
	//
	// 				//Assign Project Setup Rights and Verify They're Available
	// 				cy.assign_basic_user_right('test_user', 'Test User', 'User Rights', project_id)
	// 				cy.verify_user_rights_available('standard', 'UserRights', project_id)
	// 			})
	//
	// 			it('Should have the ability to grant/restrict Data Access Groups permission to a user', () => {
	// 				//Remove Project Setup Rights and Verify They're Unavailable
	// 				cy.remove_basic_user_right('test_user', 'Test User', 'Data Access Groups', project_id)
	// 				cy.verify_user_rights_unavailable('standard', 'DataAccessGroups', project_id, false)
	//
	// 				//Assign Project Setup Rights and Verify They're Available
	// 				cy.assign_basic_user_right('test_user', 'Test User', 'Data Access Groups', project_id)
	// 				cy.verify_user_rights_available('standard', 'DataAccessGroups', project_id)
	// 			})
	//
	// 			it('Should have the ability to grant/restrict Data Export Tool permission to a user', () => {
	// 				//"No Access" radio checked
	// 				cy.assign_basic_user_right('test_user', 'Test User', 'Data Exports', project_id, true, 'admin', 'input', '0')
	// 				cy.set_user_type('standard')
	// 				cy.visit_version({page: 'DataExport/index.php', params: 'pid=' + project_id})
	//
	// 				//Don't have a Data Export Button
	// 				cy.get('button').should(($button) => {
	// 					expect($button).to.not.contain('Export Data')
	// 				})
	//
	// 				//"Full Access" radio checked
	// 				cy.assign_basic_user_right('test_user', 'Test User', 'Data Exports', project_id, true, 'admin', 'input', '1')
	// 				cy.set_user_type('standard')
	// 				cy.visit_version({page: 'DataExport/index.php', params: 'pid=' + project_id})
	//
	// 				//Have a Data Export Button
	// 				cy.get('button').should(($button) => {
	// 					expect($button).to.contain('Export Data')
	// 				})
	// 			})
	//
	// 			it('Should have the ability to grant/restrict Add/Edit/Organize Reports permission to a user', () => {
	//
	// 			})
	//
	// 			it('Should have the ability to grant/restrict Manage Survey Participants permission to a user', () => {
	//
	// 			})
	//
	// 			it('Should have the ability to grant/restrict Data Import Tool permission to a user', () => {
	//
	// 			})
	//
	// 			it('Should have the ability to grant/restrict Data Comparison Tool permission to a user', () => {
	//
	// 			})
	//
	// 			it('Should have the ability to grant/restrict Logging permission to a user', () => {
	// 				//Remove Logging Rights and Verify They're Unavailable
	// 				cy.remove_basic_user_right('test_user', 'Test User', 'Logging', project_id)
	// 				cy.verify_user_rights_unavailable('standard', 'Logging', project_id, false)
	//
	// 				//Assign Logging Rights and Verify They're Available
	// 				cy.assign_basic_user_right('test_user', 'Test User', 'Logging', project_id)
	// 				cy.verify_user_rights_available('standard', 'Logging', project_id)
	// 			})
	//
	// 			it('Should have the ability to grant/restrict Data Quality Creation & Execution from permission to a user', () => {
	// 				//Remove Data Quality Tool and Verify They're Unavailable
	// 				cy.remove_basic_user_right('test_user', 'Test User', 'Data Quality ', project_id, 'admin', 'input[name=data_quality_execute]')
	// 				cy.remove_basic_user_right('test_user', 'Test User', 'Data Quality ', project_id, 'admin', 'input[name=data_quality_design]')
	// 				cy.verify_user_rights_unavailable('standard', 'DataQuality', project_id)
	//
	// 				//Assign Data Quality Tool and Verify They're Available
	// 				cy.assign_basic_user_right('test_user', 'Test User', 'Data Quality ', project_id, true, 'admin', 'input[name=data_quality_execute]')
	// 				cy.verify_user_rights_available('standard', 'DataQuality', project_id)
	//
	// 				//Should have a button named "Execute"
	// 				cy.get('button').should(($button) => {
	// 					expect($button).to.contain('Execute')
	// 				})
	//
	// 				//Click on the first Execute Button
	// 				cy.get('button').contains('Execute').first().click()
	//
	// 				cy.get('html').should(($html) => {
	// 					expect($html).to.contain('0')
	// 				})
	//
	// 				cy.set_user_type('admin')
	//
	// 				//Assign Data Quality Tool and Verify They're Available
	// 				cy.assign_basic_user_right('test_user', 'Test User', 'Data Quality ', project_id, true, 'admin', 'input[name=data_quality_design]')
	// 				cy.verify_user_rights_available('standard', 'DataQuality', project_id)
	//
	// 				cy.get('button').should(($button) => {
	// 					expect($button).to.contain('Add')
	// 				})
	//
	// 				cy.get('textarea#input_rulename_id_0').type('A rule name').then(() => {
	// 					cy.get('textarea#input_rulelogic_id_0').type('[first_name] = ""').then(() => {
	// 						cy.get('button').contains('Add').first().click()
	//
	// 						cy.get('html').should(($html) => {
	// 							expect($html).to.contain('A rule name')
	// 						})
	// 					})
	// 				})
	//
	// 			})
	//
	// 			it('Should have the ability to grant/restrict Create Records permission to a user', () => {
	// 				//Remove "Create Record" Rights and Verify They're Unavailable
	// 				cy.remove_basic_user_right('test_user', 'Test User', 'Create Records', project_id)
	//
	// 				//Assign "Create Record" Rights and Verify They're Available
	// 				cy.assign_basic_user_right('test_user', 'Test User', 'Create Records', project_id)
	// 			})
	//
	// 			it('Should have the ability to grant/restrict Rename Records permission to a user', () => {
	// 				//Remove "Rename Record" Rights and Verify They're Unavailable
	// 				cy.remove_basic_user_right('test_user', 'Test User', 'Rename Records', project_id)
	//
	// 				//Assign "Rename Record" Rights and Verify They're Available
	// 				cy.assign_basic_user_right('test_user', 'Test User', 'Rename Records', project_id)
	// 			})
	//
	// 			it('Should have the ability to grant/restrict Delete Records permission to a user', () => {
	// 				//Remove "Delete Record" Rights and Verify They're Unavailable
	// 				cy.remove_basic_user_right('test_user', 'Test User', 'Delete Records', project_id)
	//
	// 				//Assign "Delete Record" Rights and Verify They're Available
	// 				cy.assign_basic_user_right('test_user', 'Test User', 'Delete Records', project_id)
	// 			})
	//
	// 			it('Should have the ability to grant/restrict File Repository permission to a user', () => {
	// 				//Remove File Repository and Verify They're Unavailable
	// 				cy.remove_basic_user_right('test_user', 'Test User', 'File Repository', project_id)
	// 				cy.verify_user_rights_unavailable('standard', 'FileRepository', project_id, false)
	//
	// 				//Assign File Repository and Verify They're Available
	// 				cy.assign_basic_user_right('test_user', 'Test User', 'File Repository', project_id)
	// 				cy.verify_user_rights_available('standard', 'FileRepository', project_id)
	// 			})
	//
	// 			it('Should have the ability to grant/restrict Record Locking Customization permission to a user', () => {
	//
	// 			})
	//
	// 			it('Should have the ability to grant/restrict Lock/Unlock Records permission to a user', () => {
	//
	// 			})
	//
	// 			it('Should have the ability to grant/restrict "Allow Locking of All Forms at once" for a given record to a user', () => {
	//
	// 			})
	// 		})
	// 	})
	//
	// 	describe('Data Entry Form Access Permissions', () => {
	//
	// 		it('Should have the ability to grant/restrict No Access on a per user basis for a given form', () => {
	//
	// 		})
	//
	// 		it('Should have the ability to grant/restrict Read Only Access on a per user basis for a given Form', () => {
	//
	// 		})
	//
	// 		it('Should have the ability to grant/restrict View & Edit Access on a per user basis for a given Form', () => {
	//
	// 		})
	//
	// 		it('Should have the ability to grant/restrict permission to Edit Survey Response on a per user basis for a given form', () => {
	//
	// 		})
	// 	})

		describe('User Roles', () => {

			it('Should have the ability to Create a User Role', () => {
				cy.visit_version({page:'index.php', params: 'pid=' + project_id})

				cy.get('a').contains('User Rights').click()

				cy.get('input#new_rolename').type('New Role')
				cy.get('button').contains('Create role').click().then(() => {

					cy.get('html').should(($html) => {
						expect($html).to.contain('Creating new role "New Role"')
					})

					cy.get('div[role=dialog]').within(() => {
						cy.get('button').contains('Create role').click()
					})

					//Should not display "Working"
					cy.get('div').contains('Working').should('not.be.visible')

					//Should initially be visible
					cy.get('div').contains('Role "New Role" was successfully added').should('be.visible')

					//Should not be visible before we start our next test
					cy.get('div').contains('Role "New Role" was successfully added').should('not.be.visible')
				})

				cy.get('html').should(($html) => {
					expect($html).to.contain('New Role')
				})

			})

			it('Should have the ability to Copy a User Role', () => {

				cy.get('table#table-user_rights_roles_table').within(() => {
					cy.get('div a').contains('New Role').click()
				})

				cy.get('div[role=dialog]').within(() => {
					cy.get('button').contains('Copy role').click()
				})

				cy.get('span').contains('Copy role?').should('be.visible').parent().parent().within(() => {

					cy.get('input').clear().type('New Role - COPY')
					cy.get('button').contains('Copy role').click()


				}).then(() => {

					//Should not display "Working"
					cy.get('div').contains('Working').should('not.be.visible')

					//Should initially be visible
					cy.get('div').contains('Role "New Role - COPY" was successfully added').should('be.visible')

					//Should not be visible before we start our next test
					cy.get('div').contains('Role "New Role - COPY" was successfully added').should('not.be.visible')

					cy.get('html').should(($html) => {
						expect($html).to.contain('Editing existing user role "New Role - COPY"')
						expect($html).to.contain('Save Changes')
					})

					cy.get('button').contains('Save Changes').click()

					//Should not display "Working"
					cy.get('div').contains('Working').should('not.be.visible')

					//Should initially be visible
					cy.get('div').contains('Role "New Role - COPY" was successfully edited').should('be.visible')

					//Should not be visible before we start our next test
					cy.get('div').contains('Role "New Role - COPY" was successfully edited').should('not.be.visible')

				})

			})

			it('Should have the ability to Remove a User Role', () => {
				
			})

			it('Should have the ability to Add a User to a User Role', () => {
				
			})

			it('Should have the ability to Remove a User from a User Role', () => {
				
			})
		})
	// })
})
