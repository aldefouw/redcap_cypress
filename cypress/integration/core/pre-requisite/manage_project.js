describe('Manage Project Creation, Deletion, Settings', () => {

	before(() => {
		cy.set_user_type('standard')
	})

	describe('User Interface - General', () => {

		it('Should have the ability to create new projects from a blank slate', () => {

		})

		it('Should have the ability to customize / modify existing Project Title', () => {

		})

		it('Should have the ability to designate the purpose of the project', () => {

		})

		describe('Copy Functionality', () => {

			it('Should have the ability to copy the project with neither data nor users included', () => {

			})

			it('Should have the ability to copy the project with data included but without users', () => {

			})

			it('Should have the ability to copy the project with both data and users included', () => {

			})
		})		
	})

	describe('User Interface - Longitudinal Project Settings', () => {
		
		/*
		before(() => {
			cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=14'})
			cy.get('div').contains('Scheduling module (longitudinal only)').within(() => {
				cy.get('button').click()
			})
		})
		*/

		it('Should have the ability to enable and disable Longitudinal Data Collection', () => {
			cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=14'})
			cy.get('button#setupLongiBtn').click().then(() => {
				cy.get('span.SavedMsg').should(($s) => {
					expect($s).to.contain('Saved')
				})
			})
		})

		it('Should have the ability to designate data collection instruments for defined events for each arm', () => { 

		})

		it('Should have the ability to define unique event schedules for each arm', () => { 
			cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=14'})
			cy.get('div').contains('Scheduling module (longitudinal only)').within(() => {
				cy.get('button').click()
			})
			cy.get('button').contains('Define My Events').click().then(() => {
				cy.get('table#event_table').should(($t) => {
					expect($t).to.contain('Days Offset')
					expect($t).to.contain('Offset Range')
				})
			})
			
		})

		it('Should have the ability to create repeating events and instruments', () => { 
			cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=14'})
			cy.get('button#enableRepeatingFormsEventsBtn').click()
		})

		it('Should require administrator approval to delete events for longitudinal projects while in Production mode', () => { 

		})		
	})

	describe('User Interface - Survey Project Settings', () => {

		it('Should have the ability to enable and disable survey functionality at the project level', () => { 

		})

		it('Should have the ability to enable and disable each data collection instrument in a project as a survey', () => { 

		})

		it('Should have the ability to set the survye status to active or offline', () => { 

		})

		it('Should have the ability to create repeating surveys', () => { 

		})		
	})

	describe('User Interface - Survey distribution', () => {

		it('Should have the ability to create a public survey link when the survey is in the first instrument position', () => { 

		})

		it('Should have the ability to create a designated email field', () => { 

		})
		
	})

	describe('Control Center', () => {

		before(() => {
			cy.set_user_type('admin')
		})

		it('Should have the ability to limit creation of new projects to administrators', () => {

		})

		it('Should have the ability to limit the moving of projects to production to administrators', () => {

		})

		it('Should have the ability to enable users to edit survey responses', () => {

		})

		it('Should have the ability to enable Draft Mode changes to be automatically approved under certain conditions', () => {

		})

		it('Should have the ability to limit adding or modifying events and arms while in Production mode to administrators', () => {

		})
	})

})
