import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module Survey
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I visit the public survey URL for this project
 * @description Visits the Public Survey URL of the current project we are in.
 */
Given("I visit the public survey URL for this project", () => {
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

/**
 * @module Survey
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enter {string} into the {string} survey text input field
 * @param {string} text - the text you want to enter into the survey field
 * @param {string} field - label of the survey field you want to enter text into
 * @description Enters text into a survey field specified by a particular label.
 */
Given("I enter {string} into the {string} survey text input field", (text, field) => {
    cy.get('label').contains(field).then(($label) => {
        let table_row = $label.parentsUntil('tr').parent().first()
        cy.get(table_row).within(($s) => { cy.get('input').type(text) })
    })
})

/**
 * @module Survey
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I enter {string} into the {string} text input field
 * @param {string} text - the text you want to input into the survey field
 * @param {string} variable - variable of the survey field you want to input text into
 * @description Enters text into a survey field specified by a particular label.
 */
 Given("I enter {string} into the {string} text input field", (text, variable) => {
    cy.get('input[name='+variable+']').type(text)
})

/**
 * @module Survey
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I enter {string} into the field identified by {string}
 * @param {string} text - the text you want to input into the survey field
 * @param {string} variable - variable of the survey field you want to input text into
 * @description Enters text into a survey field specified by entire selector value
 */
 Given("I enter {string} into the field identified by {string}", (text, sel) => {
    cy.get(sel).type(text)
})

/**
 * @module Survey
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I clear the field and enter {string} into the {string} text input field
 * @param {string} text - the text you want to input into the survey field
 * @param {string} variable - variable of the survey field you want to input text into
 * @description Clear text from field and enter new text into a survey field.
 */
 Given("I clear the field and enter {string} into the {string} text input field", (text, variable) => {
    cy.get('input[name='+variable+']').clear().type(text)
})

/**
 * @module Survey
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I reset the options for field labeled {string}
 * @param {string} text - Clears options from the labeled field
 * @description Clear options from field
 */
 Given("I reset the options for field labeled {string}", (text) => {
    cy.select_radio_by_label(text).parent().parent().should(($td) => {
        let $a = $td.find('> div a')
        let $reset_exists = expect($a).to.contain('reset')
        if ($reset_exists) $a.click() 
    })
})

/**
 * @module Survey
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I enter the Username: {string} and password {string} for e-signature
 * @param {string} username - username
 * @param {string} password - password
 * @description Enters credentials when enabling e-signature on survey
 */
 Given("I enter the Username: {string} and password {string} for e-signature", (username, password) => {
    cy.get('input[id="esign_username"]').type(username)
    cy.get('input[id="esign_password"').type(password)
})

/**
 * @module Survey
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enable surveys for the project
 * @description Enables surveys for the current project
 */
Given("I enable surveys for the project", () => {
    cy.intercept({
        method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + '/ProjectSetup/modify_project_setting_ajax.php?pid=*'
    }).as('enable_survey')

    cy.get('div').contains('Use surveys in this project?').parent().within(($div) => {
        cy.get('button').contains('Enable').click()
    })

    //Wait to make sure that the AJAX request has completed before we move onto next test
    cy.wait('@enable_survey')
    cy.get('#setupEnableSurveysBtn').should('contain.text', 'Disable')
})

/**
 * @module Survey
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I disable surveys for the project
 * @description Disables surveys for the current project
 */
Given("I disable surveys for the project", () => {
    cy.intercept({
        method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + '/ProjectSetup/modify_project_setting_ajax.php?pid=*'
    }).as('projectSettings')

    cy.get('div').contains('Use surveys in this project?').within(($div) => {
        cy.get('button').contains('Disable').then(($btn) => {

            //First click the button
            $btn[0].click()

            //If the onclick attribute includes firing a confirmation window
            if($btn[0].getAttribute('onclick') === "confirmUndoEnableSurveys()") {
                cy.document().its('body').find('div[role=dialog]').within(() => {
                    //Click to disable this too
                    cy.get('button').contains('Disable').click()
                })
            }
        })
    })

    //Wait to make sure that the AJAX request has completed before we move onto checking data
    cy.wait('@projectSettings')
})

/**
 * @module Survey
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I should see that the {string} field contains the value of {string}
 * @param {string} field_label - the label of the field targeted
 * @param {string} field_value - the value of the field targeted
 * @description Verifies the value present within a specific survey field.
 */
Given("I should see that the {string} field contains the value of {string}", (field_label, field_value) => {
    cy.get('td').contains(field_label).parentsUntil('tr').last().parent().find('input').should('have.value', field_value)
})

/**
 * @module Survey
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the survey option label containing {string} label and want to track the response with a tag of {string}
 * @param {string} survey_option_label - the label of the survey option specified
 * @param {string} tag - (optional) the value of the tag specified
 * @description Clicks on a survey option label.  Track it via an optional tag.
 */
Given(/^I click on the survey option label containing "(.*)" label(?: and want to track the response with a tag of "(.*)")?$/, (survey_option_label, tag = 'default_survey_option') => {
    cy.window().then(win => {
        cy.stub(win, 'surveyOpen').callsFake((url, target) => {
            return win.open.wrappedMethod.call(win, url, '_self')
        }).as(tag)
    })

    let link = null;

    cy.get('ul li').contains(survey_option_label).then(($li) => {
        cy.wrap($li[0]).click() //Click the link

        //If we need to open the survey
        if(survey_option_label === "Open survey" || survey_option_label.includes("Log out") ){
            let onclick = Cypress.$($li[0]).prop('onclick').toString(); //Get the survey link
            let survey = onclick.split("surveyOpen('");
            link = survey[1].split("'")[0];

            if(tag === 'default_survey_option') {
                cy.get('@' + tag).should('have.been.calledOnceWithExactly', link, 0)
            }

            if(survey_option_label.includes("Log out") ){
                cy.logout()
            }
            cy.visit(link)
        }

        window.redcap_survey_link = link;
    })
})

/**
 * @module Survey
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I should see the survey open exactly once by watching the tag of {string}
 * @param {string} tag - the value of the tag specified
 * @description Verifies whether the survey has opened exactly once via the tracked tag.
 */
Then("I (should) see the survey open exactly once by watching the tag of {string}", (tag) => {
    //Check to see if the window would have opened
    cy.get('@' + tag).should('have.been.calledOnceWithExactly', window.redcap_survey_link, 0)
})

/**
 * @module Survey
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I enter name {string} and create instrument
 * @param {string} formname - name of instrument
 * @description Enters instrument name and creates it
 */
 Given("I enter name {string} and create instrument", (formname) => {
    cy.get('span').contains('New instrument name') //Make sure this exists first

    cy.get('td').contains('New instrument name').parent().within(($td) => {
        cy.get('input[type=text]', {force: true}).type(formname)
        cy.get('input[value=Create]', {force: true}).click()
    })
})

/**
 * @module Survey
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I submit draft changes for review
 * @description Submits drafted changes for review
 */
 Given("I submit draft changes for review", () => {
    cy.get('input[value="Submit Changes for Review"]').should(($i) => {
        $i.first().click()
    })

    //Submit for Appproval
    cy.get('button').contains('Submit').click()
    cy.get('.ui-dialog-buttonset').contains('Close').click()
})

/**
 * @module Survey
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I add a new field of type {string} and enter {string} into the field labeled {string}
 * @param {string} field_type - type of field (for ex. textbox, radio, checkbox, etc.)
 * @param {string} field_text - text you want to enter in the field
 * @param {string} field_name - variable name
 * @description Add a new field in form
 */
 Given("I add a new field of type {string} and enter {string} into the field labeled {string}", (field_type,field_text,field_name) => {
    cy.get('input#btn-last').click().then(() => {
        cy.get('select#field_type').select(field_type)
        cy.get('input#field_name').type(field_name)
        cy.get('input#field_label_rich_text_checkbox').uncheck()
        cy.get('textarea#field_label').type(field_text)
        cy.get('button').contains('Save').click().then(() => {
            cy.get('table#draggable').should(($t) => {
                expect($t).to.contain('Variable: '+ field_name)
            })
        })
    })
})

/**
 * @module Survey
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I add a new field of type {string} and enter {string} into the field labeled {string}, validated by label {string}
 * @param {string} field_type - type of field (for ex. textbox, radio, checkbox, etc.)
 * @param {string} field_text - text you want to enter in the field
 * @param {string} field_name - variable name
 * @param {string} label - validation label
 * @description Add a new field in form
 */
 Given("I add a new field of type {string} and enter {string} into the field labeled {string}, validated by label {string}", (field_type,field_text,field_name,label) => {
    cy.get('input#btn-last').click().then(() => {
        cy.get('select#field_type').select(field_type)
        cy.get('input#field_name').type(field_name)
        cy.get('input#field_label_rich_text_checkbox').uncheck()
        cy.get('textarea#field_label').type(field_text)
        cy.get('select').contains(label).parent().select(label)
        cy.get('button').contains('Save').click().then(() => {
            cy.get('table#draggable').should(($t) => {
                expect($t).to.contain('Variable: '+ field_name)
            })
        })
    })
})