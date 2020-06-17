describe('Design Forms using Data Dictionary & Online Designer', () => {

	before(() => {
		//Reset the projects back to what they should be
		cy.mysql_db('projects/pristine')
		
	})

    describe('Online Designer', () => {

    	before(() => {
    		cy.set_user_type('standard')
			
			//Visit Classic Database 
			cy.visit_version({page: 'Design/online_designer.php', params: "pid=13"})
    	})


		it('Should contain Project Setup permisisons for current user', () => {


		})

		it('Should show the project without surveys', () => {

		})

		it ('Should show the project in development mode', () => {


		})

		it('Should show the appropriate options for viewing and designing your data collection instruments', () => {
			// Online Designer
			// Data Dictionary
			// REDCap Shared Library
			// Download PDF of all instruments
			// Download current data dictionary
			// Check for identifiers
		})

		describe('Data Collection Instruments', () => {

			it('Should allow a new instrument to be created', () => {

			})

			it('Should allow an instrument to be renamed', () => {

			})

			it('Should allow an instrument to be deleted', () => {

			})

			it('Should allow instruments to be reordered', () => {

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