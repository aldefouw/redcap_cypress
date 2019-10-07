describe('Data Entry through the Data Collection Instrument', () => {
	before(() => {
		cy.set_user_type('admin')
		cy.visit_version({page: 'Design/define_events.php', params: "pid=13"})
		cy.get('a').contains('Add New Arm').click({force: true })
		cy.get('input#arm_name').type('Arm 2')
		cy.get('input#savebtn').click({force: true})
		cy.get('input#descrip').type('Event 1')
		cy.get('input#addbutton').click({force: true})
		cy.visit_version({page: 'Design/define_events.php', params: "pid=13"})
		cy.get('a').contains('Arm 2').click({force: true})
		cy.get('input#descrip').type('Event 2')
		cy.get('input#addbutton').click({force: true})
		cy.visit_version({page: 'Design/define_events.php', params: "pid=13"})
		cy.get('a').contains('Arm 2').click({force: true})
		cy.get('input#descrip').type('Event 3')
		cy.get('input#addbutton').click({force: true})	
		cy.visit_version({page: 'Design/online_designer.php', params: "pid=13"})
		cy.get('span').contains('Create').parent().parent().click({force: true})
		cy.get('input#new_form-my_first_instrument').type('Field Types')
		cy.get('input').contains('Create').click({force: true})
	})
    
    it('Should allow new record to be added to Arm 1', () => {
    	cy.set_user_type('standard')	
    	cy.visit_version({page: 'DataEntry/record_home.php', params: "pid=13"})
    	cy.get('select').contains('Arm 1: Arm 1').parent().select('Arm 1: Arm 1')
    	cy.get('button').contains('Add new record').click({force: true})
    	cy.get('b').contains('is a new Record ID').should(($b) => {
    		expect($b).to.contain('Record "1"')
    	})
            
    })

    it('Test spec here', () => {
            
    })
})