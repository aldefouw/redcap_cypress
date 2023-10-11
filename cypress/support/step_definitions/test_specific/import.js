import {Given} from "cypress-cucumber-preprocessor/steps";

/**
 * @module Import
 * @author Coreen DSouza
 * @example I download a file by clicking on the link labeled {string}
 * @param {string} text - the text on the anchor element you want to click
 * @description Downloads a file from an anchor element with a specific text label.
 */
Given("I download a Data Import Template file {string} by clicking on the link labeled {string}", (type, text) => {
    // We do not actually click on the link because new windows and Cypress do not work.
    // Instead, we sideload a request and save it where it would go
    cy.get('a[href*="downloadTemplate"]').each(($f, index) => {
        
        if(type == 'rows' && index == 0) {
        cy.request({
            url: $f[0]['href'],
            encoding: 'binary'
        }).then((response) => {
            expect(response.status).to.equal(200);           
            cy.writeFile('cypress/downloads/' + 'Template_rows.csv', response.body, 'binary')   
          }) }
          else { 
            if(type == 'columns')
            cy.request({
                url: $f[0]['href'],
                encoding: 'binary'
            }).then((response) => {
                expect(response.status).to.equal(200);
               //cy.writeFile('cypress/downloads/' + $f[0]['innerText'] + ' columns' + '.csv', response.body, 'binary')
               cy.writeFile('cypress/downloads/' + 'Template_columns.csv', response.body, 'binary')            
              })
          }      
        }
    )
})

/**
 * @module Import
 * @author Coreen DSouza
 * @example I should have a file named {string}
 * @param {string} fileName - the name of the downloaded file
 * @description Confirms the file is downloaded
 */
Given("I should have a file named {string}", (fileName) => {
    cy.readFile('cypress/downloads/' + fileName)
})

/**
 * @module Import
 * @author Coreen DSouza
 * @example Records names {string} should contain text {string} in brackets
 * @param {string} recordIds - List of record names
 * @param {string} text - Text that appears below newly created/updated Record names
 * @description Confirms the file is downloaded
 */
Given("Records {string} should contain text {string} in brackets", (recordIds, text) => {
    cy.get('table[id=comptable]').find('tr').each(($tr, index, list) => {
        if (index > 1 && index < list.length-1){
            let recordNum = recordIds.trim().split(',') 
            {
                cy.get('th').contains(recordNum[index-2]).siblings('div.exist_impt_rec').should('have.text', text)
            }
        }
    })
})



/**
 * @module Import
 * @author Coreen DSouza
 * @example I should see old value {string} and new value {string} for Record {string} and field named {string} in the Data Display Table
 * @param {string} oldValue - The field value before update
 * @param {string} newValue - The new field value after import
 * @param {string} recordNum - The Record number
 * @param {string} fieldName - The Field Name
 * @description Old and New imported values are shown in the Data Display Table
 */
Given("I should see old value {string} and new value {string} for Record {string} and field named {string} in the Data Display Table", (oldvalue, newValue, recordNum, fieldName) => {
    cy.get('table[id=comptable] > tbody > :nth-child(2)').find('th').contains(new RegExp("^" + fieldName + "$", "g")).invoke('index').then((index) => {
        cy.get('table[id=comptable]')
            .children().contains('tr', recordNum)
            .find('td').eq(index-1).should('have.text', newValue + oldvalue )})
    })
  
/**
 * @module Import
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I see a {string} bubble for Record {string} and Instrument named {string}
 * @param {string} instrumentName - the name of the instrument 
 * @param {string} circle_colour - Green/Red /Yellow
 * @param {string} record - The Record name
 * @description - I see a {string} bubble for Record {string} and Instrument named {string}
 */
Given("I see a {string} bubble for Record {string} and Instrument named {string}", ( circle_colour , record, instrumentName) => {
    cy.get('table[id=record_status_table]').find('th').contains(instrumentName).parents('th').invoke('index').then((index) => {
        cy.get('table[id=record_status_table]')
                .children('tbody')
                .contains('tr', record).find('td')
                .eq(index).find('img[src*=' + circle_colour + ']')
    })
 })

/**
 * @module Import
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I should see error {string} corresponding to the field named {string} for record {string} in Error Display Table
 * @param {string} errorName - Description of error
 * @param {string} fieldName - The Field Name
 * @param {string} recordNum - The Record number
 * @description - I should see error {string} corresponding to the field named {string} for record {string} in Error Display Table
 */
 Given("I should see error {string} corresponding to the field named {string} for record {string} in Error Display Table", ( errorName, fieldName, recordNum) => {
        cy.get('table[id=errortable]').find('td').contains(fieldName).parent().within(() => {
           cy.get('th').contains(recordNum).should('be.visible') && cy.get('td[class=comp_new]').last().contains(errorName).should('be.visible')
        })
    })
      
/**
 * @module Import
 * @author Coreen DSouza
 * @example I should see {string} instances in the instance table
 * @param {string} numOfInstances - The number of instances for the selected Record
 * @description I should see {string} instances in the instance table
 */      
Given("I should see {string} instances in the instance table", (numOfInstances) => {
    cy.get('#instancesTablePopup').find('.repeat_event_count_menu').should('have.text', numOfInstances) 
        cy.get('a > img[src*="delete_box"]').click()
})

/**
 * @module Import
 * @author Coreen DSouza
 * @example I should see new value {string} for Record {string} and field named {string} in the Data Display Table
 * @param {string} newValue - The new field value after import
 * @param {string} recordNum - The Record number
 * @param {string} fieldName - The Field Name
 * @description Old and New imported values are shown in the Data Display Table
 */
Given("I should see new value {string} for Record {string} and field named {string} in the Data Display Table", (newValue, recordNum, fieldName) => {
    cy.get('table[id=comptable] > tbody > :nth-child(2)').find('th').contains(new RegExp("^" + fieldName + "$", "g")).invoke('index').then((index) => {
        cy.get('table[id=comptable]')
            .children().contains('tr', recordNum)
            .find('td').eq(index-1).should('have.text', newValue)
        })
    })

/**
 * @module Import
 * @author Coreen DSouza
 * @example I should see that the {string} field contains the value of {string}
 * @param {string} field_label - the label of the field targeted
 * @param {string} field_value - the value of the field targeted
 * @description Verifies the value present within a specific survey field.
 */
Given("I should see that the field named exactly {string} contains the value of {string}", (field_label, field_value) => {
    cy.get('td').contains(new RegExp("^" + field_label + "$", "g")).parentsUntil('tr').last().parent()
    .find('input').should('have.value', field_value)
})

/**
 * @module Import
 * @author Coreen DSouza
 * @example I should see corrected value {string} for Record {string} and field named {string} in the Report
 * @param {string} approxValue - The approximate value after import
 * @param {string} recordNum - The Record number
 * @param {string} fieldName - The Field Name
 * @description Missing “seconds” and missing “minutes” are appended as “00”
 */
Given("I should see corrected value {string} for Record {string} and field named {string} in the Report Table", (approxValue, recordNum, fieldName) => {
    cy.get('table[id=report_table]').find('th').contains(fieldName ).invoke('index').then((index) => {
        cy.get('table[id=report_table]').children().contains('tr', recordNum)
        .find('td').eq(index).should('have.text', approxValue)})
    })