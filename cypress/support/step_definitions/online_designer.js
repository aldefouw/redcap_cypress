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