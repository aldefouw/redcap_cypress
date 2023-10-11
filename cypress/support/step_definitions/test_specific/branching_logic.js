import {Given} from "cypress-cucumber-preprocessor/steps";

/**
 * @module TestSpecific/BranchingLogic
 * @author David Phillips <david.phillips22@nhs.net>
 * @example I set the branching logic of the field with the variable name {string} to {string}
 * @param {string} variableName - the field variable name
 * @param {string} branchingLogic - the branching logic
 * @description Sets the branching logic of the field with the specified variable name to the provided value.
 */
Given('I set the branching logic of the field with the variable name {string} to {string}', (variableName, branchingLogic) => {
    setBranchingLogic(variableName, branchingLogic)
    saveBranchingLogic()    
})

/**
 * @module TestSpecific/BranchingLogic
 * @author David Phillips <david.phillips22@nhs.net>
 * @example I set the branching logic of the field with the variable name {string} to {string} and {string} updating fields containing shared branching logic
 * @param {string} variableName - the field variable name
 * @param {string} branchingLogic - the branching logic
 * @param {string} autoUpdateOption - <temporarily decline|permanently decline|temporarily accept|permanently accept>
 * @description Sets the branching logic of the field with the specified variable name to the provided value and temporarily decline|permanently decline|temporarily accept|permanently accept updating fields containing shared branching logic.
 */
Given('I set the branching logic of the field with the variable name {string} to {string} and {string} updating fields containing shared branching logic', (variableName, branchingLogic, autoUpdateOption) => {
    setBranchingLogic(variableName, branchingLogic)

    cy.intercept({
        method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + "/Design/branching_logic_builder.php?*"
    }).as('builder')

    cy.intercept({
        method: 'GET',
        url: '/redcap_v' + Cypress.env('redcap_version') + "/Design/online_designer_render_fields.php?*"
    }).as('render_fields')

    if (autoUpdateOption == "temporarily decline") {
        cy.get('button').contains('Save').click()
        cy.get('button:contains("No")').click()
        cy.wait('@builder')
    }
    else if (autoUpdateOption == "temporarily accept") {
        cy.get('button').contains('Save').click()
        cy.get('button:contains("Yes")').click()
        cy.wait('@builder')
        cy.wait('@render_fields')
    }
    else if (autoUpdateOption == "permanently decline") {
        cy.get('button').contains('Save').click()
        cy.get('#branching_update_chk').check()
        cy.get('button:contains("No")').click()
        //v11.1.5
        cy.wait(['@builder', '@builder'])
        //v12.4.14
        //cy.wait(['@builder'])
    }
    else {
        cy.get('button').contains('Save').click()
        cy.get('#branching_update_chk').check()
        cy.get('button:contains("Yes")').click()
        cy.wait('@builder')
        cy.wait('@render_fields')
    }
})

/**
 * @module TestSpecific/BranchingLogic
 * @author David Phillips <david.phillips22@nhs.net>
 * @example I set the branching logic of every field to {string} excluding the fields with variable names {string}
 * @param {string} branchingLogicValue - the branching logic value
 * @param {string} excludedVariableNames - the excluded variable names (pipe separated e.g. variableName1|variableName2|variableName3)
 * @description Sets the branching logic of every field excluding the fields with variable names {string}.
 */
Given('I set the branching logic of every field to {string} excluding the fields with variable names {string}', (branchingLogicValue, excludedVariableNames) => {  
    getAllFieldsExcept(excludedVariableNames)
    .each(($variableName, index) => {
        //v11.1.5
        let variableNameNodeIndex = 2
        //v12.4.14
        //let variableNameNodeIndex = 0
        let variableName = getElementText($variableName[0], variableNameNodeIndex).trim()

        setBranchingLogic(variableName, branchingLogicValue)
        saveBranchingLogic()

        //dismisses the alert about question numbering in surveys
        //will cause an error if saving the branching logic of the first field doesn't trigger the alert
        if (index == 0) {
            cy.click_on_dialog_button('Close')
        }
    })
})

/**
 * @module TestSpecific/BranchingLogic
 * @author David Phillips <david.phillips22@nhs.net>
 * @example Every field contains the branching logic {string} excluding the fields with variable names {string}
 * @param {string} expectedBranchingLogic - the branching logic to check
 * @param {string} excludedVariableNames - the excluded variable names (pipe separated e.g. variableName1|variableName2|variableName3)
 * @description Verifies that every field contains the branching logic {string} excluding the fields with variable names {string}.
 */
Given('Every field contains the branching logic {string} excluding the fields with variable names {string}', (expectedBranchingLogic, excludedVariableNames) => {
    assertOnBranchingLogic(expectedBranchingLogic, excludedVariableNames)
})

/**
 * @module TestSpecific/BranchingLogic
 * @author David Phillips <david.phillips22@nhs.net>
 * @example I open the public survey
 * @description Opens the public survey in the main tab.
 */
Given('I open the public survey', () => {
    cy.url().as("url-prior-survey")
    cy.window().then((win) => {
        cy.stub(win, 'open').as('open')
    })

    cy.contains('Open public survey').click()
    cy.get('@open').should('have.been.calledOnce')
    cy.get('#longurl').then(($url) => {
        cy.visit($url.val())
    })
})

/**
 * @module TestSpecific/BranchingLogic
 * @author David Phillips <david.phillips22@nhs.net>
 * @example The fields shown on the public survey are {string}
 * @param {string} expectedFieldNames - the expected field names (pipe separated e.g. fieldName1|fieldName2|fieldName3)
 * @description Verifies that only the specified fields are shown on the public survey.
 */
Given('The fields shown on the public survey are {string}', (expectedFieldNames) => {
    const expectedFields = expectedFieldNames.split("|")
    const actualFields = []
    //v11.1.5
    const selector = "td.labelrc > label, td.labelrc.col-11"
    //v12.4.14
    //const selector = 'div[data-kind="field-label"]'

    //fields restricted with branching logic are hidden using css but are present in the DOM
    cy.get('#questiontable > tbody > tr').not(function() {
        return Cypress.$(this).css("display") == "none"
    })
    .find(selector)
    .each(($fieldName) => {
        let fieldNameIndex = 0
        let fieldName = getElementText($fieldName[0], fieldNameIndex).trim()
        actualFields.push(fieldName)
    })
    .should('have.length', expectedFields.length)
    .then(() => {
        expect(actualFields).to.include.members(expectedFields)
    })
})

/**
 * @module TestSpecific/BranchingLogic
 * @author David Phillips <david.phillips22@nhs.net>
 * @example The fields shown on the instrument are {string}
 * @param {string} expectedFieldNames - the expected field names (pipe separated e.g. fieldName1|fieldName2|fieldName3)
 * @description Verifies that only the specified fields are shown on the instrument.
 */
Given('The fields shown on the instrument are {string}', (expectedFieldNames) => {
    const expectedFields = expectedFieldNames.split("|")
    const actualFields = []
    //v11.1.5
    const selector = "td.labelrc tr > td:first-child, td.labelrc.col-12"
    //v12.4.14
    //const selector = 'div[data-kind="field-label"]'

    //fields restricted with branching logic are hidden using css but are present in the DOM
    cy.get('#questiontable > tbody > tr').not(function() {
        return Cypress.$(this).css("display") == "none" ||
            cleanTextBefore(Cypress.$(this).text(), "?") == "Complete"
            //v12.4.14
            //|| getElementText(this, 0) == "Record ID"
    })
    .find(selector)
    .each(($fieldName) => {
        let fieldNameIndex = 0
        let fieldName = getElementText($fieldName[0], fieldNameIndex).trim()
        actualFields.push(fieldName)
    })
    .should('have.length', expectedFields.length)
    .then(() => {
        expect(actualFields).to.include.members(expectedFields)
    })
})

/**
 * @module TestSpecific/BranchingLogic
 * @author David Phillips <david.phillips22@nhs.net>
 * @example I close the public survey
 * @description Closes the public survey.
 */
Given('I close the public survey', () => {
    cy.window().then((win) => {
        cy.stub(win, 'close').as('close')
        win.close()
    })
})

/**
 * @module TestSpecific/BranchingLogic
 * @author David Phillips <david.phillips22@nhs.net>
 * @example The survey closes
 * @description Verifies that the survey was closed and navigates back to the url prior to opening the survey.
 */
Given('The survey closes', () => {
    cy.get('@close').should('have.been.calledOnce')
    cy.get('@url-prior-survey').then(($url) => {
        cy.visit($url)
    })
})

//Note that the existing Interactions step definition 'I select the radio option {string} for the field labeled {string}' can't currently be used as the DOM structure
//of surveys is different to instruments
/**
 * @module TestSpecific/BranchingLogic
 * @author David Phillips <david.phillips22@nhs.net>
 * @example I select the survey radio option {string} for the field labeled {string}
 * @param {string} radioOption - the radio option
 * @param {string} fieldLabel - the field label
 * @description Selects the survey radio option {string} for the field labeled {string}.
 */
Given('I select the survey radio option {string} for the field labeled {string}', (radioOption, fieldLabel) => {
    cy.get(`td > label:contains(${fieldLabel})`)
    .parentsUntil('tbody')
    .find(`label:contains(${radioOption})`)
    .parent()
    .find('input[type="radio"]')
    .check()
})

//Note that the existing Interactions step definition 'I select the checkbox option {string} for the field labeled {string}' can't currently be used as the DOM structure
//of surveys is different to instruments. Also the current step definition doesn't currently allow unchecking of the checkbox
/**
 * @module TestSpecific/BranchingLogic
 * @author David Phillips <david.phillips22@nhs.net>
 * @example I {string} select the survey checkbox option {string} for the field labeled {string}
 * @param {string} checkMode - the check mode <check|uncheck>
 * @param {string} checkboxOption - the checkbox option
 * @param {string} fieldLabel - the field label
 * @description Checks or unchecks the survey checkbox option {string} for the field labeled {string}.
 */
Given('I {string} the survey checkbox option {string} for the field labeled {string}', (checkMode, checkboxOption, fieldLabel) => {
    cy.get(`td > label:contains(${fieldLabel})`)
    .parentsUntil('tbody')
    .find(`label:contains(${checkboxOption})`)
    .parent()
    .find('input[type="checkbox"]').then(($ele) => {
        if (checkMode == "check") {
            cy.wrap($ele).check()
        }
        else {
            cy.wrap($ele).uncheck()
        }
    })
})

/**
 * @module TestSpecific/BranchingLogic
 * @author David Phillips <david.phillips22@nhs.net>
 * @example The field with the variable name {string} contains the branching logic {string}
 * @param {string} variableName - the variable name
 * @param {string} expectedBranchingLogic - the branching logic to check
 * @description Verifies that the field with the variable name {string} contains the branching logic {string}.
 */
Given('The field with the variable name {string} contains the branching logic {string}', (variableName, expectedBranchingLogic) => {
    cy.get('.ui-dialog').should('not.be.visible')
    cy.get(`span[id="bl-label_${variableName}"]:contains(${expectedBranchingLogic})`).should('have.length', 1)
})

function setBranchingLogic(variableName, branchingLogic) {
    clickOnBranchingLogicIcon(variableName)
    cy.get('a:visible:contains("Clear logic")').click()
    cy.get('#advBranchingBox').click()
    cy.get('.ace_content').type(branchingLogic)
    cy.get('button:contains("Update & Close Editor")').click()
}

function clickOnBranchingLogicIcon(variableName) {
    cy.intercept({
        method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + "/Design/branching_logic_builder.php?*"
    }).as('builder')

    cy.get(`.designVarName:contains(${variableName})`)
    .parent()
    .find('img[title="Branching Logic"]')
    .first()
    .click()

    cy.wait('@builder')
}

function saveBranchingLogic() {
    cy.intercept({
        method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + "/Design/branching_logic_builder.php?*"
    }).as('builder')

    cy.get('button').contains('Save').click()
    cy.wait('@builder')
}

function getAllFieldsExcept(excludedVariableNames) {
    if (excludedVariableNames != "") {
        let variableNames = excludedVariableNames.split("|")

        //v11.1.5
        return cy.get('span.designVarName').not(function() {
            let variableNameNodeIndex = 2
            let elementText = getElementText(this, variableNameNodeIndex)
            return variableNames.some((variableName) => elementText.includes(variableName))
        })

        //v12.4.14
        // return cy.get('span[data-kind="variable-name"]').not(function() {
        //     let variableNameNodeIndex = 0
        //     let elementText = getElementText(this, variableNameNodeIndex)
        //     return variableNames.some((variableName) => elementText.includes(variableName))
        // })
    }
    else {
        //v11.1.5
        return cy.get('span.designVarName')
        //v12.4.14
        //return cy.get('span[data-kind="variable-name"]')
    }
}

function assertOnBranchingLogic(branchingLogic, excludedVariableNames) {
    cy.get('.ui-dialog').should('not.be.visible')

    //v11.1.5
    let branchingLogicSelector = `span[id^="bl-label_"]:contains(${branchingLogic})`
    getAllFieldsExcept(excludedVariableNames).its('length').then((numFields) => {       
        cy.get('span[id^="bl-label_"]').filter(branchingLogicSelector).its('length').then((numFieldsWithExpBranchingLogic) => {
            expect(numFields).equal(numFieldsWithExpBranchingLogic)
        })
    })

    //v12.4.14 - makes use of data-kind attributes for clearer selectors
    // let branchingLogicSelector = `span[data-kind="branching-logic"]:contains(${branchingLogic})`
    // getAllFieldsExcept(excludedVariableNames).its('length').then((numFields) => {
    //     cy.get('span[data-kind="branching-logic"]').filter(branchingLogicSelector).its('length').then((numFieldsWithExpBranchingLogic) => {
    //         expect(numFields).equal(numFieldsWithExpBranchingLogic)
    //     })
    // })
}

function cleanTextBefore(text, separator) {
    let split = text.split(separator)
    return split[0].trim()
}

function getElementText(element, nodeIndex) {
    return Array.from(element.childNodes)[nodeIndex].textContent
}
