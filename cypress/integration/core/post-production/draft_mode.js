describe('Draft Mode', () => {

	before(() => {
		cy.set_user_type('standard')
	})

	describe('Basic Functionality', () => {

		it('Should have the ability to require that changes made to Data Collection instruments in Production Status be made by entering Draft Mode', () => {

		})

		it('Should NOT apply changes made in Draft Mode in real time to the project', () => {

		})

		it('Should have the ability to view a detailed summary of the Drafted Changes proposed', () => {

		})

		describe('Warning Capabilities', () => {

			it('Should have the ability to warn of changes that might cause label mismatches', () => {

			})

			it('Should have the ability to warn of changes that might cause data loss', () => {

			})

			it('Should have the ability to warn of changes that WILL cause data loss', () => {

			})
		})


		describe('Change Management', () => {

			it('Should have the ability for Administrators to Commit changes that are deemed acceptable', () => {

			})

			it('Should have the ability for Administrators to Reject changes that are deemed unacceptable', () => {

			})

			it('Should have the ability for Administrators to Reset and Delete drafted changes if necessary', () => {

			})	
		})

		describe('Data Dictionary', () => {

			it('Should record all versions of the Data Dictionary Post-Production Status with Date/Time, Requestor, and Approver', () => {

			})
		})

		describe('Notifications', () => {

			it('Should allow an Administrator to send a confirmation email (templated, but editable) to the requestor', () => {

			})	
		})
	})

	describe('Control Center', () => {

		before(() => {
			cy.set_user_type('admin')
		})

		it('Should require Administrators to review changes made in Draft Mode based upon the settings configured in Control Center', () => {

		})

		describe('Options for Automatic Approval of Drafted Changes', () => {

			it('Should have the ability to automatically approve changes "Never" (administrator approval required)', () => {
		            
		    })

			it('Should have the ability to automatically approve changes when No Existing Fields were Modified', () => {
		            
		    })

		    it('Should have the ability to automatically approve changes when No Records present OR Records Present AND No Existing Fields were Modified', () => {
		            
		    })

		    it('Should have the ability to automatically approve changes when No Critical Issues Exist', () => {
		            
		    })

		    it('Should have the ability to automatically approve changes when No Records present OR Records Present AND No Critical Issues Exist', () => {
		            
		    })

		})

		describe('Options for Add / Modify Events and Arms', () => {

		    it('Should have the ability to authorize ONLY Administrators to Add / Modify Events in Production Status', () => {
		            
		    })

		    it('Should have the ability to only authorize Standard Users to Add / Modify Events in Production Status', () => {
		            
		    })
		})
	})	
})