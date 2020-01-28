describe('Branching Logic', () => {
	before(() => {
		cy.set_user_type('admin')
		cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=5'})
		cy.get('button#setupEnableSurveysBtn').click({force:true})
		cy.visit_version({page: 'ProjectSetup/other_functionality.php', params: "pid=5"})
		cy.wait(1000)
        cy.get('button').contains('development status').click({force:true})
        cy.visit_version({page: 'Design/online_designer.php', params: "pid=5"})
        cy.get('button').contains('Enable').click({force:true})
        cy.get('button').contains('Save Changes').click({force:true})
        cy.get('a').contains('Basic Demography Form').click({force:true})
        cy.get('img').eq(64).parent().click({force:true})
        cy.wait(1000)
        cy.get('input').eq(96).click({force:true})
        cy.get('textarea#advBranchingBox').type('[first_name]!=""')
        cy.get('button').contains('Save').click({force:true})
        cy.get('button').contains('Close').click({force:true})
	})

	describe('User Interface', () => {
        before(() => {
            cy.visit_version({page: 'DataEntry/record_home.php', params: "pid=5"})
            cy.get('button').contains('Add new record').click({force:true})
        })
	    it('Should have the ability to show a field ONLY when specific conditions are met', () => {
            cy.get('input[name=first_name]').type('John')
            cy.get('input[name=email]').type('John@wisc.edu')
            cy.get('tr#last_name-tr').should(($tr) => {
                expect($tr).to.have.css('Display', 'table-row')
            })
            cy.get('input[name=first_name]').clear()
            cy.get('input[name=email]').clear()
            cy.get('tr#last_name-tr').should(($tr) => {
                expect($tr).to.have.css('Display', 'none')
            })
	    })
	})

	describe('Survey Interface', () => {
        before(() => {
            cy.get('a').contains('Manage Survey Participants').click({force:true})
            cy.get('button').contains('Leave without saving changes').click({force:true})
            cy.get('input#longurl').invoke('attr', 'value').then(($val) =>{
                cy.visit($val)
            })
        })
	    it('Should have the ability to show a field ONLY when specific conditions are met', () => {
            cy.get('input[name=first_name]').type('John')
            cy.get('input[name=email]').type('John@wisc.edu')
            cy.get('tr#last_name-tr').should(($tr) => {
                expect($tr).to.have.css('Display', 'table-row')
            })
            cy.get('input[name=first_name]').clear()
            cy.get('input[name=email]').clear()
            cy.get('tr#last_name-tr').should(($tr) => {
                expect($tr).to.have.css('Display', 'none')
            })
	    })
	})
})