describe('Browse Projects', function () {

    const numProjects = 13;
    const numClassicProjects = 2;
    const firstProject = "Classic Database";

    before(() => {
        cy.visit('/');
        cy.get('a').contains('Control Center').click();
        cy.get('a').contains('Browse Projects').click();
        cy.get('button').contains('View all projects').click();
    })

    beforeEach(() => {



    })

    it('displays a list of all projects', function () {

        //Check to see if there are the correct number of projects initially.
        cy.get('table#table-proj_table').find('tr:visible').should('have.length', numProjects);

    });

    it('filters project by title', function () {

        // Type in "Classic" in the filter text box
        cy.get('input#proj_search').type('Classic').then(() => {

            // See if our two test projects with the word "Classic" appear
            cy.get('table#table-proj_table').contains('Classic Database').should('be.visible');
            cy.get('table#table-proj_table').contains('Multiple Surveys (classic)').should('be.visible');

            // Make sure that a project without the word "Classic" doesn't appear
            cy.get('table#table-proj_table').contains('Test Project').should('not.be.visible');

            // See how many text rows are visible.  Should be two to match our two projects w/ word "classic"
            cy.get('table#table-proj_table').find('tr:visible').should('have.length', numClassicProjects);

            // Clear out the filter
            cy.get('input#proj_search').clear();

            // All projects should be shown again
            cy.get('table#table-proj_table').find('tr:visible').should('have.length', numProjects);
        });
    });

    it('sorts the projects appropriately when you click each column', function () {
        cy.get('table#table-proj_table tr:first a').contains('Classic Database');        
        cy.get('div').contains('Project Title').click();
        cy.get('table#table-proj_table tr:first a').contains('Basic Demography');
        cy.get('div').contains('Project Title').click();
        cy.get('table#table-proj_table tr:first a').contains('Test Project');
    });
    
});