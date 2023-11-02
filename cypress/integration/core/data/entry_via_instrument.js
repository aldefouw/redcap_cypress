describe('Data Entry through the Data Collection Instrument', () => {
    before(() => {
        cy.set_user_type('standard')
    })

	describe('Record Status Dashboard', () => {
        before(() => {
            cy.visit_version({page: 'DataEntry/record_status_dashboard.php', params: "pid=1"})
        })

		it('Should display a listing of all existing records', () => {
		    cy.get('table#record_status_table').should(($table) => {
			expect($table).to.contain('No records exist')
		    })
		})

		it('Should display a listing with the appropriate form statuses', () => {
		   cy.get('table#record_status_table').should(($table) => {
			expect($table).to.contain('Demographics')
			expect($table).to.contain('Baseline Data')
			expect($table).to.contain('Month 1 Data')
			expect($table).to.contain('Month 2 Data')
			expect($table).to.contain('Month 3 Data')
			expect($table).to.contain('Completion Data')
		    })
		})
	})

	describe('Entering Data', () => {
		before(() => {
		    cy.visit_version({page: 'DataEntry/record_home.php', params: "pid=1"})
		    cy.get('button').contains('Add new record').click({force:true})
		})

		it('Should have the ability to create a record', () => {
			cy.get('table#event_grid_table tbody td a').first().click()
			cy.get('button').contains('Save & Exit Form').click()
			cy.get('body').should(($body) => {
			expect($body).to.contain('Study ID 1 successfully added')
		    })
		})

		it('Should have the ability to enter data for core field types', () => {    
		    cy.get('table#event_grid_table tbody td a').first().click()       
		    cy.select_text_by_label('Date subject signed consent').type('01/01/2019')
		    cy.select_text_by_label('First Name').type('Rosie')
		    cy.select_text_by_label('Last Name').type('Riveter')
		    cy.select_textarea_by_label('Street, City, State, ZIP').type("555 Fake Address\nBeverly Hills, CA 90210")

		    cy.select_radio_by_label('Ethnicity').first().click()
		    cy.select_radio_by_label('Sex').first().click()

		    cy.select_field_by_label('Race').select('Asian')
		    cy.select_checkbox_by_label('Is patient taking any of the following medications? (check all that apply)').first().check()
		    cy.select_field_by_label('Complete?').select('Complete')

		    cy.get('button').contains('Save & Exit Form').click()

		    cy.get('body').should(($body) => {
			expect($body).to.contain('Study ID 1 successfully edited')
		    })
		})

		it('Should have the ability to reset a multiple-choice radio button selection', () => {
		    cy.get('table#event_grid_table tbody td a').first().click()

		    cy.select_radio_by_label('Ethnicity').parent().parent().should(($td) => {
			let $a = $td.find('> div a')
			let $reset_exists = expect($a).to.contain('reset')
			if ($reset_exists) $a.click() 
		    })
		})

		describe('Date / Time Fields', () => {
			it('Should display a date picker widget on a date field', () => {
				cy.get('img.ui-datepicker-trigger').click({multiple:true})
			})

			it('Should display a Today button', () => {
			    cy.get('button').should(($btn) => {
			        expect($btn).to.contain('Today')
			    })

			cy.get('button').contains('Save & Exit Form').click()

			cy.get('body').should(($body) => {
			    expect($body).to.contain('Study ID 1 successfully edited')
			})
		})
	})
	})

	describe('Saving Data', () => {
        before (() => {
            cy.visit_version({page: 'DataEntry/record_home.php', params: "pid=1"})
            cy.get('button').contains('Add new record').click({force:true})
            cy.get('table#event_grid_table tbody td a').first().click()  
            cy.select_checkbox_by_label('Is patient taking any of the following medications? (check all that apply)').first().check()
        })

		describe('Attempted Leave without Save Prompt', () => {
			it('Should prompt to save when an attempt to navigate away from a data entry page without saving', () => {
                cy.get('a').contains('Project Setup').click({force:true})
                cy.get('div#stayOnPageReminderDialog').should(($div) => {
                    expect($div).to.contain('If you have made any data changes on this page, they will be lost if you leave without saving them')
                })
			})

			it('Should provide the ability to save changes and leave', () => {
                cy.get('button').should(($btn) => {
                    expect($btn).to.contain('Save changes and leave')
                })
			})

			it('Should provide the ability to leave without saving changes', () => {
                cy.get('button').should(($btn) => {
                    expect($btn).to.contain('Leave without saving changes')
                })
			})

			it('Should provide the ability to stay on the page', () => {
                cy.get('button').should(($btn) => {
                    expect($btn).to.contain('Stay on page')
                })
			})
		})

		describe('Save Options', () => {
            before (() => {
                cy.get('button').contains('Stay on page').click({force:true})
            })

			it('Should have the ability to save and exit the form', () => {
                cy.get('button').should(($btn) => {
                    expect($btn).to.contain('Save & Exit Form')
                })
			})

			it('Should have the ability to save and continue on the same form for the same record', () => {
                cy.get('div').should(($li) => {
                    expect($li).to.contain('Save & Stay')
                })
			})

			it('Should have the ability to save and go to the next form for the same record', () => {
                cy.get('div').should(($li) => {
                    expect($li).to.contain('Save & Go To Next Form')
                })
			})

			it('Should have the ability to cancel the data entered and leave the record', () => {
                cy.get('button').should(($btn) => {
                    expect($btn).to.contain('-- Cancel --')
                })
			})
		})

		describe('Form Statuses', () => {

			it('Should have the ability to mark the form as Incomplete (with data)', () => {
                cy.get('select').contains('Incomplete').parent().select('Incomplete')
            })

            it('Should have the ability to mark the form as Incomplete (no saved data)', () => {
                cy.get('[type="checkbox"]').uncheck()
                cy.get('select').contains('Incomplete').parent().select('Incomplete')
			})

			it('Should have the ability to mark the form as Unverified', () => {
                cy.get('select').contains('Unverified').parent().select('Unverified')
			})

			it('Should have the ability to mark the form as Complete', () => {
                cy.get('select').contains('Complete').parent().select('Complete')
			})
		})
	})

	describe('Deleting Data', () => {
	    before(() => {
	        cy.get('div').contains('Save & Stay').click({force:true})
	    })

		it('Should have the ability to delete all data on the current form of a given record', () => {
            cy.get('button').should(($btn) => {
                expect($btn).to.contain('Delete data for THIS FORM only')
            })
		})

		it('Should have the ability to delete an individual record', () => {
            cy.get('div').contains('Save & Exit Form').click({force:true})
            cy.get('li').should(($li) => {
                expect($li).to.contain('Delete record (all forms)')
            })
		})

        it('Should have the ability to delete all data in an event for a given record', () => {
            cy.visit_version({page: 'DataEntry/record_home.php', params: "pid=1&arm=1&id=1"})
            cy.get('ul li').contains('Delete record (all forms)')
        })
	})
})
