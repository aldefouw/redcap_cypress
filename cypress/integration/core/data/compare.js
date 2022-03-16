const admin = 'test_admin';
const user1 = 'test_user';
const user2 = 'test_user2';
const record1 = 'Record1';
const record2 = 'Record2';
const pid = 14;

describe('Data Comparison Tool / DDE Module', () => {

    before(() => {
        cy.set_user_type('admin')
        cy.mysql_db('projects/pristine')
        cy.create_cdisc_project('DCT-DDE Test', "0", 'cdisc_files/core/compare.xml', pid)
        cy.visit_version({page: 'UserRights/index.php', params: `pid=${pid}`}).then(() => {
            cy.add_users_to_project([user1, user2], pid)
            cy.set_double_data_entry_module(pid, true)    
        })
    })
    
    describe('Data Entry Person Roles', () => {

        before(() => {
            cy.set_user_type('admin')
            cy.visit_version({page: 'UserRights/index.php', params:`pid=${pid}`})
        })

    	it('Should have the ability to designate Data Entry Person 1', () => {
            cy.get('a.userLinkInTable').contains(user1).click()
            cy.get('button').contains('Edit user privileges').click()
            cy.get('input[name="double_data"][value="1"]').click()
            cy.get('button').contains('Save Changes').click()
            cy.visit_version({page: 'UserRights/index.php', params:`pid=${pid}`})
            cy.get('a.userLinkInTable').contains(user1).closest('tr').find('div').contains('DDE Person #1').should('have.length', 1)
    	})

    	it('Should have the ability to designate Data Entry Person 2', () => {
            cy.get('a.userLinkInTable').contains(user2).click()
            cy.get('button').contains('Edit user privileges').click()
            cy.get('input[name="double_data"][value="2"]').click()
            cy.get('button').contains('Save Changes').click()
            cy.visit_version({page: 'UserRights/index.php', params:`pid=${pid}`})
            cy.get('a.userLinkInTable').contains(user2).closest('tr').find('div').contains('DDE Person #2').should('have.length', 1)
    	})

    	it('Should have the ability to restrict Data Entry Persons from viewing each others data', () => {
            cy.set_user_type('standard')
            cy.visit_version({page: 'DataEntry/record_status_dashboard.php', params: `pid=${pid}`})
            cy.get('table#record_status_table').should(($table) => {
                expect($table).to.have.lengthOf(1)
            })
    	})

    	it('Should assign Reviewer rights to all users not designated as Data Person 1 or 2', () => {
            cy.set_user_type('admin')
            cy.visit_version({page: 'UserRights/index.php', params:`pid=${pid}`})
            cy.get('a.userLinkInTable').contains(admin).closest('tr').find('div').contains('Reviewer').should('have.length', 1)
    	})
    })

    describe('Review / Adjudication Process', () => {

        before(() => {
            cy.set_user_type('admin')
        })

		it('Should have the ability to compare two records within the same project and display the differences between them', () => {
            cy.set_double_data_entry_module(pid, false)
            cy.visit_version({page: 'index.php', params: `pid=${pid}&route=DataComparisonController:index`})
            cy.get('select#record1').find('option').contains(record1).then( ($option) => {
                cy.get('select#record1').select(`${$option.text()}`)
            })
            cy.get('select#record2').find('option').contains(record2).then( ($option) => {
                cy.get('select#record2').select(`${$option.text()}`)
            })
            cy.get('input').contains('Compare').click()
            cy.get('form').find('td.header').contains('Label').closest('table').find('tr').should('have.length', 4)
	    })

    	it('Should allow Reviewer to view and adjudicate the differences between duplicate records', () => {
            cy.set_double_data_entry_module(pid, true)
            cy.visit_version({page: 'index.php', params: `pid=${pid}&route=DataComparisonController:index`})
            cy.get('select#record1').find('option').contains(record1).then( ($option) => {
                cy.get('select#record1').select(`${$option.text()}`)
            })
            cy.get('input').contains('Compare selected record').click()
            cy.get('form').find('td.header').contains('Label').closest('table').find('tr').should('have.length', 3)
    	})

    	it('Should allow Reviewers to merge both entires into a third, single record', () => {
            cy.get('a').contains('click here to merge them').click()
            cy.get('td').contains('text_2').closest('tr').find('td').last().as('TD')
            cy.get('@TD').find('input[type="radio"]').check()
            cy.get('@TD').find('input').first().type('Chopin')
            cy.get('input[name="record_id"]').parent().find('input[type="button"]').click()
            cy.get('h4').contains('RECORD CREATED!').should('have.length', 1)
    	})
    })

    describe('Control Center', () => {

        before(() => {
            cy.set_user_type('admin')
        })

        it('Should have the ability to enable / disable the Double Data Entry module', () => {
            cy.set_double_data_entry_module(pid, false)
            cy.get('tr#double_data_entry-tr select').should('have.value', '0')

            cy.set_double_data_entry_module(pid, true)
            cy.get('tr#double_data_entry-tr select').should('have.value', '1')
        })
    })
})