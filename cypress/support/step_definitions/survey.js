import { Given } from "cypress-cucumber-preprocessor/steps";

Given("I visit the public survey URL for Project ID {int}", (project_id) => {
    //Get the public survey URL as an admin so we know survey tools are available
    cy.set_user_type('admin')

    //Visit the project ID specified
    cy.visit_version({page: 'index.php', params: 'pid=' + project_id})

    //Look for the name of the Distribution Tools for a Survey
    cy.get('a').contains('Survey Distribution Tools').click()

    //Get the Public Survey URL block
    cy.get('div').contains('Public Survey URL').parent().find('input').then(($input) => {
        return $input[0].value
    }).then(($url) => {
        //Make sure we aren't logged in
        cy.logout()

        //Now we can visit the URL as an external user
        cy.visit_base({ url: $url })
    })
})

Given("I enter {string} into the {string} survey text input field", (text, field) => {
    cy.get('label').contains(field).then(($label) => {
        let table_row = $label.parentsUntil('tr').parent().first()
        cy.get(table_row).within(($s) => { cy.get('input').type(text) })
    })
})

Given("I disable surveys for Project ID {int}", (project_id) => {
    cy.intercept({
        method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + '/ProjectSetup/modify_project_setting_ajax.php?pid=*'
    }).as('projectSettings')

    //Re-enable surveys before proceeding
    cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=' + project_id})

    cy.get('div').contains('Use surveys in this project?').parent().within(($div) => {
        cy.get('button').contains('Disable').click()
    }).then(() => {
        cy.get('div').contains('Disable the usage of surveys in this project?').should('be.visible').parent().parent().within(() => {
            cy.get('button').contains('Disable').click()
        })
    })

    //Wait to make sure that the AJAX request has completed before we move onto checking data
    cy.wait('@projectSettings')
})

Given("I enable surveys for Project ID {int}", (project_id) => {
    cy.intercept({
        method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + '/ProjectSetup/modify_project_setting_ajax.php?pid=*'
    }).as('projectSettings')

    //Re-enable surveys before proceeding
    cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=' + project_id})

    cy.get('div').contains('Use surveys in this project?').parent().within(($div) => {
        cy.get('button').contains('Enable').click()
    })

    //Wait to make sure that the AJAX request has completed before we move onto next test
    cy.wait('@projectSettings')
})

Given("I should see that the {string} field contains the value of {string}", (field_label, field_value) => {
    cy.get('td').contains(field_label).parentsUntil('tr').last().parent().find('input').should('have.value', field_value)
})

Given(/^I click on the survey option label containing "(.*)" label(?: and want to track the response with a tag of "(.*)")?$/, (survey_option_label, tag) => {
    if(tag !== undefined){
        cy.window().then(win => {
            cy.stub(win, 'surveyOpen').callsFake((url, target) => {
                return win.open.wrappedMethod.call(win, url, '_self')
            }).as(tag)
        })
    }

    cy.get('ul li').contains(survey_option_label).then(($li) => {
        cy.wrap($li[0]).click() //Click the link

        if(tag !== undefined) {
            let onclick = Cypress.$($li[0]).prop('onclick').toString(); //Get the survey link
            let survey = onclick.split("surveyOpen('");
            window.redcap_survey_link = survey[1].split("'")[0];
        }
    })
})

Then("I should see the survey open exactly once by watching the tag of {string}", (tag) => {
    //Check to see if the window would have opened
    cy.get('@' + tag).should('have.been.calledOnceWithExactly', window.redcap_survey_link, 0)
})