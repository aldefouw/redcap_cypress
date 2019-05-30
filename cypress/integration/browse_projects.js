describe('Browse Projects', function () {

    beforeEach(() => {
        cy.visit('/').then(() => {
            cy.get('a').contains('Control Center').click().then(() => {
                cy.get('a').contains('Browse Projects').click().then(() => {  
                    cy.get('div h4').should('contain', 'Browse Projects')
                })
            })            
        })

        cy.ignore_redcap_stats()
    })

    describe('Display Projects', function () { 

        it('displays a list of all projects', function () {
            cy.get('button').contains('View all projects').click().then(() => {
                cy.get('table#table-proj_table').find('tr:visible').should('have.length', 13)
            })            
        })

        it('displays the projects for Test User when you click the view button', function () {
            cy.get('input#user_search').type('test_user').then(() => {            
                cy.get('button#user_search_btn').click().then(() => {
                     cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
                        cy.get('table#table-proj_table tr:first div.projtitle').then(($a) => {
                            expect($a).to.contain("Test Project")
                            cy.get('table#table-proj_table').find('tr:visible').should('have.length', 1)
                        })
                     })
                })
            })
        })


        it('displays the projects for Test User when you click on the user after entering the username', function () {
           cy.get('input#user_search').type('test_user').then(() => {            
                cy.get('ul#ui-id-1 li a').click().then(($a) => {
                    cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
                         cy.get('table#table-proj_table tr:first div.projtitle').then(($a) => {
                            expect($a).to.contain("Test Project")
                            cy.get('table#table-proj_table').find('tr:visible').should('have.length', 1)
                        })
                    })
                })
            })
        }) 

        it('displays the projects for Test User when you click on the user after entering the email address', function () {
            cy.get('input#user_search').type('test_user@example.com').then(() => {            
                cy.get('ul#ui-id-1 li a').click().then(($a) => {
                    cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
                         cy.get('table#table-proj_table tr:first div.projtitle').then(($a) => {
                            expect($a).to.contain("Test Project")
                            cy.get('table#table-proj_table').find('tr:visible').should('have.length', 1)
                        })
                    })
                })
            })
        })  

    })

    describe('Filter Projects', () => {

        it('filters project by title', () => {

            cy.get('button').contains('View all projects').click().then(() => {
                // Type in "Classic" in the filter text box
                cy.get('input#proj_search').type('Classic').then(() => {

                    // See if our two test projects with the word "Classic" appear
                    cy.get('table#table-proj_table').contains('Classic Database').should('be.visible')
                    cy.get('table#table-proj_table').contains('Multiple Surveys (classic)').should('be.visible')

                    // Make sure that a project without the word "Classic" doesn't appear
                    cy.get('table#table-proj_table').contains('Test Project').should('not.be.visible')

                    // All projects should be shown again
                    cy.get('table#table-proj_table').find('tr:visible').should('have.length', 2)

                    // Clear out the filter
                    cy.get('input#proj_search').clear()

                    // See how many text rows are visible.  Should be two to match our two projects w/ word "classic"
                    cy.get('table#table-proj_table').find('tr:visible').should('have.length', 13)

                })                
            })            
        })
    })
    
    describe('Sort Columns', () => {

        it('sorts the Project Title column appropriately', () => {
            cy.check_column_sort_values('Project Title', 'table#table-proj_table tr:first div.projtitle', ['Basic Demography', 'Test Project'])
        })

        it('sorts the Records column appropriately', () => {
            cy.check_column_sort_classes('Records', ['pid-cntr-7', 'pid-cntr-13'])
        })

        it('sorts the Fields column appropriately', () => {
            cy.check_column_sort_values('Fields', 'table#table-proj_table tr:first div', ['2', '198'])
        })

        it('sorts the Instrument column appropriately', () => {
            cy.check_column_sort_values('Instrument', 'table#table-proj_table tr:first div.fc span div', ['1 form', '15 forms'])
        })

        it('sorts the Type column appropriately', () => {
            cy.check_column_sort_values('Type', 'table#table-proj_table tr:first span.hidden', ['0', '1']);
        })

        it('sorts the Status column appropriately', () => {
            cy.check_column_sort_classes('Status', ['glyphicon-check', 'glyphicon-wrench']);
        })
    })            
})