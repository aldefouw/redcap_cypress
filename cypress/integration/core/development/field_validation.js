describe('Field Validation', () => {
	before(() => {
		cy.set_user_type('standard')
	})

	before(() => {
        cy.set_user_type('admin')
        cy.visit_version({page: 'ProjectSetup/other_functionality.php', params: "pid=1"})
        cy.get('button').contains('development status').click({force:true})
        cy.wait(1000)
        cy.visit_version({page: 'Design/online_designer.php', params: 'pid=1'})
        cy.get('a').contains('Demographics').click({force:true})
        cy.get('input.btn2').first().click({force:true})
        cy.get('select').contains('Text Box').click({force:true})
	})

	describe('User Interface', () => {

		describe('Text Field Validations', () => {

		    it('Should have the ability to validate Date (D-M-Y) field', () => {
                cy.get('select#val_type').should(($val) => {
                    expect($val).to.contain('Date (D-M-Y)')
                })
		    })

			it('Should have the ability to validate Datetime (M-D-Y H:M) field', () => {
				cy.get('select#val_type').should(($val) => {
                    expect($val).to.contain('Datetime (M-D-Y H:M)')
                })	            
		    })

			it('Should have the ability to validate Datetime w/seconds (Y-M-D H:M:S) field', () => {
				cy.get('select#val_type').should(($val) => {
                    expect($val).to.contain('Datetime w/seconds (Y-M-D H:M:S)')
                })
					            
			})

			it('Should have the ability to validate Email field', () => {
				cy.get('select#val_type').should(($val) => {
                    expect($val).to.contain('Email')
                })		            
			})

			it('Should have the ability to validate Integer field', () => {
				cy.get('select#val_type').should(($val) => {
                    expect($val).to.contain('Integer')
                })		            
			})

			it('Should have the ability to validate Number field', () => {
				cy.get('select#val_type').should(($val) => {
                    expect($val).to.contain('Number')
                })		            
			})

			it('Should have the ability to validate Number (1 decimal place – comma as decimal) field', () => {
				cy.get('select#val_type').should(($val) => {
                    expect($val).to.contain('Number (1 decimal place – comma as decimal)')
                })		            
			})

			it('Should have the ability to validate Time (HH:MM) field', () => {
				cy.get('select#val_type').should(($val) => {
                    expect($val).to.contain('Time (HH:MM)')
                })   
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

		    before(() => {
		        cy.visit_version({page: 'ControlCenter/validation_type_setup.php'})
		    })

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