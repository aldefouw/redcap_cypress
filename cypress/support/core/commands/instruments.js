//#############################################################################
//# Commands       A B C D E F G H I J K L M N O P Q R S T U V W X Y Z        #
//#############################################################################

//Corey
//Creates a new instrument at the end of the instrument list
Cypress.Commands.add('create_instrument', (instr_name) => {
    cy.get('[onclick*="showAddForm()"]').click()
    //If there is already at least 1 instrument,REDCap lets us choose position
    //of new instrument in the list, so we choose last.

    cy.get('body').then(($body) => {
        //if at least 1 instrument already exists (true if table has more than 1 row),
        //we need to click a button to add after the last instrument
        if ($body.find('table#table-forms_surveys tr').length > 1) {
            cy.get('button:contains("Add instrument here")').last().click()
        }

        cy.get('table#table-forms_surveys tr.addNewInstrRow').last().within(($tr) => {
            cy.get(':text[id^="new_form"]').type(instr_name)
            cy.get('input[onclick*="addNewForm("]').click()
        })
    })
})

Cypress.Commands.add('delete_instrument', (instrument_name) => {
    cy.intercept({  method: 'GET',
        url: '/redcap_v' + Cypress.env('redcap_version') + '/Design/delete_form.php?*'
    }).as('delete_instrument')

    cy.get('table[id=table-forms_surveys]')
        .find('tr').contains(instrument_name)
        .parents('tr').find('button').contains('Choose action').click()
    cy.get('ul[id=formActionDropdown]').find('a').contains('Delete').click()

    cy.get(':button:contains("Yes, delete it"):visible').click()

    cy.wait('@delete_instrument')
})

Cypress.Commands.add('rename_instrument', (current_name, new_name) => {
    cy.get('table[id=table-forms_surveys]')
        .find('tr').contains(current_name)
        .parents('tr').find('button').contains('Choose action').click()

    cy.get('ul[id=formActionDropdown]').find('a').contains('Rename').click()

    cy.get(`input[value="${current_name}"]`).clear().type(new_name)

    cy.get(`input[value="${current_name}"]`).parent().within(() => {
        cy.get(':button:contains("Save"):visible:first,:button[value*="Save"]:visible:first').click()
    })
})

//TODO: wrap async commands in then() blocks
Cypress.Commands.add('copy_instrument', (from, to, suffix) => {
    //get row, click actions dropdown
    cy.get(`div.projtitle:contains("${from}")`).parentsUntil('tr').last().parent().within(($tr) => {
        cy.get('button:contains("Choose action")').click()
    })
    //dropdown menu is inserted into HTML outside of the tr, so we exit the within() block
    cy.get('ul#formActionDropdown').within(($ul) => {
        cy.get('a:contains("Copy")').click()
    })
    //modal dialogue appears, enter new instrument name and variable suffix
    cy.get('input#copy_instrument_new_name').clear().type(to)
    cy.get('input#copy_instrument_affix').clear().type(suffix)
    cy.get('button:contains("Copy instrument")').click()
})

//TODO: not yet working, using a simple drag() or the below approach with move() cause instrument order to save unchanged
Cypress.Commands.add('reorder_instrument', (from, to) => {
    //get DOM elements of instruments at current position and target position
    const sel_from = `#row_${from} td.dragHandle`
    const sel_to = `#row_${to} td.dragHandle`
    const el_from = Cypress.$(sel_from)[0]
    const el_to = Cypress.$(sel_to)[0]
    //calculate distance needed to drag (`move()`) the first element
    const coords_from = el_from.getBoundingClientRect()
    const coords_to = el_to.getBoundingClientRect()
    const dX = coords_to.x - coords_from.x
    const dY = coords_to.y - coords_from.y
    //drag/move the instrument
    // cy.wrap(el_from).move({deltaX:dX, deltaY:dY})
    cy.log(cy.wrap(el_from) === cy.get(sel_from))
    cy.log(cy.wrap(el_from) === cy.get(sel_from))
})