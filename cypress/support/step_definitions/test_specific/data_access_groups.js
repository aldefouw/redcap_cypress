const data_access_groups_mappings = {
    'Data Access Groups' : 0,
    'Users in group' : 1,
    'Number of records in group': 2
}
/**
 * @module data_access_groups
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see {string} in the column named {string}
 * @param {string} text the text to verify
 * @param {string} column the column name of the DAG table
 * @description visually verify the column contains the text
 */
Given('I should see {string} in the column named {string}', (text, column) => {
    let found = 0
    cy.wrap(found).as('found')
    cy.get('table[id=table-dags_table]').find('tr').each((tr) => {
        cy.wrap(tr).within(() => {
            cy.get('td').eq(data_access_groups_mappings[column]).invoke('text').as('name')
            cy.get('@name').then((name) => {
                name = name.trim()
                if(name.endsWith("* Can view ALL records"))
                    name = name.substring(0, name.length - 22)
                if(name == text){
                    cy.get('@found').then(found => {
                        found = 1
                        cy.wrap(found).as('found')
                    })
                }     
            })
        })
    })
    cy.get('@found').then(found => {
        expect(found).to.equal(1)
    })  
})
/**
 * @module data_access_groups
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should see {string} {column_type}(s) in the DAG named {string}
 * @param {string} text the name of the user
 * @param {string} column column in the table
 * @param {string} dag DAG name
 * @description visually verify the text is present in column and is associated to the DAG
 */
defineParameterType({
    name: 'column_type',
    regexp: /(user|record)/
})
Given('I should see {string} {column_type}(s) in the DAG named {string}', (text, column, dag) => {
    let found = 0
    cy.wrap(found).as('found')
    let index = 0
    if(column == 'user')
        index = 1
    else
        index = 2
    cy.get('table[id=table-dags_table]').find('tr').each((tr) => {
        cy.wrap(tr).within(() => {
            cy.get('td').eq(0).invoke('text').as('col1')
            cy.get('td').eq(index).invoke('text').as('col2')
            cy.get('@col1').then((col1) => {
                if(col1.trim() == dag){
                    cy.log('true')
                    cy.get('@col2').then((col2) => {
                        col2 = col2.trim()
                        if(col2.endsWith("* Can view ALL records"))
                            col2 = col2.substring(0, col2.length - 22)
                        if(col2 == text){
                            cy.get('@found').then(found => {
                                found = 1
                                cy.wrap(found).as('found')
                            })
                        }
                            
                    })
                }     
            })
        })
    })
    cy.get('@found').then(found => {
        expect(found).to.equal(1)
    })  
}) 
