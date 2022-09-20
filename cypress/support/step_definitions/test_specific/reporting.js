import { Given } from "cypress-cucumber-preprocessor/steps";

//Visibility
Given("I should see the report with {int} rows", (number) => {

    cy.get('table[id="report_table"]').children('tbody').find('tr').should('have.length', number)

})

Given("I should NOT see the buttons labeled Edit, Copy, and Delete", () => {

    cy.get('table[id="table-report_list"]').within(() => {
    
        cy.get('button').contains("Edit").should('not.exist')
        cy.get('button').contains("Copy").should('not.exist')
        cy.get('button').contains("Delete").should('not.exist')

    })

})

//Interaction
Given("I click on the button labeled {string} for the report named {string}", (button, report) => {

    cy.get('table[id="table-report_list"]').within(() => {

        cy.get('tr').contains(report).parents('tr').within(() => {
            cy.get('button').contains(button).click()
        })

    })

})

Given("I click on the Delete image for the {string} filter category", (category) => {
    cy.get('td').contains(category).parents('tr').within(() => {
        cy.get('a').click()
    })
})

Given("I upload the Data Dictionary for the project {string}", (project) => {
    cy.set_user_type('admin')

    //Create the project with the Data Dictionary
    cy.visit_base({ url: './index.php?action=create' })

    cy.get('input[name="app_title"]').type(project)

    cy.get('select[name="purpose"]').select('4')

    cy.get('input[id="project_template_radio2"]').check()

    cy.fixture('core/post-production/reporting/' + project + '.xml')
        .then(Cypress.Blob.binaryStringToBlob)
        .then(blob => {
            cy.get('input[type="file"]').then($input => {
                const dd = new File([blob], project + '.xml', {
                    type: 'text/xml'
                })
                const dataTransfer = new DataTransfer()
                dataTransfer.items.add(dd)
                $input[0].files = dataTransfer.files
            })
        })

    cy.get('button').contains('Create Project').click()

    cy.get('a').contains('User Rights').click()

    cy.get('input[id="new_username"]').type("test_user")

    cy.get('button').contains('Add with custom rights').click()

    cy.get('div[aria-describedby="editUserPopup"]').within(() => {

        cy.get('input[name="user_rights"]').check()

        cy.get('input[name="data_export_tool"][value=1]').check()

        cy.get('button').contains('Add user').click()

    })

    cy.set_user_type('standard')

})

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

Given("I should receive a download to a {string} file", (extension) => {

    // file types
    const downloads = {
        csv: ["csv"],
        sps: ["sps", "csv", "bat"],
        sas: ["sas", "csv", "bat"],
        r: ["r", "csv"],
        do: ["do", "csv"],
        odm: ["xml"]
    }

    const toDownload = downloads[extension]

    toDownload.forEach(file => {

        let content_type;
        let hyperlink;

        switch (file) {
            case "bat":
                if (extension == sps) {
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

        cy.get(hyperlink).first().then((anchor) => {
            const url = anchor.prop('href');

            cy.request(url).then(($response) => {

                expect($response.status).to.equal(200)
                expect($response.headers['content-disposition']).to.contain('.' + file)
                expect($response.headers['content-type']).to.equal(content_type)

                //validate csv

            });
        });

    });


})