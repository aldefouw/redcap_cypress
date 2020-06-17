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

		it('Should show the project without surveys used and in development mode', () => {


		})

		it('Should show you the appropriate options for viewing and designing your data collection instruments', () => {

			// Online Designer
			// Data Dictionary
			// REDCap Shared Library
			// Download PDF of all instruments
			// Download current data dictionary
			// Check for identifiers
			
		})


    })

})