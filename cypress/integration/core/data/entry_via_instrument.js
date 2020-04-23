describe('Data Entry through the Data Collection Instrument', () => {

    before(() => {
        cy.set_user_type('standard')
    })

	describe('Record Status Dashboard', () => {

		it('Should display a listing of all existing records', () => {

		})

		it('Should display a listing with the appropriate form statuses', () => {

		})
	})

	describe('Entering Data', () => {

		it('Should have the ability to create a record', () => {

		})

		it('Should have the ability to enter data for core field types', () => {

		})

		it('Should have the ability to reset a multiple-choice radio button selection', () => {

		})

		describe('Date / Time Fields', () => {

			it('Should display a date picker widget on a date field', () => {

			})

			it('Should display a Now button', () => {

			})

			it('Should display a Today button', () => {

			})
		})
	})

	describe('Saving Data', () => {

		describe('Attempted Leave without Save Prompt', () => {

			it('Should prompt to save when an attempt to navigate away from a data entry page without saving', () => {

			})

			it('Should provide the ability to save changes and leave', () => {

			})

			it('Should provide the ability to leave without saving changes', () => {

			})

			it('Should provide the ability to stay on the page', () => {

			})
		})

		describe('Save Options', () => {

			it('Should have the ability to save and exit the form', () => {

			})

			it('Should have the ability to save and continue on the same form for the same record', () => {

			})

			it('Should have the ability to save and go to the next form for the same record', () => {

			})

			it('Should have the ability to cancel the data entered and leave the record', () => {

			})
		})

		describe('Form Statuses', () => {

			it('Should have the ability to mark the form as Incomplete (no saved data)', () => {

			})

			it('Should have the ability to mark the form as Incomplete (with data)', () => {

			})

			it('Should have the ability to mark the form as Unverified', () => {

			})

			it('Should have the ability to mark the form as Complete', () => {

			})
		})	
	})

	describe('Deleting Data', () => {

		it('Should have the ability to delete all data on the current form of a given record', () => {

		})

		it('Should have the ability to delete all data in an event for a given record', () => {

		})

		it('Should have the ability to delete an indivdual record', () => {

		})
	})
})
