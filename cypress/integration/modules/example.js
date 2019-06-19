describe('Module Example', () => {

	before(() => {

	    //Fetch the modules SQL seed data (located in test_db/modules/example.sql)
	    cy.mysql_db('/modules/example') 
	
	})

    it('Your module spec here', () => {

    })

})