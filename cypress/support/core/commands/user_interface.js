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

Cypress.Commands.add("table_cell_by_column_and_row_label", (column_label, row_label) => {
    let column_num = 0
    let table_cell = null
    const selector = `table:has(td:contains("${row_label}"),th:contains("${column_label}"))`

    cy.get(selector).within(() => {
        cy.get(`th:contains("${column_label}")`).parent('tr').then(($tr) =>{
            $tr.find('th').each((thi, th) => {
                if(Cypress.$(th).text().trim().includes(column_label)) column_num = thi
            })
        })
    }).then(() => {
        cy.get(selector).within(() => {
            cy.get(`td:contains("${row_label}")`).parent('tr').then(($tr) =>{
                $tr.find('td').each((tdi, td) => {
                    if(tdi === column_num) table_cell = td
                })
            })
        }).then(() => {
            cy.wrap(table_cell)
        })
    })
})