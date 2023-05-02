import { Given } from "cypress-cucumber-preprocessor/steps"

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I select the submit option labeled {string} on the Data Collection Instrument
 * @param {string} text - the text that appears on the option in the dropdown (options: Save & Stay, Save & Exit Record, Save & Go To Next Record, Save & Exit Form, Save & Go To Next Form)
 * @description Clicks on a "Save" option on a Data Collection instrument form
 */
 Given("I select the submit option labeled \"{instrument_save_options}\" on the Data Collection Instrument", (text) => {

     //REDCap does some crazy conditional display of buttons, so we try to handle that as we best can
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
 * @example I click on the button labeled (exactly) {string}
 * @param {string} text - the text on the button element you want to click
 * @param {string} text (optional) - < on the dialog box for the Repeatable Instruments and Events module>
 * @description Clicks on a button element with a specific text label.
 */
Given("I click on the button {labeledExactly} {string}{saveButtonRouteMonitoring}{baseElement}", (exactly, text, button_type, base_element) => {
    const choices = {
        '' : 'div[role=dialog][style*=z-index]:visible,html',
        ' on the tooltip' : 'div[class*=tooltip]:visible',
        ' on the role selector dropdown' : 'div[id=assignUserDropdownDiv]:visible',
        ' on the dialog box' : 'div[role=dialog][style*=z-index]:visible'
    }

    let outer_element = 'div[role=dialog][style*=z-index]:visible,html'

    if(base_element.length > 0){
        outer_element = choices[base_element]
    }

    if(button_type === " on the dialog box for the Repeatable Instruments and Events module"){
        cy.intercept({
            method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + "/*RepeatInstanceController:saveSetup*"
        }).as('repeat_save')
    } else if(button_type === " on the Designate Instruments for My Events page") {
        cy.intercept({
            method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/Design/designate_forms_ajax*'
        }).as('designate_instruments')
    } else if(button_type === " on the Online Designer page"){
        cy.intercept({
            method: 'GET',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/Design/online_designer_render_fields.php*'
        }).as('online_designer')
    } else if(button_type === " and cancel the confirmation window"){
        cy.on('window:confirm', (str) => {
            return false
        })
    } else if(button_type === " and accept the confirmation window"){
        cy.on('window:confirm', (str) => {
            return true
        })
    }

    if(exactly === 'labeled exactly'){
        let sel = `button:contains("${text}"):visible:first,input[value*="${text}"]:visible:first`

        cy.top_layer(sel, outer_element).within(() => {
            cy.get(':button:visible').contains(new RegExp("^" + text + "$", "g")).click()
        })

    } else {
        let sel = `button:contains("${text}"):visible:first,input[value*="${text}"]:visible:first`

        cy.top_layer(sel, outer_element).within(() => {
            cy.get(sel).click()
        })
    }

    if(button_type === " on the dialog box for the Repeatable Instruments and Events module"){
        cy.wait('@repeat_save')
    } else if (button_type === " on the Designate Instruments for My Events page") {
        cy.wait('@designate_instruments')
    } else if (button_type === " on the Online Designer page") {
        cy.wait('@online_designer')
    } else if (button_type === " and cancel the confirmation window") {
        cy.on('window:confirm', (str) => {
            return true //subsequent windows go back to default behavior 
        })
    }
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the < link | tab > labeled (exactly) {string}
 * @param {string} text - the text on the anchor element you want to click
 * @description Clicks on an anchor element with a specific text label.
 */
Given("I click on the {linkNames} {labeledExactly} {string}", (link_name, exactly, text) => {
    if(exactly === 'labeled exactly'){
        cy.get('a:visible').contains(new RegExp("^" + text + "$", "g")).click()
    } else {
        cy.get('a:visible').contains(text).click()
    }
})

/**
 * @module Interactions
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I close the popup
 * @description Closes popup with button labeled "Close"
 */
 Given("I close the popup", (text) => {
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
 * @example I (clear field and) enter {string} into the input field labeled {string}
 * @param {string} text - the text to enter into the field
 * @param {string} label - the label of the field
 * @description Enters a specific text string into a field identified by a label.  (NOTE: The field is not automatically cleared.)
 */
Given('I {enter_type} {string} into the input field labeled {string}', (enter_type, text, label) => {
    let sel = `:contains("${label}"):visible`
    let element = `input[type=text]:not(.ui-helper-hidden-accessible):visible:first,input[type=password]:visible:first`

    cy.get_top_layer(($el) => { expect($el.find(sel)).length.to.be.above(0)} ).within(() => {

        let elm = null

        cy.contains(label).then(($label) => {
            cy.wrap($label).parent().then(($parent) =>{

                if($parent.find(element).length){
                    elm = cy.wrap($parent).find(element)
                } else if ($parent.parent().find(element).length ) {
                    elm = cy.wrap($parent).parent().find(element)
                }

                if(enter_type === "enter"){
                    elm.type(text)
                } else if (enter_type === "clear field and enter") {
                    if(text.length > 0){
                        elm.clear().type(text)
                    } else {
                        elm.clear().type(`{enter}`)
                    }
                }
            })
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
Given('I {enter_type} {string} into the textarea field labeled {string}', (enter_type, text, label) => {
    //We locate the label element first.  This isn't always a label which is unfortunate, but this approach seems to work so far.
    let label_selector = `:contains("${label}"):visible`
    let element_selector = `textarea:visible:first`

    cy.top_layer(label_selector).within(() => {
        let selector = cy.get_labeled_element(element_selector, label)

        if(enter_type === "enter"){
            selector.type(text)
        } else if (enter_type === "clear field and enter") {
            if(text.length > 0){
                selector.clear().type(text)
            } else {
                selector.clear().type(`{enter}`)
            }
        }
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
 * @example I < click on | check | uncheck > the checkbox labeled {string}
 * @param {string} label - the label associated with the checkbox field
 * @description Selects a checkbox field by its label
 */
Given("I {click_type} the checkbox labeled {string}", (check, label) => {
    let label_selector = `:contains("${label}"):visible`
    let element_selector = `input[type=checkbox]:visible`
    cy.top_layer(label_selector).within(() => {
        let selector = cy.get_labeled_element(element_selector, label)
        if (check === "click on") {
            selector.scrollIntoView().click()
        } else if (check === "check") {
            selector.scrollIntoView().check()
        } else if (check === "uncheck") {
            selector.scrollIntoView().uncheck()
        }
    })
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
    let sel = 'input[name=' + name + ']'

    cy.get_top_layer(($el) => { expect($el.find(sel)).length.to.be.above(0)} ).within(() => {
        cy.get('input[name=' + name + ']').then(($field) => {
            cy.wrap($field).selectFile(path)
        })
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
 * @example for this scenario, I will < accept | cancel > a confirmation window containing the text {string}
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
 * @example I select {string} on the < dropdown | multiselect > field labeled {string}
 * @param {string} text - the text to enter into the field
 * @param {string} label - the label of the field
 * @description Selects a specific item from a dropdown
 */
Given('I select {string} on the {dropdown_type} field labeled {string}{baseElement}', (option, type, label, base_element) => {
    const choices = {
        '' : 'div[role=dialog][style*=z-index]:visible,html',
        ' on the tooltip' : 'div[class*=tooltip]:visible',
        ' on the role selector dropdown' : 'div[id=assignUserDropdownDiv]:visible',
        ' on the dialog box' : 'div[role=dialog][style*=z-index]:visible'
    }

    let outer_element = choices[base_element]

    let label_selector = `:contains("${label}"):visible`
    let element_selector = `select:has(option:contains("${option}")):visible:enabled`
    cy.top_layer(label_selector, outer_element).within(() => {
        cy.get_labeled_element(element_selector, label, option).then(($select) => {
            cy.wrap($select).scrollIntoView().
                should('be.visible').
                should('be.enabled').then(($t) => {
                    cy.wait(500)
                    cy.wrap($t).select(option)
                    cy.wait(500)
                })
        })
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