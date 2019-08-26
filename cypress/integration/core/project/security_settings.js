describe('Admin Security Settings', () => {

	before(()=> {
		cy.set_user_type('admin')
	    cy.visit_version({page: 'ControlCenter/general_settings.php'})
    })

    it('Should display system status as "SYSTEM ONLINE"', () => {
	    cy.get('select').contains('SYSTEM ONLINE').should(($a) => { 
	    	expect($a).to.contain('SYSTEM ONLINE')
    	})   
    })

    it('Should change system status to "SYSTEM OFFLINE"', () => {
    	cy.get('select').contains('SYSTEM OFFLINE').click({force: true})
    	cy.get('input').contains('Save Changes').click({force: true})
    	cy.get('div').should(($div) => {
    		expect($div).to.contain('Your system configuration values have now been changed!')
    	})
	})
})


describe('User Security Settings' , () => {

	before(()=> {
		cy.get('ul').contains('Log out').click({force: true})
		cy.set_user_type('standard')
		cy.visit_version({page: 'index.php'})	
	})

	it('Should display system offline message when user logs in', () => {
		cy.get('div').should(($div) => {
			expect($div).to.contain('REDCap is currently offline. Please return at another time. We apologize for any inconvenience.')
		})
	})
	
})

describe('Project Settings', () => {

	before(() => {
		cy.set_user_type('admin')
		cy.visit_version({page: 'ControlCenter/edit_project.php?project=5'})
	})

	it('Should save changes after project status is changed from online to offline', () => {
		cy.get('select').contains('OFFLINE').click({force: true})
		cy.get('input').contains('Save Changes').click({force: true})
		cy.get('div').should(($div) => {
			expect($div).to.contain('Your changes have been saved!')
		})
	})
	})

