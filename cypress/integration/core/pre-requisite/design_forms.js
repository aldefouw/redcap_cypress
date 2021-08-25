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

					console.log(elem)

					elem.move({x: 0, y: 500, force: true })

				}).then(() => {

					cy.get('tr#row_1').should(($tr) => {
						expect($tr).to.contain('My Renamed Instrument')
					})

				})




			})

			it('Should allow an instrument to be deleted', () => {

			})

			describe('Field Types', () => {


				it('Should contain all of expected field types', () => {
					// Text Box
					// Notes Box
					// Calculated Field
					// Multiple Choice – Drop Down
					// Multiple Choice – Radio Buttons
					// Checkboxes
					// Signature
					// File Upload
					// Descriptive Text
					// Begin New Section				
				})

				it('Should not allow invalid names', () => {
				
				})

				it('Should allow reordering of fields', () => {
					
				})

				it('Should allow renaming of a field', () => {
					
				})

				it('Should allow copying of a field', () => {
					
				})

				it('Should allow a field to be marked as an identifier', () => {
					
				})

				describe('Text Box', () => {

					it('Should allow the creation of this field type', () => {

					})

				})

				describe('Notes', () => {

					it('Should allow the creation of this field type', () => {

					})

				})

				describe('Calculated Field', () => {

					it('Should allow the creation of this field type', () => {

					})

				})

				describe('Calculated Field', () => {

					it('Should allow the creation of this field type', () => {

					})		

				})

				describe('Multiple Choice', () => {

					describe('Dropdown', () => {
						it('Should allow the creation of this field type', () => {

						})		

						it('Should automatically populate raw values for choices', () => {

						})
					})

					describe('Radio', () => {
						it('Should allow the creation of this field type', () => {

						})	

						it('Should automatically populate raw values for choices', () => {

						})	
					})
					
				})

				describe('Checkboxes', () => {

					it('Should allow the creation of this field type', () => {

					})	

					it('Should automatically populate raw values for choices', () => {

					})

				})

				describe('Signature', () => {

					it('Should allow the creation of this field type', () => {

					})	

				})


				describe('File Upload', () => {

					it('Should allow the creation of this field type', () => {

					})	

				})

				describe('Descriptive Text', () => {
					
					it('Should allow the creation of this field type', () => {

					})	

					it('Should allow an attached image', () => {

					})	


					it('Should allow an attached audio clip', () => {

					})	

				})

				describe('Begin New Section', () => {

					it('Should allow the creation of this field type', () => {

					})	

					it('Should not allow this to be the first field of the form', () => {

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