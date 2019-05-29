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
        // Any steps that need to be performed before each individual spec
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

    it('sorts the Project Title column appropriately', function () {
        cy.get('th div').contains('Project Title').click();
        cy.get('table#table-proj_table tr:first a').contains('Basic Demography');
        cy.get('th div').contains('Project Title').click();
        cy.get('table#table-proj_table tr:first a').contains('Test Project');
    });

    it('sorts the Records column appropriately', function () {
        cy.get('th div').contains('Records').click();
        cy.get('table#table-proj_table tr:first span').should('have.class', 'pid-cntr-13');
        cy.get('th div').contains('Records').click();
        cy.get('table#table-proj_table tr:first span').should('have.class', 'pid-cntr-5');
    });

    it('sorts the Fields column appropriately', function () {
        cy.get('th div').contains('Fields').click();
        cy.get('table#table-proj_table tr:first span').contains('2');
        cy.get('th div').contains('Fields').click();
        cy.get('table#table-proj_table tr:first span').contains('198');
    });

    it('sorts the Instrument column appropriately', function () {
        cy.get('th div').contains('Instrument').click();
        cy.get('table#table-proj_table tr:first span').contains('1 form');
        cy.get('table#table-proj_table tr:first span').contains('3 surveys');
        cy.get('th div').contains('Instrument').click();
        cy.get('table#table-proj_table tr:first span').contains('15 forms');
    });

    it('sorts the Type column appropriately', function () {
        cy.get('th div').contains('Type').click();
        cy.get('table#table-proj_table tr:first span').contains('1');
        cy.get('th div').contains('Type').click();
        cy.get('table#table-proj_table tr:first span').contains('0');
    });

    it('sorts the Status column appropriately', function () {
        cy.get('th div').contains('Status').click();
        cy.get('table#table-proj_table tr:first span').should('have.class', 'glyphicon-check');
        cy.get('th div').contains('Status').click();
        cy.get('table#table-proj_table tr:first span').should('have.class', 'glyphicon-wrench');
    });
    
});