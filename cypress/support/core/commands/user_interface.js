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

Cypress.Commands.add("table_cell_by_column_and_row_label", (column_label, row_label, table_selector= 'table', row_number = 0) => {
    let column_num = 0
    let table_cell = null
    let selector = `${table_selector}:has(th:contains("${column_label}"):visible):visible`
    let td_selector = `tr:has(td:visible):visible`

    if(row_number === 0) {
        selector = `${table_selector}:has(td:contains("${row_label}"):visible,th:contains("${column_label}"):visible):visible`
        td_selector = `tr:has(td:contains("${row_label}"):visible):visible`
    }

    cy.get(selector).within(() => {
        cy.get(`th:contains("${column_label}"):visible`).parent('tr').then(($tr) => {
            $tr.find('th').each((thi, th) => {
                if (Cypress.$(th).text().trim().includes(column_label)) column_num = thi
            })
        })
    }).then(() => {

        cy.get(selector).within(() => {
            cy.get(td_selector).then(($td) => {
                $td.each(($tri, $tr) => {
                    cy.wrap($tr).each((tri, tr) => {
                        tri.find('td').each((tdi, td) => {
                            if (tdi === column_num && $tri === row_number){
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