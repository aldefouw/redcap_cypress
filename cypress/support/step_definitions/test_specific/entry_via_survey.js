/**
 * @module entry_via_survey
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see the instrument labeled {string} is not a survey
 * @param {string} label the name of the instrument
 * @description Visually verify the instrument is not a survey
 */
Given('I should see the instrument labeled {string} is not a survey', (label) => {
    cy.get('a').contains(label).parents('tr').find(':nth-child(5)').contains("Enable")

})

/**
 * @module entry_via_survey
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see the instrument labeled {string} is a survey
 * @param {string} label the name of the instrument
 * @description Visually verify the instrument is a survey
 */
Given('I should see the instrument labeled {string} is a survey', (label) => {
    cy.get('a').contains(label).parents('tr').find(':nth-child(5)').within(() =>
        cy.get('img[src*=tick_shield_small]')
    )
})

/**
 * @module entry_via_survey
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see {int} participant(s) listed in the Participant List
 * @param {int} count - the number of participants present
 * @description Visibility - Verifies the correct number of participants are present in the Participant List
 */
Given('I should see {int} participant(s) listed in the Participant List', (count) => {
    cy.get('table[id="table-participant_table"]').children('tbody').find('tr').as('iRow')
    cy.get('@iRow').then(iRow => {
        expect(iRow.length).to.equal(count)
    })
})

/**
 * @module entry_via_survey
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I select the Participant List belonging to option {string}
 * @param {string} name - the instrument-event name to select
 * @description select the instrument-event for the Participant List in Survey Distribution Tools
 */
Given('I select the Participant List belonging to option {string}', (name) => {
    cy.get('td').contains('Participant List').find('select').select(name)
})

/**
 * @module entry_via_survey
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I click on the button labeled {string} for the instrument named {string}
 * @param {string} label the label of the button
 * @param {string} instrument - the instrument name
 * @description Click on the button for the instrument in the Designer window
 */
Given('I click on the button labeled {string} for the instrument named {string}', (label, instrument) => {
    cy.get('td:nth-child(2)').contains(instrument).parents('tr').find('button').contains(label).click()

})

/**
 * @module entry_via_survey
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see a {string} {imagetype} for record ID {string}
 * @param color - color of the survey
 * @param recID - Record ID
 * @description Visibility - Verifies the status of the survey for a given record ID
 */
defineParameterType({
    name: 'imagetype',
    regexp: /(bubble|icon)/
})

Given('I should see a {string} {imagetype} for record ID {string}', (color, type, recID) => {
    cy.get('table[id="table-participant_table"]').find('a').contains(recID).parents('tr').within(() =>
        cy.get('img[src*=' + color + ']')
    )
})

/**
 * @module entry_via_survey
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see {int} email(s) listed in the Participant List
 * @param {int} count - the number of participants displayed
 * @description Visibility - Verifies the number of emails in the participant list table
 */
Given('I should see {int} email(s) listed in the Participant List', (count) => {
    cy.get('table[id="table-participant_table_email"]').children('tbody').find('tr').as('iRow')
    cy.get('@iRow').then(iRow => {
        expect(iRow.length).to.equal(count)
    })
})

/**
 * @module entry_via_survey
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I enable the cron job
 * @description Enable the cron job
 */
Given('I enable the cron job', () => {
    let url = Cypress.config('baseUrl') + '/cron.php'
    cy.visit(url)     
})

/**
 * @module entry_via_survey
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see {int} email(s) listed in the Survey Invitation Log
 * @param {string} text - the text displayed
 * @description Visibility - Verifies the number of emails in the Survey Invitation Log
 */
Given('I should see {int} email(s) listed in the Survey Invitation Log', (count) => {
    cy.get('table[id="table-email_log_table"]').children('tbody').find('tr').as('iRow')
    cy.get('@iRow').then(iRow => {
        expect(iRow.length).to.equal(count)
    })
})

/**
 * @module entry_via_survey
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see the Event List with the options below
 * @param {DataTable} options the Data Table of selectable options
 * @description Visibility - Visually verifies that the Event List has the options listed
 */
Given('I should see the Event List with the options below', (options) => {
    cy.get('table[id="partListTitle"]').children('tbody').find('td').contains('Participant List').within(() => {
        for(let i = 0; i < options.rawTable[0].length; i++){
            let element_selector = `select:has(option:contains("${options.rawTable[0][i]}")):visible`
            let dropdown = cy.get('select')
            dropdown.should('contain', options.rawTable[0][i])
            cy.wait(500)
        }
    })
})
