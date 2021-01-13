describe('Design Forms using Data Dictionary & Online Designer', () => {

	before(() => {
		//Reset the projects back to what they should be
		cy.mysql_db('projects/pristine')

		//Set the standard user permission
		cy.set_user_type('standard')

		//Go to the main page of the project
		cy.visit_version({page: 'index.php', params: "pid=13"})
	})

	describe('Prerequisite', () => {

		it('Should contain Project Setup permissions for current user', () => {
			cy.get('a').contains('User Rights').click()

			cy.get('div#user_rights_roles_table').should(($table) => {
				expect($table).to.contain('test_user (Test User)')
			})
		})

	})

	describe('Project Setup', () => {

		before(() => {
			cy.visit_version({page: '/ProjectSetup/index.php', params: "pid=13"})
		})

		it('Should show the project without surveys', () => {
			cy.get('div').contains('Use surveys in this project?').parent().within(($div) => {
				cy.get('button').contains('Disable').then(($button) => {
					cy.wrap($button).click().then(($b) => {
						//Fetch the button again by making a jQuery request
						let updated_button = Cypress.$($b)
						cy.get(updated_button).should('contain', 'Disable')
					})
				})
			})
		})

		it ('Should show the project in development mode', () => {
			cy.get('div.menubox').should(($div) => {
				expect($div).to.contain('Project status')
				expect($div).to.contain('Development')
			})
		})

		it('Should show the appropriate options for viewing and designing your data collection instruments', () => {
			cy.visit_version({page: '/ProjectSetup/index.php', params: "pid=13"})

			// Online Designer
			cy.get('button').contains('Online Designer')

			// Data Dictionary
			cy.get('button').contains('Data Dictionary')

			// REDCap Shared Library
			cy.get('button').contains('REDCap Shared Library')

			// Download PDF of all instruments
			cy.get('a').contains('Download PDF of all instruments')

			// Download current data dictionary
			cy.get('a').contains('Download the current Data Dictionary')

			// Check for identifiers
			cy.get('a').contains('Check For Identifiers')
		})

	})

	describe('Online Designer', () => {

		before(() => {
			//Visit Classic Database
			cy.visit_version({page: 'Design/online_designer.php', params: "pid=13"})
		})


		describe('Data Collection Instruments', () => {

			before(() => {
				cy.visit_version({page: 'Design/online_designer.php', params: "pid=13"})
			})

			it('Should allow a new instrument to be created', () => {
				cy.get('div').
				contains('a new instrument from scratch').
				parent().
				within(($div) => {

					cy.get('button').contains('Create').click()

				})

				cy.get('button').contains('Add instrument here').click()

				cy.get('td').contains('New instrument name').parent().within(($td) => {
					cy.get('input[type=text]', {force: true}).type('My Second Instrument')
					cy.get('input[value=Create]', {force: true}).click()
				})

				cy.get('span').should(($span) => {
					expect($span).to.contain('My Second Instrument')
				})
			})

			it('Should allow an instrument to be renamed', () => {
				cy.get('span').contains('My Second Instrument').parents('tr').children('td').last().within(($td) => {
					cy.get('button').contains('Choose action').click()
				})

				cy.get('a').should('contain', 'Rename')
				cy.get('a').contains('Rename').click()

				cy.get('input[value="My Second Instrument"]').then(($i) => {
					cy.wrap($i).clear().type('My Renamed Instrument')

					cy.wrap($i).parent('div').should(($div) => {

						//If there are three inputs, we know that things have finished loading
						expect($div.children()).to.have.length(3)

						//There might be a more elegant way to select this, but this works for now
						$div.children('input[type=button]')[0].click()
					})
				})

				cy.get('span').should(($span) => {
					expect($span).to.contain('My Renamed Instrument')
				})

			})

			it('Should allow instruments to be reordered', () => {

				cy.get('span').contains('My Renamed Instrument').then(($span) => {

					//Click on the first element in the row
					let elem = cy.wrap($span).parentsUntil('tr').last().prev()

					elem.move({x: 0, y: 500, force: true})

				}).then(() => {

					//Make sure we know that this has happened before moving on
					cy.get('div').contains('INSTRUMENT WAS MOVED').then(($div) => {

						//Make sure this DIV disappears before going onto the next step
						cy.wrap($div).should('not.be', 'visible')

					})

					// cy.pause()
					//
					// cy.get('div').should('contain', 'INSTRUMENT WAS MOVED').then(($html) => {
					// 	//cy.wrap($html).should('not.contain', 'INSTRUMENT WAS MOVED')
					// })
					//
					// cy.pause()

					// cy.get('html').should(($html) => {
					//
					// 	cy.wrap($html).should('contain', "INSTRUMENT WAS MOVED").then(() => {
					//
					// 		cy.wrap($html).should('not.contain', 'INSTRUMENT WAS MOVED')
					//
					// 	})
					//
					// })

					// cy.get('tr#row_1').should(($tr) => {
					// 	expect($tr).to.contain('My Renamed Instrument')
					// })

				})

			})

			it('Should allow an instrument to be deleted', () => {

				cy.get('span').contains('My Second Instrument').parents('tr').children('td').last().within(($td) => {
					cy.get('button').contains('Choose action').click()
				})

				cy.get('a').should('contain', 'Delete')
				cy.get('a').contains('Delete').click()

			})

			describe('Field Types', () => {


				it('Should contain all of expected field types', () => {

					cy.get('a').contains('Demographics').click().then(() => { 
						cy.get('input#btn-patient_document-f').click().then(() => {
						cy.get('select').contains('Select a Type').parent().should(($s) => {
							expect($s).to.contain('Text Box')
							expect($s).to.contain('Notes Box')
							expect($s).to.contain('Calculated Field')
							expect($s).to.contain('Multiple Choice - Drop-down List')
							expect($s).to.contain('Multiple Choice - Radio Buttons')
							expect($s).to.contain('Checkboxes')
							expect($s).to.contain('Signature')
							expect($s).to.contain('File Upload')
							expect($s).to.contain('Descriptive Text')
							expect($s).to.contain('Begin New Section')
						})
					})
				})
							
				})

				it('Should not allow invalid names', () => {
					cy.get('select#field_type').select('text')
					cy.get('input#field_name').type('h?i')
					cy.get('button').contains('Save').click().then(() => {
						cy.get('table#draggable').should(($t) => {
							expect($t).to.contain('Variable: h_i')
						})
					})
				})

				it('Should allow reordering of fields', () => {
					
				})

				it('Should allow renaming of a field', () => {
					cy.get('table#design-last_name').within(() => {
						cy.get('img[title="Edit"]').click()
					})
					cy.get('textarea#field_label').type('s')
					cy.get('button').contains('Save').click().then(() => {
						cy.get('table#design-last_name').should(($t) => {
							expect($t).to.contain('Last Names')
						})
					})
					})
				

				it('Should allow copying of a field', () => {
					cy.get('table#design-last_name').within(() => {
						cy.get('img[title="Copy"]').click()
							
						
					})
					cy.get('button').contains('Copy field').click()
					cy.get('table#draggable').should(($t) => {
						expect($t).to.contain('Variable: last_name_2')
					})
				})

				it('Should allow a field to be marked as an identifier', () => {
					cy.get('table#design-last_name').within(() => {
						cy.get('img[title="Edit"]').click()
					})
					cy.get('input#field_phi1').click()
					cy.get('button').contains('Save').click()
				})

				describe('Text Box', () => {

					it('Should allow the creation of this field type', () => {
						cy.get('input#btn-patient_document-f').click().then(() => {
							cy.get('select#field_type').select('text')
							cy.get('input#field_name').type('new_text_box')
							cy.get('input#field_label_rich_text_checkbox').uncheck()
							cy.get('textarea#field_label').type('New Text Box')
							cy.get('button').contains('Save').click().then(() => {
								cy.get('table#draggable').should(($t) => {
									expect($t).to.contain('Variable: new_text_box')
								})
							})
						})

					})

				})

				describe('Notes', () => {

					it('Should allow the creation of this field type', () => {
						cy.get('input#btn-patient_document-f').click().then(() => {
							cy.get('select#field_type').select('textarea')
							cy.get('input#field_name').type('new_note_box')
							cy.get('input#field_label_rich_text_checkbox').uncheck()
							cy.get('textarea#field_label').type('New Note Box')
							cy.get('button').contains('Save').click().then(() => {
								cy.get('table#draggable').should(($t) => {
									expect($t).to.contain('Variable: new_note_box')
								})
							})
						})
					})

				})

				describe('Calculated Field', () => {

					it('Should allow the creation of this field type', () => {
						cy.get('input#btn-patient_document-f').click().then(() => {
							cy.get('select#field_type').select('calc')
							cy.get('input#field_name').type('new_calc_field')
							cy.get('input#field_label_rich_text_checkbox').uncheck()
							cy.get('textarea#field_label').type('New Calc Field')
							cy.get('button').contains('Save').click().then(() => {
								cy.get('table#draggable').should(($t) => {
									expect($t).to.contain('Variable: new_calc_field')
								})
							})
						})
					})

				})


				describe('Multiple Choice', () => {

					describe('Dropdown', () => {
						it('Should allow the creation of this field type', () => {
							cy.get('input#btn-patient_document-f').click().then(() => {
								cy.get('select#field_type').select('select')
								cy.get('input#field_name').type('new_drop_down')
								cy.get('input#field_label_rich_text_checkbox').uncheck()
								cy.get('textarea#field_label').type('New Drop Down')
								//cy.get('input#dropdown_autocomplete').check()
								//cy.get('textarea#element_enum').type('Option 1{enter}Option 2')
								//cy.get('button').contains('Save').click().then(() => { 
								//cy.get('button.ui-button ui-corner-all ui-widget').contains('Close').click().then(() => {
								cy.get('button').contains('Save').click().then(() => {
									cy.get('table#draggable').should(($t) => {
										expect($t).to.contain('Variable: new_drop_down')
									})
								})
							})
						})
						//})
						//})		

						it('Should automatically populate raw values for choices', () => {

						})
					})

					describe('Radio', () => {
						it('Should allow the creation of this field type', () => {
							cy.get('input#btn-patient_document-f').click().then(() => {
								cy.get('select#field_type').select('radio')
								cy.get('input#field_name').type('new_radio')
								cy.get('input#field_label_rich_text_checkbox').uncheck()
								cy.get('textarea#field_label').type('New Radio')
								//cy.get('input#dropdown_autocomplete').check()
								//cy.get('textarea#element_enum').type('Option 1{enter}Option 2')
								cy.get('button').contains('Save').click()
								//cy.get('button').contains('Close').click().then(() => {
									cy.get('table#draggable').should(($t) => {
										expect($t).to.contain('Variable: new_radio')
									})
								})
							})
						//})	

						it('Should automatically populate raw values for choices', () => {

						})	
					})
					
				})

				describe('Checkboxes', () => {

					it('Should allow the creation of this field type', () => {
						cy.get('input#btn-patient_document-f').click().then(() => {
							cy.get('select#field_type').select('checkbox')
							cy.get('input#field_name').type('new_check_box')
							cy.get('input#field_label_rich_text_checkbox').uncheck()
							cy.get('textarea#field_label').type('New Check Box')
							cy.get('button').contains('Save').click().then(() => {
								cy.get('table#draggable').should(($t) => {
									expect($t).to.contain('Variable: new_check_box')
								})
							})
						})
					})	

					it('Should automatically populate raw values for choices', () => {

					})

				})

				describe('Signature', () => {

					it('Should allow the creation of this field type', () => {
						cy.get('input#btn-patient_document-f').click().then(() => {
							cy.get('select#field_type').select('Signature (draw signature with mouse or finger)')
							cy.get('input#field_name').type('new_sign')
							cy.get('input#field_label_rich_text_checkbox').uncheck()
							cy.get('textarea#field_label').type('New Sign')
							cy.get('button').contains('Save').click().then(() => {
								cy.get('table#draggable').should(($t) => {
									expect($t).to.contain('Variable: new_sign')
								})
							})
						})
					})	

				})


				describe('File Upload', () => {

					it('Should allow the creation of this field type', () => {
						cy.get('input#btn-patient_document-f').click().then(() => {
							cy.get('select#field_type').select('File Upload (for users to upload files)')
							cy.get('input#field_name').type('new_file_upload')
							cy.get('input#field_label_rich_text_checkbox').uncheck()
							cy.get('textarea#field_label').type('New File Upload')
							cy.get('button').contains('Save').click().then(() => {
								cy.get('table#draggable').should(($t) => {
									expect($t).to.contain('Variable: new_file_upload')
								})
							})
						})
					})	

				})

				describe('Descriptive Text', () => {
					
					it('Should allow an attached image', () => {
						cy.get('input#btn-patient_document-f').click().then(() => {
							cy.get('select#field_type').select('descriptive')
							cy.get('input#field_name').type('new_desc_text')
							cy.get('input#field_label_rich_text_checkbox').uncheck()
							cy.get('textarea#field_label').type('New Desc Text')
							cy.get('div#righthand_fields').should(($d) => {
							expect($d).to.contain('Attach an image')
						})
					})	
				})
					it('Should allow an attached audio clip', () => {
						cy.get('div#righthand_fields').should(($d) => {
							expect($d).to.contain('Embed an external video')
						})
						//cy.get('button').contains('Save').click()
						//cy.get('button').contains('Cancel').click()
					})
					it('Should allow the creation of this field type', () => {
						//cy.get('input#btn-patient_document-f').click().then(() => {
							//cy.get('select#field_type').select('descriptive')
							//cy.get('input#field_name').type('new_desc_text')
							//cy.get('input#field_label_rich_text_checkbox').uncheck()
							//cy.get('textarea#field_label').type('New Desc Text')
							cy.get('button').contains('Save').click().then(() => {
								cy.get('table#draggable').should(($t) => {
									expect($t).to.contain('Variable: new_desc_text')
								})
							})
						})
					//})	


				})

				describe('Begin New Section', () => {

					it('Should allow the creation of this field type', () => {
						//cy.get('button').contains('Cancel').click()
						cy.get('input#btn-patient_document-f').click().then(() => {
							cy.get('select#field_type').select('section_header')
							//cy.get('input#field_name').type('new_section')
							cy.get('input#field_label_rich_text_checkbox').uncheck()
							cy.get('textarea#field_label').type('New Section')
							cy.get('button').contains('Save').click().then(() => {
								cy.get('table#draggable').should(($t) => {
									expect($t).to.contain('New Section')
								})
							})
						})
					})	

					it('Should not allow this to be the first field of the form', () => {
						cy.get('input#btn-date_enrolled-sh-f').click().then(() => {
							cy.get('select#field_type').should(($s) => {
								expect($s).not.to.contain('Begin New Section ')
							})
						})
					})	

				})
			})
		})
    })

	describe ('Data Dictionary', () => {

		it ('Should contain a Data Dictionary that matches the initial expectation', () => {

		})

		it ('Should add a new field to the project if you contribute a new row to the Data Dictionary file', () => {
			
		})

	})
})