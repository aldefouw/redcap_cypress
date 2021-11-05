import {Given} from "cypress-cucumber-preprocessor/steps";

Given('I should see {int} row(s) displayed in the projects table', (num_rows) => {
    if(num_rows === 0){
        cy.get('table#table-proj_table').find('tr:visible').should('have.length', 0)
    } else {
        cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
            cy.get('table#table-proj_table').find('tr:visible').should('have.length', num_rows)
        })
    }
})

Given('I should see a row labeled {string} in the projects table', (project_name) => {
    cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
        cy.get('table#table-proj_table tr:first div.projtitle').then(($a) => {
            expect($a).to.contain(project_name)
        })
    })
})

Given('I should see projects sorted correctly when I click on {string} to sort in either direction', (column_name) => {
    cy.check_column_sort_classes(column_name, 'td', 'span')
})