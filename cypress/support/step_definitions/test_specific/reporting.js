import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module Reporting
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the report with a column labeled {string}
 * @param {string} text the label of a column seen in a report
 * @description Visibility - Visually verifies that the report has the column name
 */
Given("I should see the report with a column labeled {string}", (text) => {

    cy.get('table[id="report_table"]').children('thead').find('th').should('contain', text)

})

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
 * @example I should see the dropdown identified by {string} with the options below for the {string} category
 * @param {string} selector the selector that identifies a checkbox
 * @param {string} category the category that the selector belongs to
 * @param {DataTable} options the Data Table of selectable options
 * @description Visibility - Visually verifies that a specified dropdown has the options for the category
 */
Given("I should see the dropdown identified by {string} with the options below for the {string} category", (selector, category, options) => {
    //Really only added this to delay cypress cause sometimes it was moving forward without being checked
    cy.get('td').contains(category).parents('tr').within(() => {
        for(let i = 0; i < options.rawTable[0].length; i++){
            cy.get(selector).should('contain', options.rawTable[0][i])
        }
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
 * @example I click on the record {string} link for the row containing {string}
 * @param {string} record - the name of the record you want to click the link for
 * @param {string} text - the name of the event you want to click the record for
 * @description Interactions - Clicks on a button element with a specific text label for a specific report name
 */
Given("I click on the record {string} link for the row containing {string}", (record, text) => {

    cy.get('table[id="report_table"]').find('tr').each( ($tr) => {
        if($tr.text().includes(text)){
            if($tr.find('a')[0].innerText.includes(record)){
                cy.wrap($tr).find('a').click()
                return false
            }
        }
    })

})

/**
 * @module Reporting
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I click on the image {string} link for the row containing {string}
 * @param {string} file the text file name of image you are looking for
 * @param {string} text the text label of the table row you are looking for
 * @description Interactions - Clicks on the image of the table row with the text label
 */
Given("I click on the image {string} link for the row containing {string}", (file, text) => {
    // might need a better phrasing for this
    cy.get('td').contains(text).parents('tr').within(() => {
        cy.get('img[src*=' + file + ']').click()
    })
})

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
                    expect($response.headers['content-disposition']).to.contain('.' + ext)
                    expect($response.headers['content-type']).to.equal(content_type)

                    cy.writeFile("cypress/downloads" + '/test_file.' + ext, $response.body)


                });
            });

        } else {
            cy.get(hyperlink).eq(i).then((anchor) => {
                const url = anchor.prop('href');

                cy.request(url).then(($response) => {

                    expect($response.status).to.equal(200)
                    expect($response.headers['content-disposition']).to.contain('.' + ext)
                    expect($response.headers['content-type']).to.equal(content_type)

                    cy.writeFile("cypress/downloads" + '/test_file.' + ext, $response.body)


                });
            });
        }
    }

})

/**
 * @module Reporting
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should have a {string} file that contains {int} rows
 * @param {string} format the text format of the data export you are looking to receive
 * @param {DataTable} headings the DataTable of headings this file should have
 * @description Interactions - Checks the number of rows (excluding header) the file should have
 */
Given("I should have a {string} file that contains the headings below", (format, headings) => {

    cy.readFile("cypress/downloads" + '/test_file.' + format).then( ($text) => {
        let lines = $text.trim().split('\n')
        let header_line = headings.rawTable[0][0]
        for(let i = 1; i < headings.rawTable[0].length; i++){
            header_line += "," + headings.rawTable[0][i]
        }

        expect(lines[0]).to.equal(header_line)
    })

})

/**
 * @module Reporting
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should have a {string} file that contains {int} rows
 * @param {string} format the text format of the data export you are looking to receive
 * @param {int} count the number of rows of data this file should have
 * @description Interactions - Checks the number of rows (excluding header) the file should have
 */
Given("I should have a {string} file that contains {int} rows", (format, count) => {

    cy.readFile("cypress/downloads" + '/test_file.' + format).then( ($text) => {
        let lines = $text.trim().split('\n')
        expect(lines.length).to.equal(count + 1)
    })

})