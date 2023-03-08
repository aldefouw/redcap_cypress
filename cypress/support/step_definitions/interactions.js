import { Given } from "cypress-cucumber-preprocessor/steps"
import { defineParameterType } from "cypress-cucumber-preprocessor/steps"

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the button labeled exactly {string}
 * @param {string} text - the EXACT text on the button element you want to click
 * @description Clicks on a button element with a EXACT text label.
 */
Given("I click on the button labeled exactly {string}", (text) => {
    cy.get('button').contains(new RegExp("^" + text + "$", "g")).click(  )
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the link labeled exactly {string}
 * @param {string} text - the EXACT text on the link element you want to click
 * @description Clicks on a link element with a EXACT text label.
 */
Given("I click on the link labeled exactly {string}", (text) => {
    cy.get('a').contains(new RegExp("^" + text + "$", "g")).click()
})

defineParameterType({
    name: 'instrument_save_options',
    regexp: /Save & Stay|Save & Exit Record|Save & Go To Next Record|Save & Exit Form|Save & Go To Next Form|Save & Go To Next Instance/
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I select the submit option labeled {string} on the Data Collection Instrument
 * @param {string} text - the text that appears on the option in the dropdown (options: Save & Stay, Save & Exit Record, Save & Go To Next Record, Save & Exit Form, Save & Go To Next Form)
 * @description Clicks on a "Save" option on a Data Collection instrument form
 */
 Given("I select the submit option labeled \"{instrument_save_options}\" on the Data Collection Instrument", (text) => {

     //REDCap does some crazy conditional display of buttons so we try to handle that as we best can
     cy.get('tr#__SUBMITBUTTONS__-tr').within(() => {
         let btn = Cypress.$("button:contains(" + JSON.stringify(text) + ")");

         //If the button shows up on the main section, we can click it like a typical element
         if(btn.length){

             cy.get('button').contains(text).click({ no_csrf_check: true })

         //If the button does NOT show up on main section, let's find it in the dropdown section
         } else {

             cy.get('button#submit-btn-dropdown').
                first().
                click({ no_csrf_check: true }).
                closest('div').
                find('a').
                contains(text).
                should('be.visible').
                click()
         }
     })
 })

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the button labeled {string}
 * @param {string} text - the text on the button element you want to click
 * @description Clicks on a button element with a specific text label.
 */
Given("I click on the button labeled {string}", (text) => {
    cy.get('button').contains(text).click()
})

/**
 * @module Interactions
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I close popup
 * @description Closes popup with button labeled "Close"
 */
 Given("I close popup", (text) => {
    cy.focused().should('have.text', 'Close').click()
 })

 /**
 * @module Interactions
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I click on the button labeled {string} for the row labeled {string}
 * @param {string} text - the text on the button element you want to click
 * @param {string} label - the lable of the row with the button you want to click
 * @description Clicks on a button element with a specific text title inside the table row label
 */
Given("I click on the button labeled {string} for the row labeled {string}", (text, label) => {
    // Find the cell that contains the label and find the parent
    cy.get('td').contains(label).parents('tr').within(() => {
        // Find the button element
        cy.get('button[title="' + text +'"]').click()
    })
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the button labeled {string} in the dialog box
 * @param {string} text - the text on the button element you want to click
 * @description Clicks on a button element with a specific text label in a dialog box.
 */
Given("I click on the button labeled {string} in the dialog box", (text) => {
    cy.click_on_dialog_button(text)
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the radio labeled {string} in the dialog box
 * @param {string} text - the text on the button element you want to click
 * @description Clicks on a radio element with a specific text label in a dialog box.
 */
Given("I click on the radio labeled {string} in the dialog box", (text) => {
    cy.click_on_dialog_button(text, 'span')
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the link labeled {string}
 * @param {string} text - the text on the anchor element you want to click
 * @description Clicks on an anchor element with a specific text label.
 */
Given("I click on the link labeled {string}", (text) => {
    cy.get('a').contains(text).click()

    // cy.location().then((loc) => {
    //     const current_url = loc.href
    //
    //     cy.get('a').contains(text).then(($text) => {
    //         //If we are staying on the same page, we need to force the click since element is guaranteed to detach
    //         if(current_url === $text[0]['href']){
    //             $text[0].click({ force: true })
    //
    //         //In all other cases, let's do a standard click
    //         } else {
    //             $text[0].click()
    //         }
    //     })
    //
    // })
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the input button labeled {string}
 * @param {string} text - the text value of the input element you want to click
 * @description Clicks on an input element with a specific text label.
 */
Given("I click on the input button labeled {string}", (text) => {
    cy.get('input[value="' + text + '"]').click()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I edit the field labeled {string}
 * @param {string} text - the text value of the label associated with a specific field
 * @description Edits a field in the Online Designer by its specified field label.
 */
Given("I edit the field labeled {string}", (text) => {
    cy.edit_field_by_label(text)
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I mark the field required
 * @description Marks a field as required within the Online Designer.
 */
Given("I mark the field required", () => {
    cy.get('input#field_req1').click()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I mark the field as not required
 * @description Marks a field as NOT required within the Online Designer.
 */
Given("I mark the field as not required", () => {
    cy.get('input#field_req0').click()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I save the field
 * @description Saves a Field within the Online Designer.
 */
Given("I save the field", () => {
    cy.save_field()
})

defineParameterType({
    name: 'enter_type',
    regexp: /enter|clear field and enter/
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enter {string} into the input field labeled {string}
 * @param {string} text - the text to enter into the field
 * @param {string} label - the label of the field
 * @description Enters a specific text string into a field identified by a label.  (NOTE: The field is not automatically cleared.)
 */
Given('I {enter_type} {string} into the input field labeled {string}', (enter_type, text, label) => {
    let sel = `:contains("${label}")`

    cy.get_top_layer(($el) => { expect($el.find(sel)).length.to.be.above(0)} ).within(() => {
        cy.contains(label).then(($label) => {
            if(enter_type === "enter"){
                cy.wrap($label).parent().find('input').type(text)
            } else if (enter_type === "clear field and enter") {
                cy.wrap($label).parent().find('input').clear().type(text)
            }
        })
    })
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enter {string} into the textarea field labeled {string}
 * @param {string} text - the text to enter into the field
 * @param {string} label - the label of the field
 * @description Enters a specific text string into a field identified by a label.  (NOTE: The field is not automatically cleared.)
 */
Given('I enter {string} into the textarea field labeled {string}', (text, label) => {
    //We locate the label element first.  This isn't always a label which is unfortunate, but this approach seems to work so far.
    cy.contains(label).then(($label) => {
        cy.wrap($label).parent().find('textarea').type(text)
    })
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enter {string} into the data entry form field labeled {string}
 * @param {string} text - the text to enter into the field
 * @param {string} label - the label of the field
 * @description Enters a specific text string into a field identified by a label.  (NOTE: The field is not automatically cleared.)
 */
Given('I {enter_type} {string} into the data entry form field labeled {string}', (enter_type, text, label) => {
    //Note that we CLICK on the field (to select it) BEFORE we type in it - otherwise the text ends up somewhere else!
    if(enter_type === "clear field and enter"){
        cy.contains('label', label)
            .invoke('attr', 'id')
            .then(($id) => {
                cy.get('[name="' + $id.split('label-')[1] + '"]')
            })
            .click()
            .clear()
            .type(text)
            .blur() //Remove focus after we are done so alerts pop up
    } else {
        cy.contains('label', label)
            .invoke('attr', 'id')
            .then(($id) => {
                cy.get('[name="' + $id.split('label-')[1] + '"]')
            })
            .click()
            .type(text)
            .blur() //Remove focus after we are done so alerts pop up
    }
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I clear the field labeled {string}
 * @param {string} label - the label of the field to select
 * @description Clears the text from an input field based upon its label
 */
Given('I clear the field labeled {string}', (label) => {
    cy.contains(label).then(($label) => {
        cy.wrap($label).parent().find('input').clear()
    })
})

/**
 * @module Interactions
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I clear the field identified by {string}
 * @param {string} selector - the selector of the field to select
 * @description Clears the text from an input field based upon its selector
 */
Given('I clear the field identified by {string}', (selector) => {
    cy.get(selector).clear()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the table cell containing a link labeled {string}
 * @param {string} text - the text in the table cell
 * @description Clicks on a table cell that is identified by a particular text string specified.
 */
Given('I click on the table cell containing a link labeled {string}', (text) => {
    cy.get('td').contains(text).parent().find('a').click()
})



/**
 * @module Interactions
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I select {string} from the dropdown identified by {string} labeled {string}
 * @param {string} value - the option to select from the dropdown
 * @param {string} selector - the selector of the dropdown to choose an option from
 * @param {string} label - the label of the dropdown to choose and option from
 * @description Selects a dropdown by its table row name, label, and the option via a specific string.
 */
Given("I select {string} from the dropdown identified by {string} labeled {string}", (value, selector, label) => {
    // Find the cell that contains the label and find the parent
    cy.get('td').contains(label).parents('tr').within(() => {
        //cy.get(sel).contains(value).parents("select").select(value, { force: true })
        cy.contains(selector, value).then(($label) => {
            cy.wrap($label).select(value, {force: true})
        })
    })
})

defineParameterType({
    name: 'element_type',
    regexp: /element|checkbox/
})
/**
 * @module Interactions
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I click on the < element | checkbox > identified by {string}
 * @param {string} element_type - valid choices are 'element' OR 'checkbox'
 * @param {string} selector - the selector of the element to click on
 * @description Clicks on an element identified by specific selector
 */
Given("I click on the {element_type} identified by {string}", (type, selector) => {
    cy.get(selector).click()
})

/**
 * @module Interactions
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I enter {string} into the field identified by {string}
 * @param {string} text - the text to enter into the field
 * @param {string} selector - the selector of the element to enter the text into
 * @description Enter text into a specific field
 */
Given("I enter {string} into the field identified by {string}", (text, sel) => {
    cy.get(sel).type(text)
})

/**
 * @module Interactions
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I enter {string} into the hidden field identified by {string}
 * @param {string} text - the text to enter into the field
 * @param {string} selector - the selector of the element to enter the text into
 * @description Enter text into a specific field that is hidden (Specifically for Logic Editor)
 */
Given("I enter {string} into the hidden field identified by {string}", (text, sel) => {
    cy.get(sel).type(text, {force: true})
})

defineParameterType({
    name: 'click_type',
    regexp: /click on|check|uncheck/
})

defineParameterType({
    name: 'checkbox_field_type',
    regexp: /checkbox|checkbox in table/
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the checkbox labeled {string}
 * @param {string} label - the label associated with the checkbox field
 * @description Selects a checkbox field by its label
 */
Given("I {click_type} the {checkbox_field_type} labeled {string}", (check, field_type, label) => {
    let sel = `:contains("${label}"):visible`

    cy.get_top_layer(($el) => { expect($el.find(sel)).length.to.be.above(0)} ).within(() => {

        let selector = null

        cy.contains(label).then(($label) => {
            if(field_type === "checkbox in table"){
                selector = cy.wrap($label).parentsUntil('tr').parent().first().find('input[type=checkbox]')
            } else {
                selector = cy.wrap($label).parentsUntil(':has(:has(input[type=checkbox]))').first().parent().find('input[type=checkbox]')
            }

            if(check === "click on"){
                selector.click()
            } else if (check === "check"){
                selector.check()
            } else if (check === "uncheck"){
                selector.uncheck()
            }
        })
    })
})

defineParameterType({
    name: 'elm_type',
    regexp: /input|list item|checkbox|span/
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the input element labeled {string}
 * @param {string} label - the label associated with the checkbox field
 * @description Selects a checkbox field by its label
 */
Given("I {click_type} the {elm_type} element labeled {string}", (click_type, element_type, label) => {
    cy.contains(label).then(($label) => {
        if(element_type === 'input'){
            cy.wrap($label).parent().find('input').click()
        } else if(element_type === 'checkbox'){
            if(click_type === "click on"){
                cy.wrap($label).parent().find('input[type=checkbox]').click()
            } else if (click_type === "check"){
                cy.wrap($label).parent().find('input[type=checkbox]').check()
            } else if (click_type === "uncheck"){
                cy.wrap($label).parent().find('input[type=checkbox]').uncheck()
            }
        } else if (element_type === "list item"){
            cy.get('li').contains(label).click()
        } else if (element_type === "span"){
            cy.get('span').contains(label).click()
        }
    })
})

/**
 * @module Interactions
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I set the input file field named {string} to the file at path {string}
 * @param {string} name - the name attribute of the input file field
 * @param {string} path - the path of the file to upload
 * @description Selects a file path to upload into input named name
 */
Given("I set the input file field named {string} to the file at path {string}", (name, path) => {
    cy.get('input[name=' + name + ']').then(($field) => {
        cy.wrap($field).selectFile(path)
    })
})

/**
 * @module Interactions
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I enter {string} into the field identified by {string} for the label {string}
 * @param {string} text - the text to enter into the field
 * @param {string} selector - the selector of the element to enter the text into
 * @param {string} label - the label associated with the field
 * @description Selects an input field by its label and then by selector
 */
Given('I enter {string} into the field identified by {string} labeled {string}', (text, selector, label) => {
    // Method is because the input on Edit Reports doesn't have a label
    // Find the cell that contains the label and find the parent
    cy.get('td').contains(label).parents('tr').within(() => {
        cy.get(selector).type(text)
    })
})


defineParameterType({
    name: 'confirmation',
    regexp: /accept|cancel/
})
/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example for this scenario, I will <accept/cancel> a confirmation window containing the text {string}
 * @param {string} action - valid choices are 'accept' OR 'cancel'
 * @param {string} window_text - text that is expected to appear in the confirmation window
 * @description Pre-emptively tell Cypress what to do about a confirmation window.  NOTE: This step must come BEFORE step that clicks button.
 */
Given('for this scenario, I will {confirmation} a confirmation window containing the text {string}', (action, window_text) => {
    cy.on('window:confirm', (str) => {
        expect(str).to.contain(window_text)
        return action === "accept"
    })
})

/**
 * @module Interactions
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I select the option labelled {string}
 * @param {string} value - the option to select from the dropdown
 * @description Selects the option via a specific string.
 */
 Given('I select the option labeled {string}', (text) => {
    cy.get('a').contains(text).should('be.visible').click()
})

/**
 * @module Interactions
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I export all data in {string} format and expect {int} record
 * @param {string} value - type of export
 * @param {int} num - expect this many records
 * @description Exports all data in selected export type
 */
 Given('I export all data in {string} format and expect {int} record(s)', (value, num) => {
    cy.get('tr#reprow_ALL').find('button.data_export_btn').should('be.visible').contains('Export Data').click()
    cy.get('input[value='+value+']').click()
    cy.export_csv_report().should((csv) => {
        expect([...new Set(csv.map((row) => row[0]).slice(1))]).to.have.lengthOf(num)                     // 2 records
    })
})

/**
 * @module Interactions
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I click on the dropdown identified by {string} and select value {string} labelled by {string}
 * @param {string} sel - select
 * @param {string} label - the label of the select
 * @param {string} value - the value to expect
 * @description Selects the option via a specific string.
 
 Given('I click on the dropdown identified by {string} and select value {string} labelled by {string}', (sel, label, value) => {
    cy.get(sel).select(label).should('have.value', value)
})
*/

/**
 * @module Interactions
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I check the checkbox identified by {string}
 * @param {string} value - input element
 * @description Checks the checkbox identified by its element 
 */
 Given('I check the checkbox identified by {string}', (value) => {
    cy.get(value).check()
})

/**
 * @module Interactions
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I uncheck the checkbox identified by {string}
 * @param {string} value - input element
 * @description Unchecks the checkbox identified by its element 
 */
 Given('I uncheck the checkbox identified by {string}', (value) => {
    cy.get(value).uncheck()
})

/**
 * @module Interactions
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I should see that the checkbox identified by {string} should be checked
 * @param {string} value - input id of the checkbox
 * @description Ensure checkbox is checked
 */
 Given('I should see that the checkbox identified by {string} should be checked', (value) => {
    cy.get(value).should('be.checked')
})

/**
 * @module Interactions
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
        cy.get('input[value=Create]').click()
    })

     cy.wait('@new_data_instrument')
})

/**
 * @module Interactions
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I click on the button labeled Remove User
 * @description Clicks the button to remove user from the User Rights page
 */
 Given('I click on the button labeled Remove User', () => {
    cy.get('div#editUserPopup').should('be.visible').parent().find('button').contains("Remove user").should('be.visible').click()
    cy.get('span').contains("Remove user?").should('be.visible').closest('div[role="dialog"]').find('button').contains("Remove user").click()
})

/**
 * @module Interactions
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I click the input element identified by {string}
 * @param {string} value - input element that you want to click
 * @description Clicks the input field
 */
 Given('I click the input element identified by {string}', (value) => {
    cy.get(value).click()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click the element containing the following text: {string}
 * @param {string} value - text that is inside the element
 * @description Clicks the element that contains the text specified
 */
Given('I click the element containing the following text: {string}', (value) => {
    cy.get(':contains(' + value + '):last').click()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I select the radio option {string} for the field labeled {string}
 * @param {string} option - option we want to select from the radio options
 * @param {string} field_label - the label on the field we want to select
 * @description Clicks the radio option on the field specified
 */
Given('I select the radio option {string} for the field labeled {string}', (radio_option, field_label) => {
    cy.select_radio_by_label(field_label, radio_option)
})


/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I select the dropdown option {string} for the Data Collection Instrument field labeled {string}
 * @param {string} dropdown_option - option we want to select from the dropdown
 * @param {string} field_label - the label on the field we want to select
 * @description Clicks the dropdown option on the field specified
 */
Given('I select the dropdown option {string} for the Data Collection Instrument field labeled {string}', (dropdown_option, field_label) => {
    cy.select_field_by_label(field_label).select(dropdown_option)
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I select the checkbox option {string} for the field labeled {string}
 * @param {string} checkbox_option - option we want to select from the dropdown
 * @param {string} field_label - the label on the field we want to select
 * @description Clicks the dropdown option on the field specified
 */
Given('I select the checkbox option {string} for the field labeled {string}', (checkbox_option, field_label) => {
    cy.select_checkbox_by_label(field_label, checkbox_option)
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I select {string} from the dropdown identified by {string}
 * @param {string} value - the option to select from the dropdown
 * @param {string} label - the label of the dropdown to choose an option from
 * @description Selects a dropdown by its label and the option via a specific string.
 */
Given('I select {string} from the dropdown identified by {string}', (value,label) => {
    cy.get(label).select(value, { force: true })
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I edit the Data Collection Instrument field labeled {string}
 * @param {string} label - the label of the field to edit
 * @description Opens the edit window for the field with the specified label
 */
Given('I edit the Data Collection Instrument field labeled {string}', (label) => {
    cy.edit_field_by_label(label)
})

/**
 * @module Interactions
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
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I edit the Data Collection Instrument field labeled {string}
 * @param {string} label - the label of the field to edit
 * @description Opens the edit window for the field with the specified label
 */
Given('I enter {string} into the Field Label of the open "Edit Field" dialog box', (field_label) => {
    cy.get('textarea#field_label').clear().type(field_label)
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I edit the Data Collection Instrument field labeled {string}
 * @param {string} label - the label of the field to edit
 * @description Opens the edit window for the field with the specified label
 */
Given('I enter {string} into the Field Label of the open "Edit Field" dialog box', (field_label) => {
    cy.get('textarea#field_label').clear().type(field_label)
})

/**
 * @module Interactions
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
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I select {string} from the Field Type dropdown of the open "Edit Field" dialog box
 * @param {string} label - the label of the field to edit
 * @description Selects option from the Field Type dropdown in open "Edit Field" dialog box
 */
Given('I select {string} from the Field Type dropdown of the open "Edit Field" dialog box', (dropdown_option) => {
    cy.get('select#field_type').select(dropdown_option)
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I select {string} from the Validation dropdown of the open "Edit Field" dialog box
 * @param {string} label - the label of the field to edit
 * @description Selects option from the Validation dropdown in open "Edit Field" dialog box
 */
Given('I select {string} from the Validation dropdown of the open "Edit Field" dialog box', (dropdown_option) => {
    cy.get('select#val_type').select(dropdown_option)
})


defineParameterType({
    name: 'dropdown_type',
    regexp: /field|table field/
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I select {string} on the dropdown field labeled {string}
 * @param {string} text - the text to enter into the field
 * @param {string} label - the label of the field
 * @description Selects a specific item from a dropdown
 */
Given('I select {string} on the dropdown {dropdown_type} labeled {string}', (text, type, label) => {
    let sel = `:contains("${label}"):visible`

    cy.get_top_layer(($el) => { expect($el.find(sel)).length.to.be.above(0)} ).within(() => {
        if(type === "table field") {
            cy.contains(label).then(($label) => {
                cy.wrap($label).parentsUntil(':has(:has(:has(:has(select))))').first().parent().parent().within(($elm) => {
                    cy.wrap($elm).find('select').select(text)
                })
            })
        } else if (type === "field"){
            cy.contains(label).then(($label) => {
                cy.wrap($label).parent().find('select').select(text)
            })
        }
    })
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I wait for {decimal} seconds
 * @param {string} seconds - the number of seconds to wait - can be an integer or decimal
 * @description Waits for a specific amount of time before moving on
 */
Given(/^I wait for (\d+(?:\.\d+)?) seconds$/, (seconds) => {
    cy.wait(seconds * 1000)
})


/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enter {string} into the field with the placeholder text of {string}
 * @param {string} text - the text to enter into the field
 * @param {string} placeholder - the text that is currently in the field as a placeholder
 * @description Enter text into a specific field
 */
Given("I enter {string} into the field with the placeholder text of {string}", (text, placeholder) => {
    cy.get('input[placeholder="' + placeholder + '"]').type(text).blur()
})