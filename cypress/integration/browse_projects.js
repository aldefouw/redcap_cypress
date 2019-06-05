describe('Browse Projects', () => {

    it('Should display the "Browse Projects" page when you click on "Control Center"', () => {
        cy.visit_v({ page: '' }).then(() => {                
            cy.get('a').contains('Control Center').click().then(() => {
                cy.get('a').contains('Browse Projects').click().then(() => {  
                    cy.get('div h4').should('contain', 'Browse Projects')
                })
            })            
        })
    })

    describe('Display Projects', () => { 

        before(() => {
            cy.visit_v({page: 'ControlCenter/view_projects.php'})
        })

        it('Should display a list of all projects', () => {
            cy.get('button').contains('View all projects').click().then(() => {
                cy.get('table#table-proj_table').find('tr:visible').should('have.length', 13)
            })
        })

        it('Should display the projects for Test User when you click the view button', () => {
            cy.visible_projects_user_input_click_view('test_user', 'Test Project', 1)
        })


        it('Should display the projects for Test User when you click on the user after entering the username', () => {
           cy.visible_projects_user_input('test_user', 'Test Project', 1)
        }) 

        it('Should display the projects for Test User when you click on the user after entering the email address', () => {
            cy.visible_projects_user_input('test_user@example.com', 'Test Project', 1)
        })  

    })

    describe('Filter Projects', () => {

        it('Should filter project by title', () => {

            cy.visit_v({page: 'ControlCenter/view_projects.php'}).then(() => {

                cy.require_redcap_stats()

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
    })
    
    describe('Sort Columns', () => {

        before(() => {
            cy.visit_v({page: 'ControlCenter/view_projects.php'}).then(() => {
               cy.require_redcap_stats()
               cy.get('button').contains('View all projects').click()
            })
        })

        it('Should sort the Project Title column appropriately', () => {
            cy.check_column_sort_values('Project Title', 
                                        'table#table-proj_table tr:first div.projtitle', 
                                        ['Basic Demography', 'Test Project'])
        })

        it('Should sort the Records column appropriately', () => {
            cy.check_column_sort_classes('Records', 
                                         ['pid-cntr-10', 'pid-cntr-5'])
        })

        it('Should sort the Fields column appropriately', () => {
            cy.check_column_sort_values('Fields', 
                                        'table#table-proj_table tr:first div', 
                                        ['2', '198'])
        })

        it('Should sort the Instrument column appropriately', () => {
            cy.check_column_sort_values('Instrument', 
                                        'table#table-proj_table tr:first div.fc span div', 
                                        ['1 form', '15 forms'])
        })

        it('Should sort the Type column appropriately', () => {
            cy.check_column_sort_values('Type', 
                                        'table#table-proj_table tr:first span.hidden', 
                                        ['0', '1']);
        })

        it('Should sort the Status column appropriately', () => {
            cy.check_column_sort_classes('Status', 
                                         ['glyphicon-check', 'glyphicon-wrench']);
        })
    })            
})