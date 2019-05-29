describe('Browse Projects', function () {

    function testColumnSortByClassName(col_name, klasses = []){
        cy.get('table#table-proj_table tr:first span').should('not.contain', "Loading").then(() => {
                cy.get('th div').contains(col_name).click().then(()=> {
            

                cy.get('table#table-proj_table tr:first span').then(($a) => { 

                    expect($a).to.have.class(klasses[0]);  

                    cy.get('th div').contains(col_name).click().then(()=>{

                        cy.get('table#table-proj_table tr:first span').then(($e) => {

                            expect($e).to.have.class(klasses[1]);                           

                        })

                    })
                })

            })
        })
    }

    function testColumnSortByValue(col_name, element, values = []){
        cy.get('table#table-proj_table tr:first span').should('not.contain', "Loading").then(() => {
            cy.get('th div').contains(col_name).click().then(()=> {            
                cy.get('table#table-proj_table tr:first ' + element).then(($a) => { 

                    expect($a).to.contain(values[0]);  

                    cy.get('th div').contains(col_name).click().then(()=>{
                        cy.get('table#table-proj_table tr:first ' + element).then(($e) => {

                            expect($e).to.contain(values[1]);                           

                        })
                    })
                })               
            })
        })
    }

    beforeEach(() => {
        cy.visit('/').then(() => {
            cy.get('a').contains('Control Center').click();
            cy.get('a').contains('Browse Projects').click();
            cy.get('button').contains('View all projects').click();
        });  
    })

    it('displays a list of all projects', function () {
        //Check to see if there are the correct number of projects initially.
        cy.get('table#table-proj_table').find('tr:visible').should('have.length', 13);
    });

    it('filters project by title', function () {

        // Type in "Classic" in the filter text box
        cy.get('input#proj_search').type('Classic').then(() => {

            // See if our two test projects with the word "Classic" appear
            cy.get('table#table-proj_table').contains('Classic Database').should('be.visible');
            cy.get('table#table-proj_table').contains('Multiple Surveys (classic)').should('be.visible');

            // Make sure that a project without the word "Classic" doesn't appear
            cy.get('table#table-proj_table').contains('Test Project').should('not.be.visible');

            // All projects should be shown again
            cy.get('table#table-proj_table').find('tr:visible').should('have.length', 2);

            // Clear out the filter
            cy.get('input#proj_search').clear();

            // See how many text rows are visible.  Should be two to match our two projects w/ word "classic"
            cy.get('table#table-proj_table').find('tr:visible').should('have.length', 13);

        });
    });

    it('sorts the Project Title column appropriately', function () {
        testColumnSortByValue("Project Title", 'div.projtitle', ["Basic Demography", "Test Project"]);
    });

    it('sorts the Records column appropriately', function () {
        testColumnSortByClassName("Records", ['pid-cnti-1', 'pid-cnti-13']);
    });

    it('sorts the Fields column appropriately', function () {
        testColumnSortByValue("Fields", 'div', ["2", "198"]);
    });

    it('sorts the Instrument column appropriately', function () {
        testColumnSortByValue("Instrument", 'div.fc span div', ["1 survey", "15 forms"]);
    });

    it('sorts the Type column appropriately', function () {
        testColumnSortByValue("Type", 'span.hidden', ["0", "1"]);
    });

    it('sorts the Status column appropriately', function () {
        testColumnSortByClassName("Status", ["glyphicon-check", "glyphicon-wrench"]);
    });

    it('displays the projects for Test User', function () {
        cy.get('input#user_search').type('test_user').then(() => {
            

        });
    });

    
});