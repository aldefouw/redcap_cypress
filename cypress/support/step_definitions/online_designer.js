import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I rename the current data instrument named {string} to {string}
 * @param {string} current_name - name of current instrument
 * @param {string} new_name - name to rename the instrument to
 * @description Renames a data collection instrument
 */

Given("I rename the current data instrument named {string} to {string}", (current_name, new_name) => {
    cy.rename_instrument(current_name, new_name)
})

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I delete the data instrument named {string}
 * @param {string} instrument_name - name of current instrument
 * @description Deletes a data collection instrument
 */

Given("I delete the data instrument named {string}", (instrument_name) => {
    cy.delete_instrument(instrument_name)
})


/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enable surveys for the data instrument named {string}
 * @param {string} instrument_name - name of current instrument
 * @description Enables a data collection instrument as a survey
 */

Given("I enable surveys for the data instrument named {string}", (instrument_name) => {
    cy.enable_surveys(instrument_name)
})

/**
 * @module OnlineDesigner
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I create a new data collection instrument called {string}
 * @param {string} instrument_name - the name of the instrument to create
 * @description Clicks the button to create new instrument and enters the instrument name into the text box
 */
Given('I create a new data collection instrument called {string}', (instrument_name) => {
    cy.intercept({  method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + '/Design/create_form.php?*'
    }).as('new_data_instrument')

    cy.get('div').
    contains('a new instrument from scratch').
    parent().
    within(($div) => {
        cy.get('button').contains('Create').click()
    })

    cy.get('body').contains('Add instrument here')
    cy.get('button').contains("Add instrument here").click()
    cy.get('span').contains('New instrument name') //Make sure this exists first

    cy.get('td').contains('New instrument name').parent().within(($td) => {
        cy.get('input[type=text]').type(instrument_name)
        cy.button_or_input('Create').click()
    })

    cy.wait('@new_data_instrument').then(() => {
        //Close the dialog box which appears on newer versions of REDCap
        if (Cypress.$('div[role=dialog]').length) {
            cy.button_or_input('Close').click()
        }
    })
})

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I edit the Data Collection Instrument field labeled {string}
 * @param {string} label - the label of the field to edit
 * @description Opens the edit window for the field with the specified label
 */
Given('I edit the Data Collection Instrument field labeled {string}', (label) => {
    cy.edit_field_by_label(label)
})

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I edit the Data Collection Instrument field labeled {string}
 * @param {string} label - the label of the field to edit
 * @description Opens the edit window for the field with the specified label
 */
Given('I enter Choices of {string} into the open "Edit Field" dialog box', (choices) => {
    let field_choices = cy.select_field_choices()
    field_choices.clear()
    field_choices.type(choices)
})

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I edit the Data Collection Instrument field labeled {string}
 * @param {string} label - the label of the field to edit
 * @description Opens the edit window for the field with the specified label
 */
Given('I enter {string} into the Field Label of the open "Edit Field" dialog box', (field_label) => {
    cy.get('textarea#field_label').clear().type(field_label)
})

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I edit the Data Collection Instrument field labeled {string}
 * @param {string} label - the label of the field to edit
 * @description Opens the edit window for the field with the specified label
 */
Given('I enter {string} into the Field Label of the open "Edit Field" dialog box', (field_label) => {
    cy.get('textarea#field_label').clear().type(field_label)
})

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enter the equation {string} into Calculation Equation of the open "Edit Field" dialog box
 * @param {string} equation - the equation to enter
 * @description Enters specified equation into a Calculated Field within an open "Edit Field" dialog box
 */
Given('I enter the equation {string} into Calculation Equation of the open "Edit Field" dialog box', (equation) => {
    cy.get('textarea#element_enum').click()
    cy.get('div.ace_content').type("{shift}{home}{del}" + equation)
    cy.get('button').contains('Update & Close Editor').click()
})

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I select {string} from the Field Type dropdown of the open "Edit Field" dialog box
 * @param {string} label - the label of the field to edit
 * @description Selects option from the Field Type dropdown in open "Edit Field" dialog box
 */
Given('I select {string} from the Field Type dropdown of the open "Edit Field" dialog box', (dropdown_option) => {
    cy.get('select#field_type').select(dropdown_option)
})

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I select {string} from the Validation dropdown of the open "Edit Field" dialog box
 * @param {string} label - the label of the field to edit
 * @description Selects option from the Validation dropdown in open "Edit Field" dialog box
 */
Given('I select {string} from the Validation dropdown of the open "Edit Field" dialog box', (dropdown_option) => {
    cy.get('select#val_type').select(dropdown_option)
})

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I edit the field labeled {string}
 * @param {string} text - the text value of the label associated with a specific field
 * @description Edits a field in the Online Designer by its specified field label.
 */
Given("I edit the field labeled {string}", (text) => {
    cy.edit_field_by_label(text)
})

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I mark the field required
 * @description Marks a field as required within the Online Designer.
 */
Given("I mark the field required", () => {
    cy.get('input#field_req1').click()
})

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I mark the field as not required
 * @description Marks a field as NOT required within the Online Designer.
 */
Given("I mark the field as not required", () => {
    cy.get('input#field_req0').click()
})

/**
 * @module OnlineDesigner
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I save the field
 * @description Saves a Field within the Online Designer.
 */
Given("I save the field", () => {
    cy.save_field()
})

/**
 * @module OnlineDesigner
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I enter draft mode
 * @description Enters draft mode
 */
Given("I enter draft mode", () => {
    cy.get('html').should('contain', 'Enter Draft Mode')

    cy.button_or_input('Enter Draft Mode').click()

    //Check to see that REDCap indicates we're in DRAFT mode
    cy.get('div#actionMsg').should(($alert) => {
        expect($alert).to.contain('The project is now in Draft Mode.')
    })
})

/**
 * @module OnlineDesigner
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
 * @module OnlineDesigner
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
 * @module OnlineDesigner
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
 * @module OnlineDesigner
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
 * @module OnlineDesigner
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
 * @module OnlineDesigner
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
 * @module OnlineDesigner
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
 * @module OnlineDesigner
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
 * @module OnlineDesigner
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
 * @module OnlineDesigner
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
 * @module OnlineDesigner
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
 * @module OnlineDesigner
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
