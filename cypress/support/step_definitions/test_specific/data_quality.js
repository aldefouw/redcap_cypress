import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I click on a bubble with instrument named {string} and event named {string}
 * @param {string} instrument - the name of the instrument you are adding to an event
 * @param {string} event - the name of the event you are adding an instrument to
 * @description Interacations - Clicks on a bubble for an  instrument and event name
 */
Given("I click on a bubble with instrument named {string} and event named {string}", (instrument, event) => {
    cy.get('table[id=event_grid_table]').find('th').contains(event).parents('th').invoke('index').then((index) => {
        cy.get('table[id=event_grid_table]')
            .children('tbody')
            .contains('tr', instrument)
            .find('img').eq(index-1).click()
    })
})


/**
 * @module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I see a {string} bubble for instrument named {string} and event named {string}
 * @param {string} instrument - the name of the instrument you are adding to an event
 * @param {string} event - the name of the event you are adding an instrument to
 * @description Interacations - Checks a specfic checkbox for an  instrument and event name
 */
Given("I see a {string} bubble for instrument named {string} and event named {string}", ( circle_colour , instrument, event) => {
    cy.get('table[id=event_grid_table]').find('th').contains(event).parents('th').invoke('index').then((index) => {
        cy.get('table[id=event_grid_table]')
                .children('tbody')
                .contains('tr', instrument)
                .eq(index-1).find('img[src*=' + circle_colour + ']')
    })
 })



 /**
 * module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I scroll the page to the field identified by {string}
 * @description scroll the page till given field is in view
 */
Given("I scroll the page to the field identified by {string}", (label) => {
    cy.get(label).scrollIntoView()
})

/**
 * module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example The field turns red when data validation is violated 
 * @description The field turns red when data validation is violated 
 */
Given ("I see the field identified by {string} turns red", (sel) => {
    cy.get(sel).should('have.css', 'background','rgb(255, 183, 190) none repeat scroll 0% 0% / auto padding-box border-box')
})


/**
 * module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example All data quality rules are executed
 * @description All data quality rules are executed at once
 */
Given("All data quality rules are executed", () => {
    cy.intercept({ method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + '/DataQuality/execute_ajax.php?pid=13'}).as('execute_rule')
        cy.get('table#table-rules').find('tr').each(($tr, index, $list) => {
            cy.wrap($tr).within((tr) => {
                if(index < ($list.length - 2) ) {
                    cy.wait('@execute_rule')    
                    cy.get('div.exebtn').should(($d) => {
                        expect($d).not.to.contain('Execute')
       
                    })      
                }
            })
        })
})

/**
 * @module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I see {string} Total Discrepancies under Rule {string}
 * @param {string} num - the number of discrepancies
 * @param {string} Rulename - the name of the Rule
 * @description Data Quality - 
 */
Given("I see {string} Total Discrepancies under Rule {string}", ( num , Rulename) => {
    cy.get('table[id=table-rules]')
        .contains(new RegExp("^" + Rulename + "$", "g")).parents('tr').within(() => cy.get('div.exebtn')
            .should(($d) => {expect($d).to.contain(num)}
        )
    )     
})

/**
 * @module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I click {string} Total Discrepancies under Rule {string}
 * @param {string} item - Eg. view or execute
 * @param {string} Rulename - the name of the Rule
 * @description Data Quality - 
 */
Given("I click {string} Total Discrepancies under Rule {string}", ( item , Rulename) => {
    cy.get('table[id=table-rules]')
        .contains(new RegExp("^" + Rulename + "$", "g")).parents('tr')
            .within(() => cy.get('div.exebtn')
             .children().contains(item).invoke('show').should('be.visible').click({force: true})
    )
})
                                 
/**
 * @module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I exclude the top {string} rows of discrepancies table identified by {string}
 * @param {string} num - number of rows
 * @param {string} tablename - the name of the Rule
 * @description Data Quality - 
 */
Given("I exclude the top {string} rows of discrepancies table identified by {string}", (num, tablename) => {
    cy.get( tablename).find('tr').each(($tr, index) => {
        cy.wrap($tr).within(() => {
            if(index < (num))     
                cy.get('div.fc').children().contains('exclude').click()
        })
    })
})           
    


/**
 * @module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example All rules are reset with the clear button 
 * @description Data Quality - All data quality rules are reset 
 */
Given ("All rules are reset and I see Execute button available", () => {
    cy.intercept({  method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + '/DataQuality/record_list.php?pid=13'
        }).as('record_list')
        cy.get('table#table-rules').find('tr').each(($tr, index, $list) => {
        cy.wrap($tr).within((tr) => {
            if(index < ($list.length - 2)) {
                cy.get('div.exebtn').should(($d) => {
                    expect($d).to.contain('Execute')
                }
            )}  
        })
    })
})

/**
 * @module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I should see {string} in the top {string} rows of table identified by {string}
 * @param {string} item - Eg. 'Execute' or 'Remove exclusion'
 * @param {string} num - the number of rows
 * @param {string} Rulename - the name of the Rule
 * @description Data Quality - Confirms what buttons/options are visible
 */
Given("I should see {string} in the top {string} rows of table identified by {string}", (item, num, tablename) => {
    cy.get(tablename).find('tr').each(($tr, index ) => {
      cy.wrap($tr).within(() => {
            if(index < (num))       
                cy.get('div.fc').should(($d) => {
                    expect($d).to.contain(item)
                })
            }
        )
    })
})


/**
 * @module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I select Record {string} from the dropdown list to execute Data Quality rules
 * @param {string} item - Record number
 * @description Data Quality - Select a specific Record to execute rules
 */            
Given("I select Record {string} from the dropdown list to execute Data Quality rules", (item ) =>{                      
    cy.get('select[id="dqRuleRecord"]').select(item)          
        })



/**
 * @module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I click X under new rule named {string} to delete it
 * @param {string} Rulename - Rule name
 * @description Data Quality - Deletes customised rule
 */
Given("I click X under new rule named {string} to delete it", ( Rulename) => {
    cy.get('table[id=table-rules]').contains(new RegExp("^" + Rulename + "$", "g")).parents('tr')
        .within(() => cy.get('div.fc').find('img').should('be.visible').click()
        )
})

/**
 * @module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I clear text in the field identified by {string}
 * @param {string} sel - Selector
 * @description Data Quality - To clear text when the field is disabled by parent css property
 */
Given("I clear text in the field identified by {string}", (sel) => {
    cy.get(sel).clear({force:true})
})

/**
 * @module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I should see {string} rule violation in the table
 * @param {string} Rulename - Rule name
 * @description Data Quality -  Data Quality rule violation alert box
 */
Given("I should see {string} rule violation in the table", ( Rulename ) => {
    cy.get('table[id="table-dq_rules_table_single_record"] > tbody > tr > :nth-child(2)')
        .contains(new RegExp("^" + Rulename + "$", "g")
    )
})
               
/**
 * @module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I click to edit Rule {string}
 * @param {string} Rulename - Rule name
 * @description Data Quality -  Edit a Data Quality rule
 */    
Given("I click to edit Rule {string}", (Rulename) => {
    cy.get('table#table-rules')
        .contains(new RegExp("^" + Rulename + "$", "g"))
            .parents('tr').within(() => cy.get('div.editlogic')).click()             
})
  


/**
 * @module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example I should not see Record {string} in the top {string} rows of discrepancies table {string}
 * @param {string} record - Record number
 * @param {tablename} - the table name
 * @description Data Quality - Records to which the user does not have acces to, or are excluded from Data Quality rules, 
 *              should not appear
 */ 
     

Given("I should NOT see Record {string} in the discrepancies table identified by {string}", (record, tablename) => {
    cy.get(tablename).find('tr').each(($tr, index , $list) => {
        cy.wrap($tr).within(() => {
            if(index < ($list.length))     
            cy.get('td').first().then(($td) => { 
                expect($td).to.not.contain(new RegExp("^" + record , "g")) 
                })
            })
          }
        )
    })
     

/**
 * @module DataQuality
 * @author Coreen D'Souza <coreen.dsouza1@nhs.net>
 * @example Discrepancies for Record {string} should appear in the table identified by {string}
 * @param {string} record - Record number
 * @description Data Quality - Saves a custom Rule after editing
 */      
Given("Discrepancies for Record {string}, should appear in the table identified by {string}", (record, tablename) => {
    cy.get(' '+ tablename + '>tbody>tr td:nth-child(1)').within(() =>
    
        cy.get('div').contains(new RegExp("^" + record , "g")).should('exist') 
      
    )
})                         
                            