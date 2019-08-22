describe('Project Security Settings', () => {

	before(()=> {
		cy.set_user_type('admin')
	    cy.visit_version({page: 'ControlCenter/general_settings.php'})
    })

    it('Should display system status as "SYSTEM ONLINE"', () => {
	    	cy.get('select').contains('SYSTEM ONLINE').should(($a) => { 
	    		expect($a).to.contain('SYSTEM ONLINE')
    	})   
    })

    before(()=> {
		cy.get('select').contains('SYSTEM OFFLINE').select('system_offline')
		/*
		In the ‘Custom message to display to users 
		when system is offline’ box, change 6.0 to 7.4.4.
		*/
	})

	it('Should update message to "This is a test of Vanderbilt REDCap 7.4.4 System is offline and will be back on-line shortly. Custom message to display to users when system is offline"', () => {
		cy.get('textarea').contains('This is a test of Vanderbilt REDCap 7.4.4 System is offline and will be back on-line shortly. Custom message to display to users when system is offline').should(($t) => {
			expect($t).to.contain('This is a test of Vanderbilt REDCap 7.4.4 System is offline and will be back on-line shortly. Custom message to display to users when system is offline')
		})
	})



	before(()=> {
		/*
		click save changes
		*/
	})

	it('Should save changes', () => {
		cy.get('div').contains('Save Changes').should(($s) => {
			expect($s).to.contain('Your system configuration values have now been changed')
		})
	})

	before(() => {
		cy.logout
		//logout
	})

	it('Should log user out', () => {
		
	})

	before(() => {
		cy.set_user_type('user')
	})

	it('Should display custom offline message', () => {
		//check if previously created offline message is displayed
	})
})