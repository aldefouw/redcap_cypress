describe('Data Entry through the Data Collection Instrument', () => {
	before(() => {
		cy.set_user_type('admin')
		cy.visit_version({page: 'ControlCenter/validation_type_setup.php'})
		cy.get('button').contains('Enable').then(($btn) => {
			$btn.click({force: true})
		})
		
	})
    it('Test spec here', () => {
            
    })

    it('Test spec here', () => {
            
    })
})