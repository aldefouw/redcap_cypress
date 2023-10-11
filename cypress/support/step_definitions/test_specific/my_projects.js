/**
 * @module my_projects
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see {string} in column {int} next to the link {string}
 * @param {string} text the text that should be visible
 * @param {int} num the column number where the text should be visible
 * @param {string} label the label on an anchor tag
 * @description Visibility - Visually verifies that the text is visible in column next to the link
 */
Given('I should see {string} in column {int} next to the link {string}', (text, num, label) => {
    cy.get('a').contains(label).parents('tr').find(':nth-child(' + num +')').contains(text)
})

/**
 * @module my_projects
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see the icon {string} in column {int} next to the link {string}
 * @param {string} text the text that should be visible
 * @param {int} num the column number where the text should be visible
 * @param {string} label the label on an anchor tag
 * @description Visibility - Visually verifies that the text is visible in column next to the link
 */
Given('I should see the icon {string} in column {int} next to the link {string}', (text, num, label) => {
    cy.get('a').contains(label).parents('tr').find(':nth-child(' + num + ') > div').children('[title="' + text + '"]')
})

/**
 * @module my_projects
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see {int} record(s) in the Record Status Dashboard
 * @param {int} num the number that should be visible
 * @description Visibility - Visually verifies the total no:of records
 */
Given('I should see {int} record(s) in the Record Status Dashboard', (num) => { 
    cy.get('div').contains('Displaying record').children('span').contains(num)
})


/**
 * @module my_projects
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see {int} instrument(s)
 * @param {int} count - the number of instrument rows seen
 * @description Visibility - Verifies the correct number of instrument rows are present
 */
Given('I should see {int} instrument(s)', (count) => {

    cy.get('table[id="table-forms_surveys"]').children('tbody').find('tr').as('iRow')
    cy.get('@iRow').then(iRow => {
        expect(iRow.length).to.equal(count)
    })
})

/**
 * @module my_projects
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example The sum of field count of all the instruments should equal to {int}
 * @param {int} count - the total field count
 * @description Visibility - Verifies the sum of field count
 */
Given('The sum of field count of all the instruments should equal to {int}', (count) => {

    let fCount = 0
    cy.wrap(fCount).as("fCount")
    cy.get('table[id="table-forms_surveys"]').children('tbody').find('tr').each(($tr) => {
        cy.get('@fCount').then(fCount => {
            let fieldCount = parseInt($tr.find(':nth-child(3)  > div').text())
            if(fieldCount){
                fCount = fCount + fieldCount
                cy.wrap(fCount).as('fCount')  
            }
       })
    })
    cy.get('@fCount').then(fCount => {
        expect(fCount).to.equal(count)
   })
})

/**
 * @module my_projects
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I confirm to mark project as complete
 * @description Confirm to mark project as complete
 */
Given("I confirm to mark project as complete", (text) => {
    cy.get('div[aria-describedby="completed_time_dialog"]').find('button').contains('Mark project as Complete').click()
 })

/**
 * @module my_projects
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see all the projects containing {string}
 * @param {string} text - the text that should be visible
 * @description Visibility - Visually verifies that the project title contains text
 */
Given('I should see all the projects containing {string}', (text) => {
    cy.get('table[id="table-proj_table"]').find('tr').each(($tr) => {
        expect($tr.find('div[class="projtitle"]').children('a').text()).to.contain(text) 
       })
    })
    
