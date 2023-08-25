import { Given } from "cypress-cucumber-preprocessor/steps"

function before_click_monitor(type){
    if (type === " on the dialog box for the Repeatable Instruments and Events module"){
        cy.intercept({
            method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + "/*RepeatInstanceController:saveSetup*"
        }).as('repeat_save')
    } else if (type === " on the Designate Instruments for My Events page") {
        cy.intercept({
            method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/Design/designate_forms_ajax*'
        }).as('designate_instruments')
    } else if (type === " to rename an instrument"){
        cy.intercept({
            method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/Design/set_form_name.php*'
        }).as('rename_instrument')
    } else if (type === " on the Online Designer page"){
        cy.intercept({
            method: 'GET',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/Design/online_designer_render_fields.php*'
        }).as('online_designer')
    } else if (type === " and cancel the confirmation window"){
        cy.on('window:confirm', (str) => {
            return false
        })
    } else if (type === " and accept the confirmation window"){
        cy.window().then((win) =>
            cy.stub(win, 'confirm').as('confirm').returns(true),
        )

        cy.on('window:confirm', (str) => {
            return true
        })
    }
}

function after_click_monitor(type){
    if(type === " in the dialog box to request a change in project status"){
        cy.get('div#actionMsg').should("have.css", "display", "none")
    } else if (type === " on the dialog box for the Repeatable Instruments and Events module"){
        cy.wait('@repeat_save')
    } else if (type === " to rename an instrument"){
        cy.wait('@rename_instrument')
    } else if (type === " on the Designate Instruments for My Events page") {
        if(Cypress.$('span#progress_save').length) cy.get('span#progress_save').should('not.be.visible')
        cy.wait('@designate_instruments')
    } else if (type === " on the Online Designer page") {
        cy.wait('@online_designer')
    } else if (type === " and cancel the confirmation window") {
        cy.on('window:confirm', (str) => {
            return true //subsequent windows go back to default behavior
        })
    }
}

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
Given("I click on the{ordinal} button {labeledExactly} {string}{baseElement}{saveButtonRouteMonitoring}{iframeVisibility}{toDownloadFile}", (ordinal, exactly, text, button_type, base_element, iframe, download) => {
    let ord = 0
    if(ordinal !== undefined) ord = window.ordinalChoices[ordinal]

    before_click_monitor(button_type)

    if(download === " to download a file") {
        const loadScript = '<script> setTimeout(() => location.reload(), 1000); </script>';
        cy.get('body').invoke('append', loadScript);
    }

    let outer_element = window.elementChoices[base_element]

    if (iframe === " in the iframe"){
        const base = cy.frameLoaded().then(() => { cy.iframe() })

        if(exactly === 'labeled exactly'){
            base.within(() => {
                cy.get('button:visible,input[value*=""]:visible').contains(new RegExp("^" + text + "$", "g")).eq(ord).click()
            })
        } else {
            let sel = `button:contains("${text}"):visible,input[value*="${text}"]:visible`

            base.within(() => {
                cy.get(sel).eq(ord).click()
            })
        }

    } else {
        if(exactly === 'labeled exactly'){
            let sel = `button:contains("${text}"):visible,input[value*=""]:visible`

            cy.top_layer(sel, outer_element).within(() => {
                cy.get(':button:visible,input[value*=""]:visible').contains(new RegExp("^" + text + "$", "g")).eq(ord).click()
            })

        } else {
            let sel = `button:contains("${text}"):visible,input[value*="${text}"]:visible`

            cy.top_layer(sel, outer_element).within(() => {
                cy.get(sel).eq(ord).click()
            })
        }
    }

    after_click_monitor(button_type)
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the < link | tab > labeled (exactly) {string}
 * @param {string} text - the text on the anchor element you want to click
 * @description Clicks on an anchor element with a specific text label.
 */
Given("I click on the {linkNames} {labeledExactly} {string}{saveButtonRouteMonitoring}{toDownloadFile}{baseElement}", (link_name, exactly, text, link_type, download, base_element) => {
    before_click_monitor(link_type)

    if(base_element === undefined){
        base_element = ''
    }
    let outer_element = window.elementChoices[base_element]

    if(download === " to download a file") {
        const loadScript = '<script> setTimeout(() => location.reload(), 1000); </script>';
        cy.get('body').invoke('append', loadScript);
    }

    cy.top_layer('a:visible', outer_element).within(() => {
        if(exactly === 'labeled exactly'){
            cy.get('a:visible').contains(new RegExp("^" + text + "$", "g")).click()
        } else {
            cy.get(`a:contains(${JSON.stringify(text)}):visible`).contains(text).click()
        }
    })

    after_click_monitor(link_type)
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
 * @example I click on the radio labeled {string} in the dialog box
 * @param {string} text - the text on the button element you want to click
 * @description Clicks on a radio element with a specific text label in a dialog box.
 */
Given("I click on the radio labeled {string} in the dialog box{iframeVisibility}", (text, iframe) => {
    let element = ''
    if(iframe === " in the iframe"){ element = cy.frameLoaded().then(() => { cy.iframe() }) }
    cy.click_on_dialog_button(text, 'span', element)
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I (clear field and) enter {string} into the input field labeled {string}
 * @param {string} text - the text to enter into the field
 * @param {string} label - the label of the field
 * @description Enters a specific text string into a field identified by a label.  (NOTE: The field is not automatically cleared.)
 */
Given('I {enter_type} {string} into the input field labeled {string}{baseElement}', (enter_type, text, label, base_element) => {
    let sel = `:contains(${JSON.stringify(label)}):visible`
    let element = `input[type=text]:visible:first,input[type=password]:visible:first`

    //Either the base element as specified or the default
    let outer_element = base_element.length > 0 ?
        cy.top_layer(sel, window.elementChoices[base_element]) :
        cy.top_layer(sel)

    outer_element.within(() => {
        let elm = null

        cy.contains(label).should('be.visible').then(($label) => {
            cy.wrap($label).parent().then(($parent) =>{
                if($parent.find(element).length){
                    elm = cy.wrap($parent).find(element)
                } else if ($parent.parent().find(element).length) {
                    elm = cy.wrap($parent).parent().find(element)
                }

                if(enter_type === "enter"){
                    elm.type(text)
                } else if (enter_type === "clear field and enter") {
                    elm.clear().type(text)
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
Given('I enter {string} into the textarea field labeled {string}', (text, label) => {
    //We locate the label element first.  This isn't always a label which is unfortunate, but this approach seems to work so far.
    cy.contains(label).then(($label) => {

        cy.wrap($label).parent().find('textarea').then(($textarea) => {
            //If the textarea has a TinyMCE editor applied to it
            if($textarea.hasClass('mceEditor')){
                cy.setTinyMceContent($textarea[0]['id'], text)
            //All other cases
            } else {
                cy.wrap($textarea).type(text)
            }
        })
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
        cy.get(`label:contains(${JSON.stringify(label)})`)
            .invoke('attr', 'id')
            .then(($id) => {
                cy.get('[name="' + $id.split('label-')[1] + '"]')
            })
            .click()
            .clear()
            .type(text)
            .blur() //Remove focus after we are done so alerts pop up
    } else {
        cy.get(`label:contains(${JSON.stringify(label)})`)
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
 * @example I click on a table cell containing the text {string} in the data access groups table and clear field and (clear field and) enter {string}
 * @param {string} text - the text to locate the table cell
 * @param {string} table - the name of the table
 * @param {string} new_text - new text to type
 * @description Clicks on a table cell that is identified by a particular text string specified.
 */
Given(/^I click on (?:a|the) table cell containing the text "(.*?)"(?: in)?(?: the)? (.*?) table(?: and (.*?) "(.*?)")?$/, (text, table_type, enter_type = '', new_text = '') => {
    if(table_type === 'data access groups'){
        cy.intercept({
            method: 'GET',
            url: '/redcap_v' + Cypress.env('redcap_version') + '/index.php?route=DataAccessGroupsController:getDagSwitcherTable&tablerowsonly=1&pid=*&rowoption=dags*'
        }).as('dag_data')
    }
    let selector = window.tableMappings[table_type]
    cy.get(selector).within(() => {
        cy.get(`td:contains(${JSON.stringify(text)}):visible`).
        find(`a:contains(${JSON.stringify(text)}):visible:first, span:contains(${JSON.stringify(text)}):visible:first`).
        eq(0).then(($element) => {
            cy.wrap($element).click()

            if(enter_type === "clear field and enter"){
                cy.wrap($element).clear().type(`${new_text}{enter}`)
                if(table_type === 'data access groups') cy.wait('@dag_data')
            } else if (enter_type === "enter"){
                cy.wrap($element).type(`${new_text}{enter}`)
                if(table_type === 'data access groups') cy.wait('@dag_data')
            }
        })
    })
})

/**
 * @module RecordStatusDashboard
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click the X to delete the data access group named {string}
 * @param {string} event - name of the event displayed on the Record Home Page
 * @description Activates a pop-up confirming that user wants to delete all data on a specific even within a record
 */

Given("I click the X to delete the data access group named {string}", (dag_name) => {
    cy.table_cell_by_column_and_row_label("Delete", dag_name).then(($td) => {
        cy.wrap($td).find('a:visible:first').click({ waitForAnimations: false })
        cy.get('.ui-dialog').should('contain.text', 'Delete group')
    })
})


/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I < click on | check | uncheck > the checkbox labeled {string}
 * @param {string} label - the label associated with the checkbox field
 * @description Selects a checkbox field by its label
 */
Given("I {click_type} the {checkBoxRadio} labeled {string}{baseElement}", (check, type, label, base_element) => {
    let outer_element = window.elementChoices[base_element]
    let label_selector = `:contains("${label}"):visible`
    let element_selector = `input[type=${type}]:visible:not([disabled])`
    cy.top_layer(label_selector, outer_element).within(() => {
        let selector = cy.get_labeled_element(element_selector, label)
        if (type === "radio" || check === "click on") {
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
 * @example I < click on | check | uncheck > the checkbox labeled {string}
 * @param {string} label - the label associated with the checkbox field
 * @description Selects a checkbox field by its label
 */
Given("I {click_type} {string} for user {string} in the DAG Switcher{baseElement}", (click_type, dag, user, base_element) => {
    if(Cypress.$('img[src*="progress"]').length) cy.get('img[src*="progress"]').should('not.be.visible')

    cy.table_cell_by_column_and_row_label(user, dag, 'div.dataTables_scrollHead table', 'th', 'td', 0, 'div.dataTables_scrollBody table').then(($td) => {
        if(click_type === "click on"){
            cy.wrap($td).next('td').find('input[type=checkbox]:visible:first').click({ waitForAnimations: false })
        } else if (click_type === "check"){
            cy.wrap($td).next('td').find('input[type=checkbox]:visible:first').check({ waitForAnimations: false })
        } else if (click_type === "uncheck"){
            cy.wrap($td).next('td').find('input[type=checkbox]:visible:first').uncheck({ waitForAnimations: false })
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
Given("I set the input file field named {string} to the file at path {string}{baseElement}", (name, path, base_element) => {
    let sel = 'input[name=' + name + ']'

    //Either the base element as specified or the default
    let outer_element = base_element.length > 0 ?
        cy.top_layer(sel, window.elementChoices[base_element]) :
        cy.top_layer(sel)

    outer_element.within(() => {
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
    cy.get(':contains("' + value + '"):visible:last').click()
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
    let outer_element = window.elementChoices[base_element]
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
Given("I {enter_type} {string} into the field with the placeholder text of {string}", (enter_type, text, placeholder) => {
    const selector = 'input[placeholder="' + placeholder + '"]:visible,input[value="' + placeholder + '"]:visible'

    const elm = cy.get(selector)

    if(enter_type === "enter"){
        elm.type(text)
    } else if (enter_type === "clear field and enter") {
        elm.clear().type(text)
    }
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I close the iframe window
 * @description Closes iframe window on the To-Do List page
 */
Given("I close the iframe window", () => {
    cy.frameLoaded()
    cy.get('div.trim-close-btn').click()
})

/**
 * @module Interactions
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I click on the table heading column labeled {string}
 * @param {string} column - the text to enter into the field
 * @description Clicks on a specific table column
 */
Given('I click on the table heading column labeled {string}', (column) => {
    let selector = `table:has(th:contains("${column}"):visible):visible`

    cy.get(selector).then(($th) => {
        cy.wrap($th).find(`:contains("${column}"):visible:first`).click()
    })
})

