describe('Data Access Groups (DAGs)', () => {

	before(() => {
		cy.set_user_type('standard')
		cy.mysql_db('projects/pristine')
	})

	describe('User Interface', () => {
		
		before(() => {
			cy.set_user_type('admin')
			cy.visit_version({page: 'DataAccessGroups/index.php', params: 'pid=1'})
		})

		it('Should have the ability to create Data Access Groups', () => {
					cy.get('input#new_group').type('Test Group')
					cy.get('button#new_group_button').click()
					cy.get('div#dags_table').should(($div) => {
						expect($div).to.contain('Test Group')
					})
	    })

	    it('Should have the ability to delete Data Access Groups', () => {
	            cy.get('tr').contains('Test Group').parent().parent().parent().within(($tr) => {
					cy.get('img').click()
				})
				cy.get('button').contains('Delete').click()
				cy.get('div#dags_table').should(($div) => {
					expect($div).not.to.contain('Test Group')
				})
	    })

	    it('Should have the ability to provide a unique Data Access Group name in the data export CSV or label', () => {

	    })

	    it('Should have the ability to assign data instruments to a specific Data Access Group', () => {
	    	
	    })

	    describe('Data Restriction Abilities', () => {

		    it('Should have the ability to restrict a user to the data they entered', () => {
		            
		    })

		    it('Should have the ability to restrict a user to the data of the same Data Access Group', () => {
		            
		    })

	    })
	}) 
})