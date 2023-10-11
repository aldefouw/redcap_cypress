/**
 * @module record_locking_e_sig
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I cannot edit the field identified by {string}
 * @param {string} selector the selector of the field
 * @description Verify the field is disabled
 */
Given('I cannot edit the field identified by {string}', (selector) => {  
    cy.get(selector).should("be.disabled") 

})


/**
 * @module record_locking_e_sig
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see {icon} icon for the instrument labeled {string} for record ID {string}
 * @param {string} icon icon displayed
 * @param {string} text name of instrument
 * @param {string} id Record ID
 * @description Visually verify the instrument has the icon
 */
defineParameterType({
    name: 'icon',
    regexp: /(lock_small|lock_big|tick_shield)/
})

Given('I should see {icon} icon for the instrument labeled {string} for record ID {string}', (icon, text, id) => {
    cy.get('table[id="esignLockList"]').children('tbody').within(() => {
        let found = 0
        cy.wrap(found).as('found')
        cy.get('tr').each((tr, index) =>{
            // // This was to stop the iteration when found = 1 but doesn't work as expected
            // cy.get('@found').then(found => { 
            //     if(found == 1){
            //         cy.log("tr-found:" + found)
            //         return false
            //     }
            // })
            if(index > 1){
                cy.wrap(tr).within(() => {
                    let count = 0
                    cy.get('td').each((td) => {
                        if(count == 2)
                            return false
                        if(td.text() == id)
                            count++
                        if(td.text() == text)
                            count++
                        if (count == 2) {
                            cy.get('img[src*=' + icon + ']')
                            cy.get('@found').then(found => {
                                found = 1
                                cy.wrap(found).as('found')
                            })
                        }       
                    })
                })
            }
        })  
        cy.get('@found').then(found => {
            expect(found).to.equal(1)
        })        
    })
})


/**
 * @module record_locking_e_sig
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I check the checkbox to display E-signature option for the instrument labeled {string}
 * @param {string} text name of instrument
 * @description Check E-Signature option on instrument
 *
 */
Given("I check the checkbox to display E-signature option for the instrument labeled {string}", (text) => {
    cy.get('td').contains(text).next('td').find('input').check()
})


/**
 * @module record_locking_e_sig
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I save the option for the instrument labeled {string}
 * @param {string} text name of instrument
 * @description Save E-Signature option on instrument
 *
 */
Given("I save the option for the instrument labeled {string}", (text) => {
    cy.get('tr').contains(text).parent().within(() =>
        cy.get('input[type=button]').click()
    )   
})


/**
 * @module record_locking_e_sig
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see the instrument labeled {string} with icon {string}
 * @param {string} text - Instrument name
 * @param {string} icon - icon displayed
 * @description Visually verify the instrument has icon dispalyed
 *
 */
Given("I should see the instrument labeled {string} with icon {string}", (text, icon) => {
    cy.get('table[id="event_grid_table"]').children('tbody').find('td').contains(text).parents('tr').within(() =>
        cy.get('img[src*=' + icon + ']')
    )
})


/**
 * @module record_locking_e_sig
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I click on the {string} icon for the instrument labeled {string}
 * @param {string} text - Instrument name
 * @param {string} icon - icon to click
 * @description Click on the icon for the instrument
 *
 */
Given("I click on the {string} icon for the instrument labeled {string}", (icon, text) => {
    cy.get('table[id="part11_forms"]').children('tbody').find('td').contains(text).parent().within(() =>
        cy.get('img[src*=' + icon + ']').click()
    )
})


/**
 * @module record_locking_e_sig
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should not see {icon} icon for the instrument labeled {string} for record ID {string}
 * @param {string} icon icon displayed
 * @param {string} text name of instrument
 * @param {string} id Record ID
 * @description Visually verify the instrument does not have the icon
 */
Given('I should not see {icon} icon for the instrument labeled {string} for record ID {string}', (icon, text, id) => {
    cy.get('table[id="esignLockList"]').children('tbody').within(() => {
        let found = 1
        cy.wrap(found).as('found')
        cy.get('tr').each((tr, index) =>{
            // // This was to stop the iteration when found = 0 but doesn't work as expected
            // cy.get('@found').then(found => { 
            //     if(found == 0){
            //         cy.log("tr-found:" + found)
            //         return false
            //     }
            // })
            if(index > 1){
                cy.wrap(tr).within(() => {
                    let count = 0
                    cy.get('td').each((td) => {
                        if(count == 2)
                            return false
                        if(td.text() == id)
                            count++
                        if(td.text() == text)
                            count++
                        if (count == 2) {
                            cy.get('img[src*=' + icon + ']').should('not.exist')
                            cy.get('@found').then(found => {
                                found = 0
                                cy.wrap(found).as('found')
                            })
                        }       
                    })
                })
            }
        })  
        cy.get('@found').then(found => {
            expect(found).to.equal(0)
        })        
    })
})


/**
 * @module record_locking_e_sig
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see today's date in the column labeled {label}
 * @description Visually verify today's date in the column labeled Locked/E-signed
 */
defineParameterType({
    name: 'label',
    regexp: /(Locked|E-signed)/
})
Given("I should see today's date in the column labeled {label}", (label) => {
    let today = new Date()
    var dd = String(today.getDate()).padStart(2, '0')
    var mm = String(today.getMonth() + 1).padStart(2, '0')
    var yyyy = today.getFullYear()
    today = mm + '/' + dd + '/' + yyyy

    if(label == 'Locked')
        cy.get('table[id="esignLockList"]').children('tbody').find('td[class="data lock"]').contains(today)
    else
        cy.get('table[id="esignLockList"]').children('tbody').find('td[class="data esign"]').contains(today)
})


/**
 * @module record_locking_e_sig
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should not see today's date in the column labeled {label}
 * @description Visually verify today's date is not visible in the column labeled Locked/E-signed
 */
Given("I should not see today's date in the column labeled {label}", (label) => {
    let today = new Date()
    var dd = String(today.getDate()).padStart(2, '0')
    var mm = String(today.getMonth() + 1).padStart(2, '0')
    var yyyy = today.getFullYear()
    today = mm + '/' + dd + '/' + yyyy

    if(label == 'Locked')
        cy.get('table[id="esignLockList"]').children('tbody').find('td[class="data lock"]').contains(today).should('not.be.visible')
    else
    cy.get('table[id="esignLockList"]').children('tbody').find('td[class="data esign"]').contains(today).should('not.be.visible')
})


/**
 * @module my_projects
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see {int} row(s)
 * @param {int} count - the number of rows seen
 * @description Visibility - Verifies the correct number of rows are present
 */
Given('I should see {int} row(s) containing {icon} icon', (count, icon) => {

    cy.get('img[src*=' + icon + ']').as('iRow')
    cy.get('@iRow').then(iRow => {
        expect(iRow.length).to.equal(count)
    })
})


/**
 * @module my_projects
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see {int} row(s) {lock_status}
 * @param {int} count - the number of rows seen
 * @param {lock_status} count - lock status of record
 * @description Visibility - Verifies the number of rows with the status
 */
defineParameterType({
    name: 'lock_status',
    regexp: /(locked|e-signed|unlocked|not e-signed|locked and e-signed|locked and not e-signed|unlocked and not e-signed|in total)/
})
Given('I should see {int} row(s) {lock_status}', (count, text) => {
    let class_name = ''
    if(text == "locked")
        class_name = ".locked"
    else if(text == "e-signed")
        class_name = ".esigned"
    else if(text == "unlocked")
        class_name = ".unlocked"
    else if(text == "not e-signed")
        class_name = ".aesigned"
    else if(text == "locked and e-signed")
        class_name = ".locked.esigned"
    else if(text == "locked and not e-signed")
        class_name = ".locked.aesigned"
    else if(text == "unlocked and not e-signed")
        class_name = ".unlocked.aesigned"
    else // Show All
        class_name = ".rowl"

    cy.get('table[id="esignLockList"]').find(class_name).as('iRow')
    cy.get('@iRow').then(iRow => {
        expect(iRow.length).to.equal(count)
    })
})


/**
 * @module my_projects
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see {int} row(s) {lock_status}
 * @param {lock_status} count - lock status of record
 * @description Visibility - Verifies the number of rows with the status
 */
Given('I should see no rows {lock_status}', (text) => {
    let class_name = ''
    if(text == "locked")
        class_name = ".locked"
    else if(text == "e-signed")
        class_name = ".esigned"
    else if(text == "unlocked")
        class_name = ".unlocked"
    else if(text == "not e-signed")
        class_name = ".aesigned"
    else if(text == "locked and e-signed")
        class_name = ".locked.esigned"
    else if(text == "locked and not e-signed")
        class_name = ".locked.aesigned"
    else if(text == "unlocked and not e-signed")
        class_name = ".unlocked.aesigned"
    else // Show All
        class_name = ".rowl"

    cy.get('table[id="esignLockList"]').find(class_name).should('not.be.visible')
})

