import { Given } from "cypress-cucumber-preprocessor/steps";
import { defineParameterType } from "cypress-cucumber-preprocessor/steps";

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the button labeled exactly {string}
 * @param {string} text - the EXACT text on the button element you want to click
 * @description Clicks on a button element with a EXACT text label.
 */
Given("I click on the button labeled exactly {string}", (text) => {
    cy.get('button').contains(new RegExp("^" + text + "$", "g")).click()
})

defineParameterType({
    name: 'instrument_save_options',
    regexp: /Save & Stay|Save & Exit Record|Save & Go To Next Record|Save & Exit Form|Save & Go To Next Form/
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

             cy.get('button').contains(text).click()

         //If the button does NOT show up on main section, let's find it in the dropdown section
         } else {

             cy.get('button#submit-btn-dropdown').
                first().
                click().
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
 * @example I click on the link labeled {string}
 * @param {string} text - the text on the anchor element you want to click
 * @description Clicks on an anchor element with a specific text label.
 */
Given("I click on the link labeled {string}", (text) => {
    cy.get('a').contains(text).should('be.visible').click({force:true})
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
 * @example I save the field
 * @description Saves a Field within the Online Designer.
 */
Given("I save the field", () => {
    cy.save_field()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enter {string} into the input field labeled {string}
 * @param {string} text - the text to enter into the field
 * @param {string} label - the label of the field
 * @description Enters a specific text string into a field identified by a label.  (NOTE: The field is not automatically cleared.)
 */
Given('I enter {string} into the input field labeled {string}', (text, label) => {
    //We locate the label element first.  This isn't always a label which is unfortunate, but this approach seems to work so far.
    cy.contains(label).then(($label) => {
        cy.wrap($label).parent().find('input').type(text)
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
Given('I enter {string} into the data entry form field labeled {string}', (text, label) => {
    cy.contains('label', label)
        .invoke('attr', 'id')
        .then(($id) => {
            cy.get('[name="' + $id.split('label-')[1] + '"]')
        })
        .type(text)
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

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the checkbox labeled {string}
 * @param {string} label - the label associated with the checkbox field
 * @description Selects a checkbox field by its label
 */
Given("I click on the checkbox labeled {string}", (label) => {
    cy.contains(label).then(($label) => {
        cy.wrap($label).parent().find('input').click()
    })
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the input element labeled {string}
 * @param {string} label - the label associated with the checkbox field
 * @description Selects a checkbox field by its label
 */
Given("I click on the input element labeled {string}", (label) => {
    cy.contains(label).then(($label) => {
        cy.wrap($label).parent().find('input').click()
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
 * @example after the next step, I will <accept/cancel> a confirmation window containing the text {string}
 * @param {string} action - valid choices are 'accept' OR 'cancel'
 * @param {string} window_text - text that is expected to appear in the confirmation window
 * @description Pre-emptively tell Cypress what to do about a confirmation window.  NOTE: This step must come BEFORE step that clicks button.
 */
Given('after the next step, I will {confirmation} a confirmation window containing the text {string}', (action, window_text) => {
    cy.on('window:confirm', (str) => {
        expect(str).to.contain(window_text)
        action === "accept"
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
 * @param {string} value - the option to select from the dropdown
 * @param {int} num - expect this many records
 * @description Selects the option via a specific string.
 */
 Given('I export all data in {string} format and expect {int} record', (value, num) => {
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
 * @param {string} value - the option to select from the dropdown
 * @description Selects the option via a specific string.
 */
 Given('I check the checkbox identified by {string}', (value) => {
    cy.get(value).check()
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
 * @example I create a new instrument from scratch
 * @description Clicks the button to create new instrument and prompts the user to add instrument
 */
 Given('I create a new instrument from scratch', () => {
    cy.get('div').
    contains('a new instrument from scratch').
    parent().
    within(($div) => {
        cy.get('button').contains('Create').click()
    })
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
 * @param {string} value - input element
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
Given('I select {string} from the Field Type dropdown of the open "Edit Field" dialog box', (dropdown_option) => {
    cy.get('select#field_type').select(dropdown_option)
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enter {string} into the field labeled {string}
 * @param {string} text - the text to enter into the field
 * @param {string} label - the label of the field
 * @description Enters a specific text string into a field identified by a label.  (NOTE: The field is not automatically cleared.)
 */
Given('I select {string} on the dropdown field labeled {string}', (text, label) => {
    cy.contains(label).then(($label) => {
        cy.wrap($label).parent().find('select').select(text)
    })
})