describe('Field Validation', () => {

	before(() => {
		cy.set_user_type('standard')
	})

	describe('User Interface', () => {

		describe('Text Field Validations', () => {

		    it('Should have the ability to validate Date (D-M-Y) field', () => {
		            
		    })

			it('Should have the ability to validate Datetime (M-D-Y H:M) field', () => {
					            
		    })

			it('Should have the ability to validate Datetime w/seconds (Y-M-D H:M:S) field', () => {
					            
			})

			it('Should have the ability to validate Email field', () => {
					            
			})

			it('Should have the ability to validate Integer field', () => {
					            
			})

			it('Should have the ability to validate Number field', () => {
					            
			})

			it('Should have the ability to validate Number (1 decimal place – comma as decimal) field', () => {
					            
			})

			it('Should have the ability to validate Time (HH:MM) field', () => {
		            
		    })

		})

		describe('Range Validations', () => {

		    it('Should support ranges for a Date (D-M-Y) field', () => {
		            
		    })

			it('Should support ranges for a Datetime (M-D-Y H:M) field', () => {
					            
		    })

			it('Should support ranges for a Datetime w/seconds (Y-M-D H:M:S) field', () => {
					            
			})

			it('Should support ranges for a Integer field', () => {
					            
			})

			it('Should support ranges for a Number field', () => {
					            
			})

			it('Should support ranges for a Number (1 decimal place – comma as decimal) field', () => {
					            
			})

			it('Should support ranges for a Time (HH:MM) field', () => {
		            
		    })

		})
	})

	describe('Control Center', () => {

		before(() => {
			cy.set_user_type('admin')
		})

		describe('Enable Field Validation', () => {

		    it('Should have the ability to enable Date (D-M-Y) field validation', () => {
		            
		    })

			it('Should have the ability to enable Datetime (M-D-Y H:M) field validation', () => {
					            
		    })

			it('Should have the ability to enable Datetime w/seconds (Y-M-D H:M:S) field validation', () => {
					            
			})

			it('Should have the ability to enable Email field validation', () => {
					            
			})

			it('Should have the ability to enable Integer field validation', () => {
					            
			})

			it('Should have the ability to enable Number field validation', () => {
					            
			})

			it('Should have the ability to enable Number (1 decimal place – comma as decimal) field validation', () => {
					            
			})

			it('Should have the ability to enable Time (HH:MM) field validation', () => {
		            
		    })

		})

		describe('Disable Field Validation', () => {

		    it('Should have the ability to disable Date (D-M-Y) field validation', () => {
		            
		    })

			it('Should have the ability to disable Datetime (M-D-Y H:M) field validation', () => {
					            
		    })

			it('Should have the ability to disable Datetime w/seconds (Y-M-D H:M:S) field validation', () => {
					            
			})

			it('Should have the ability to disable Email field validation', () => {
					            
			})

			it('Should have the ability to disable Integer field validation', () => {
					            
			})

			it('Should have the ability to disable Number field validation', () => {
					            
			})

			it('Should have the ability to disable Number (1 decimal place – comma as decimal) field validation', () => {
					            
			})

			it('Should have the ability to disable Time (HH:MM) field validation', () => {
		            
		    })
			
		})
	})
})