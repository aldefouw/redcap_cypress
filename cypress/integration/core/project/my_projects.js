describe('My Projects', () => {

	before(() => {
		cy.set_user_type('standard')
		cy.visit_base({url: '?action=myprojects'})
	})

	it('Should display columns: Project Title, Records, Fields, Instruments, Type, and Status', () => {
        cy.get('div').should(($div) => {
            expect($div).to.contain('Project Title')
            expect($div).to.contain('Fields')
            expect($div).to.contain('Instrument')
            expect($div).to.contain('Type')
            expect($div).to.contain('Status')
        })
   })

   it('Should open a project when the link is clicked', () => {
        cy.get('a').contains('Test Project').click().then(() => {
            cy.get('html').should(($html) => {
                expect($html).to.contain('Test Project')
                expect($html).to.contain('Main project settings')
            })
        })
   })

   it('Should display the Record Status Dashboard when the link is clicked', () => {
        cy.get('a').contains('Record Status Dashboard').click().then(() => {
            cy.get('html').should(($html) => {
                expect($html).to.contain('Record Status Dashboard')
                expect($html).to.contain('Record ID')
                expect($html).to.contain('My First Instrument')
            })
        })
   })

   it('Should display the Online Designer when the link is clicked on the Project Setup tab', () => {
        cy.get('a').contains('Project Setup').click().then(() => {
            cy.get('html').should(($html) => {
                expect($html).to.contain('Record Status Dashboard')
                expect($html).to.contain('Record ID')
                expect($html).to.contain('My First Instrument')
            })
        })
   })

})