describe('Reporting', () => {

	before(() => {
		cy.set_user_type('standard')
	})

    describe('Basic Functionality', () => {

	    it('Should have the ability to assign a name to a report', () => {
	            
	    })

	    it('Should have the ability to copy a report', () => {
	            
	    })

	    it('Should have the ability to edit a report', () => {
	            
	    })

	    it('Should have the ability to view a report', () => {
	            
	    })

	    it('Should have the ability to delete a report', () => {
	            
	    })
	})

    describe('Data Filtering Abilities', () => {

	    it('Should have the ability to filter a report based upon "equal to" criterion', () => {

	    })

	    it('Should have the ability to filter a report based upon "not equal to" criterion', () => {

	    })

	    it('Should have the ability to filter a report based upon "greater than or equal to" criterion', () => {

	    })
    })

    describe('Data Export Formats', () => {

    	it('Should have the ability to export a custom report to CSV format', () => {

    	})

    	it('Should have the ability to export a custom report to SPSS format', () => {

    	})

    	it('Should have the ability to export a custom report to SAS format', () => {

    	})

    	it('Should have the ability to export a custom report to R format', () => {

    	})

		it('Should have the ability to export a custom report to STATA format', () => {

    	})

		it('Should have the ability to export a custom report to CDISC ODM (XML) format', () => {

    	})
    })
})