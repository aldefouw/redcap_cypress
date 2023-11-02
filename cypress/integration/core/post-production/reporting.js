describe('Reporting', () => {

	beforeEach(() => {
		cy.maintain_login()
		cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/DataExport/data_export_ajax.php?*').as('data_export')
		cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/DataExport/report_filter_ajax.php?*').as('report_filter')
	})

	before(() => {
		cy.mysql_db('projects/pristine')

		cy.set_user_type('admin')

		//Create the project with the Data Dictionary
		cy.visit_base({ url: './index.php?action=create' })

		cy.get('input[name="app_title"]').type('22_Reporting_v913').then(() => {

			cy.get('select[name="purpose"]').select('4')

			cy.get('input[id="project_template_radio2"]').check()

			cy.fixture('core/post-production/reporting/22Reportingv913.xml')
				.then(Cypress.Blob.binaryStringToBlob)
				.then(blob => {
					cy.get('input[type="file"]').then($input => {
						const dd = new File([blob], '22Reportingv913.xml', {
							type: 'text/xml'
						})
						const dataTransfer = new DataTransfer()
						dataTransfer.items.add(dd)
						$input[0].files = dataTransfer.files
					})
				}).then(() => {


				cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/ProjectSetup/index.php?*').as('create_project')

				cy.get('button').contains('Create Project').click()

				cy.wait('@create_project')

				cy.get('a').contains('User Rights').click()

				cy.get('input[id="new_username"]').type("test_user")

				cy.get('button').contains('Add with custom rights').click()

				cy.get('div[aria-describedby="editUserPopup"]').within(() => {
					cy.get('input[name="user_rights"]').check()
					cy.get('input[name="data_export_tool"][value=1]').check()
					cy.get('button').contains('Add user').click()
				})

				cy.set_user_type('standard')
			})
		})
	})

	describe('Basic Functionality', () => {

		it('Should have the ability to assign a name to a report', () => {

			cy.visit_base({ url: './index.php?action=myprojects' })

			cy.get('a').contains('22_Reporting_v913').click()
			cy.get('a').contains('Data Exports, Reports, and Stats').click()
			cy.get('button').contains('Create New Report').click()

			//set report title
			cy.get('input[name="__TITLE__"]').type('Report 1')

			cy.get('button').contains('Quick Add').click()

			// the report should have record_id, fname, lname, reminder, and description
			cy.get('input[name="fname"]').click()
			cy.get('input[name="lname"]').click()
			cy.get('input[name="reminder"]').click()
			cy.get('input[name="description"]').click()

			cy.get('button').contains('Close').click()
			cy.get('button').contains('Save Report').click()

			cy.get('div[id="report_saved_success_dialog"]', { timeout: 10000 }).click();

			cy.get('button').contains('View report').click()
		})

		it('Should have the ability to list report on navigation panel', () => {
			//should be listed on sidebar
			cy.get('div[id="report_panel"]').should('contain', 'Report 1')
		})

		it('Should have the ability to view a report', () => {
			//should have 8 columns
			cy.get('tr[role="row"]').find('th').should('have.length', 8)

			//check for headers
			cy.get('tr[role="row"]').first().should('contain', 'record_id')
			cy.get('tr[role="row"]').first().should('contain', 'fname')
			cy.get('tr[role="row"]').first().should('contain', 'lname')
			cy.get('tr[role="row"]').first().should('contain', 'reminder')
			cy.get('tr[role="row"]').first().should('contain', 'description')

			//check for number of records
			var $dict = {}
			cy.get('a[class="rl"]').each(($el, index, $list) => {
				const $record = $el.text()
				$dict[$record] = true;
			}).then(($list) => {
				expect(Object.keys($dict).length).to.eq(8)
			})

			//check number of repeating instruments
			cy.get('table[id="report_table"]').children('tbody').get('tr:contains("Repeating")').should('have.length', 11)

			//check an Event 1 record for correct values
			cy.get('table[id="report_table"]').children('tbody').find('tr:contains("Event 1")').then(($event_1) => {
				var $length = Cypress.$($event_1).length
				var $rand = Math.floor((Math.random() * $length))

				const $event = Cypress.$($event_1).eq($rand)
				const $columns = Cypress.$($event).find('td')

				var $fname = Cypress.$($columns).eq(4).text()
				var $lname = Cypress.$($columns).eq(5).text()
				var $reminder = Cypress.$($columns).eq(6).text()

				cy.wrap($event).find('a').click()

				cy.get('tr:contains("Export")').find('a').eq(0).click()

				cy.get('input[name="fname"]').should('have.value', $fname)
				cy.get('input[name="lname"]').should('have.value', $lname)
				cy.get('input[name="reminder"]').should('have.value', $reminder)
			})

			cy.get('div[id="report_panel"]').find('a:contains("Report 1")').click().then(() => {
				//check an Event 2 record for correct values
				cy.get('table[id="report_table"]').children('tbody').find('tr:contains("Event 2"):contains("Repeating")').then(($event_2) => {

					var $length = Cypress.$($event_2).length
					var $rand = Math.floor((Math.random() * $length))

					const $event = Cypress.$($event_2).eq($rand)
					const $columns = $event.find('td')

					var $description = Cypress.$($columns).eq(7).text()

					cy.wrap($event).find('a').click()

					cy.get('textarea[name="description"]').should('have.value', $description)
				})
			})
		})

		it('Should have the ability to edit a report', () => {
			cy.get('a').contains('Data Exports, Reports, and Stats').click()

			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').contains('Report 1').parents('tr').within(() => {
					cy.get('button').contains('Edit').click()
				})
			})

			cy.get('button').contains('Quick Add').click()

			cy.get('input[value="description"]').then(($el) => {

				cy.get('input[name="description"]').click().then(() => {
					cy.get('button').contains('Close').then(($el) => {
						cy.wrap($el).click()
						cy.wrap($el).should('not.be.visible')
					})
				})

				//This is key.  We want to ensure that the DOM element for "Description" does not exist before saving.
				cy.wrap($el).should('not.exist')
			})

			cy.get('div[id="quickAddField_dialog"]', { timeout: 10000 }).should('not.be.visible');

			cy.get('input[name="filter_type"]').uncheck()

			cy.get('button').contains('Save Report').click()

			cy.get('div[id="report_saved_success_dialog"]', { timeout: 10000 }).click();


			cy.get('button').contains('View report').click()

			//should have 7 columns
			cy.get('tr[role="row"]').find('th').should('have.length', 7)

			//check for headers
			cy.get('tr[role="row"]').first().should('contain', 'record_id')
			cy.get('tr[role="row"]').first().should('contain', 'fname')
			cy.get('tr[role="row"]').first().should('contain', 'lname')
			cy.get('tr[role="row"]').first().should('contain', 'reminder')
			cy.get('tr[role="row"]').first().should('not.contain', 'description')

			//check for number of records
			var $dict = {}
			cy.get('a[class="rl"]').each(($el, index, $list) => {
				const $record = $el.text()
				$dict[$record] = true;
			}).then(($list) => {
				expect(Object.keys($dict).length).to.eq(8)
			})

			//check number of rows
			cy.get('table[id="report_table"]').children('tbody').find('tr').should('have.length', 16)
		})


		it('Should have the ability to copy a report', () => {
			cy.get('a').contains('Data Exports, Reports, and Stats').click()

			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').contains('Report 1').parents('tr').within(() => {
					cy.get('button').contains('Copy').click()
				})
			})

			//test copy cancel
			cy.get('div[role="dialog"]').within(() => {
				cy.get('button').contains('Cancel').click()
			})

			//should not have copy
			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').should('not.contain', 'Report 1 (copy)')
			})

			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').contains('Report 1').parents('tr').within(() => {
					cy.get('button').contains('Copy').click()
				})
			})

			cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/DataExport/report_copy_ajax.php?*').as('report_copy')
			cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/DataExport/render_report_panel_ajax.php?*').as('report_panel')

			//test copy
			cy.get('div[role="dialog"]').within(() => {
				cy.get('button').contains('Copy').click()
			})

			// UI Catch up
			cy.wait('@report_copy')
			cy.wait('@report_panel')

			//should have copy
			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').should('contain', 'Report 1 (copy)')
			})
		})

		it('Should have the ability to delete a report', () => {
			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').contains('Report 1 (copy)').parents('tr').within(() => {
					cy.get('button').contains('Delete').click()
				})
			})

			//test delete cancel
			cy.get('div[role="dialog"]').within(() => {
				cy.get('button').contains('Cancel').click()
			})

			//should contain copy
			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').should('contain', 'Report 1 (copy)')
			})

			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').contains('Report 1 (copy)').parents('tr').within(() => {
					cy.get('button').contains('Delete').click()
				})
			})

			cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/DataExport/report_delete_ajax.php?*').as('report_delete')
			cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/DataExport/render_report_panel_ajax.php?*').as('report_panel')

			//test delete
			cy.get('div[role="dialog"]').within(() => {
				cy.get('button').contains('Delete').click()
			})

			// UI Catch up
			cy.wait('@report_delete')
			cy.wait('@report_panel')

			//should not contain copy
			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').should('not.contain', 'Report 1 (copy)')
			})
		})

		it('Should have the ability to review all records/events/repeating events data', () => {
			cy.get('a').contains('Data Exports, Reports, and Stats').click()

			cy.get('tr[id="reprow_ALL"]').within(() => {
				cy.get('button').contains('View Report').click()
			})

			//check for number of records
			var $dict = {}
			cy.get('a[class="rl"]').each(($el, index, $list) => {
				const $record = $el.text()
				$dict[$record] = true;
			}).then(($list) => {
				expect(Object.keys($dict).length).to.eq(8)
			})
		})

		it('Should have the ability to properly display rights', () => {
			cy.get('a').contains('User Rights').click()

			cy.get('a').contains('test_user').click()

			cy.get('button').contains('Edit user privileges').click()

			cy.get('div[aria-describedby="editUserPopup"]').within(() => {
				cy.get('input[name="reports"]').uncheck()
				cy.get('button').contains('Save Changes').click()
			})

			cy.get('a').contains('Data Exports, Reports, and Stats').click()

			cy.get('button').should('not.contain', 'Edit')
			cy.get('button').should('not.contain', 'Copy')
			cy.get('button').should('not.contain', 'Delete')

			cy.get('a').contains('User Rights').click()

			cy.get('a').contains('test_user').click()

			cy.get('button').contains('Edit user privileges').click()

			cy.get('div[aria-describedby="editUserPopup"]').within(() => {
				cy.get('input[name="reports"]').check()
				cy.get('button').contains('Save Changes').click()
			})
		})
	})

	describe('Data Filtering Abilities', () => {

		it('Should have the ability to filter a report based upon "equal to" criterion', () => {

			cy.get('a').contains('Data Exports, Reports, and Stats').click()

			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').contains('Report 1').parents('tr').within(() => {
					cy.get('button').contains('Edit').click()
				})
			})

			cy.get('button').contains('Quick Add').click()
			cy.get('input[name="dob"]').check()
			cy.get('button').contains('Close').click()


			// UI Catch up
			cy.get('div[id="quickAddField_dialog"]', { timeout: 10000 }).should('not.be.visible');


			//filter event = Event 1
			cy.get('select[name="filter_events"]').select('Event 1')

			//sort by dob
			cy.get('select[name="sort[]"]').first().select('dob')
			cy.get('select[name="sort[]"] option:selected').should('have.value', 'dob', { timeout: 10000 })
			cy.get('button').contains('Save Report').click()

			//UI Catch up
			cy.get('div[id="report_saved_success_dialog"]', { timeout: 10000 }).click();
			cy.get('button').contains('View report').click()


			//check for dob
			cy.get('tr[role="row"]').first().should('contain', 'dob')

			//check for number of records
			var $dict = {}
			cy.get('a[class="rl"]').each(($el, index, $list) => {
				const $record = $el.text()
				$dict[$record] = true;
			}).then(($list) => {
				expect(Object.keys($dict).length).to.eq(8)
			})

			//check if DOBs are ascending
			var $previousDate = ''
			cy.get('table[id="report_table"]').children('tbody').children('tr').each(($el, index, $list) => {
				var $dateString = $el.children('td').eq(7).text()
				cy.log($dateString)
				var parts = $dateString.split('-')

				var date = new Date(parts[2], parts[0] - 1, parts[1])

				if (index === 0) {
					$previousDate = date
				} else {
					expect(date).to.be.at.least($previousDate)
					$previousDate = date
				}
			})

			cy.get('a').contains('Data Exports, Reports, and Stats').click()

			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').contains('Report 1').parents('tr').within(() => {
					cy.get('button').contains('Edit').click()
				})
			})

			//sort dob desc
			cy.get('select[name="sortascdesc[]"]').first().select('DESC')
			cy.get('select[name="sortascdesc[]"] option:selected').should('have.value', 'DESC', { timeout: 10000 })

			cy.get('button').contains('Save Report').click()


			//UI Catch up
			cy.get('div[id="report_saved_success_dialog"]', { timeout: 10000 }).click();
			cy.get('button').contains('View report').click()

			//check for number of records
			var $dict = {}
			cy.get('a[class="rl"]').each(($el, index, $list) => {
				const $record = $el.text()
				$dict[$record] = true;
			}).then(($list) => {
				expect(Object.keys($dict).length).to.eq(8)
			})

			//check if DOBs are descending
			$previousDate = ''
			cy.get('table[id="report_table"]').children('tbody').children('tr').each(($el, index, $list) => {
				var $dateString = $el.children('td').eq(7).text()
				var parts = $dateString.split('-')

				var date = new Date(parts[2], parts[0] - 1, parts[1])

				if (index === 0) {
					$previousDate = date
				} else {
					expect(date).most($previousDate)
					$previousDate = date
				}
			})
		})

		it('Should have the ability to filter a report based upon "greater than or equal to" criterion', () => {

			//filter dates
			cy.get('a').contains('Data Exports, Reports, and Stats').click()

			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').contains('Report 1').parents('tr').within(() => {
					cy.get('button').contains('Edit').click()
				})
			})

			cy.get('tr[class="limiter_row nodrop"]').within(() => {
				cy.get('button[title="View full list of fields"]').click()

				cy.get('select[name="limiter[]"]').select('dob')
				.trigger('input')

				cy.get('select[name="limiter[]"] option:selected').should('have.value', 'dob', { timeout: 10000 })

				// UI Catch up
				cy.get('select[name="limiter_operator[]"]', { timeout: 10000 }).should('not.be.disabled')

				cy.wait('@report_filter')

				//check limiters
				cy.get('select[name="limiter_operator[]"]').children()
					.should('have.value', 'E').next()
					.should('have.value', 'NE').next()
					.should('have.value', 'LT').next()
					.should('have.value', 'LTE').next()
					.should('have.value', 'GT').next()
					.should('have.value', 'GTE')


				cy.get('select[name="limiter_operator[]"]').select('GT')
				cy.get('select[name="limiter_operator[]"] option:selected').should('have.value', 'GT', { timeout: 10000 })
				cy.get('input[name="limiter_value[]"]').type('6/20/19')

			})

			cy.get('button').contains('Save Report').click()


			//UI Catch up
			cy.get('div[id="report_saved_success_dialog"]', { timeout: 10000 }).click();

			cy.get('button').contains('View report').click()

			var $dict = {}
			cy.get('a[class="rl"]').each(($el, index, $list) => {
				const $record = $el.text()
				$dict[$record] = true;
			}).then(($list) => {
				expect(Object.keys($dict).length).to.eq(4)
			})
		})

		it('Should have the ability to filter a report based upon filtered text', () => {

			cy.get('a').contains('Data Exports, Reports, and Stats').click()

			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').contains('Report 1').parents('tr').within(() => {
					cy.get('button').contains('Edit').click()
				})
			})

			cy.get('tr[class="limiter_row nodrop"]').first().within(() => {
				//cy.get('button[title="View full list of fields"]').click()

				cy.get('select[name="limiter[]"]').select('fname')
				.trigger('input')

				cy.get('select[name="limiter[]"] option:selected').should('have.value', 'fname', { timeout: 10000 })

				cy.wait('@report_filter')

				//check limiters
				cy.get('select[name="limiter_operator[]"]').children()
					.should('have.value', 'E').next()
					.should('have.value', 'NE').next()
					.should('have.value', 'CONTAINS').next()
					.should('have.value', 'NOT_CONTAIN').next()
					.should('have.value', 'STARTS_WITH').next()
					.should('have.value', 'ENDS_WITH')

				cy.get('select[name="limiter_operator[]"]').select('CONTAINS')

				cy.get('select[name="limiter_operator[]"] option:selected').should('have.value', 'CONTAINS', { timeout: 10000 })

				cy.get('input[name="limiter_value[]"]').type('o')

			})

			cy.get('button').contains('Save Report').click()


			//UI Catch up
			cy.get('div[id="report_saved_success_dialog"]', { timeout: 10000 }).click();


			cy.get('button').contains('View report').click()

			var $dict = {}
			cy.get('a[class="rl"]').each(($el, index, $list) => {
				const $record = $el.text()
				$dict[$record] = true;
			}).then(($list) => {
				expect(Object.keys($dict).length).to.eq(3)
			})
		})

		it('Should have the ability to filter a report based upon two criterion (equal to or less than)', () => {
			cy.get('a').contains('Data Exports, Reports, and Stats').click()

			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').contains('Report 1').parents('tr').within(() => {
					cy.get('button').contains('Edit').click()
				})
			})

			cy.get('tr[class="limiter_row nodrop"]').eq(1).within(() => {
				cy.get('button[title="View full list of fields"]').click()

				cy.get('select[name="limiter[]"]').select('dob')
				.trigger('input')

				cy.get('select[name="limiter[]"] option:selected').should('have.value', 'dob', { timeout: 10000 })


				// UI Catch up

				cy.get('select[name="limiter_operator[]"]', { timeout: 10000 }).should('not.be.disabled')


				cy.get('select[name="limiter_operator[]"]').select('LT')

				cy.get('select[name="limiter_operator[]"] option:selected').should('have.value', 'LT', { timeout: 10000 })

				cy.get('input[name="limiter_value[]"]').type('6/20/19')

			})

			cy.get('tr[class="limiter_and_row nodrop"]').eq(1).within(() => {

				cy.get('select').select('OR')

				cy.get('select option:selected').should('have.value', 'OR', { timeout: 10000 })

			})

			cy.get('button').contains('Save Report').click()


			//UI Catch up

			cy.get('div[id="report_saved_success_dialog"]', { timeout: 10000 }).click();


			cy.get('button').contains('View report').click()

			var $dict = {}
			cy.get('a[class="rl"]').each(($el, index, $list) => {
				const $record = $el.text()
				$dict[$record] = true;
			}).then(($list) => {
				expect(Object.keys($dict).length).to.eq(4)
			})
		})

		it('Should have the ability to filter a report based upon two criterion (equal to and less than)', () => {
			cy.get('a').contains('Data Exports, Reports, and Stats').click()

			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').contains('Report 1').parents('tr').within(() => {
					cy.get('button').contains('Edit').click()
				})
			})

			cy.get('select[name="limiter_group_operator[]"]').eq(1).select('AND')

			cy.get('select[name="limiter_group_operator[]"] option:selected').should('have.value', 'AND', { timeout: 10000 })

			cy.get('button').contains('Save Report').click()


			//UI Catch up
			cy.get('div[id="report_saved_success_dialog"]', { timeout: 10000 }).click();


			cy.get('button').contains('View report').click()

			var $dict = {}
			cy.get('a[class="rl"]').each(($el, index, $list) => {
				const $record = $el.text()
				$dict[$record] = true;
			}).then(($list) => {
				expect(Object.keys($dict).length).to.eq(2)
			})
		})

		it('Should have the ability to filter a report based upon "not equal to" criterion', () => {
			cy.get('a').contains('Data Exports, Reports, and Stats').click()

			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').contains('Report 1').parents('tr').within(() => {
					cy.get('button').contains('Edit').click()
				})
			})

			cy.get('tr[class="limiter_row nodrop"]').first().within(() => {

				cy.get('select[name="limiter[]"]').select('lname')
				.trigger('input')

				cy.get('select[name="limiter[]"] option:selected').should('have.value', 'lname', { timeout: 10000 })

				cy.wait('@report_filter')

				// UI Catch up
				cy.get('select[name="limiter_operator[]"]', { timeout: 10000 }).should('not.be.disabled')


				cy.get('select[name="limiter_operator[]"]').select('NE')

				cy.get('select[name="limiter_operator[]"] option:selected').should('have.value', 'NE', { timeout: 10000 })

				cy.get('input[name="limiter_value[]"]').type('Test')

			})

			cy.get('tr[class="limiter_row nodrop"]').eq(1).within(() => {
				cy.get('i[title="Delete"]').parents('a').click()
			})


			// UI Catch up
			cy.get('tr[class="limiter_row nodrop"]', { timeout: 10000 }).should('have.length', 2)


			cy.get('button').contains('Save Report').click()


			//UI Catch up
			cy.get('div[id="report_saved_success_dialog"]', { timeout: 10000 }).click();
			cy.get('button').contains('View report').click()
			cy.get('html').should('contain', 'No results were returned')
		})
	})

	describe('Data Export Formats', () => {

		before(() => {
			cy.get('a').contains('Data Exports, Reports, and Stats').click()

			cy.get('table[id="table-report_list"]').within(() => {
				cy.get('tr').contains('Report 1').parents('tr').within(() => {
					cy.get('button').contains('Edit').click()
				})
			})

			cy.get('tr[class="limiter_row nodrop"]').first().within(() => {
				cy.get('i[title="Delete"]').parents('a').click()
			})


			// UI Catch up
			cy.get('tr[class="limiter_row nodrop"]', { timeout: 10000 }).should('have.length', 1)
			cy.get('button').contains('Save Report').click()


			//UI Catch up
			cy.get('div[id="report_saved_success_dialog"]', { timeout: 10000 }).click();
			cy.intercept('/redcap_v9.1.3/DataExport/report_ajax.php?*').as('report_ajax')
			cy.get('button').contains('View report').click()
			cy.wait('@report_ajax')
		})

		afterEach(() => {
			cy.get('div[role="dialog"]:visible').contains('Data export was successful!')
				.parents('div[role="dialog"]').within(() => {

				cy.get('button').contains('Close').click({force: true})

			})
		})

		it('Should have the ability to export a custom report to CSV format', () => {
			cy.get('button').contains('Export Data').click().then(() => {
				cy.get('input[value="csvraw"]').check()
			})

			cy.get('div[class="ui-dialog-buttonset"]').within(() => {
				cy.get('button').contains('Export Data').click()
				cy.wait('@data_export')
			})

			cy.get('a[href*="/FileRepository/file_download.php"]:visible').then((anchor) => {
				const url = anchor.prop('href');
				// cy.request() will work, because web app did talk to the backend out-of-band.
				cy.request(url).then(($response) => {
					expect($response.status).to.equal(200)
					expect($response.headers['content-disposition']).to.contain('.csv')
					expect($response.headers['content-type']).to.equal('application/csv')
					//validate CSV
				})
			})

		})

		it('Should have the ability to export a custom report to SPSS format', () => {
			cy.get('button').contains('Export Data').click().then(() => {
				cy.get('input[value="spss"]').check()
			})

			cy.get('div[class="ui-dialog-buttonset"]').within(() => {
				cy.get('button').contains('Export Data').click()
				cy.wait('@data_export')
			})

			// Process .SPS File
			cy.get('a img[src*="spss.gif"]').parent('a').then((anchor) => {
				const url = anchor.prop('href');

				cy.request(url).then(($response) => {
					expect($response.status).to.equal(200)
					expect($response.headers['content-disposition']).to.contain('.sps')
					expect($response.headers['content-type']).to.equal('application/octet-stream')
					//validate .sps
				})
			})

			// Process .csv File
			cy.get('a img[src*="csvdata.gif"]').parent('a').then((anchor) => {
				const url = anchor.prop('href');

				cy.request(url).then(($response) => {
					expect($response.status).to.equal(200)
					expect($response.headers['content-disposition']).to.contain('.csv')
					expect($response.headers['content-type']).to.equal('application/csv')
					//validate csv
				})
			})

			// Process .bat File
			cy.get('a[href*="/DataExport/spss_pathway_mapper.php"]:visible').then((anchor) => {
				const url = anchor.prop('href');

				cy.request(url).then(($response) => {
					expect($response.status).to.equal(200)
					expect($response.headers['content-disposition']).to.contain('.bat')
					expect($response.headers['content-type']).to.equal('application/bat')
					//validate .bat
				})
			})

		})

		it('Should have the ability to export a custom report to SAS format', () => {
			cy.get('button').contains('Export Data').click({force: true}).then(() => {
				cy.get('input[value="sas"]').check()
			})

			cy.get('div[class="ui-dialog-buttonset"]').within(() => {
				cy.get('button').contains('Export Data').click()
				cy.wait('@data_export')
			})

			// Process .SAS File
			cy.get('a img[src*="sas.gif"]').parent('a').then((anchor) => {
				const url = anchor.prop('href');

				cy.request(url).then(($response) => {
					expect($response.status).to.equal(200)
					expect($response.headers['content-disposition']).to.contain('.sas')
					expect($response.headers['content-type']).to.equal('application/octet-stream')
					//validate .sas
				})
			})

			// Process .csv File
			cy.get('a img[src*="csvdata.gif"]').parent('a').then((anchor) => {
				const url = anchor.prop('href');

				cy.request(url).then(($response) => {
					expect($response.status).to.equal(200)
					expect($response.headers['content-disposition']).to.contain('.csv')
					expect($response.headers['content-type']).to.equal('application/csv')
					//validate csv
				})
			})

			// Process .bat File
			cy.get('a[href*="/DataExport/sas_pathway_mapper.php"]:visible').then((anchor) => {
				const url = anchor.prop('href');

				cy.request(url).then(($response) => {
					expect($response.status).to.equal(200)
					expect($response.headers['content-disposition']).to.contain('.bat')
					expect($response.headers['content-type']).to.equal('application/bat')
					//validate .bat
				})
			})

		})

		it('Should have the ability to export a custom report to R format', () => {

			cy.get('button').contains('Export Data').click({force: true}).then(() => {
				cy.get('input[value="r"]').check()
			})

			cy.get('div[class="ui-dialog-buttonset"]').within(() => {
				cy.get('button').contains('Export Data').click()
				cy.wait('@data_export')
			})

			// Process .R File
			cy.get('a img[src*="download_r.gif"]').parent('a').then((anchor) => {
				const url = anchor.prop('href');

				cy.request(url).then(($response) => {
					expect($response.status).to.equal(200)
					expect($response.headers['content-disposition']).to.contain('.r')
					expect($response.headers['content-type']).to.equal('application/octet-stream')
					//validate .r
				})
			})

			// Process .csv File
			cy.get('a img[src*="csvdata.gif"]').parent('a').then((anchor) => {
				const url = anchor.prop('href');

				cy.request(url).then(($response) => {
					expect($response.status).to.equal(200)
					expect($response.headers['content-disposition']).to.contain('.csv')
					expect($response.headers['content-type']).to.equal('application/csv')
					//validate csv
				})
			})
		})

		it('Should have the ability to export a custom report to STATA format', () => {

			cy.get('button').contains('Export Data').click({force: true}).then(() => {
				cy.get('input[value="stata"]').check()
			})

			cy.get('div[class="ui-dialog-buttonset"]').within(() => {
				cy.get('button').contains('Export Data').click()
				cy.wait('@data_export')
			})

			// Process .STATA File
			cy.get('a img[src*="stata.gif"]').parent('a').then((anchor) => {
				const url = anchor.prop('href');

				cy.request(url).then(($response) => {
					expect($response.status).to.equal(200)
					expect($response.headers['content-disposition']).to.contain('.do')
					expect($response.headers['content-type']).to.equal('application/octet-stream')
					//validate .sas
				})
			})

			// Process .csv File
			cy.get('a img[src*="csvdata.gif"]').parent('a').then((anchor) => {
				const url = anchor.prop('href');

				cy.request(url).then(($response) => {
					expect($response.status).to.equal(200)
					expect($response.headers['content-disposition']).to.contain('.csv')
					expect($response.headers['content-type']).to.equal('application/csv')
					//validate csv
				})
			})
		})

		it('Should have the ability to export a custom report to CDISC ODM (XML) format', () => {

			cy.get('button').contains('Export Data').click({force: true}).then(() => {
				cy.get('input[value="odm"]').check()
			})

			cy.get('div[class="ui-dialog-buttonset"]').within(() => {
				cy.get('button').contains('Export Data').click()
				cy.wait('@data_export')
			})

			//Process .XML file
			cy.get('a img[src*="xml.gif"]').parent('a').then((anchor) => {
				const url = anchor.prop('href');

				cy.request(url).then(($response) => {
					expect($response.status).to.equal(200)
					expect($response.headers['content-disposition']).to.contain('.xml')
					expect($response.headers['content-type']).to.equal('application/octet-stream')
					//validate xml
				})
			})
		})
	})
})