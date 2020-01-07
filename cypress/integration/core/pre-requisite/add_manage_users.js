describe('Add / Manage Users', () => {

	before(() => {
		cy.set_user_type('admin')
	})

	describe('Control Center', () => {

		describe('Users', () => {

			it('Should have the ability to create an individual user' => {

			})

			it('Should have the ability to suspend an individual user' => {
				
			})

			it('Should have the ability to unsuspend an individual user' => {
				
			})

			it('Should have the ability to delete an individual user' => {
				
			})

			it('Should have the ability to view all users in a tabular form' => {
				
			})

			it('Should have the ability to search for an individual user' => {
				
			})

		})

		describe('Security & Authentication' => { 

			it('Should have the ability to lock out users after a certain number of failed login attempts' => {
				
			})

			it('Should have the ability to specify the amount of time a user will be locked out after failed login attempts' => {
				
			})

		})
	})

})
