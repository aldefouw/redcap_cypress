describe('Project Status', () => {
	before(() => {
		//Reset the projects back to what they should be
		cy.mysql_db('projects/pristine').then(() => {
			cy.set_user_type('standard')

			cy.visit_version({page: 'DataEntry/record_home.php', params: "pid=13"})
			cy.get('button').contains('Add new record').click()
			cy.get('select').contains('Complete').parent().select('Complete')
			cy.get('button').contains('Save & Exit Form').click().then(() => {
				cy.visit_version({page: 'ProjectSetup/index.php', params: "pid=13"})
			})	

			cy.visit_version({page: 'ProjectSetup/index.php', params: "pid=13"})	
		})	
	})
	it('Should originally be in development', () => {
		cy.get('span').contains('Project status:').parent().should(($span) => {
			expect($span).to.contain('Development')
		})
	})
	it('Should require administrator approval to move to production', () => {
		cy.get('button').contains('Move project to production').click()
		cy.get('p').contains('Since only REDCap administrators can move a project to production').should(($p) => {
			expect($p).to.contain('Since only REDCap administrators can move a project to production')
		})
	})
	describe('Move Project to Production', () => {
		
		before(() => {
			cy.set_user_type('admin')
			cy.visit_version({page: 'ControlCenter/user_settings.php'}).then(() => {
				cy.get('select').contains('Yes, normal users can move projects to production').parent().select('Yes, normal users can move projects to production')
				cy.get('input').contains('Save Changes').click().then(() => {
					cy.set_user_type('standard')
				})				
			})			
		})
		it('Should allow standard users to move project to production after user settings are changed', () => {
			cy.visit_version({page: 'ProjectSetup/index.php', params: "pid=13"}).then(() => {
				cy.get('button').contains('Move project to production').click()
				cy.get('input#keep_data').click()
				cy.get('button').contains('YES, Move to Production Status').click()
				cy.get('div#actionMsg').should(($div) => {
					expect($div).to.contain('The project is now in production.')
				})
			})
		})
		it('Should contain 1 record', () => {
			cy.visit_version({page: 'DataEntry/record_home.php', params: "pid=13"}).then(() => {
				cy.get('select').contains('-- select record --').parent().should(($r) => {
					expect($r).to.contain('1')
				})
			})
		})
	})
	describe('Move Project to Development', () => {
		before(() => {
			cy.set_user_type('standard')
			cy.visit_version({page: 'ProjectSetup/other_functionality.php', params: "pid=13"})
		})
		it('Should not give normal users the option to move project back to development', () => {
			cy.get('table').contains('archive the project').parent().parent().should('not.contain', 'development status')
		})
		it('Should allow administrator to move project back to development', () => {
			cy.set_user_type('admin')
			cy.visit_version({page: 'ProjectSetup/other_functionality.php', params: "pid=13"}).then(() => {
				cy.get('button').contains('development status').click()
				cy.get('div#actionMsg').should(($msg) => {
					expect($msg).to.contain('The project is now back in development status.')
				})
			})
		})
		it('Should delete all records after user moves project to production and selects "delete all data"', () => {
			cy.set_user_type('standard')
			cy.visit_version({page: 'ProjectSetup/index.php', params: "pid=13"}).then(() => {
				cy.get('button').contains('Move project to production').click()
				cy.get('input#delete_data').click()
				cy.get('button').contains('YES, Move to Production Status').click()
				cy.visit_version({page: 'DataEntry/record_home.php', params: "pid=13"})
				cy.get('select').contains('-- select record --').parent().should('not.contain', '1')
			})
		})
	})
	describe('Archive Project', () => {	
		before(() => {
			cy.set_user_type('admin')
			cy.visit_version({page: 'ProjectSetup/other_functionality.php', params: "pid=13"}).then(() => {
				cy.get('button').contains('development status').click().then(() => {
					cy.set_user_type('standard')
				})	
			})						
		})
		it('Should allow normal user to archive the project', () => {
			cy.visit_version({page: 'ProjectSetup/other_functionality.php', params: "pid=13"}).then(() => {
				cy.get('button').contains('Archive the project').click()
				cy.get('div.ui-dialog-buttonset').contains('Archive the project').click().then(() => {
					cy.visit_base({url: 'index.php?action=myprojects'}).then(() => {
						cy.get('div#proj_table').should('not.contain', 'Test Project')
					})
				})
			})
		})
		it('Should show the archived project in the archived projects list', () => {
			cy.visit_base({url: 'index.php?action=myprojects'}).then(() => {
				cy.get('a').contains('My Projects').parent().click()
				cy.get('a').contains('Show archived projects').click()
				cy.get('div#proj_table').should(($test) => {
					expect($test).to.contain('Test Project')
				})
			})			
		})
		it('Should display a message when user attempts to open an archived project', () => {
			cy.visit_version({page: 'index.php', params: "pid=13"}).then(() => {
				cy.get('div#status_note').should(($note) => {
					expect($note).to.contain('Please note that because this project is either in Inactive or Archived status')
				}).then(() => {
					cy.get('button').focused().contains('Close').click()
				})		
			})				
		})
		it('Should allow user to move archived project to production status', () => {
			cy.visit_version({page: 'ProjectSetup/other_functionality.php', params: "pid=13"}).then(() => {
				cy.get('button').contains('Move to production').click()
				cy.get('button').contains('YES, Move to Production Status').click()
				cy.get('div#actionMsg').should(($div) => {
					expect($div).to.contain('The project is now in production.')
				})
			})
		})
	})
	describe('Move Project to Inactive', () => {
		it('Should allow user to move project to inactive status', () => {
			cy.visit_version({page: 'ProjectSetup/other_functionality.php', params: "pid=13"}).then(() => {
				cy.get('button').contains('Move to inactive').click()
				cy.get('button').contains('YES, Move to Inactive Status').click()
				cy.get('div#status_note').should(($note) => {
					expect($note).to.contain('Please note that because this project is either in Inactive or Archived status,')
				})
				cy.get('button').focused().contains('Close').click()
			})
		})
		it('Should allow user to archive an inactive project', () => {
			cy.visit_version({page: 'ProjectSetup/other_functionality.php', params: "pid=13"}).then(() => {
				cy.get('button').contains('Archive the project').click().then(() => {
					cy.get('div.ui-dialog-buttonset button').contains('Archive the project').click().then(() => {
						cy.on('window:alert', (e) => {
							expect(e).to.contain('The project has now been ARCHIVED.')
					 	})				   	
					})							
				})						
			})
		})	
	})
})