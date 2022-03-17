describe('Draft Mode', () => {

	before(() => {
		//Reset the projects back to what they should be
		cy.mysql_db('projects/pristine')
	})

	describe('Basic Functionality', () => {

		before(() => {
			//Set standard user
			cy.set_user_type('standard')
		})


		it('Should NOT apply changes made in Draft Mode in real time to the project', () => {
			//Visit Longitudinal Database
			cy.visit_version({page: 'Design/online_designer.php', params: "pid=2"})

			//Enter Draft Mode in the project
			cy.get('input[value="Enter Draft Mode"]').click()

			//Check to see that REDCap indicates we're in DRAFT mode
			cy.get('div#actionMsg').should(($alert) => {
				expect($alert).to.contain('The project is now in Draft Mode.')
			})

		})

		it('Should have the ability to require that changes made to Data Collection instruments in Production Status be made by entering Draft Mode', () => {
			cy.set_user_type('admin')

			//Need to be admin to enter CONTROL CENTER
			cy.visit_version({page: 'ControlCenter/user_settings.php'})

			//Check if we have this ability available in this version of REDCap
			cy.get('table').should(($table) => {
				expect($table).to.contain('General User Settings')
				expect($table).to.contain('Allow production Draft Mode changes to be approved automatically under certain conditions?')
			})

			//Check to see that we have some ability to configure Production Status options
			cy.get('select[name=auto_prod_changes]').should(($select) => {
				expect($select).to.contain('Never')
				expect($select).to.contain('Yes')
			})
		})

		it('Should have the ability to view a detailed summary of the Drafted Changes proposed', () => {
			//Need to first demonstrate that we can make changes
			cy.visit_version({page: 'Design/online_designer.php', params: "pid=2&page=demographics"})

			//Then we can try to view the drafted changes summary
			cy.get('input[value="Add Field"]').then(($i) => {
				$i.first().click()

				cy.get('div').contains("Add New Field").then(($div) => {
					cy.get('div').contains('Field Type:').next().select('text')
					cy.get('input#field_name').type('test_field')
					cy.get('input#field_label_rich_text_checkbox').click()
					cy.get('textarea#field_label').type('Test Field')
					cy.get('button').contains('Save').click()
				})
			})

			//View the detailed summary of Drafted Changes
			cy.get('a').contains('View detailed summary').click().then(() => {

				cy.get('table').should(($table) => {
					expect($table).to.contain('Variable Name')
					expect($table).to.contain('test_field')

					expect($table).to.contain('Field Label')
					expect($table).to.contain('Test Field')

					expect($table).to.contain('Field Type')
					expect($table).to.contain('text')
				})

			})

		})

		describe('Warning Capabilities', () => {

			beforeEach(() => {
				//Seed the db for the project before each test
				cy.mysql_db('projects/project_2')

				//Visit Longitudinal Database
				cy.visit_version({page: 'Design/online_designer.php', params: "pid=2&page=demographics"})
			})


			it('Should have the ability to warn of changes that might cause label mismatches', () => {
				//Select field to edit some choices for
				cy.edit_field_by_label('Ethnicity')

				//Get the field choices and set the new values / labels
				let field_choices = cy.select_field_choices()
				field_choices.clear()
				field_choices.type('0, NEW LABEL 0\n1, NEW LABEL 1\n2, NEW LABEL 2')

				//Save this particular field we are editing
				cy.save_field()

				//View the detailed summary of Drafted Changes
				cy.get('a').contains('View detailed summary').click().then(() => {
					cy.get('table').should(($table) => {
						expect($table).to.contain('ethnicity')
						expect($table).to.contain('NEW LABEL 0')
						expect($table).to.contain('NEW LABEL 1')
						expect($table).to.contain('NEW LABEL 2')
						expect($table).to.contain('Possible label mismatch')
					})
				})
			})

			it('Should have the ability to warn of changes that might cause data loss', () => {
				//Select field to edit some choices for
				cy.edit_field_by_label('Ethnicity')

				//Get the field choices and set the new values / labels
				let field_choices = cy.select_field_choices()
				field_choices.clear()
				field_choices.type('0, Hispanic or Latino\n1, NOT Hispanic or Latino')

				//Save this particular field we are editing
				cy.save_field()

				//View the detailed summary of Drafted Changes
				cy.get('a').contains('View detailed summary').click().then(() => {
					cy.get('table').should(($table) => {
						expect($table).to.contain('ethnicity')
						expect($table).to.contain('Hispanic or Latino')
						expect($table).to.contain('NOT Hispanic or Latino')
						expect($table).to.contain('Data MIGHT be lost due to deleted choice(s)')
					})
				})
			})

			it('Should have the ability to warn of changes that WILL cause data loss', () => {

				//Select field to edit some choices for
				cy.edit_field_by_label('Ethnicity')

				//Get the field choices and set the new values / labels
				let field_choices = cy.select_field_choices()
				field_choices.clear()
				field_choices.type('0, Hispanic or Latino\n2, Unknown / Not Reported')

				//Save this particular field we are editing
				cy.save_field()

				//View the detailed summary of Drafted Changes
				cy.get('a').contains('View detailed summary').click().then(() => {
					cy.get('table').should(($table) => {
						expect($table).to.contain('ethnicity')
						expect($table).to.contain('Hispanic or Latino')
						expect($table).to.contain('NOT Hispanic or Latino')
						expect($table).to.contain('Data MIGHT be lost due to deleted choice(s)')
					})
				})

				//Check to see that REDCap is reporting things data wise for us
				cy.get('button').contains('Compare').click().then(() => {
						cy.get('table').should(($table) => {
							expect($table).to.contain('3')
							expect($table).to.contain('Removed')
							expect($table).to.contain('Unknown / Not Reported')
							expect($table).to.contain('-')
						})
				})
			})
		})


		describe('Change Management', () => {

			let i = 0

			beforeEach(() => {
				//Submit some Changes for Approval
				cy.set_user_type('standard')

				//Seed the db for the project before each test
				cy.mysql_db('projects/project_2')

				//Visit Longitudinal Database
				cy.visit_version({page: 'Design/online_designer.php', params: "pid=2"})

				//Search for the Enter Draft Mode button
				let draft = cy.get('input[value="Enter Draft Mode"]').should(($draft_mode) => {
					if($draft_mode.length > 0){
						$draft_mode.first().click()
					}

					return $draft_mode;
				})

				if(draft.length > 0 ){
					cy.get('div#actionMsg').should(($alert) => {
						expect($alert).to.contain('The project is now in Draft Mode.')
					})
				}

				//Visit the demographics instrument
				cy.visit_version({page: 'Design/online_designer.php', params: "pid=2&page=demographics"})

				//Select field to edit some choices for
				cy.edit_field_by_label('Ethnicity')

				//Get the field choices and set the new values / labels
				let field_choices = cy.select_field_choices()
				field_choices.clear()
				field_choices.type('0, NEW LABEL ' + i + '\n1, NEW LABEL 1' + i + '\n2, NEW LABEL 2' + i)

				//Save this particular field we are editing
				cy.save_field()


				cy.get('input[value="Submit Changes for Review"]').should(($i) => {
					$i.first().click()
				})

				//Submit for Appproval
				cy.get('button').contains('Submit').click()

				//Visit modification panel as admin
				cy.set_user_type('admin')
				cy.visit_version({page: 'Design/project_modifications.php', params: "pid=2"})

				i++

			})

			it('Should have the ability for Administrators to Commit changes that are deemed acceptable', () => {
				//Click COMMIT Changes button and verify notice
				cy.get('button').contains('COMMIT CHANGES').click()
				cy.get('div.ui-dialog-buttonset button').contains('COMMIT CHANGES').click()
				cy.get('body').should(($body) => {
					expect($body).to.contain('Project Changes Committed / User Notified')
				})

			})

			it('Should have the ability for Administrators to Reject changes that are deemed unacceptable', () => {
				//Click Reject Changes button and verify notice
				cy.get('button').contains('Reject Changes').click()
				cy.get('div.ui-dialog-buttonset button').contains('Reject Changes').click()
				cy.get('body').should(($body) => {
					expect($body).to.contain('Project Changes Rejected / User Notified')
				})
			})

			it('Should have the ability for Administrators to Reset and Delete drafted changes if necessary', () => {
				//Click Remove All Changes button and verify notice
				cy.get('button').contains('Remove All Drafted Changes').click()
				cy.get('div.ui-dialog-buttonset button').contains('Remove All Drafted Changes').click()
				cy.get('body').should(($body) => {
					expect($body).to.contain('changes were NOT committed to the project but were removed')
				})
			})

			describe('Notifications', () => {

				it('Should allow an Administrator to send a confirmation email (templated, but editable) to the requestor', () => {
					//Click Remove All Changes button and verify notice
					cy.get('button').contains('Compose confirmation email').click()

					//Check for the telltale signs of an email template
					cy.get('div.ui-dialog').should(($div) => {
						expect($div).to.contain('Compose confirmation email')
						expect($div).to.contain('To:')
						expect($div).to.contain('From:')
						expect($div).to.contain('Subject:')
						expect($div).to.contain('Send Email')
					})

					//Send the email
					cy.get('button.ui-button').contains('Send Email').click()

					//Check to see that REDCap indicates the email was sent
					cy.get('body').should(($body) => {
						expect($body).to.contain('Your email was successfully sent')
					})
				})
			})
		})

		describe('Data Dictionary', () => {

			it('Should record all versions of the Data Dictionary Post-Production Status with Date/Time, Requestor, and Approver', () => {
				//Visit Project Revision history page
				cy.visit_version({page: 'ProjectSetup/project_revision_history.php', params: "pid=2"})

				//These are the changes that should be present from the last test in the series above
				cy.get('body').should(($body) => {
					expect($body).to.contain('Production revision')
					expect($body).to.contain('Requested by')
					expect($body).to.contain('Approved by')
					expect($body).to.contain('Moved to production')
				})
			})
		})

	})

	describe('Control Center', () => {

		before(() => {
			cy.set_user_type('admin')
			cy.visit_version({page: 'ControlCenter/user_settings.php#tr-auto_prod_changes'})

		    	cy.get('select[name="auto_prod_changes"] option').should(($options) => {
		    		window.auto_prod_options = [...$options].map(o => o.text)
		    	})

		    	cy.get('select[name="enable_edit_prod_repeating_setup"] option').should(($options) => {
		    		window.edit_repeating_options = [...$options].map(o => o.text)
		    	})
		})

		it('Should require Administrators to review changes made in Draft Mode based upon the settings configured in Control Center', () => {
			//This is actually implicit to the tests that are covered within Change Management
			//If those tests pass, this test is true as well
		})

		describe('Options for Automatic Approval of Drafted Changes', () => {

			it('Should have the ability to automatically approve changes "Never" (administrator approval required)', () => {
				assert.include(window.auto_prod_options, 'Never (always require an admin to approve changes)')
		    })

			it('Should have the ability to automatically approve changes when No Existing Fields were Modified', () => {
				assert.include(window.auto_prod_options, 'Yes, if no existing fields were modified')
		    })

		    it('Should have the ability to automatically approve changes when No Records present OR Records Present AND No Existing Fields were Modified', () => {
  		    	assert.include(window.auto_prod_options, 'Yes, if project has no records OR if has records and no existing fields were modified')
		    })

		    it('Should have the ability to automatically approve changes when No Critical Issues Exist', () => {
	    	   	assert.include(window.auto_prod_options, 'Yes, if no critical issues exist')
		    })

		    it('Should have the ability to automatically approve changes when No Records present OR Records Present AND No Critical Issues Exist', () => {
	    	 	assert.include(window.auto_prod_options, 'Yes, if project has no records OR if has records and no critical issues exist')
		    })

		})

		describe('Options for Add / Modify Events and Arms', () => {

		    it('Should have the ability to authorize ONLY Administrators to Add / Modify Events in Production Status', () => {
	            assert.include(window.edit_repeating_options, 'No, only Administrators can modify the repeatable instance setup in production')
		    })

		    it('Should have the ability to only authorize Standard Users to Add / Modify Events in Production Status', () => {
	            assert.include(window.edit_repeating_options, 'Yes, normal users can modify the repeatable instance setup in production')
		    })
		})
	})
})