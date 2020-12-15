describe('Data Collection and Storage', () => {

	before(() => {
		cy.set_user_type('standard')	
		cy.visit_version({page: 'DataEntry/record_status_dashboard.php', params: "pid=1"})			
	})

	beforeEach(() => {
		cy.get('a').contains('Data Import Tool').click()
	})

	it('Should have the ability to download two versions of a data import template formatted as a CSV file (records by row or column)', () => {
		
		cy.get('body').should(($body) => {
			expect($body).to.contain('Download your Data Import Template (with records in rows)')
			expect($body).to.contain('Download your Data Import Template (with records in columns)')
		})	    
    })

	it('Should have the ability to import data by Rows', () => {
		cy.get('select[name="format"]').select('Rows')

		cy.upload_file('import_files/classic_db_import_rows.csv', 'csv', 'input[name="uploadedfile"]').then(() => {

			cy.wait(1000)

			cy.get('input').contains('Upload File').click().then(() => {
				cy.get('body').should($body => {
					expect($body).to.contain('Your document was uploaded successfully and is ready for review.')
					expect($body).to.contain('Jane')
					expect($body).to.contain('John')
					expect($body).to.contain('Doe')
				})

				cy.wait(1000)

				cy.get('input').contains('Import Data').click().then(() => {

					cy.get('body').should($body => {
						expect($body).to.contain('Import Successful!')
					})
				})
			})
		})
	})

	it('Should have the ability to import data by Columns', () => {
		cy.get('select[name="format"]').select('Columns')

		cy.upload_file('import_files/classic_db_import_columns.csv', 'csv', 'input[name="uploadedfile"]').then(() => {

			cy.wait(1000)

			cy.get('input').contains('Upload File').click().then(() => {
				cy.get('body').should($body => {
					expect($body).to.contain('Your document was uploaded successfully and is ready for review.')
					expect($body).to.contain('Jane')
					expect($body).to.contain('John')
					expect($body).to.contain('Doe')
				})

				cy.wait(1000)

				cy.get('input').contains('Import Data').click().then(() => {

					cy.get('body').should($body => {
						expect($body).to.contain('Import Successful!')
					})
				})
			})
		})
	})
	
	it('Should have the ability to import a CSV template to create and modify records', () => {
            
    })

	it('Should have the ability to highlight data modifications for user confirmation', () => {

    })

	it('Should have the ability to import only valid formats for text fields with validation', () => {
            
    })

	it('Should have the ability to import only valid choice codes for radio buttons, dropdowns and checkboxes', () => {
            
    })

	it('Should have the ability to require the event name in the csv file when importing data to a longitudinal study', () => {
            
    })

	it('Should have the ability to not allow data to be changed on locked data entry forms', () => {
            
    })

	it('Should have the ability to not allow a new record to be imported if user does not have Create Records access', () => {
            
    })

	it('Should have the ability to allow blank values to overwrite existing saved values', () => {
            
    })

	it('Should have the ability to assign data instruments to a data access group with the Data Import Tool', () => {
            
    })

	it('Should have the ability to ignore survey identifier and timestamp fields on all data import spreadsheets and allow all other data to be imported', () => {
            
    })

})