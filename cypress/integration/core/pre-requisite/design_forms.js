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

					cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/Design/update_form_order.php?*').as('reorder_request')
					cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/Design/online_designer.php?*').as('designer_request')

					//Click on the first element in the row
					let elem = cy.wrap($span).parentsUntil('tr').last().prev()
					elem.move({x: 0, y: 500, force: true})

				})

				cy.wait('@reorder_request')
				cy.wait('@designer_request')
			})

			it('Should allow an instrument to be deleted', () => {

				cy.get('span').contains('My Renamed Instrument').parents('tr').children('td').last().within(($td) => {
					cy.get('button').contains('Choose action').click()
				}).then(() => {

					cy.get('a').should('contain', 'Delete')
					cy.get('a').contains('Delete').click()

					cy.get('button').should('contain', 'delete')
					cy.get('button').contains('delete').click().then(() => {

						//Make sure we know that this has happened before moving on
						cy.get('[id^=popup_]').contains('The data collection instrument and all its fields have been successfully deleted!').should('be.visible').then(($div) => {
							cy.get($div).should('not.be.visible')
						})


					})

					cy.get('span').contains('My Renamed Instrument').should('not.exist')
				})
			})

			describe('Field Types', () => {

				beforeEach(() => {
					cy.get('div').contains('Working').should('not.be.visible')
				})

				it('Should contain all of expected field types', () => {

					cy.get('span').contains('My First Instrument').click().then(() => {
						cy.get('input#btn-last').click().then(() => {
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
					cy.get('table#design-h_i').within(() => {
						cy.get('img[title="Edit"]').click()
					})

					cy.get('label').contains('Use the Rich Text Editor').click().then(() => {
						cy.get('textarea#field_label').type('Renamed Field')
					})

					cy.get('button').contains('Save').click().then(() => {
						cy.get('table#design-h_i').should(($t) => {
							expect($t).to.contain('Renamed Field')
						})
					})
				})


				it('Should allow copying of a field', () => {
					cy.get('table#design-h_i').within(() => {
						cy.get('img[title="Copy"]').click()


					})
					cy.get('button').contains('Copy field').click()
					cy.get('table#draggable').should(($t) => {
						expect($t).to.contain('Variable: h_i_2')
					})
				})

				it('Should allow a field to be marked as an identifier', () => {
					cy.get('table#design-h_i').within(() => {
						cy.get('img[title="Edit"]').click()
					})
					cy.get('input#field_phi1').click()
					cy.get('button').contains('Save').click()
				})

				describe('Text Box', () => {

					it('Should allow the creation of this field type', () => {
						cy.get('input#btn-last').click().then(() => {
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
						cy.get('input#btn-last').click().then(() => {
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
						cy.get('input#btn-last').click().then(() => {
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
							cy.get('input#btn-last').click().then(() => {
								cy.get('select#field_type').select('select')
								cy.get('input#field_name').type('new_drop_down')
								cy.get('input#field_label_rich_text_checkbox').uncheck()
								cy.get('textarea#field_label').type('New Drop Down')

								cy.get('button').contains('Save').click().then(() => {
									cy.get('table#draggable').should(($t) => {
										expect($t).to.contain('Variable: new_drop_down')
									})
								})
							})
						})

						it('Should automatically populate raw values for choices', () => {

							//Select field to edit some choices for
							cy.edit_field_by_label('New Drop Down')

							//Get the field choices and set the new values / labels
							let field_choices = cy.select_field_choices()
							field_choices.type('NEW LABEL 1\nNEW LABEL 2\nNEW LABEL 3')

							//Check that raw values were automatically added
							cy.get('div').contains('Field Type:').click().then(() => {
								cy.get('html').should(($html) => {
									expect($html).to.contain('Raw values for choices were added automatically')
								})

								cy.get('div').contains('Raw values for choices were added automatically').parent().within(() => {
									cy.get('button').contains('Close').click()
								})
							})

							//Save this particular field we are editing
							cy.save_field()
						})
					})

					describe('Radio', () => {
						it('Should allow the creation of this field type', () => {
							cy.get('input#btn-last').click().then(() => {
								cy.get('select#field_type').select('radio')
								cy.get('input#field_name').type('new_radio')
								cy.get('input#field_label_rich_text_checkbox').uncheck()
								cy.get('textarea#field_label').type('New Radio')

								cy.get('button').contains('Save').click()

								cy.get('table#draggable').should(($t) => {
									expect($t).to.contain('Variable: new_radio')
								})
							})
						})


						it('Should automatically populate raw values for choices', () => {
							//Select field to edit some choices for
							cy.edit_field_by_label('New Radio')

							//Get the field choices and set the new values / labels
							let field_choices = cy.select_field_choices()
							field_choices.type('NEW LABEL 1\nNEW LABEL 2\nNEW LABEL 3')

							//Check that raw values were automatically added
							cy.get('div').contains('Field Type:').click().then(() => {
								cy.get('html').should(($html) => {
									expect($html).to.contain('Raw values for choices were added automatically')
								})

								cy.get('div').contains('Raw values for choices were added automatically').parent().within(() => {
									cy.get('button').contains('Close').click()
								})
							})

							//Save this particular field we are editing
							cy.save_field()
						})
					})
				})

				describe('Checkboxes', () => {

					it('Should allow the creation of this field type', () => {
						cy.get('input#btn-last').click().then(() => {
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
						//Select field to edit some choices for
						cy.edit_field_by_label('New Check Box')

						//Get the field choices and set the new values / labels
						let field_choices = cy.select_field_choices()
						field_choices.type('NEW LABEL 1\nNEW LABEL 2\nNEW LABEL 3')

						//Check that raw values were automatically added
						cy.get('div').contains('Field Type:').click().then(() => {
							cy.get('html').should(($html) => {
								expect($html).to.contain('Raw values for choices were added automatically')
							})

							cy.get('div').contains('Raw values for choices were added automatically').parent().within(() => {
								cy.get('button').contains('Close').click()
							})
						})

						//Save this particular field we are editing
						cy.save_field()
					})

				})

				describe('Signature', () => {

					it('Should allow the creation of this field type', () => {
						cy.get('input#btn-last').click().then(() => {
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
						cy.get('input#btn-last').click().then(() => {
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
						cy.get('input#btn-last').click().then(() => {
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

					})

					it('Should allow the creation of this field type', () => {
						cy.get('button').contains('Save').click().then(() => {
							cy.get('table#draggable').should(($t) => {
								expect($t).to.contain('Variable: new_desc_text')
							})
						})
					})

				})

				describe('Begin New Section', () => {

					it('Should allow the creation of this field type', () => {

						cy.get('input#btn-new_desc_text-f').click().then(() => {
							cy.get('select#field_type').select('section_header')

							cy.get('input#field_label_rich_text_checkbox').uncheck()
							cy.get('textarea#field_label').type('New Section')

							cy.get('button').contains('Save').click().then(() => {
								cy.get('table#draggable').should(($t) => {
									expect($t).to.contain('New Section')
								})
							})
						})
					})

					it('Should NOT allow two consecutive new sections', () => {

						cy.get('input#btn-h_i-f').click().then(() => {
							cy.get('select#field_type').select('section_header')

							cy.get('input#field_label_rich_text_checkbox').uncheck()
							cy.get('textarea#field_label').type('New Section')

							cy.get('button').contains('Save').click().then(() => {
								cy.get('table#draggable').should(($t) => {
									expect($t).to.contain('New Section')
								})
							})
						})

						//The new section should not appear on this instance
						cy.get('input#btn-h_i-f').click().then(() => {
							cy.get('select#field_type > option').each(($el, index, $list) => {

								//Iterate through the entire list of options to ensure we do not have 'section_header' option
								$list.each(($k, $v) => { expect($v['value']).to.not.eq('section_header') })
							})
						}).then(() => {
							//Close out the window
							cy.get('button[title=Close]').last().click()
						})

					})

					it('Should NOT allow a new sections at bottom of form', () => {

						cy.get('input#btn-last').click().then(() => {
							cy.get('select#field_type').select('section_header')

							cy.get('button').contains('Save').click().then(() => {
								cy.on('window:alert', ($alert) => {
									expect($alert).to.equal('Sorry, but Section Headers cannot be the last field on a data entry form.')
								})
							})
						})
					})
				})
			})
		})
    })

	describe ('Data Dictionary', () => {

		before(() => {
			cy.visit_version({page: '/ProjectSetup/index.php', params: "pid=13"})
			cy.get('button').contains('Data Dictionary').click()
		})

		it ('Should contain a Data Dictionary that matches the initial expectation', () => {

			//This code prior to the click is necessary so Cypress doesn't stall out
			cy.window().document().then(function (doc) {
				doc.addEventListener('click', () => {
					setTimeout(function () {
						doc.location.reload()
					}, 2000)
				})
				cy.intercept('**/Design/data_dictionary_download.php?pid=**').as('data_dictionary')
				cy.get('a').contains('Download the current Data Dictionary').click()
			})

			const downloads_folder = Cypress.config('downloadsFolder')

			cy.wait('@data_dictionary').then(() =>{
				cy.read_directory(downloads_folder).then((downloads) => {
					downloads.forEach(function(file, index) {
						if(index === 0){
							cy.readFile(downloads_folder + '/' + file).should('contain',
								'"Variable / Field Name","Form Name","Section Header","Field Type","Field Label","Choices, Calculations, OR Slider Labels","Field Note","Text Validation Type OR Show Slider Number","Text Validation Min","Text Validation Max",Identifier?,"Branching Logic (Show field only if...)","Required Field?","Custom Alignment","Question Number (surveys only)","Matrix Group Name","Matrix Ranking?","Field Annotation"\n' +
								'record_id,my_first_instrument,,text,"Record ID",,,,,,,,,,,,,\n' +
								'h_i,my_first_instrument,"New Section",text,"Renamed Field",,,,,,y,,,,,,,\n' +
								'h_i_2,my_first_instrument,,text,"Renamed Field",,,,,,,,,,,,,\n' +
								'new_text_box,my_first_instrument,,text,"New Text Box",,,,,,,,,,,,,\n' +
								'new_note_box,my_first_instrument,,notes,"New Note Box",,,,,,,,,,,,,\n' +
								'new_calc_field,my_first_instrument,,calc,"New Calc Field",,,,,,,,,,,,,\n' +
								'new_drop_down,my_first_instrument,,dropdown,"New Drop Down","1, NEW LABEL 1 | 2, NEW LABEL 2 | 3, NEW LABEL 3",,,,,,,,,,,,\n' +
								'new_radio,my_first_instrument,,radio,"New Radio","1, NEW LABEL 1 | 2, NEW LABEL 2 | 3, NEW LABEL 3",,,,,,,,,,,,\n' +
								'new_check_box,my_first_instrument,,checkbox,"New Check Box","1, NEW LABEL 1 | 2, NEW LABEL 2 | 3, NEW LABEL 3",,,,,,,,,,,,\n' +
								'new_sign,my_first_instrument,,file,"New Sign",,,signature,,,,,,,,,,\n' +
								'new_file_upload,my_first_instrument,,file,"New File Upload",,,,,,,,,,,,,\n' +
								'new_desc_text,my_first_instrument,"New Section",descriptive,"New Desc Text",,,,,,,,,,,,,')
						}
					})
				})
			})
		})

		it ('Should add a new field to the project if you contribute a new row to the Data Dictionary file', () => {

			cy.upload_file('dictionaries/core/data_dictionary_for_import.csv', 'csv', 'input[type=file]').then(() => {
				cy.wait(1000)
				cy.get('input').contains('Upload File').click().then(() => {
					cy.get('html').then($html => {
						expect($html).to.contain('Your document was uploaded successfully and awaits your confirmation below.')
						cy.wait(1000)
						cy.get('input').contains('Commit Changes').click()
						cy.wait(1000)
					})
				})
			})

			//Need to check for a new row existing in the Online Designer
			cy.visit_version({page: 'Design/online_designer.php', params: 'pid=13'})

			cy.get('a').contains('My First Instrument').click()

			cy.get('html').then(($html) => {
				expect($html).to.contain('Newest Field')
			})

		})

	})
})