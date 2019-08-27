describe('System Security Settings', () => {

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

	it('Should display system offline message when user logs in', () => {
		cy.get('ul').contains('Log out').click({force: true})
		cy.set_user_type('standard')
		cy.visit_base({url: 'index.php'})
		cy.get('div').should(($div) => {
			expect($div).to.contain('REDCap is currently offline. Please return at another time. We apologize for any inconvenience.')
		})
	})

	it('Should display system offline message when admin logs in', () => {
		cy.get('ul').contains('Log out').click({force: true})
		cy.set_user_type('admin')
		cy.visit_base({url: 'index.php'})
		cy.get('div').should(($div) => {
			expect($div).to.contain('REDCap and all its projects are currently OFFLINE and are not accessible to normal users. You can return the REDCap system back to ONLINE status in the Control Center.')
		})
	})

	it('Should change system status back to "SYSTEM ONLINE"', () => {
		cy.visit_version({page: 'ControlCenter/general_settings.php'})
		cy.get('select').contains('SYSTEM ONLINE').click({force: true})
    	cy.get('input').contains('Save Changes').click({force: true})
    	cy.get('div').should(($div) => {
    		expect($div).to.contain('Your system configuration values have now been changed!')
    	})
	})

})

describe('Project Security Settings', () => {

	before(() => {
		cy.set_user_type('admin')
		cy.visit_version({page: 'ControlCenter/edit_project.php', params: "project=5"})
	})

	it('Should save changes after project status is changed from online to offline', () => {
		cy.get('select').contains('OFFLINE').click({force: true})
		cy.get('input').contains('Save Changes').click({force: true})
		cy.get('div').should(($div) => {
			expect($div).to.contain('Your changes have been saved!')
		})
	})

	it('Should display offline next to project title when user logs in', () => {
		cy.get('ul').contains('Log out').click({force: true})
		cy.set_user_type('standard')
		cy.visit_version({page: 'index.php', params: "pid=5"})
		cy.get('div').should(($div) => {
			expect($div).to.contain('REDCap is currently offline. PLease return at another time. We apologize for any inconvenience.')
		})
	})
})

