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
 * @example I export the logging page and open file to verify
 * @description Exports all logging from the Logging page
 */
 Given('I export the logging page and open file to verify', () => {
    var today = new Date();
    var day = today.getDate();
    var month = today.getMonth()+1;
    var year = today.getFullYear();

    cy.export_logging_csv_report().should((csv) => {
        expect(csv[0].length).to.equal(4)
        
        //Headers
        expect(csv[0][0]).to.contain('Time / Date')
        expect(csv[0][1]).to.contain('Username')
        expect(csv[0][2]).to.contain('Action')
        expect(csv[0][3]).to.contain('List of Data Changes OR Fields Exported')

        //Check if Time/Date columns contains date/time when the action occured
        expect(csv[1][0]).to.contain(`${year}-${month}-${day}`)
        
        //Users
        expect(csv[1][1]).to.contain('test_user2')
        expect(csv[14][1]).to.contain('test_user')
        expect(csv[25][1]).to.contain('test_admin')

        //Actions
        expect(csv[1][2]).to.contain('Manage/Design')
        expect(csv[4][2]).to.contain('E-signature')
        expect(csv[5][2]).to.contain('Lock/Unlock Record')
        expect(csv[6][2]).to.contain('Updated Record 1')
        expect(csv[11][2]).to.contain('Data Export')
        expect(csv[13][2]).to.contain('Updated User test_user2')
        expect(csv[14][2]).to.contain('Created User test_user2')
        expect(csv[15][2]).to.contain('Deleted User test_user2')
        expect(csv[16][2]).to.contain('Deleted Role ')
        expect(csv[18][2]).to.contain('Created Role')
        expect(csv[17][2]).to.contain('Edited Role')
        expect(csv[19][2]).to.contain('Deleted Record')
        expect(csv[20][2]).to.contain('Created Record')

        //List of Data Changes OR Fields Exported
        expect(csv[1][3]).to.contain('Approve production project modifications (automatic)')
        expect(csv[4][3]).to.contain('e-signature Record: 1 Form: Text Validation')
        expect(csv[9][3]).to.contain('Lock record Record: 1 Form: Text Validation')
        expect(csv[11][3]).to.contain('Download exported data file (CSV raw)')
        expect(csv[13][3]).to.contain('user = \'test_user2\'')
        expect(csv[14][3]).to.contain('user = \'test_user2\'')
        expect(csv[15][3]).to.contain('user = \'test_user2\'')
        expect(csv[16][3]).to.contain('role = \'Data\'')
        expect(csv[17][3]).to.contain('role = \'Data\'')
        expect(csv[18][3]).to.contain('role = \'Data\'')
        expect(csv[19][3]).to.contain('record_id = \'3\'')
        expect(csv[20][3]).to.contain('ptname = \'Delete\', email = \'delete@test.com\', text_validation_complete = \'0\', record_id = \'3\'')
    })
})