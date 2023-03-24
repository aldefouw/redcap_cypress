import {Given} from "cypress-cucumber-preprocessor/steps";

/**
 * @module DevelopmentOnly
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I want to pause
 * @description Pauses the Cypress session. NOTE: Should only be used during development of tests.
 */
Given("I want to pause", () => {
    cy.pause()
})

/**
 * @module DevelopmentOnly
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should no longer see the element identified by {string}
 * @param {string} selector - the selector that identifies an element
 * @description Visually verifies that element exists and is not visible OR does not exist
 */
Given("I should no longer see the element identified by {string}", (selector) => {
    if(Cypress.$(selector).length)
        cy.get(selector).should('not.be.visible')
    else
        cy.get(selector).should('not.exist')
})

/**
 * @module DevelopmentOnly
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
 * @module DevelopmentOnly
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the checkbox identified by {string}, {check}
 * @param {string} selector - the selector that identifies a checkbox
 * @param {string} check - valid choices are 'checked' OR 'unchecked'
 * @description Visually verifies that a specified checkbox is checked or uncheck
 */
Given("I should see the checkbox identified by {string}, {check}", (sel, check) => {
    //Really only added this to delay cypress cause sometimes it was moving forward without being checked
    //ATTN: Function no longer needed, can probably delete if no one needs it
    check === 'checked' ? cy.get(sel).should('be.checked') : cy.get(sel).should('not.be.checked')
})

/**
 * @module DevelopmentOnly
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
 * @module DevelopmentOnly
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
 * @module DevelopmentOnly
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the element identified by {string}
 * @param {string} selector - the selector that identifies an element
 * @description Visually verifies that element exists and is visible
 */
Given("I should see the element identified by {string}", (selector) => {
    cy.get(selector).should('exist').and('be.visible')
})

/**
 * @module DevelopmentOnly
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the checkbox identified by {string}, {check}
 * @param {string} selector - the selector that identifies a checkbox
 * @param {string} check - valid choices are 'checked' OR 'unchecked'
 * @description Visually verifies that a specified checkbox is checked or uncheck
 */
Given("I should see the checkbox identified by {string}, {check}", (sel, check) => {
    //Really only added this to delay cypress cause sometimes it was moving forward without being checked
    //ATTN: Function no longer needed, can probably delete if no one needs it
    check === 'checked' ? cy.get(sel).should('be.checked') : cy.get(sel).should('not.be.checked')
})

/**
 * @module DevelopmentOnly
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the input field identified by {string} with the value {string}
 * @param {string} selector the selector that identifies an input field
 * @param {string} text the text that the input field should be set to
 * @description Visually verifies that a specified input field is set to text
 */

Given("I should see the input field identified by {string} with the value {string}", (selector, text) => {
    text = text.replaceAll('\\n', '\n')
    cy.get(selector).should("have.value", text)
})

/**
 * @module DevelopmentOnly
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the dropdown identified by {string} with the option {string} selected
 * @param {string} selector the selector that identifies a checkbox
 * @param {string} option the option that should be selected
 * @description Visually verifies that a specified dropdown has the option selected
 */
Given("I should see the dropdown identified by {string} with the option {string} selected", (selector, option) => {
    //cy.get(selector).invoke('val').should('eq', option)
    cy.get(selector).find(':selected').should('have.text', option)
})

/**
 * @module DevelopmentOnly
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should no longer see the element identified by {string}
 * @param {string} selector - the selector that identifies an element
 * @description Visually verifies that element exists and is not visible OR does not exist
 */
Given("I should no longer see the element identified by {string}", (selector) => {
    if(Cypress.$(selector).length)
        cy.get(selector).should('not.be.visible')
    else
        cy.get(selector).should('not.exist')
})

/**
 * @module DevelopmentOnly
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see a new dialog box named {string}
 * @param {string} text the id of the new dialog box
 * @description Visually verifies that there is a new dialog box with the id text
 */
Given("I should see a new dialog box named {string}", (text) => {
    // Need to make this more specific for dialog boxes dialog, simpleDialog, etc
    cy.get('div[id="' + text + '"]', { timeout: 10000 }).should('be.visible')
})

/**
 * @module DevelopmentOnly
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the dropdown identified by {string} with the options below
 * @param {string} selector the selector that identifies a dropbox
 * @param {DataTable} options the Data Table of selectable options
 * @description Visibility - Visually verifies that the element selector has the options listed
 */
Given("I should see the dropdown identified by {string} with the options below", (selector, options) => {
    for(let i = 0; i < options.rawTable[0].length; i++){
        cy.get(selector).should('contain', options.rawTable[0][i])
    }
})

/**
 * @module DevelopmentOnly
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I clear the field identified by {string}
 * @param {string} selector - the selector of the field to select
 * @description Clears the text from an input field based upon its selector
 */
Given('I clear the field identified by {string}', (selector) => {
    cy.get(selector).clear()
})

/**
 * @module DevelopmentOnly
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
 * @module DevelopmentOnly
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I check the checkbox identified by {string}
 * @param {string} value - input element
 * @description Checks the checkbox identified by its element
 */
Given('I check the checkbox identified by {string}', (value) => {
    cy.get(value).check()
})

/**
 * @module DevelopmentOnly
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I uncheck the checkbox identified by {string}
 * @param {string} value - input element
 * @description Unchecks the checkbox identified by its element
 */
Given('I uncheck the checkbox identified by {string}', (value) => {
    cy.get(value).uncheck()
})

/**
 * @module DevelopmentOnly
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I click the input element identified by {string}
 * @param {string} value - input element that you want to click
 * @description Clicks the input field
 */
Given('I click the input element identified by {string}', (value) => {
    cy.get(value).click()
})

/**
 * @module DevelopmentOnly
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example the AJAX {string} request at {string} tagged by {string} is being monitored
 * @param {string} type - the type of request to monitor (e.g. GET, POST, etc.)
 * @param {string} request_url - the URL to monitor (e.g. Design/online_designer_render_fields.php?*)
 * @param {string} tag - the specified name within Cypress we will use to keep track of this request
 * @description Monitors a specific HTTP request happening within REDCap.  Generally used to track a request that we need to WAIT for.
 */
Given("the AJAX {string} request at {string} tagged by {string} is being monitored", (type, request_url, tag) => {
    cy.intercept({
        method: type,
        url: '/redcap_v' + Cypress.env('redcap_version') + "/" + request_url
    }).as(tag)
})

/**
 * @module DevelopmentOnly
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example the AJAX request tagged by {string} has completed
 * @param {string} tag - the specified name within Cypress we will use to keep track of this request
 * @description Waits until the tagged request we monitored is finished.
 */
Given("the AJAX request tagged by {string} has completed", (tag) => {
    cy.wait('@' + tag)
})

/**
 * @module DevelopmentOnly
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
 * @module DevelopmentOnly
 * @author Tintin Nguyen <tin-tin.nguyen@nih.gov>
 * @example I should see the dropdown identified by {string} labeled {string} with the options below
 * @param {string} selector the selector that identifies a dropbox
 * @param {string} label the label of the row the selector belongs to
 * @param {DataTable} options the Data Table of selectable options
 * @description Visibility - Visually verifies that the element selector labeled label has the options listed
 */
Given("I should see the dropdown identified by {string} labeled {string} with the options below", (selector, label, options) => {
    //Really only added this to delay cypress cause sometimes it was moving forward without being checked
    cy.get('td').contains(label).parents('tr').within(() => {
        for(let i = 0; i < options.rawTable[0].length; i++){
            cy.get(selector).should('contain', options.rawTable[0][i])
        }
    })
})