import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module Logging
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I select the {string} option identified by {string} from the Filter by event dropdown field
 * @param {string} option - the text value of data collection instrument you want to target
 * @param {string} label - the text value of the select option
 * @description Select logging option from the Filter by event dropdown field
 */
 Given('I select the {string} option identified by {string} from the Filter by event dropdown field', (label, option) => {
    cy.get('select[id="logtype"]').select(label).should('have.value', option)
})

/**
 * @module Logging
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I select the {string} option from the Filter by username dropdown field
 * @param {string} text - dropdown option
 * @description Select logging option from the Filter by username dropdown field
 */
 Given('I select the {string} option from the Filter by username dropdown field', (text) => {
    cy.get('select[id="usr"]').select(text).should('have.value', text)
})

/**
 * @module Logging
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I select the {string} option from the Filter by record dropdown field
 * @param {string} text - dropdown option
 * @description Select logging option from the Filter by record dropdown field
 */
 Given('I select the {string} option from the Filter by record dropdown field', (text) => {
    cy.get('select[id="record"]').select(text).should('have.value', text)
})

/**
 * @module Logging
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I should see {string} in the logging table
 * @param {string} text - text to look for
 * @description Select logging option from the dropdown field on the logging page
 */
 Given('I should see {string} in the logging table', (text) => {
    cy.get('table').contains('td', text);
})

/**
 * @module Logging
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I export the logging data and compare against expected result in a fixture file located within /logs/ folder
 * @description Exports all logging from the Logging page
 */
 Given('I export all logging from the project and verify the result against expected logging results in the file named {string}', (fixture_file) => {
    var today = new Date();
    var day =("0"+today.getDate()).slice(-2); //Make sure we zero pad
    var month = ("0"+(today.getMonth() + 1)).slice(-2); //Make sure we zero pad
    var year = today.getFullYear();

     cy.fixture(`logs/${fixture_file}`).then(fixture_data => {
         cy.task('parseCsv', {csv_string: fixture_data}).then((expected_csv) => {
             cy.export_logging_csv_report().should((actual_csv) => {
                 actual_csv.forEach((a, i) => {
                     if(i === 0){
                         expect(actual_csv[i][0]).to.contain(expected_csv[i][0])
                     } else {
                         //Excluding unless we can figure out bulletproof method for DAY
                         //expect(actual_csv[i][0]).to.contain(`${year}-${month}-${day}`)
                     }

                     expect(actual_csv[i][1]).to.contain(expected_csv[i][1])
                     expect(actual_csv[i][2]).to.contain(expected_csv[i][2])
                     expect(actual_csv[i][3]).to.contain(expected_csv[i][3])
                 })
             })
         })
     })
})