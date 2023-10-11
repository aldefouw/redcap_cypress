/**
 * @module Compare
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I click on the checkbox labeled {string} for repeating instrument setup
 * @param {string} label the label of the repeating instrument
 * @description Clicks on the checkbox for repeating instrument setup
 */
Given('I click on the checkbox labeled {string} for repeating instrument setup', (label) => {
    cy.get('table[id=table-repeat_setup]').contains('td', label).parents('tr').find('input[type=checkbox]').click()   
})

// /**
//  * @module Compare
//  * @author Mintoo Xavier <min2xavier@gmail.com>
//  * @example I print the page
//  * @description Prints the page
//  */
// Given('I print the page', (label) => {
//     cy.window().then((win) => {
//       cy.stub(win, 'print').as('print')
//     })
//     cy.contains('button', 'Print page').click()
//     cy.get('@print').should('have.been.calledOnce')
// })

/**
 * @module Compare
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @exampleI I click on the text {string} of Record ID {string}
 * @param {int} id the ID of the record
 * @param {string} text the text which is diplayed
 * @description Clicks on the text of the record
 */
Given('I click on the text {string} of Record ID {string}', (text, id) => {
    cy.get('.compare').contains(text).parents('tr').find('td:nth-child(2)').invoke('text').as('page')
    let pid = ''
    cy.window().then((win) => {     
      cy.stub(win,'open').as('windowOpen')
      pid = win.pid
      
    })
    cy.get('.compare').contains(text).click()
    cy.get('@windowOpen').should('be.called')
    cy.get('@page').then(page => {
      if (page.trim() === "Data Types")
        page = "data_types"
      else
        page = "text_validation"
      cy.visit_version({page: 'DataEntry/index.php', params: 'pid=' + pid + '&id=' + id + '&page=' + page})
    })
})
  
/**
 * @module my_projects
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see the value {string} in the field name {string} for Record ID {string}
 * @param {string} text the text that should be visible
 * @param {string} field the name of the field
 * @param {string} id the ID of the record
 * @description Visibility - Visually verifies that the text is visible for the field name for the given Record ID
 */
Given('I should see the value {string} in the field name {string} for Record ID {string}', (text, field, id) => {
  cy.get('table[class=form_border]').find('td').children('b').contains(id).parent('td').invoke('index').then((index) => {
    cy.get('.data').children().contains(field).parents('tr').find('td').eq(index+2).children().invoke('text').as('value')
     cy.get('@value').then(value => {
      expect(value).to.equal(text)  
    })       
  })  
})

/**
 * @module Compare
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I scroll the page to the field identified by {string}
 * @param {string} selector the selector of the field to select
 * @description Scroll the page to the field
 */
Given('I scroll the page to the field identified by {string}', (selector) => {
  cy.get(selector).scrollIntoView()
})

/**
 * @module Compare
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I click on the radio option labeled {string} in the data comparison tool to merge records
 * @param {string} text the label of the radio button
 * @description Click on the radio option in the data comparison tool to merge the records
 */
Given('I click on the radio option labeled {string} in the data comparison tool to merge records', (label) => {
  cy.get('.compare').contains(label).parents('td').find('input[name=text2___RADradio]').click()
})
