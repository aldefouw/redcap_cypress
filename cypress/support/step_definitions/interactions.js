import { Given } from "cypress-cucumber-preprocessor/steps";
require("./parameter_types.js")
import { ordinal_to_int } from '../core/commands'

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

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the dropdown and select the button identified by {string}
 * @param {string} text - button id
 * @description Clicks on the button in the dropdown of the survey
 */
 Given("I click on the dropdown and select the button identified by {string}", (text) => {
    cy.get('button#submit-btn-dropdown').first().click().closest('div').find(text).should('be.visible').click()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the( {string}) button labeled {string}
 * @param {string} n - (optional) The ordinal specifying which matching button to click
 *      Valid options are "first", "second", "third", "fourth", "fifth", "sixth", "seventh", or "eighth".
 * @param {string} text - the text on the button element you want to click
 * @description Clicks on a button element with a specific text label. If `n` is not specified, the first matching
 *      button is clicked.
 */
Given(/^I click on the(?: (first|second|third|fourth|fifth|sixth|seventh|eighth|last))? button labeled "(.*)"$/, (n, text) => {
    n = ordinal_to_int(n)
    let sel = `:button:contains("${text}"):visible:nth(${n}),:button[value*="${text}"]:visible:nth(${n})` //for assertion
    cy.get_top_layer(($el) => {expect($el.find(sel)).length.to.be.above(0)}) //assertion could be improved, ugly logs
        .within(() => {
            cy.get(sel).click()
        })
})

//For comparing results of tests before z-index & n'th selector changes
Given("Old I click on the button labeled {string}", (text) => {
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
    cy.get('div[role="dialog"]').then((divs) => {
        // can be multiple layers of dialogs, find the top most - tintin edit
        let topDiv = null
        for(let i = 0; i < divs.length; i++){
            // ignore invisible dialogs
            if(divs[i].style.display == 'none') {continue}

            if(topDiv == null || divs[i].style.zIndex > topDiv.style.zIndex){
                topDiv = divs[i]
            }
        }
        cy.wrap(topDiv).find('button').contains(text).click()
    })
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the link labeled {string}
 * @param {string} text - the text on the anchor element you want to click
 * @description Clicks on an anchor element with a specific text label.
 */
Given(/^I click on the(?: (first|second|third|fourth|fifth|sixth|seventh|eighth))? link labeled "(.*)"/, (n, text) => {
    n = ordinal_to_int(n)
    let sel = `a:contains("${text}"):visible:nth(${n})`
    cy.get_top_layer(($el) => {expect($el.find(sel)).length.to.be.above(0)})
        .within(() => cy.get(sel).click())
    // cy.get(`a:contains("${text}")`).filter(':visible').first().click()
    // cy.get('a').contains(text).should('be.visible').click({force:true})
})

//For comparing results of tests before z-index & n'th selector changes
Given("Old I click on the link labeled {string}", (text) => {
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
 * @example I enter {string} into the field labeled {string}
 * @param {string} text - the text to enter into the field
 * @param {string} label - the label of the field
 * @description Enters a specific text string into a field identified by a label.  (NOTE: The field is not automatically cleared.)
 */
Given('I enter {string} into the field labeled {string}', (text, label) => {
    //We locate the label element first.  This isn't always a label which is unfortunate, but this approach seems to work so far.
    cy.contains(label).then(($label) => {
        //We are finding the parent of the label element and then looking for nearest input
        cy.wrap($label).parent().find('input').type(text)
    })
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

/**
 * @module Interactions
 * @author Corey Debacker <debacker@wisc.edu>
 * @example I click on the element identified by {string}
 * @param {string} selector - the selector of the element to click on
 * @description Clicks on an element identified by specific selector. 
 */
Given("I click on the element identified by {string}", (selector) => {
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
