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

})