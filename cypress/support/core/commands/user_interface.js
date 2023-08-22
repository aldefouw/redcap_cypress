//#############################################################################
//# Commands       A B C D E F G H I J K L M N O P Q R S T U V W X Y Z        #
//#############################################################################

Cypress.Commands.add("dragTo", { prevSubject: 'element'}, (subject, target) => {
    let rect = cy.get(target).then((element) => {
        let rect = element[0].getBoundingClientRect()
        return rect
    })
    //click on element
    cy.wrap(subject).trigger('mousedown')

    //move mouse to new position
    cy.get(target).trigger('mousemove', 'bottom')
        .trigger('mousemove', 'center')

    // target position changed, mouseup on original element
    cy.wrap(subject).trigger('mouseup')

})

Cypress.Commands.add("table_cell_by_column_and_row_label", (column_label, row_label, table_selector= 'table', header_row_type = 'th', row_cell_type = 'td', row_number = 0, body_table = 'table') => {
    let column_num = 0
    let table_cell = null
    let selector = `${table_selector}:has(${header_row_type}:contains(${JSON.stringify(column_label)}):visible):visible`
    let td_selector = `tr:has(${row_cell_type}:visible):visible`

    if(row_number === 0) {
        if(table_selector !== body_table){
            selector = `${table_selector}:has(${header_row_type}:contains(${JSON.stringify(column_label)}):visible):visible`
        } else {
            selector = `${table_selector}:has(${row_cell_type}:contains(${JSON.stringify(row_label)}):visible,${header_row_type}:contains(${JSON.stringify(column_label)}):visible):visible`
        }

        td_selector = `tr:has(${row_cell_type}:contains(${JSON.stringify(row_label)}):visible):visible`
    }

    cy.get(selector).within(() => {
        cy.get(`${header_row_type}:contains(${JSON.stringify(column_label)}):visible`).parent('tr').then(($tr) => {
            $tr.find(header_row_type).each((thi, th) => {
                // console.log(Cypress.$(th).text().trim().includes(column_label))
                // console.log(thi)
                if (Cypress.$(th).text().trim().includes(column_label) && column_num === 0) column_num = thi
                //if (Cypress.$(th).text().trim().includes(column_label) && column_num === 0) console.log(thi)
            })
        })
    }).then(() => {

        if(body_table !== 'table'){
            selector = `${body_table}:has(${header_row_type}:contains(${JSON.stringify(column_label)}):visible):visible`
        }

        cy.get(selector).within(() => {
            cy.get(td_selector).then(($td) => {
                $td.each(($tri, $tr) => {
                    cy.wrap($tr).each((tri, tr) => {
                        tri.find(row_cell_type).each((tdi, td) => {
                            if (tdi === column_num && $tri === row_number){
                                console.log(column_num)
                                table_cell = td
                            }
                        })
                    })
                })
            })
        }).then(() => {
            cy.wrap(table_cell)
        })
    })
})

Cypress.Commands.add("fetch_bubble_record_homepage", (table_selector = '#event_grid_table', event, instrument, instance) => {

    cy.table_cell_by_column_and_row_label(event, instrument, '#event_grid_table')

})
