describe('Logging', () => {

	before(() => {
		cy.set_user_type('standard')
	})

	it('Should have the ability to export the logs to a CSV file', () => {

	})

	describe('Log of User Actions', () => {

		it('Should keep a record of the time / date of user actions', () => {
			
		})

		it('Should keep a record of when a Data Export is performed', () => {

		})

		it('Should keep a record of E-signature events', () => {

		})

		it('Should keep a record of changes to project instruments (Manage / Design)', () => {

		})

	 	describe('Data Recorded', () => {

	    	it('Should keep a record of the username who performed the action', () => {

	    	})

			it('Should keep a record of the specific data change made', () => { 

			})

	    	describe('Updated Data', () => {

	    		it('Should keep a record of the new value for an updated record', () => {

	    		})

	    		it('Should keep a record of the new value for an updated E-signature', () => {

	    		})

	    		it('Should keep a record of the new value for lock/unlock actions', () => {

	    		})

	    	})

    		it('Should keep a record of the fields exported', () => {

    		})

	    })

		describe('Changes to Records', () => {

		    it('Should keep a record of all create actions', () => {
	            
		    })

		    it('Should keep a record of all update actions', () => {
		            
		    })

		    it('Should keep a record of all delete actions', () => {
		            
		    })

		    it('Should keep a record of all record locks', () => {
		            
		    })

		    it('Should keep a record of all record unlocks', () => {
		            
		    })
		   
		})

		describe('Changes to User Roles', () => {

		    it('Should keep a record of all created user roles', () => {
		            
		    })

		    it('Should keep a record of all updated user roles', () => {
		            
		    })

		    it('Should keep a record of all deleted user roles', () => {
		            
		    })
		})

		describe('Changes to Individual User Permissions', () => {

		    it('Should keep a record of all created user permissions', () => {
		            
		    })

		    it('Should keep a record of all updated user permissions', () => {
		            
		    })

		    it('Should keep a record of all deleted user permissions', () => {
		            
		    })
		})	

	})

	describe('Filtering Options', () => {

		describe('By Event Type', () => {

			it('Should allow filtering on ALL Event Types (excluding Page Views)', () => {

			})

			it('Should allow filtering by Data Export type', () => {

			})

			it('Should allow filtering by Manage/Design type', () => {

			})

			it('Should allow filteirng by User or Role (created-updated-deleted)', () => {

			})

			it('Should allow filtering by Record (created-updated-deleted)', () => {

			})

			it('Should allow filtering by Record (created only)', () => {

			})

			it('Should allow filtering by Record (updated only)', () => {

			})

			it('Should allow filtering by Record (deleted only)', () => {

			})

			it('Should allow filtering by Record locking and e-signatures', () => {

			})

			it('Should allow filtering by Page Views', () => {

			})	
		})

		describe('By Specific Username', () => {

			it('Should allow filtering by Username (all users for a given study selectable)', () => {

			})	

		})

		describe('By Specific Record', () => {

			it('Should allow filtering by Record (all records for a given study selectable)', () => {

			})				

		})

	})
})