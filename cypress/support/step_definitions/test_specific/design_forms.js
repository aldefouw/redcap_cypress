import { Given } from "cypress-cucumber-preprocessor/steps";
///////////////
//Instruments//
///////////////

/**
 * @module DesignForms
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I add an instrument named {string} the event named {string}
 * @param {string} instrument - the name of the instrument you are adding to an event
 * @param {string} event - the name of the event you are adding an instrument to
 * @description Interacations - Checks a specfic checkbox for an  instrument and event name
 */
 Given("I add an instrument named {string} to the event named {string}", (instrument, event) => {
    
    cy.get('table[id=event_grid_table]').find('th').contains(event).parents('th').invoke('index').then((index) => {
        cy.get('table[id=event_grid_table]')
                .children('tbody')
                .contains('tr', instrument)
                .find('input').eq(index-1).check()
    })
    
})

/**
 * @module DesignForms
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I remove an instrument named {string} the event named {string}
 * @param {string} instrument - the name of the instrument you are adding to an event
 * @param {string} event - the name of the event you are adding an instrument to
 * @description Interacations - Unchecks a specfic checkbox for an  instrument and event name
 */
 Given("I remove an instrument named {string} to the event named {string}", (instrument, event) => {
    
    cy.get('table[id=event_grid_table]').find('th').contains(event).parents('th').invoke('index').then((index) => {
        cy.get('table[id=event_grid_table]')
                .children('tbody')
                .contains('tr', instrument)
                .find('input').eq(index-1).uncheck()
    })
    
})

/**
 * @module DesignForms
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I add an instrument below the instrument named {string}
 * @param {string} instrument - the name of the instrument you are adding an instrument below
 * @description Interacations - Clicks the Add Instrument Here button below a specific Instrument name
 */
 Given("I add an instrument below the instrument named {string}", (instrument) => {

    cy.get('table[id=table-forms_surveys]')
        .find('tr').contains(instrument)
            .parents('tr')
                .next().find('button').contains("Add instrument here").click()

})

/**
 * @module DesignForms
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I add an instrument below the instrument named {string}
 * @param {string} action - the action label of the link that should be clicked
 * @param {string} instrument - the name of the instrument that a form should be added below
 * @description Interacations - Clicks the "choose action" button and clicks an anchor link
 */
 Given("I click on the Instrument Action {string} for the instrument named {string}", (action, instrument) => {

    cy.get('table[id=table-forms_surveys]')
        .find('tr').contains(instrument)
            .parents('tr').find('button').contains('Choose action').click()
    cy.get('ul[id=formActionDropdown]').find('a').contains(action).click({force: true})

})

/**
 * @module DesignForms
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I drag on the instrument named {string} to the position {int}
 * @param {string} instrument - the naame of the instrument being drag-n-dropped
 * @param {int} position - the position (index starting from 0) where the instrument should be placed
 * @description Interacations - Drag and drop the instrument to the int position
 */
 Given("I drag on the instrument named {string} to position {int}", (instrument, position) => {

    cy.get('table[id=table-forms_surveys]').find('tr').contains(instrument).parents('tr').then((row) => {
        cy.get('table[id=table-forms_surveys]').find('tr').eq(position).find('td[class=dragHandle]').as('target')
        cy.wrap(row).find('td[class=dragHandle]').dragTo('@target')
    })

})

///////////
// Forms //
///////////

/**
 * @module DesignForms
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I click on the {addField} input button below the field named {string}
 * @param {addField} type - the type of addField action you want to perform
 * @param {string} target - the name of the field you want to add a field below
 * @description Interacations - Clicks on one of the add field options below a specified field name
 */
defineParameterType({
    name: 'addField',
    regexp: /(Add Field|Add Matrix of Fields|Import from Field Bank)/
})
 Given("I click on the {addField} input button below the field named {string}", (type, target) => {
    cy.get('tbody[class=formtbody]').children('tr').contains(target)
        .parents('tr').next().within(() => {
            cy.get('input[value="' + type + '"]').click()
        })
})

/**
 * @module DesignForms
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I click on the {editField} image for the field named {string}
 * @param {string} type - the type of edit action you want to perform on a field
 * @param {string} field - the name of the field you want to edit
 * @description Interacations - Clicks on the image link of the action you want to perform on a field
 */
 defineParameterType({
    name: 'editField',
    regexp: /(Edit|Branching Logic|Copy|Move|Delete Field)/
})
 Given("I click on the {editField} image for the field named {string}", (type, field) => {
    cy.get('td[class=frmedit_row]').contains(field).parents('tr').find('img[title="' + type + '"]').click()
})

/**
 * @module DesignForms
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I drag on the field named {string} to the position {int}
 * @param {string} field - the name of the field being drag-n-dropped
 * @param {int} position - the position (index starting from 0) where the instrument should be placed
 * @description Interacations - Drag and drop the field to the int position
 */
 Given("I drag on the field named {string} to position {int}", (field, position) => {

    cy.get('table[id*=design-]').contains(field).parents('table[id*=design-]').then((row) => {
        cy.get('table[id*=design-]').eq(position).as('target')
        cy.wrap(row).dragTo('@target')
    })

 })

 /**
 * @module DesignForms
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see a the field named {string} before field named {string}
 * @param {string} fieldBefore the field name that comes before
 * @param {string} fieldAfter the field name that comes after
 * @description Visually verifies that the fieldBefore is before fieldAfter
 */
  Given("I should see a the field named {string} before field named {string}", (fieldBefore, fieldAfter) => {
    cy.get('tr[id*=-tr]').contains(fieldBefore).parents('tr[id*=-tr]')
        .nextAll().contains(fieldAfter)
})

///////////////////
//Data Dictionary//
///////////////////

/**
 * @module DesignForms
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I add a new variable named {string} in the form named {string} with the field type {string} and the label {string} into the Data Dictionary file at {string}
 * @param {string} variable - the variable name being added to the data dictionary
 * @param {string} form_name - the form name of the variable being added to the data dictionary
 * @param {string} field_type - the field type of the variable being added to the data dictionary
 * @param {string} label - the label of the variable being added to the data dictionary
 * @param {string} path - the path of the data dictionary
 * @description Interactions - Add a variable, field type, form name to the data dictionary
 */
 Given("I add a new variable named {string} in the form named {string} with the field type {string} and the label {string} into the Data Dictionary file at {string}", (variable, form_name, field_type, label, path) => {

    //variable,form_name,,text,label,,,,,,,,,,,,,
    let input = variable + "," + form_name + ",,text," + label + ",,,,,,,,,,,,,\n"

    cy.writeFile(path, input, {flag: 'a+'})

})

/**
 * @module DesignForms
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I download the data dictionary and save the file as {string}
 * @param {string} name - name to save the data dictionary file
 * @description Utility - Download and save the data dictionary file
 */
 Given("I download the data dictionary and save the file as {string}", (name) => {
    cy.intercept({
        method: 'GET',
        url: '/redcap_v' + Cypress.env('redcap_version') + '/' + '/Design/data_dictionary_download.php?*'
    }).as("download")

    cy.get('a').contains("Download the current Data Dictionary").then(($btn) => {
        // work-around for timeout due cypress waiting for page to change when clicking an anchor
        // {force: true} doesn't seem to ignore actionability
        // https://github.com/cypress-io/cypress/issues/8089

        let onclick = $btn.attr("onclick")
        let func = "; setTimeout(function(){ location.reload() }, 2000);"
        $btn.attr("onclick", onclick + func)
        $btn.click()
    })
    //.click({force: true, timeout: 0})

    cy.wait("@download").then((xhr) => {
        let cd = xhr.response.headers['content-disposition']
        let filename = cd.split('filename=')[1]

        cy.readFile('cypress/downloads/' + filename).then((csv) => {
            cy.writeFile('cypress/downloads/' + name, csv)
        })
    })

})


/**
 * @module DesignForms
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example the form should have a redcap_csrf_token
 * @description Checks to verify that a redcap_csrf_token is a field on the page's form
 */
 Given("the form should have a redcap_csrf_token", () => {
    cy.get('input[name=redcap_csrf_token]')
})

/**
 * @module DesignFormsTests
 * @author Corey DeBacker <debacker@wisc.edu>
 * @description Asserts that 'Text Box', 'Notes Box', 'Calculated Field', 'Multiple Choice - Drop-down', 
 * 'Multiple Choice - Radio', 'Checkboxes', 'Signature', 'File Upload', 'Descriptive Text', and 'Begin New Section' 
 * are all available choices in the field type dropdown when adding a new field to an instrument.
 */
Given('The field types specified in step 20 of script 07 should be available',  () => {
    let options = [
        'Text Box', 'Notes Box', 'Calculated Field', 'Multiple Choice - Drop-down', 'Multiple Choice - Radio',
        'Checkboxes', 'Signature', 'File Upload', 'Descriptive Text', 'Begin New Section'
    ]
    cy.get('select#field_type').should(($select) => {
        options.forEach((option) => {
            expect($select).to.contain(option)
        })
    })
})

//TODO: refactor to custom cypress command
//Requires that the current page is the instrument editing page within the online designer
//Current implementation does not support matrix variables
Given('I should see that the choice {string} for the field {string} is coded as {string}', (choice_text, field_name, code) => {

    cy.get(`#${field_name}-tr`).within(() => {
        cy.get(`label:contains(${choice_text}), option:contains(${choice_text})`).then($e => {
            //filter matches for exact text match, in case one choice is a substring of another
            $e = $e.filter(function() {
                return (
                    cy.$$(this).text() === choice_text
                    && ! cy.$$(this).hasClass('fl')) //don't include field label
            })

            let foundCorrectCode = false
            
            if ($e.prop('tagName') === 'OPTION') {
                if ($e.attr('value') === code) {
                    foundCorrectCode = true
                }
            } else if ($e.prop('tagName') === 'LABEL') {
                let $i = $e.parent().find('input:visible')
                let type = $i.attr('type')
                if (type === 'checkbox') {
                    if ($i.attr('code') === code) {
                        foundCorrectCode = true
                    }
                } else if (type === 'radio') {
                    if ($i.attr('value') === code) {
                        foundCorrectCode = true
                    }
                }
            }

            expect(foundCorrectCode).to.be.true
        })
    })
})