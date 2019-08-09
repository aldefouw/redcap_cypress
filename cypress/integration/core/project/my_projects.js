describe('My Projects', () => {

	before(() => {
		cy.set_user_type('standard')
	})

	describe('My Projects Page', () => {
		it('Should display columns: Project Title, Records, Fields, Instruments, Type, and Status', () => {
		    cy.visit_base({url: 'index.php?action=myprojects'}).then(() => {
		    	cy.get('div').should(($div) => {
		            expect($div).to.contain('Project Title')
		            expect($div).to.contain('Fields')
		            expect($div).to.contain('Instrument')
		            expect($div).to.contain('Type')
		            expect($div).to.contain('Status')
		    	})
			})
		})

		it('Should open a project when the link is clicked', () => {
			cy.visit_base({url: 'index.php?action=myprojects'}).then(() => {
				cy.require_redcap_stats()
		        cy.get('a').contains('Test Project').click().then(() => {
		            cy.get('html').should(($html) => {
		                expect($html).to.contain('Test Project')
		                expect($html).to.contain('Main project settings')
		            })
		        })
			})
		})
	})

	describe('Individual Project Functionality', () => {

		beforeEach(() => {
			cy.visit_version({page: 'ProjectSetup/index.php', params: "pid=13"})
		})

		it('Should display the Record Status Dashboard when the link is clicked', () => {
	    	cy.get('a').contains('Record Status Dashboard').click().then(() => {
	            cy.get('html').should(($html) => {
	                expect($html).to.contain('Record Status Dashboard')
	                expect($html).to.contain('Record ID')
	                expect($html).to.contain('My First Instrument')
	            })
	    	})
		})

		it('Should display the Online Designer when the link is clicked on the Project Setup tab', () => {
	    	cy.get('button').contains('Online Designer').click().then(() => {
	    		cy.get('html').should(($html) => {
	                expect($html).to.contain('Instrument name')
	                expect($html).to.contain('Data Collection Instruments')
	                expect($html).to.contain('Fields')
	            })
	    	})
		})

		it('Should allow me to turn off longitudinal data collection with defined events', () => {
			cy.get('button').should('contain', 'Define My Events')
			cy.get('button').should('contain', 'Designate Instruments for My Events')

			cy.get('div').contains('Use longitudinal data collection with defined events?').children('button').then(($a) => {

				expect($a).to.contain('Disable')

				cy.wrap($a).click().then(() => {
					cy.get('button#' + $a[0]['id']).should(($b) => {
						expect($b).to.contain('Enable')
					})	
				})
									
			})			
		
		})
	})	

})