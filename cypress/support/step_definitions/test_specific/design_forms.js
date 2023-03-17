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
 * @description Interactions - Checks a specfic checkbox for an  instrument and event name
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
 * @description Interactions - Unchecks a specfic checkbox for an  instrument and event name
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
 * @description Interactions - Clicks the Add Instrument Here button below a specific Instrument name
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
 * @description Interactions - Clicks the "choose action" button and clicks an anchor link
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
 * @description Interactions - Drag and drop the instrument to the int position
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
 * @description Clicks on one of the add field options below a specified field name
 */
Given("I click on the {addField} input button below the field named {string}", (type, target) => {
    cy.get('tbody[class=formtbody]').children('tr:contains(' + target +')').contains(target)
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
 * @description Clicks on the image link of the action you want to perform on a field
 */

 Given("I click on the {editField} image for the field named {string}", (type, field_name) => {
    cy.click_on_design_field_function(type, field_name)
})

/**
 * @module DesignForms
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I delete the field named {string}
 * @param {string} type - the type of edit action you want to perform on a field
 * @description Interactions - Clicks on the image link of the action you want to perform on a field
 */
Given("I delete the field named {string}", (field_name) => {
    cy.click_on_design_field_function("Delete Field", field_name)

    cy.intercept({
        method: 'GET',
        url: '/redcap_v' + Cypress.env('redcap_version') + "/Design/delete_field.php?*"
    }).as('delete_field')

    cy.intercept({
        method: 'GET',
        url: '/redcap_v' + Cypress.env('redcap_version') + "/Design/online_designer_render_fields.php?*"
    }).as('render_fields')

    cy.get('button').contains('Delete').click()

    cy.wait('@delete_field')
    cy.wait('@render_fields')
})

/**
 * @module DesignForms
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I move the field named {string} after the field named {string}
 * @param {string} field_name - name of field you want to move
 * @param {string} after_field - name of field you want to move AFTER
 * @description Moves a field AFTER the field specified
 */
Given("I move the field named {string} after the field named {string}", (field_name, after_field) => {
    cy.click_on_design_field_function("Move", field_name)

    //Get the variable name of the field to move "after"
    cy.get('label:contains(' + after_field + '):visible').then(($label) => {
        const after_field_var_name = $label[0]['id'].split('label-')[1]
        cy.get('#move_after_field').select(after_field_var_name).should('have.value', after_field_var_name)
    })

    cy.intercept({
        method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + "/Design/move_field.php?*"
    }).as('move_field')

    cy.get('button').contains('Move field').click()

    cy.wait('@move_field')

    cy.click_on_dialog_button("Close")
})

/**
 * @module DesignForms
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I drag on the field named {string} to the position {int}
 * @param {string} field - the name of the field being drag-n-dropped
 * @param {int} position - the position (index starting from 0) where the instrument should be placed
 * @description Interactions - Drag and drop the field to the int position
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
 * @module DesignForms
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @author Madilynn Peterson <mmpeterson24@wisc.edu>
 * @example I add a new {fieldType} field labeled {string} with variable name {string}
 * @param {string} field_type - <Text Box|Notes Box|Drop-down List|Radio Buttons|Checkboxes|Yes - No|True - False|Signature|File Upload|Slider|Descriptive Text|Begin New Section>
 * @param {string} field_label - label for the field
 * @param {string} variable_name - variable name
 * @description Creates a new field in the Online Designer
 */
Given("I add a new {fieldType} field labeled {string} with variable name {string}", (field_type, field_text, variable_name) => {
    cy.get('input#btn-last').click().then(() => {
        cy.get('select#field_type')
            .find('option')
            .contains(field_type)
            .then( ($option) => {
                cy.get('select#field_type').select($option[0].innerText)
            })

        cy.get('input#field_name').type(variable_name)
        cy.get('input#field_label_rich_text_checkbox').uncheck()
        cy.get('textarea#field_label').type(field_text)
        cy.get('button').contains('Save').click().then(() => {
            cy.get('table#draggable').should(($t) => {
                expect($t).to.contain('Variable: '+ variable_name)
            })
        })
    })
})