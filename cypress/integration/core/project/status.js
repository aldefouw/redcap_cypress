describe('Project Status', () => {

	before(() => {
		cy.set_user_type('standard')
	})

	describe('User Interface', () => {

		describe('Development as Initial Status', () => {

			it('Should have the ability to change the project status from Development to Production and keep collected data', () => {

			})

			it('Should have the ability to change the project status from Development to Production and delete all data, logging, and survey responses', () => {

			})

			it('Should have the ability to change the project status from Development to Archive', () => {

			})
		})

		describe('Production as Initial Status', () => {

			it('Should have the ability to change the project status from Production to Inactive', () => {

			})

			it('Should have the ability to change the project status from Production to Archive', () => {

			})

			it('Should have the ability to change the project status from Production to Development (for administrators)', () => {
				cy.set_user_type('admin')
				cy.set_user_type('standard')
			})
		})

		describe('Inactive as Initial Status', () => {

			it('Should have the ability to change the project status from Inactive to Production', () => {

			})

			it('Should have the ability to change the project status from Inactive to Archive', () => {

			})

			it('Should have the ability to change the project status from Inactive to Development (for administrators)', () => {
				cy.set_user_type('admin')
				cy.set_user_type('standard')
			})
		})

		describe('Archive as Initial Status', () => {

			it('Should have the ability to change the project status from Archive to Production', () => {

			})

			it('Should have the ability to change the project status from Archive to Development (for administrators)', () => {
				cy.set_user_type('admin')
				cy.set_user_type('standard')
			})
		})
	})

	describe('Control Center', () => {

		before(() => {
			cy.set_user_type('admin')
		})

	    it('Should have the ability to limit "Move to Production" capabilities to administrators only', () => {
            
    	})
	})

})