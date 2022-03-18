describe('Assign User Rights', () => {
	const project_id = 1

	before(() => {
		cy.set_user_type('admin')
	})

	describe('Project Level Abilities', () => {

		describe('Data Entry Form Access Permissions', () => {

			before(() => {
				//Set ourselves as admin initially so we can configure project as necessaryt
				cy.set_user_type('admin')

				//Enable Surveys on the Project
				cy.visit_version({page: 'ProjectSetup/index.php', params:'pid=' + project_id})
				cy.intercept('modify_project_setting_ajax.php?pid=' + project_id).as('enable_survey')
				cy.get('button').contains('Enable').first().click()
				cy.wait('@enable_survey')

				cy.get('body').should(($body) => {
					expect($body).to.contain('Main project settings')
				})

				//Visit the Online Designer
				cy.visit_version({page: 'Design/online_designer.php', params:'pid=' + project_id}).then(() => {
					cy.get('body').should(($body) => {
						expect($body).to.contain('Data Collection Instruments')
					})
				})

				//Enable the First Data Collection Instrument as a Survey
				cy.get('button').contains('Enable').click()
				cy.get('button').contains('Save Changes').click()

				//After survey settings are saved, we can move onto the next step
				cy.get('div').contains('Your survey settings were successfully saved').should('be.visible')
				cy.get('div').contains('Your survey settings were successfully saved').should('not.be.visible')

				//Remove the survey editing rights
				cy.change_survey_edit_rights(project_id, 'test_user', 'Demographics')

				//Complete the survey
				cy.visit_version({page: 'index.php', params: 'pid=' + project_id})
				cy.get('a').contains('Survey Distribution Tools').click()
				cy.get('div').contains('Public Survey URL').parent().find('input').then(($input) => {
					cy.visit_base({ url: $input[0].value }).then(() => {
						cy.get('button').contains('Submit').click().then(() => {
							cy.get('html').then(($html) => {
								expect($html).to.contain('Thank you for taking the survey.')
							})
						})
					})
				})
			})

			it('Should have the ability to grant/restrict No Access on a per user basis for a given form', () => {
				cy.set_user_type('admin')
				cy.assign_form_rights(project_id, 'test_user', 'Demographics', 'No Access')

				//Verify standard user does not have edit rights
				cy.set_user_type('standard')

				//Visit the data entry page and see appropriate messages
				cy.visit_version({page: 'DataEntry/index.php', params:'pid=' + project_id + '&id=1&event_id=1&page=demographics'})
				cy.get('html').should(($html) => {
					expect($html).to.contain('ACCESS DENIED')
				})
			})

			it('Should have the ability to grant/restrict Read Only Access on a per user basis for a given Form', () => {
				cy.set_user_type('admin')
				cy.assign_form_rights(project_id, 'test_user', 'Baseline Data', 'Read Only')

				//Verify standard user does not have edit rights
				cy.set_user_type('standard')

				//Visit the data entry page and see appropriate messages
				cy.visit_version({page: 'DataEntry/index.php', params:'pid=' + project_id + '&id=1&event_id=1&page=baseline_data'})

				//Should be no "Save" button at the bottom since we're read only on the form
				cy.get('button').should(($button) => {
					expect($button).not.to.contain('Save')
				})
			})

			it('Should have the ability to grant/restrict View & Edit Access on a per user basis for a given Form', () => {
				cy.set_user_type('admin')
				cy.assign_form_rights(project_id, 'test_user', 'Baseline Data', 'View & Edit')

				//Visit the data entry page and see appropriate messages
				cy.visit_version({page: 'DataEntry/index.php', params:'pid=' + project_id + '&id=1&event_id=1&page=baseline_data'})

				//Should be no "Save" button at the bottom since we're read only on the form
				cy.get('button').should(($button) => {
					expect($button).to.contain('Save')
				})
			})

			it('Should have the ability to grant/restrict permission to Edit Survey Response on a per user basis for a given form', () => {
				cy.set_user_type('admin')
				cy.assign_form_rights(project_id, 'test_user', 'Demographics', 'View & Edit')

				//Verify standard user does not have edit rights
				cy.set_user_type('standard')

				//Visit the data entry page and see appropriate messages
				cy.visit_version({page: 'DataEntry/index.php', params:'pid=' + project_id + '&id=1&event_id=1&page=demographics'})
				cy.get('html').should(($html) => {
					expect($html).to.contain('Survey response is read-only')
					expect($html).to.contain('You have not been given permission to edit survey responses.')
				})
			})
		})

		describe('Add, Edit, and Delete Core User Privileges', () => {

			it('Should have the ability to assign an Expiration Date to User Privileges', () => {
				//Set the test user's access to expire within the admin role
				cy.assign_expiration_date_to_user('test_user', 'Test User', project_id)

				//Now let's login as a standard user and ensure that the expiration did expire
				cy.set_user_type('standard')
				cy.visit_version({page:'index.php', params: 'pid=' + project_id})
				cy.get('html').should(($html) => {
					expect($html).contain('Your access to this particular REDCap project has expired.')
				})

				//Clean up after ourselves by resetting the expiration date
				cy.set_user_type('admin')
				cy.visit_version({page:'index.php', params: 'pid=' + project_id})
				cy.remove_expiration_date_from_user('test_user', 'Test User', project_id)
			})

			describe('Permissions / Abilities', () => {

				it('Should have the ability to grant/restrict Project Design / Setup permission to a user', () => {
					//Remove Project Setup Rights and Verify They're Unavailable
					cy.remove_basic_user_right('test_user', 'Test User', 'Project Design and Setup', project_id)
					cy.verify_user_rights_unavailable('standard', 'ProjectSetup', project_id)

					//Assign User Rights and Verify They're Available
					cy.assign_basic_user_right('test_user', 'Test User', 'Project Design and Setup', project_id)
					cy.verify_user_rights_available('standard', 'ProjectSetup', project_id)
				})

				it('Should have the ability to grant/restrict User Rights permission to a user', () => {
					//Remove Project Setup Rights and Verify They're Unavailable
					cy.remove_basic_user_right('test_user', 'Test User', 'User Rights', project_id)
					cy.verify_user_rights_unavailable('standard', 'UserRights', project_id, false)

					//Assign Project Setup Rights and Verify They're Available
					cy.assign_basic_user_right('test_user', 'Test User', 'User Rights', project_id)
					cy.verify_user_rights_available('standard', 'UserRights', project_id)
				})

				it('Should have the ability to grant/restrict Data Access Groups permission to a user', () => {
					//Remove Project Setup Rights and Verify They're Unavailable
					cy.remove_basic_user_right('test_user', 'Test User', 'Data Access Groups', project_id)
					cy.verify_user_rights_unavailable('standard', 'DataAccessGroups', project_id, false)

					//Assign Project Setup Rights and Verify They're Available
					cy.assign_basic_user_right('test_user', 'Test User', 'Data Access Groups', project_id)
					cy.verify_user_rights_available('standard', 'DataAccessGroups', project_id)
				})

				it('Should have the ability to grant/restrict Data Export Tool permission to a user', () => {
					//"No Access" radio checked
					cy.assign_basic_user_right('test_user', 'Test User', 'Data Exports', project_id, true, 'admin', 'input', '0')
					cy.set_user_type('standard')
					cy.visit_version({page: 'DataExport/index.php', params: 'pid=' + project_id})

					//Don't have a Data Export Button
					cy.get('button').should(($button) => {
						expect($button).to.not.contain('Export Data')
					})

					//"Full Access" radio checked
					cy.assign_basic_user_right('test_user', 'Test User', 'Data Exports', project_id, true, 'admin', 'input', '1')
					cy.set_user_type('standard')
					cy.visit_version({page: 'DataExport/index.php', params: 'pid=' + project_id})

					//Have a Data Export Button
					cy.get('button').should(($button) => {
						expect($button).to.contain('Export Data')
					})
				})

				it('Should have the ability to grant/restrict Add/Edit/Organize Reports permission to a user', () => {

					//If someone is NOT allowed to Add/Edit/Organize, then they can still VIEW reports
					//Should NOT be able to see "Create New Report"
					cy.remove_basic_user_right('test_user', 'Test User', 'Add/Edit/Organize Reports', project_id)

					//Login in as standard user
					cy.set_user_type('standard')
					cy.visit_version({page: 'DataExport/index.php', params: 'pid=' + project_id})

					cy.get('html').should(($html) => {
						//There should be no "Create New Report"
						expect($html).not.to.contain('Create New Report')

						//There should be a "View Report"
						expect($html).to.contain('View Report')
					})

					//If someone is allowed to Add/Edit/Organize, then they can "Create New Report"
					cy.assign_basic_user_right('test_user', 'Test User', 'Add/Edit/Organize Reports', project_id)

					//Login in as standard user
					cy.set_user_type('standard')
					cy.visit_version({page: 'DataExport/index.php', params: 'pid=' + project_id})

					cy.get('html').should(($html) => {
						//There should be no "Create New Report"
						expect($html).to.contain('Create New Report')

						//There should be a "View Report"
						expect($html).to.contain('View Report')
					})

				})

				it('Should have the ability to grant/restrict Manage Survey Participants permission to a user', () => {
					//Set admin to change the survey status
					cy.set_user_type('admin')

					//Enable Surveys on the Project
					cy.visit_version({page: 'ProjectSetup/index.php', params:'pid=' + project_id})

					cy.intercept('modify_project_setting_ajax.php?pid=' + project_id).as('enable_survey')
					cy.get('button').contains('Enable').first().click()
					cy.wait('@enable_survey')

					cy.set_user_type('standard')

					//Remove the right from standard user
					cy.remove_basic_user_right('test_user', 'Test User', 'Survey Distribution Tools', project_id)

					//Login in as standard user
					cy.set_user_type('standard')
					cy.visit_version({page: 'index.php', params: 'pid=' + project_id})

					//Should not see "Survey Distribution Tools"
					cy.get('html').should(($html) => {
						expect($html).not.to.contain('Survey Distribution Tools')
					})

					//Remove the right from standard user
					cy.assign_basic_user_right('test_user', 'Test User', 'Survey Distribution Tools', project_id)

					//Login in as standard user
					cy.set_user_type('standard')
					cy.visit_version({page: 'index.php', params: 'pid=' + project_id})

					//Should not see "Survey Distribution Tools"
					cy.get('html').should(($html) => {
						expect($html).to.contain('Survey Distribution Tools')
					})
				})

				it('Should have the ability to grant/restrict Data Import Tool permission to a user', () => {
					//Remove the right from standard user
					cy.remove_basic_user_right('test_user', 'Test User', 'Data Import Tool', project_id)

					//Login in as standard user
					cy.set_user_type('standard')
					cy.visit_version({page: 'index.php', params: 'pid=' + project_id})

					//Should not see "Data Import Tool"
					cy.get('html').should(($html) => {
						expect($html).not.to.contain('Data Import Tool')
					})

					//Remove the right from standard user
					cy.assign_basic_user_right('test_user', 'Test User', 'Data Import Tool', project_id)

					//Login in as standard user
					cy.set_user_type('standard')
					cy.visit_version({page: 'index.php', params: 'pid=' + project_id})

					//Should not see "Data Import Tool"
					cy.get('html').should(($html) => {
						expect($html).to.contain('Data Import Tool')
					})
				})

				it('Should have the ability to grant/restrict Data Comparison Tool permission to a user', () => {
					//Remove the right from standard user
					cy.remove_basic_user_right('test_user', 'Test User', 'Data Comparison Tool', project_id)

					//Login in as standard user
					cy.set_user_type('standard')
					cy.visit_version({page: 'index.php', params: 'pid=' + project_id})

					//Should not see "Data Comparison Tool"
					cy.get('html').should(($html) => {
						expect($html).not.to.contain('Data Comparison Tool')
					})

					//Remove the right from standard user
					cy.assign_basic_user_right('test_user', 'Test User', 'Data Comparison Tool', project_id)

					//Login in as standard user
					cy.set_user_type('standard')
					cy.visit_version({page: 'index.php', params: 'pid=' + project_id})

					//Should not see "Data Comparison Tool"
					cy.get('html').should(($html) => {
						expect($html).to.contain('Data Comparison Tool')
					})
				})

				it('Should have the ability to grant/restrict Logging permission to a user', () => {
					//Remove Logging Rights and Verify They're Unavailable
					cy.remove_basic_user_right('test_user', 'Test User', 'Logging', project_id)
					cy.verify_user_rights_unavailable('standard', 'Logging', project_id, false)

					//Assign Logging Rights and Verify They're Available
					cy.assign_basic_user_right('test_user', 'Test User', 'Logging', project_id)
					cy.verify_user_rights_available('standard', 'Logging', project_id)
				})

				it('Should have the ability to grant/restrict Data Quality Creation & Execution from permission to a user', () => {
					//Remove Data Quality Tool and Verify They're Unavailable
					cy.remove_basic_user_right('test_user', 'Test User', 'Data Quality ', project_id, 'admin', 'input[name=data_quality_execute]')
					cy.remove_basic_user_right('test_user', 'Test User', 'Data Quality ', project_id, 'admin', 'input[name=data_quality_design]')
					cy.verify_user_rights_unavailable('standard', 'DataQuality', project_id)

					//Assign Data Quality Tool and Verify They're Available
					cy.assign_basic_user_right('test_user', 'Test User', 'Data Quality ', project_id, true, 'admin', 'input[name=data_quality_execute]')
					cy.verify_user_rights_available('standard', 'DataQuality', project_id)

					//Should have a button named "Execute"
					cy.get('button').should(($button) => {
						expect($button).to.contain('Execute')
					})

					//Click on the first Execute Button
					cy.get('button').contains('Execute').first().click()

					cy.get('html').should(($html) => {
						expect($html).to.contain('0')
					})

					//Set the user type first
					cy.set_user_type('admin')

					//Need to visit the page after we've set the Admin user type
					cy.visit_version({page:'index.php', params: 'pid='+project_id})

					//Assign Data Quality Tool and Verify They're Available
					cy.assign_basic_user_right('test_user', 'Test User', 'Data Quality ', project_id, true, 'admin', 'input[name=data_quality_design]')
					cy.verify_user_rights_available('standard', 'DataQuality', project_id)

					cy.get('button').should(($button) => {
						expect($button).to.contain('Add')
					})

					cy.get('textarea#input_rulename_id_0').type('A rule name').then(() => {
						cy.get('textarea#input_rulelogic_id_0').type('[first_name] = ""').then(() => {
							cy.get('button').contains('Add').first().click()

							cy.get('html').should(($html) => {
								expect($html).to.contain('A rule name')
							})
						})
					})

				})

				it('Should have the ability to grant/restrict Create Records permission to a user', () => {
					//Remove "Create Record" Rights and Verify They're Unavailable
					cy.remove_basic_user_right('test_user', 'Test User', 'Create Records', project_id)

					//Assign "Create Record" Rights and Verify They're Available
					cy.assign_basic_user_right('test_user', 'Test User', 'Create Records', project_id)
				})

				it('Should have the ability to grant/restrict Rename Records permission to a user', () => {
					//Remove "Rename Record" Rights and Verify They're Unavailable
					cy.remove_basic_user_right('test_user', 'Test User', 'Rename Records', project_id)

					//Assign "Rename Record" Rights and Verify They're Available
					cy.assign_basic_user_right('test_user', 'Test User', 'Rename Records', project_id)
				})

				it('Should have the ability to grant/restrict Delete Records permission to a user', () => {
					//Remove "Delete Record" Rights and Verify They're Unavailable
					cy.remove_basic_user_right('test_user', 'Test User', 'Delete Records', project_id)

					//Assign "Delete Record" Rights and Verify They're Available
					cy.assign_basic_user_right('test_user', 'Test User', 'Delete Records', project_id)
				})

				it('Should have the ability to grant/restrict File Repository permission to a user', () => {
					//Remove File Repository and Verify They're Unavailable
					cy.remove_basic_user_right('test_user', 'Test User', 'File Repository', project_id)
					cy.verify_user_rights_unavailable('standard', 'FileRepository', project_id, false)

					//Assign File Repository and Verify They're Available
					cy.assign_basic_user_right('test_user', 'Test User', 'File Repository', project_id)
					cy.verify_user_rights_available('standard', 'FileRepository', project_id)
				})

				it('Should have the ability to grant/restrict Record Locking Customization permission to a user', () => {
					//Remove the right from standard user
					cy.remove_basic_user_right('test_user', 'Test User', 'Record Locking Customization', project_id)

					//Login in as standard user
					cy.set_user_type('standard')

					//Attempt to visit the page where Record Locking Customizations happen
					cy.visit_version({page: 'Locking/locking_customization.php', params: 'pid=' + project_id})

					//Should see ACCESS DENIED
					cy.get('html').should(($html) => {
						expect($html).to.contain('ACCESS DENIED')
					})

					//Remove the right from standard user
					cy.assign_basic_user_right('test_user', 'Test User', 'Record Locking Customization', project_id)

					//Login in as standard user
					cy.set_user_type('standard')

					//Attempt to visit the page where Record Locking Customizations happen
					cy.visit_version({page: 'Locking/locking_customization.php', params: 'pid=' + project_id})

					//Should not see "ACCESS DENIED" but should see "Record Locking"
					cy.get('html').should(($html) => {
						expect($html).not.to.contain('ACCESS DENIED')
						expect($html).to.contain('Record Locking Customization')
					})
				})

				it('Should have the ability to grant/restrict Lock/Unlock Records permission to a user', () => {

					//Remove the right from standard user
					cy.remove_basic_user_right('test_user', 'Test User', 'Record Locking Customization', project_id)

					//This uses the "assigning" method, but it's actually setting it to "Disabled"
					cy.assign_basic_user_right('test_user', 'Test User', 'Lock/Unlock Records', project_id, true, 'admin', 'input', '0')

					//Login in as standard user
					cy.set_user_type('standard')

					//Attempt to visit the page where Record Locking Customizations happen
					cy.visit_version({page: 'Locking/esign_locking_management.php', params: 'pid=' + project_id})

					//Should see ACCESS DENIED
					cy.get('html').should(($html) => {
						expect($html).to.contain('ACCESS DENIED')
					})

					//Assigns right to standard user for Record Lock/Unlock
					cy.assign_basic_user_right('test_user', 'Test User', 'Lock/Unlock Records', project_id, true, 'admin', 'input', '1')

					//Login in as standard user
					cy.set_user_type('standard')

					//Attempt to visit the page where Record Locking Customizations happen
					cy.visit_version({page: 'Locking/esign_locking_management.php', params: 'pid=' + project_id})

					//Should not see "ACCESS DENIED" but should see "Record Locking"
					cy.get('html').should(($html) => {
						expect($html).not.to.contain('ACCESS DENIED')
						expect($html).to.contain('Record Locking and E-signature Functionality')
					})

				})

				it('Should have the ability to grant/restrict "Allow Locking of All Forms at once" for a given record to a user', () => {
					cy.set_user_type('admin')

					//create record
					cy.visit_version({page: 'DataEntry/index.php', params: 'pid=' + project_id + '&id=1&event_id=1&page=demographics&auto=1'})
					cy.get('button').contains('Save & Exit Form').click()

					//enable locking
					cy.assign_basic_user_right('test_user', 'Test User', 'Lock/Unlock Records', project_id, true, 'admin', 'input', '1')

					//add ability to lock all forms at once
					cy.assign_basic_user_right('test_user', 'Test User', 'Allow locking of all forms at once for a given record?', project_id)

					//login as standard user
					cy.set_user_type('standard')

					//test lock all forms
					cy.visit_version({page: 'DataEntry/record_home.php', params: 'pid=' + project_id + '&arm=1&id=1'})

					//test unlock all forms
					cy.get('button').contains('Choose action for record').click()
					cy.get('a').should('contain', 'Lock all instruments')
					cy.get('a').contains('Lock all instruments').click()

					//verify that each form is locked
					cy.visit_version({page: 'DataEntry/index.php', params: 'pid=' + project_id + '&id=1&event_id=1&page=demographics&instance=1'})
					cy.get('html').should(($html) => {
						expect($html).to.contain('Locked by test_user')
					})

					cy.visit_version({page: 'DataEntry/index.php', params: 'pid=' + project_id + '&id=1&event_id=1&page=baseline_data&instance=1'})
					cy.get('html').should(($html) => {
						expect($html).to.contain('Locked by test_user')
					})

					cy.visit_version({page: 'DataEntry/index.php', params: 'pid=' + project_id + '&id=1&event_id=1&page=month_1_data&instance=1'})
					cy.get('html').should(($html) => {
						expect($html).to.contain('Locked by test_user')
					})

					cy.visit_version({page: 'DataEntry/index.php', params: 'pid=' + project_id + '&id=1&event_id=1&page=month_2_data&instance=1'})
					cy.get('html').should(($html) => {
						expect($html).to.contain('Locked by test_user')
					})

					cy.visit_version({page: 'DataEntry/index.php', params: 'pid=' + project_id + '&id=1&event_id=1&page=month_3_data&instance=1'})
					cy.get('html').should(($html) => {
						expect($html).to.contain('Locked by test_user')
					})

					cy.visit_version({page: 'DataEntry/index.php', params: 'pid=' + project_id + '&id=1&event_id=1&page=completion_data&instance=1'})
					cy.get('html').should(($html) => {
						expect($html).to.contain('Locked by test_user')
					})

					//now unlock all pages
					cy.visit_version({page: 'DataEntry/record_home.php', params: 'pid=' + project_id + '&arm=1&id=1'})

					//test unlock all forms
					cy.get('button').contains('Choose action for record').click()
					cy.get('a').should('contain', 'Unlock all instruments')
					cy.get('a').contains('Unlock all instruments').click()

					//verify that each form is locked
					cy.visit_version({page: 'DataEntry/index.php', params: 'pid=' + project_id + '&id=1&event_id=1&page=demographics&instance=1'})
					cy.get('html').should(($html) => {
						expect($html).not.to.contain('Locked by test_user')
					})

					cy.visit_version({page: 'DataEntry/index.php', params: 'pid=' + project_id + '&id=1&event_id=1&page=baseline_data&instance=1'})
					cy.get('html').should(($html) => {
						expect($html).not.to.contain('Locked by test_user')
					})

					cy.visit_version({page: 'DataEntry/index.php', params: 'pid=' + project_id + '&id=1&event_id=1&page=month_1_data&instance=1'})
					cy.get('html').should(($html) => {
						expect($html).not.to.contain('Locked by test_user')
					})

					cy.visit_version({page: 'DataEntry/index.php', params: 'pid=' + project_id + '&id=1&event_id=1&page=month_2_data&instance=1'})
					cy.get('html').should(($html) => {
						expect($html).not.to.contain('Locked by test_user')
					})

					cy.visit_version({page: 'DataEntry/index.php', params: 'pid=' + project_id + '&id=1&event_id=1&page=month_3_data&instance=1'})
					cy.get('html').should(($html) => {
						expect($html).not.to.contain('Locked by test_user')
					})

					cy.visit_version({page: 'DataEntry/index.php', params: 'pid=' + project_id + '&id=1&event_id=1&page=completion_data&instance=1'})
					cy.get('html').should(($html) => {
						expect($html).not.to.contain('Locked by test_user')
					})

					//remove ability to lock all forms at once
					cy.set_user_type('admin')

					//add ability to lock all forms at once
					cy.remove_basic_user_right('test_user', 'Test User', 'Allow locking of all forms at once for a given record?', project_id)

					//change back to standard user
					cy.set_user_type('standard')

					//verify that the abilty to lock/unlock the forms no longer exists
					cy.visit_version({page: 'DataEntry/record_home.php', params: 'pid=' + project_id + '&arm=1&id=1'})

					//test unlock all forms
					cy.get('button').contains('Choose action for record').click()

					//Make sure we don't get the option to lock/unlock
					cy.get('a').should(($a) => {
						expect($a).not.to.contain('Lock all instruments')
						expect($a).not.to.contain('Unlock all instruments')
					})

				})
			})
		})



		describe('User Roles', () => {

			before(() => {
				cy.set_user_type('admin')
				cy.visit_version({page:'index.php', params: 'pid=' + project_id})
				cy.get('a').contains('User Rights').click()
			})

			it('Should have the ability to Create a User Role', () => {
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
				cy.get('table#table-user_rights_roles_table').within(() => {
					cy.get('a').contains('New Role - COPY').click()
				})

				cy.get('div[role=dialog]').within(() => {
					cy.get('button').contains('Delete role').click()
				})

				cy.get('span').contains('Delete role?').should('be.visible').parent().parent().within(() => {
					cy.get('button').contains('Delete role').click()
				}).then(() => {
					//Should not display "Working"
					cy.get('div').contains('Working').should('not.be.visible')

					//Should initially be visible
					cy.get('div').contains('Role "New Role - COPY" was successfully deleted').should('be.visible')

					//Should not be visible before we start our next test
					cy.get('div').contains('Role "New Role - COPY" was successfully deleted').should('not.be.visible')
				})

			})

			it('Should have the ability to Add a User to a User Role', () => {
				cy.get('table#table-user_rights_roles_table').within(() => {
					cy.get('a').contains('test_user').click()
				})

				cy.get('div').contains('User actions:').parent().within(() => {
					cy.get('button').contains('Assign to role').click()
				})

				cy.get('a').contains('New Role').click()

				//Should not display "Working"
				cy.get('div').contains('Working').should('not.be.visible')

				//Should initially be visible
				cy.get('div').contains('User "test_user" has been successfully ASSIGNED to the user role "New Role".').should('be.visible')

				//Should not be visible before we start our next test
				cy.get('div').contains('User "test_user" has been successfully ASSIGNED to the user role "New Role".').should('not.be.visible')
			})

			it('Should have the ability to Remove a User from a User Role', () => {
				cy.get('table#table-user_rights_roles_table').within(() => {
					cy.get('a').contains('test_user').click()
				})

				cy.get('div').contains('User actions:').parent().within(() => {
					cy.get('button').contains('Remove from role').click()
				})

				//Should not display "Working"
				cy.get('div').contains('Working').should('not.be.visible')

				//Should initially be visible
				cy.get('div').contains('User "test_user" has been successfully REMOVED from their user role.').should('be.visible')

				//Should not be visible before we start our next test
				cy.get('div').contains('User "test_user" has been successfully REMOVED from their user role.').should('not.be.visible')

				//Should check to make sure the notice shows up
				cy.get('html').should(($html) => {
					expect($html).to.contain("NOTICE: User's privileges will remain the same")
				})
			})
		})
	})
})
