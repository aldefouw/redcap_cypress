describe('Field Validation', () => {
	
	describe('User Interface', () => {
		
		describe('Text Field Validations', () => {
			before(() => {
				cy.mysql_db("projects/pristine")
				cy.set_user_type('admin')
				cy.visit_version({page: 'Design/online_designer.php', params: 'pid=1'})
				cy.get('a').contains('Demographics').click({force:true})
				cy.get('input.btn2').first().click({force:true})
				cy.get('select').contains('Text Box (Short Text, Number, Date/Time, ...)').parent().select('Text Box (Short Text, Number, Date/Time, ...)')
			})
			
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

			it('Should have the ability to validate Datetime w/ seconds (Y-M-D H:M:S) field', () => {
				cy.get('select#val_type').should(($val) => {
                    expect($val).to.contain('Datetime w/ seconds (Y-M-D H:M:S)')
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

			//not an option for validation
			// it('Should have the ability to validate Number (1 decimal place – comma as decimal) field', () => {
			// 	cy.get('select#val_type').should(($val) => {
            //         expect($val).to.contain('Number (1 decimal place – comma as decimal)')
            //     })		            
			// })

			it('Should have the ability to validate Time (HH:MM) field', () => {
				cy.get('select#val_type').should(($val) => {
                    expect($val).to.contain('Time (HH:MM)')
                })   
		    })

		})

		describe('Range Validations', () => {
			
			before(() => {
				cy.set_user_type('admin')
				cy.visit_version({page: 'Design/online_designer.php', params: 'pid=1'})
				cy.get('a').contains('Demographics').click({force:true})
				cy.get('input.btn2').first().click({force:true})
				cy.get('select').contains('Text Box (Short Text, Number, Date/Time, ...)').parent().select('Text Box (Short Text, Number, Date/Time, ...)')
			})

		    it('Should support ranges for a Date (D-M-Y) field', () => {
				cy.get('select').contains('Date (D-M-Y)').parent().select('Date (D-M-Y)')
				cy.wait(1000)
				cy.get('div#div_val_minmax').should(($div) => {
					expect($div).to.contain('Minimum')
					expect($div).to.contain('Maximum')
				})
		    })

			it('Should support ranges for a Datetime (M-D-Y H:M) field', () => {
				cy.get('select').contains('Datetime (M-D-Y H:M)').parent().select('Datetime (M-D-Y H:M)')
				cy.wait(1000)
				cy.get('div#div_val_minmax').should(($div) => {
					expect($div).to.contain('Minimum')
					expect($div).to.contain('Maximum')
				})
		    })

			it('Should support ranges for a Datetime w/ seconds (Y-M-D H:M:S) field', () => {
				cy.get('select').contains('Datetime w/ seconds (Y-M-D H:M:S)').parent().select('Datetime w/ seconds (Y-M-D H:M:S)')
				cy.wait(1000)
				cy.get('div#div_val_minmax').should(($div) => {
					expect($div).to.contain('Minimum')
					expect($div).to.contain('Maximum')
				})
			})

			it('Should support ranges for a Integer field', () => {
				cy.get('select').contains('Integer').parent().select('Integer')
				cy.wait(1000)
				cy.get('div#div_val_minmax').should(($div) => {
					expect($div).to.contain('Minimum')
					expect($div).to.contain('Maximum')
				})
			})

			/*
			it('Should support ranges for a Number field', () => {
				cy.get('select').contains('Number').parent().select('Number')
				cy.wait(1000)
				cy.get('div#div_val_minmax').should(($div) => {
					expect($div).to.contain('Minimum')
					expect($div).to.contain('Maximum')
				})
			})
*/
			//not an option for validation
			// it('Should support ranges for a Number (1 decimal place – comma as decimal) field', () => {

			// })

			it('Should support ranges for a Time (HH:MM) field', () => {
				cy.get('select').contains('Time (HH:MM)').parent().select('Time (HH:MM)')
				cy.wait(1000)
				cy.get('div#div_val_minmax').should(($div) => {
					expect($div).to.contain('Minimum')
					expect($div).to.contain('Maximum')
				})
		    })


		})
	})

	describe('Control Center', () => {
		
		before(() => {
			//cy.mysql_db("projects/pristine")
			cy.set_user_type('admin')
			cy.visit_version({page: 'ControlCenter/validation_type_setup.php'})
		})

		it('Should display validation changes in project when Date (D-M-Y) field validation is disabled', () => {
			cy.get('tr#date_dmy').within(($tr) => {
				cy.get('button').contains('Disable').click()
			})
			cy.visit_version({page: 'Design/online_designer.php', params: 'pid=1'})
			cy.get('a').contains('Demographics').click({force:true})
			cy.get('input.btn2').first().click({force:true})
			cy.get('select').contains('Text Box (Short Text, Number, Date/Time, ...)').parent().select('Text Box (Short Text, Number, Date/Time, ...)')
			cy.get('select#val_type').should(($val) => {
				expect($val).not.to.contain('Date (D-M-Y)')
			})
		})

		it('Should display validation changes in project when Datetime (M-D-Y H:M) field validation is disabled', () => {
			cy.visit_version({page: 'ControlCenter/validation_type_setup.php'})
			cy.get('tr#datetime_mdy').within(($tr) => {
				cy.get('button').contains('Disable').click()
			})
			cy.visit_version({page: 'Design/online_designer.php', params: 'pid=1'})
			cy.get('a').contains('Demographics').click({force:true})
			cy.get('input.btn2').first().click({force:true})
			cy.get('select').contains('Text Box (Short Text, Number, Date/Time, ...)').parent().select('Text Box (Short Text, Number, Date/Time, ...)')
			cy.get('select#val_type').should(($val) => {
				expect($val).not.to.contain('Datetime (M-D-Y H:M)')
			})
		})

		it('Should display validation changes in project when Datetime w/seconds (Y-M-D H:M:S) field validation is disabled', () => {
			cy.visit_version({page: 'ControlCenter/validation_type_setup.php'})
			cy.get('tr#datetime_seconds_ymd').within(($tr) => {
				cy.get('button').contains('Disable').click()
			})
			cy.visit_version({page: 'Design/online_designer.php', params: 'pid=1'})
			cy.get('a').contains('Demographics').click({force:true})
			cy.get('input.btn2').first().click({force:true})
			cy.get('select').contains('Text Box (Short Text, Number, Date/Time, ...)').parent().select('Text Box (Short Text, Number, Date/Time, ...)')
			cy.get('select#val_type').should(($val) => {
				expect($val).not.to.contain('Datetime w/seconds (Y-M-D H:M:S)')
			})
		})

		it('Should display validation changes in project when Email field validation is disabled', () => {
			cy.visit_version({page: 'ControlCenter/validation_type_setup.php'})
			cy.get('tr#email').within(($tr) => {
				cy.get('button').contains('Disable').click()
			})
			cy.visit_version({page: 'Design/online_designer.php', params: 'pid=1'})
			cy.get('a').contains('Demographics').click({force:true})
			cy.get('input.btn2').first().click({force:true})
			cy.get('select').contains('Text Box (Short Text, Number, Date/Time, ...)').parent().select('Text Box (Short Text, Number, Date/Time, ...)')
			cy.get('select#val_type').should(($val) => {
				expect($val).not.to.contain('Email')
			})
		})

		it('Should display validation changes in project when Integer field validation is disabled', () => {
			cy.visit_version({page: 'ControlCenter/validation_type_setup.php'})
			cy.get('tr#integer').within(($tr) => {
				cy.get('button').contains('Disable').click()
			})
			cy.visit_version({page: 'Design/online_designer.php', params: 'pid=1'})
			cy.get('a').contains('Demographics').click({force:true})
			cy.get('input.btn2').first().click({force:true})
			cy.get('select').contains('Text Box (Short Text, Number, Date/Time, ...)').parent().select('Text Box (Short Text, Number, Date/Time, ...)')
			cy.get('select#val_type').should(($val) => {
				expect($val).not.to.contain('Integer')
			})
		})

		it('Should display validation changes in project when Number field validation is disabled', () => {
			cy.visit_version({page: 'ControlCenter/validation_type_setup.php'})
			cy.get('tr#number').within(($tr) => {
				cy.get('button').contains('Disable').click()
			})
			cy.visit_version({page: 'Design/online_designer.php', params: 'pid=1'})
			cy.get('a').contains('Demographics').click({force:true})
			cy.get('input.btn2').first().click({force:true})
			cy.get('select').contains('Text Box (Short Text, Number, Date/Time, ...)').parent().select('Text Box (Short Text, Number, Date/Time, ...)')
			cy.get('select#val_type').should(($val) => {
				expect($val).not.to.contain('Number')
			})
		})

		it('Should display validation changes in project when Number (1 decimal place – comma as decimal) field validation is disabled', () => {
			cy.visit_version({page: 'ControlCenter/validation_type_setup.php'})
			cy.get('tr#number_1dp_comma_decimal').within(($tr) => {
				cy.get('button').contains('Disable').click()
			})
			cy.visit_version({page: 'Design/online_designer.php', params: 'pid=1'})
			cy.get('a').contains('Demographics').click({force:true})
			cy.get('input.btn2').first().click({force:true})
			cy.get('select').contains('Text Box (Short Text, Number, Date/Time, ...)').parent().select('Text Box (Short Text, Number, Date/Time, ...)')
			cy.get('select#val_type').should(($val) => {
				expect($val).not.to.contain('Number (1 decimal place – comma as decimal)')
			})
		})

		it('Should display validation changes in project when Time (HH:MM) field validation is disabled', () => {
			cy.visit_version({page: 'ControlCenter/validation_type_setup.php'})
			cy.get('tr#time').within(($tr) => {
				cy.get('button').contains('Disable').click()
			})
			cy.visit_version({page: 'Design/online_designer.php', params: 'pid=1'})
			cy.get('a').contains('Demographics').click({force:true})
			cy.get('input.btn2').first().click({force:true})
			cy.get('select').contains('Text Box (Short Text, Number, Date/Time, ...)').parent().select('Text Box (Short Text, Number, Date/Time, ...)')
			cy.get('select#val_type').should(($val) => {
				expect($val).not.to.contain('Time (HH:MM)')
			})
		})
	})

	
	
	/* 
	describe('Control Center', () => {

		before(() => {
			cy.mysql_db("projects/pristine")
			cy.set_user_type('admin')
			cy.visit_version({page: 'ControlCenter/validation_type_setup.php'})
		})
		describe('Enable Field Validation', () => {

		    before(() => {
				//cy.mysql_db("projects/pristine")
				//cy.visit_version({page: 'ControlCenter/validation_type_setup.php'})
			})

		    it('Should have the ability to enable Date (D-M-Y) field validation', () => {
				cy.get('tr#date_dmy').should(($tr) => {
					expect($tr).to.contain('Enable')
				})
				cy.get('tr#date_dmy').within(($tr) => {
					cy.get('button').contains('Enable').click({force:true})
				})
				
		    })

			it('Should have the ability to enable Datetime (M-D-Y H:M) field validation', () => {
				cy.get('tr#datetime_mdy').should(($tr) => {
					expect($tr).to.contain('Enable')
				})
				cy.get('tr#datetime_mdy').within(($tr) => {
					cy.get('button').contains('Enable').click({force:true})
				}) 
		    })

			it('Should have the ability to enable Datetime w/seconds (Y-M-D H:M:S) field validation', () => {
				cy.get('tr#datetime_seconds_ymd').should(($tr) => {
					expect($tr).to.contain('Enable')
				})
				cy.get('tr#datetime_seconds_ymd').within(($tr) => {
					cy.get('button').contains('Enable').click({force:true})
				})  
			})

			it('Should have the ability to enable Email field validation', () => {
				cy.get('tr#email').should(($tr) => {
					expect($tr).to.contain('Enable')
				})
				cy.get('tr#email').within(($tr) => {
					cy.get('button').contains('Enable').click({force:true})
				})
			})

			it('Should have the ability to enable Integer field validation', () => {
				cy.get('tr#integer').should(($tr) => {
					expect($tr).to.contain('Enable')
				})
				cy.get('tr#integer').within(($tr) => {
					cy.get('button').contains('Enable').click({force:true})
				})
			})

			it('Should have the ability to enable Number field validation', () => {
				cy.get('tr#number').should(($tr) => {
					expect($tr).to.contain('Enable')
				})
				cy.get('tr#number').within(($tr) => {
					cy.get('button').contains('Enable').click({force:true})
				}) 
				
			})

			it('Should have the ability to enable Number (1 decimal place – comma as decimal) field validation', () => {
				cy.get('tr#number_1dp_comma_decimal').should(($tr) => {
					expect($tr).to.contain('Enable')
				})
				cy.get('tr#number_1dp_comma_decimal').within(($tr) => {
					cy.get('button').contains('Enable').click({force:true})
				}) 
			})

			it('Should have the ability to enable Time (HH:MM) field validation', () => {
				cy.get('tr#time').should(($tr) => {
					expect($tr).to.contain('Enable')
				})
				cy.get('tr#time').within(($tr) => {
					cy.get('button').contains('Enable').click({force:true})
				})
		    })

		})
		describe('Disable Field Validation', () => {

		    it('Should have the ability to disable Date (D-M-Y) field validation', () => {
				cy.get('tr#date_dmy').should(($tr) => {
					expect($tr).to.contain('Disable')
				})
				
		            
		    })

			it('Should have the ability to disable Datetime (M-D-Y H:M) field validation', () => {
				cy.get('tr#datetime_mdy').should(($tr) => {
					expect($tr).to.contain('Disable')
				})      
				   
		    })

			it('Should have the ability to disable Datetime w/seconds (Y-M-D H:M:S) field validation', () => {
				cy.get('tr#datetime_seconds_ymd').should(($tr) => {
					expect($tr).to.contain('Disable')
				})   
				   
			})

			it('Should have the ability to disable Email field validation', () => {
				cy.get('tr#email').should(($tr) => {
					expect($tr).to.contain('Disable')
				})    
				  
			})

			it('Should have the ability to disable Integer field validation', () => {
				cy.get('tr#integer').should(($tr) => {
					expect($tr).to.contain('Disable')
				}) 
				           
			})

			it('Should have the ability to disable Number field validation', () => {
				cy.get('tr#number').should(($tr) => {
					expect($tr).to.contain('Disable')
				}) 
				       
			})

			it('Should have the ability to disable Number (1 decimal place – comma as decimal) field validation', () => {
				cy.get('tr#number_1dp_comma_decimal').should(($tr) => {
					expect($tr).to.contain('Disable')
				}) 
				          
			})

			it('Should have the ability to disable Time (HH:MM) field validation', () => {
				cy.get('tr#time').should(($tr) => {
					expect($tr).to.contain('Disable')
				})	
		    })
		})	
	})
	
	
	

		
	})
*/
	

})