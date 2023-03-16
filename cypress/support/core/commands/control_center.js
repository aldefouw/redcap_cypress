//#############################################################################
//# Commands       A B C D E F G H I J K L M N O P Q R S T U V W X Y Z        #
//#############################################################################

function sorterCompare(col_name, element, selector = null, klass = false, title = false){
    let first_row = null
    let last_row = null

    let main_selector = 'table#table-proj_table tr '

    let expectation = null
    let end_expect = ''
    let last_expectation = null
    let first_expectation = null
    let selector_thing = ''
    let last_row_val = ''
    let first_row_val = ''

    cy.get(main_selector + ' span').should('not.contain', "Loading").then(() => {

        let current_index = 0

        cy.get('th').then((th) => {

            th.each((i, t) => {
                if(t.textContent === col_name){
                    current_index = t.cellIndex
                }
            })

            cy.get('th').contains(col_name).click().then(($col)=>{

                cy.get(main_selector).then((tr) => {
                    const num_rows = Cypress.$(tr).length

                    if(selector === null){
                        first_row = Cypress.$(tr[0]).find(element)[current_index]
                        last_row = Cypress.$(tr[num_rows - 1]).find(element)[current_index]
                    } else {
                        first_row = Cypress.$(Cypress.$(tr[0]).find(element)[current_index]).find(selector)[0]
                        last_row = Cypress.$(Cypress.$(tr[num_rows - 1]).find(element)[current_index]).find(selector)[0]
                    }

                    if(klass && first_row !== undefined && last_row !== undefined){

                        console.log(last_row)
                        console.log(first_row)

                        last_row_val = last_row.className
                        first_row_val = first_row.className
                        expectation = 'to.have.class'
                        last_expectation = expectation + '(last_row_val)'
                        first_expectation = expectation + '(first_row_val)'
                        selector_thing = 'Cypress.$($e[current_index]).find(selector)[0]'
                    } else if (title && first_row !== undefined && last_row !== undefined) {
                        last_row_val = last_row.title
                        first_row_val = first_row.title
                        expectation  = 'to.have.attr'
                        last_expectation = expectation + '("title", "' + last_row_val+ '")'
                        first_expectation = expectation + '("title", "' + first_row_val + '")'
                        selector_thing = 'Cypress.$($e[current_index]).find(selector)[0]'
                    } else if (first_row !== undefined && last_row !== undefined) {
                        last_row_val = last_row.textContent
                        first_row_val = first_row.textContent
                        expectation = 'to.contain'
                        last_expectation = expectation + '(last_row_val)'
                        first_expectation = expectation + '(first_row_val)'
                        selector_thing = '$e[current_index]'
                    }

                    if(first_row !== undefined && last_row !== undefined){
                        //See if the first row is what the last row WAS
                        cy.get('th').contains(col_name).click().then(()=>{
                            cy.get(main_selector + element).then(($e) => {
                                cy.get(main_selector + ' span').should('not.contain', "Loading").then(() => {
                                    eval('expect(' + selector_thing + ').' + last_expectation)
                                })
                            })
                        })

                        //See if the first row is what the first row WAS initially
                        cy.get('th').contains(col_name).click().then(()=>{
                            cy.get(main_selector + element).then(($e) => {
                                cy.get(main_selector + ' span').should('not.contain', "Loading").then(() => {
                                    eval('expect(' + selector_thing + ').' + first_expectation)
                                })
                            })
                        })
                    }


                })
            })
        })
    })
}

Cypress.Commands.add('check_column_sort_classes', (col_name, element, selector = null) => {
    sorterCompare(col_name, element, selector, 1)
})

Cypress.Commands.add('check_column_sort_values', (col_name, element, selector = null) => {
    sorterCompare(col_name, element, selector)
})

Cypress.Commands.add('check_column_sort_titles', (col_name, element, selector = null) => {
    sorterCompare(col_name, element, selector, 0, 1)
})

Cypress.Commands.add('contains_cc_link', (link, title = '') => {
    function test_link (link, title, try_again = true) {
        cy.get('div#control_center_menu a').
        contains(link).
        click().
        then(($control_center) => {
            if($control_center.find('div#control_center_window').length){
                cy.get('div#control_center_window').then(($a) => {
                    if($a.find('div#control_center_window h4').length){
                        cy.get('div#control_center_window h4').contains(title)
                    } else if ($a.find('div#control_center_window div').length){
                        cy.get('div#control_center_window div').contains(title)
                    } else {
                        cy.get('body').contains(title)
                    }
                })
            } else {
                cy.get('body').contains(title)
            }
        })
    }

    if(title === '') title = link
    let t = Cypress.$("div#control_center_menu a:contains(" + JSON.stringify(link) + ")");
    t.length ? test_link(link, title) : test_link(link.split(' ')[0], title.split(' ')[0])
})

Cypress.Commands.add("toggle_field_validation_type", (field_validation_type, button_text = 'Enable') => {
    cy.intercept({
        method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + "/ControlCenter/validation_type_setup.php"
    }).as('validation_type_setup')

    cy.get('td').contains(field_validation_type).parents('tr').children('td').each((td, i) => {
        //Get to third column
        if(i === 2 && td.length){
            if(td[0].innerText.includes(button_text)){
                td.find('button')[0].click()
                cy.wait('@validation_type_setup')
            } else {
                //Do nothing if we do not find the "button text" - it means we're already in the state we want to be!
            }
        }
    })
})