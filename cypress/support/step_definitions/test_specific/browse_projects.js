import {Given} from "cypress-cucumber-preprocessor/steps";

/**
 * @module BrowseProjects
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I should see {int} row(s) displayed in the projects table
 * @param {int} num_rows - number of rows expected to be displayed in the Projects Table
 * @description Verifies the number of rows in the Browse Projects table.
 */
Given('I should see {int} row(s) displayed in the projects table', (num_rows) => {
    if(num_rows === 0){
        cy.get('table#table-proj_table').find('tr:visible').should('have.length', 0)
    } else {
        cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
            cy.get('table#table-proj_table').find('tr:visible').should('have.length', num_rows)
        })
    }
})

/**
 * @module BrowseProjects
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I should see a row labeled {string} in the projects table
 * @param {string} project_name - name of the REDCap Project we are expecting to see
 * @description Verifies a specific project - by name - is displayed within the projects table.
 */
Given('I should see a row labeled {string} in the projects table', (project_name) => {
    cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
        cy.get('table#table-proj_table tr:first div.projtitle').then(($a) => {
            expect($a).to.contain(project_name)
        })
    })
})

/**
 * @module BrowseProjects
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I should see projects sorted correctly when I click on {string} to sort in either direction
 * @param {string} column_name - name of the Column we want to click on to change the sort direction
 * @description Clicks on a specific column to sort it in the opposite direction versus initial state.
 */
Given('I should see projects sorted correctly when I click on {string} to sort in either direction', (column_name) => {
    cy.check_column_sort_classes(column_name, 'td', 'span')
})

/**
 * @module BrowseProjects
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enter {string} into the filter projects field
 * @param {string} filter_string - string that we enter into the filter field
 * @description Enters a string into the filter field on the Browse Projects page
 */
Given('I enter {string} into the filter projects field', (filter_string) => {
    cy.get('#proj_search').clear().type(filter_string)
})