import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module Reporting
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the report with {int} rows
 * @param {int} number the number of rows seen in a report
 * @description Visibility - Visually verifies that the report has the correct number of rows
 */
Given("I should see the report with {int} rows", (number) => {

    cy.get('table[id="report_table"]').children('tbody').find('tr').should('have.length', number)

})

/**
 * @module Reporting
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should NOT see the buttons labeled Edit, Copy, and Delete
 * 
 * @description Visibility - Visually verifies that permissions are not granted for reports
 */
Given("I should NOT see the buttons labeled Edit, Copy, and Delete", () => {

    cy.get('table[id="table-report_list"]').within(() => {
    
        cy.get('button').contains("Edit").should('not.exist')
        cy.get('button').contains("Copy").should('not.exist')
        cy.get('button').contains("Delete").should('not.exist')

    })

})

/**
 * @module Reporting
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I click on the button labeled {string} for the report named {string}
 * @param {string} button - the text on the button element you want to click
 * @param {string} report the name of the report you want to click buttons for
 * @description Interactions - Clicks on a button element with a specific text label for a specific report name
 */
Given("I click on the button labeled {string} for the report named {string}", (button, report) => {

    cy.get('table[id="table-report_list"]').within(() => {

        cy.get('tr').contains(report).parents('tr').within(() => {
            cy.get('button').contains(button).click()
        })

    })

})

/**
 * @module Reporting
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I click on the Delete image for the {string} filter category
 * @param {string} category the text label of the table row you are looking for
 * @description Interactions - Clicks on the anchor tag of the table row with the text label
 */
Given("I click on the Delete image for the {string} filter category", (category) => {
    // might need a better phrasing for this
    cy.get('td').contains(category).parents('tr').within(() => {
        cy.get('a').click()
    })
})

/*
defineParameterType({
    name: 'change',
    regexp: /add|remove/
})

Given("I {change} a Standard users Data Export permissions", (change) => {

    cy.get('a').contains('User Rights').click()

    cy.get('a').contains('test_user').click()

    cy.get('button).contains('Edit user privileges').click()

    cy.get('div[aria-describedby="editUserPopup"]').within(() => {

        change == 'add' ? cy.get('input[name="reports"]').check() : cy.get('input[name="reports"]').uncheck()
        
        cy.get('button).contains('Save Changes')
    })

})*/

/**
 * @module Reporting
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I export data for the report named {string} in {string} format
 * @param {string} report the text label of the Report you are looking for
 * @param {string} format the input value of the Radio button you are looking for
 * @description Interactions - Exports the data of the report name you are looking for, selects the export format you are looking for, and exports the data
 */
Given("I export data for the report named {string} in {string} format", (report, format) => {
    cy.get('a').contains('Data Exports, Reports, and Stats').click()

    cy.get('table[id="table-report_list"]').within(() => {
        cy.get('tr').contains(report).parents('tr').within(() => {
            cy.get('button').contains('Export Data').click({ force: true })
        })
    })

    cy.get('input[value="' + format + '"]').check()

    cy.get('div[class="ui-dialog-buttonset"]').within(() => {

        cy.get('button').contains('Export Data').click()
    })

})

/**
 * @module Reporting
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should receive a download to a {string} file
 * @param {string} format the text format of the data export you are looking to receive
 * @description Interactions - Checks the hyperlinks and download formats for the data export
 */
Given("I should receive a download to a {string} file", (format) => {

    // file types
    const downloads = {
        csv: ["csv"],
        sps: ["sps", "csv", "bat"],
        sas: ["sas", "csv", "bat"],
        r: ["r", "csv"],
        do: ["do", "csv"],
        odm: ["xml"]
    }

    const toDownload = downloads[format]

    for(let i = 0; i < toDownload.length; i++){

        let content_type;
        let hyperlink;
        let ext = toDownload[i]

        switch (ext) {
            case "bat":
                if (format == sps) {
                    hyperlink = 'a[href*="/DataExport/spss_pathway_mapper.php"]:visible'
                } else {
                    hyperlink = 'a[href*="/DataExport/sas_pathway_mapper.php"]:visible'
                }
                content_type = "application/bat"
                break;
            case "csv":
                content_type = "application/csv"
                hyperlink = 'a[href*="/FileRepository/file_download.php"]:visible'
                break;
            default:
                content_type = "application/octet-stream"
                hyperlink = 'a[href*="/FileRepository/file_download.php"]:visible'
        }

        if(ext == ".bat"){

            cy.get(hyperlink).then((anchor) => {
                const url = anchor.prop('href');

                cy.request(url).then(($response) => {

                    expect($response.status).to.equal(200)
                    expect($response.headers['content-disposition']).to.contain('.' + file)
                    expect($response.headers['content-type']).to.equal(content_type)

                    //validate csv

                });
            });

        } else {
            cy.get(hyperlink).eq(i).then((anchor) => {
                const url = anchor.prop('href');

                cy.request(url).then(($response) => {

                    expect($response.status).to.equal(200)
                    expect($response.headers['content-disposition']).to.contain('.' + file)
                    expect($response.headers['content-type']).to.equal(content_type)

                    //validate csv

                });
            });
        }
    }

})