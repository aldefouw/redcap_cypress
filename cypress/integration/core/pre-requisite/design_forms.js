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


		it('Should allow a new instrument to be created', () => {

		})

		it('Should allow an instrument to be renamed', () => {

		})

		it('Should allow an instrument to be deleted', () => {

		})

		it('Should allow instruments to be reordered', () => {

		})

		it('Should contains all of the expected field types', () => {
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

		describe('Field Types', () => {


			describe('Text Box', () => {




			})

			describe('Notes', () => {




			})

			describe('Calculated Field', () => {

				

				
			})

			describe('Calculated Field', () => {

				

				
			})

			describe('Multiple Choice', () => {

				
				describe('Dropdown', () => {

				}

				describe('Radio', () => {

				}
				
			})

			describe('Checkboxes', () => {


			})

			describe('Signature', () => {
				

			})


			describe('File Upload', () => {
				

			})

			describe('Descriptive Text', () => {
				

			})

			describe('Begin New Section', () => {
				

			})

		})

		it('Should allow reordering of fields', () => {
			
		})

		it('Should allow renaming of a field', () => {
			
		})

		it('Should allow copying of a field', () => {
			
		})

		it('Should allow a field to be marked as an identifier', () => {
			
		})

    })

	describe ('Data Dictionary', () => {

		it ('Should contain a Data Dictionary that matches the initial expectation', () => {

		})

		it ('Should add a new field to the project if you contribute a new row to the Data Dictionary file', () => {
			
		})


	})

})