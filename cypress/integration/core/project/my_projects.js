describe('My Projects', () => {

	before(() => {
		cy.set_user_type('standard')
		window.modified_project_title = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789Validation'		
	})

	it('Should open a project when the link is clicked', () => {
		cy.visit_base({url: 'index.php?action=myprojects'})

        cy.get('a').contains('Test Project').click().then(() => {
            cy.get('html').should(($html) => {
                expect($html).to.contain('Test Project')
                expect($html).to.contain('Main project settings')
            })
        })
	})

	it('Should display columns: Project Title, Records, Fields, Instruments, Type, and Status', () => {
		cy.visit_base({url: 'index.php?action=myprojects'})

		cy.get('div#proj_table').should(($div) => {
            expect($div).to.contain('Project Title')
            expect($div).to.contain('Fields')
            expect($div).to.contain('Instrument')
            expect($div).to.contain('Type')
            expect($div).to.contain('Status')
    	})
	})

	it ('Should display a non-truncated title for a given project', () => {

		cy.visit_version({page: 'ProjectSetup/index.php', params: "pid=13"})

		cy.get('button').contains('Modify project title').click().then(() => {
			cy.get('input#app_title').type(window.modified_project_title)

				cy.get('button').contains('Save').click().then(() => {
					cy.visit_base({url: 'index.php?action=myprojects'}).then(() => {
				    	cy.get_project_table_row_col(1, 1).then(($a) => {
				            expect($a).to.contain(window.modified_project_title)
		    			})
					})
				})
		})
	})

	it('Should display the correct number of records for a given project', () => {
		cy.visit_base({url: 'index.php?action=myprojects'})

        cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
             cy.get_project_table_row_col(1, 2).then(($a) => {
                expect($a).to.contain('0')
            })
        })

        cy.visit_version({page: 'ProjectSetup/index.php', params: "pid=13"})

        cy.get('a').contains('Add / Edit Records').click().then(() => {
        	cy.get('button').contains('Add new record').click().then(() => {
        		cy.get('button').contains('Save & Exit Form').click().then(() => {
        			cy.visit_base({url: 'index.php?action=myprojects'})

		            cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
		                 cy.get_project_table_row_col(1, 2).then(($a) => {
		                    expect($a).to.contain('1')
		                })
		            })
        		})
        	})
        })
	})

	it('Should display the correct number of fields for a given project', () => {

		cy.visit_base({url: 'index.php?action=myprojects'})

        cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
             cy.get_project_table_row_col(1, 3).then(($a) => {
                expect($a).to.contain('2') // Note that this calculated to include the default Record ID field
            })
        })

        cy.visit_version({page: 'ProjectSetup/index.php', params: "pid=13"})

        cy.get('a').contains('Project Setup').click().then(() => {
        	cy.get('button').contains('Online Designer').click().then(() => {
        		cy.get('a').contains('My First Instrument').click().then(() => {
            		cy.get('input#btn-last').click().then(() => {
            			cy.get('select#field_type').select('text').then(() => {
            				cy.get('input#field_name').type('second_field').then(() => {
	            				cy.get('button').contains('Save').click().then(() => {

									cy.get('span.designVarName').should('contain', "second_field").then(() => {		            					
		            					cy.visit_base({url: 'index.php?action=myprojects'})

							            cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
						                 	cy.get_project_table_row_col(1, 3).then(($a) => {
						                    	expect($a).to.contain('3') // Note that this calculated to include the default Record ID field
						                	})
		            					})		 
	            					})    
	            				})
            				})
		            	})
		        	})
        		})
        	})
        })

	})

	it('Should display the correct number of instruments for a given project', () => {
		cy.visit_base({url: 'index.php?action=myprojects'})

        cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
             cy.get_project_table_row_col(1, 4).then(($a) => {
                expect($a).to.contain('1 form')
            })
        })

        cy.visit_version({page: 'ProjectSetup/index.php', params: "pid=13"})

       	cy.get('a').contains('Project Setup').click().then(() => {
        	cy.get('button').contains('Online Designer').click().then(() => {
        		cy.get('button').contains(/^Create$/).click().then(() => {
        			cy.get('button').contains('Add instrument here').click().then(() => {
	            		cy.get('input#new_form-my_first_instrument').type('Second Instrument').then(() => {
	            			cy.get('input[value="Create"]').click().then(() => {

	            				cy.visit_base({url: 'index.php?action=myprojects'})
	          
					            cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
				                 	cy.get_project_table_row_col(1, 4).then(($a) => {
				                    	expect($a).to.contain('2 forms') // Note that this calculated to include the default Record ID field
				                	})		            	
					
								})								
	    					})
		            	})
		        	})
        		})
        	})
        })
	})

	it('Should display the correct icon for a given longitudinal project', () => {
		cy.visit_base({url: 'index.php?action=myprojects'})

        cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
             cy.get_project_table_row_col(1, 5).then(($a) => {
                expect($a[0].innerHTML).to.contain('Longitudinal / repeating forms')
            })
        })        
	})

	it('Should display the correct icon for a given classic project', () => {

		cy.visit_version({page: 'ProjectSetup/index.php', params: "pid=13"})

		cy.get('div').contains('Use longitudinal data collection with defined events?').children('button').then(($a) => {
			expect($a).to.contain('Disable')

			cy.wrap($a).click().then(() => {
				cy.get('button#' + $a[0]['id']).should(($b) => {
					expect($b).to.contain('Enable')
				})	
			})					
		})		

		cy.visit_base({url: 'index.php?action=myprojects'})

		cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
             cy.get_project_table_row_col(1, 5).then(($a) => {
                expect($a[0].innerHTML).to.contain('Classic')
            })
        })
	})

	it('Should display the correct project status for a project in Development', () => {
		cy.visit_base({url: 'index.php?action=myprojects'})

        cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
             cy.get_project_table_row_col(1, 6).then(($a) => {
                expect($a[0].innerHTML).to.contain('Development')
            })
        })        
	})

	it('Should display the correct project status for a project in Production', () => {
		cy.set_user_type('admin')

        cy.visit_version({page: 'ProjectSetup/index.php', params: "pid=13"})

       	cy.get('a').contains('Project Setup').click().then(() => {
        	cy.get('button').contains('Move project to production').click().then(() => {
        		cy.get('span').contains('Keep ALL data').click().then(() => {
        			cy.get('button').contains('YES').click().then(() => {

						cy.get('button').should('not.contain', "Please wait").then(() => {

	        				cy.set_user_type('standard')

		            		cy.visit_base({url: 'index.php?action=myprojects'})

						    cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
								cy.get_project_table_row_col(1, 6).then(($a) => {
						            expect($a[0].innerHTML).to.contain('Production')
						        })
						    })
						})
					})
        		})
        	})
        })
	})

	it('Should display the correct project status for an Inactive project (from Production status)', () => {

		cy.visit_version({page: 'ProjectSetup/other_functionality.php', params: "pid=13"})

		cy.get('button').contains('Move to inactive').click().then(() => {
			cy.get('button').contains('YES').click().then(() => {
				cy.visit_base({url: 'index.php?action=myprojects'})

				cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
					cy.get_project_table_row_col(1, 6).then(($a) => {
		                expect($a[0].innerHTML).to.contain('Inactive')
		            })
		        })  
			})
		})       
	})

	it('Should not display archived projects by default', () => {
		cy.visit_version({page: 'ProjectSetup/other_functionality.php', params: "pid=13"})

		cy.get('button').contains('Archive the project').click().then(() => {
			cy.get('div.ui-dialog button').contains('Archive the project').click().then(() => {
				cy.visit_base({url: 'index.php?action=myprojects'})

				cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
					cy.get_project_table_row_col(1, 1).then(($a) => {
		                expect($a[0].innerHTML).to.contain('You do not have access to any projects')
	            	})				
				})
			})     
		})
	})

	it('Should allow me to see archived projects if desired', () => {
		cy.visit_base({url: 'index.php?action=myprojects'})

		cy.get('a').contains('Show archived projects').click().then(() => {
			cy.get_project_table_row_col(1, 1).then(($a) => {
	            expect($a).to.contain(window.modified_project_title)
			})
		})
	})

	it('Should display the correct project status for an Archived project (from Inactive status)', () => {
		cy.visit_base({url: 'index.php?action=myprojects'}).then(() => {
	    	cy.get('a').contains('Show archived projects').click().then(() => {
	    		cy.get_project_table_row_col(1, 6).then(($a) => {
	            	expect($a[0].innerHTML).to.contain('Archived')
				})
	    	})
		})
	})

})