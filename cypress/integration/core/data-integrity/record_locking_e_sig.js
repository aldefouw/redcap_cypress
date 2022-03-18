describe('Record Locking and E-Signatures', () => {

	before(() => {
		
		cy.mysql_db('projects/pristine')
        cy.set_user_type('admin')

        cy.visit_version({page: 'Locking/locking_customization.php', params: 'pid=7'})

		cy.get('div[role="dialog"]', { timeout: 10000 }).within(() => {

			cy.get('button').contains('I understand. Let me make changes.').click();

		})

		cy.get('[id="part11_forms"]', { timeout: 10000 }).within(() => {

			cy.get('tr[id="row-demographics"]').within(() => {

				cy.get('input[id="dispchk-demographics"]').check()

				cy.get('input[onClick="setDisplayEsign(\'demographics\',this.checked)"]').check()

				cy.get('input[type="button"][value="Save"]').click()

			})		
			
			cy.get('tr[id="row-month_1_data"]').within(() => {

				cy.get('input[id="dispchk-month_1_data"]').uncheck()

				//cy.get('input[type="button"][value="Save"]').click()

			})	

			cy.get('tr[id="row-month_2_data"]').within(() => {

				cy.get('input[id="dispchk-month_2_data"]').uncheck()

				//cy.get('input[type="button"][value="Save"]').click()

			})	

			cy.get('tr[id="row-month_3_data"]').within(() => {

				cy.get('input[id="dispchk-month_3_data"]').uncheck()

				//cy.get('input[type="button"][value="Save"]').click()

			})	

			cy.get('tr[id="row-completion_data"]').within(() => {

				cy.get('input[id="dispchk-completion_data"]').uncheck()

				//cy.get('input[type="button"][value="Save"]').click()

			})	

		})

		cy.visit_version({page: 'DataEntry/record_home.php', params: 'pid=7'})

		cy.get('div[id="center"]').within(() => { 

			cy.get('table[class="form_border"]').within(() => { 

				cy.get('button').contains('Add new record').click();

			})

		})

		cy.get('table[id=event_grid_table]').within(() => {


			cy.get('td[class="labelform"]').contains('Demographics').parent().within(() => {

				cy.get('img').click()

			})


		})

		cy.get('button').contains('Save & Exit Form').click();

		cy.visit_version({page: 'DataEntry/record_home.php', params: 'pid=7'})

		cy.get('div[id="center"]').within(() => { 

			cy.get('table[class="form_border"]').within(() => { 

				cy.get('button').contains('Add new record').click();

			})

		})

		cy.get('table[id=event_grid_table]').within(() => {

			cy.get('td[class="labelform"]').contains('Demographics').parent().within(() => {

				cy.get('img').click()

			})

		})

		cy.get('input[type="checkbox"][id="__LOCKRECORD__"]').check()	

		cy.get('button').contains('Save & Exit Form').click();

		cy.visit_version({page: 'DataEntry/record_home.php', params: 'pid=7'})

		cy.get('div[id="center"]').within(() => { 

			cy.get('table[class="form_border"]').within(() => { 

				cy.get('button').contains('Add new record').click();

			})

		})

		cy.get('table[id=event_grid_table]').within(() => {

			cy.get('td[class="labelform"]').contains('Demographics').parent().within(() => {

				cy.get('img').click()

			})

		})

		cy.get('input[type="checkbox"][id="__LOCKRECORD__"]').check()	

		cy.get('input[type="checkbox"][id="__ESIGNATURE__"]').check()
		
		cy.get('button').contains('Save & Exit Form').click();

		cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/Locking/single_form_action.php?*').as('single_form')

		cy.get('div[role="dialog"]', { timeout: 10000 }).within(() => {

			cy.get('input[type="password"][id="esign_password"]').type(Cypress.env("users").admin.pass)

			cy.get('button').contains('Save').click()

			cy.wait('@single_form').then(({ request, response }) => {
				expect(response.statusCode).to.eq(200)
			})
		})

		cy.visit_version({page: 'DataEntry/record_home.php', params: 'pid=7'})

		cy.get('div[id="center"]').within(() => { 

			cy.get('table[class="form_border"]').within(() => { 

				cy.get('button').contains('Add new record').click();

			})

		})

		cy.get('table[id=event_grid_table]').within(() => {

			cy.get('td[class="labelform"]').contains('Randomization Form').parent().within(() => {

				cy.get('img').click()

			})

		})

		cy.get('input[type="checkbox"][id="__LOCKRECORD__"]').check()	
		
		cy.get('button').contains('Save & Exit Form').click();

		cy.visit_version({page: 'DataEntry/record_home.php', params: 'pid=7'})

		cy.get('div[id="center"]').within(() => { 

			cy.get('table[class="form_border"]').within(() => { 

				cy.get('button').contains('Add new record').click();

			})

		})

		cy.get('table[id=event_grid_table]').within(() => {

			cy.get('td[class="labelform"]').contains('Completion Data').parent().within(() => {

				cy.get('img').click()

			})

		})
		
		cy.get('button').contains('Save & Exit Form').click();

		/*cy.visit_version({page: 'ControlCenter/view_users.php', params: 'username=site_admin'})

		cy.get('input[value="Suspend user account"]').click()*/
		
	})

	 describe('Basic Functionality', () => {


		it('Should display all records with status that is Locked or E-signed for all Data Collection instruments', () => {

			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('table[id=esignLockList]').within(() => {

				cy.get('tr[class="rowl unlocked unesigned"]').should('include.text', '1');

				cy.get('tr[class="rowl locked unesigned"]').should('include.text', '2');

				cy.get('tr[class="rowl locked esigned"]').should('include.text', '3');

			})

	    })

	    it('Should NOT display Data Collection instruments that are NOT designated to be Locked', () => {
	            
			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('table[id=esignLockList]').should('not.include.text', 'Month 1 Data');

			cy.get('table[id=esignLockList]').should('not.include.text', 'Month 2 Data');

			cy.get('table[id=esignLockList]').should('not.include.text', 'Month 3 Data');

			cy.get('table[id=esignLockList]').should('not.include.text', 'Completion Data');


	    })

	    it('Should display the Locked status of Data Collection instruments for all records', () => {

			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('tr[class="rowl unlocked unesigned"]').should('include.text', '1').and('include.text', 'Demographics')			

			cy.get('tr[class="rowl unlocked aesigned"]').should('include.text', '1').and('include.text', 'Randomization Form')
			
			cy.get('tr[class="rowl unlocked aesigned"]').should('include.text', '1').and('include.text', 'Baseline Data')


			cy.get('tr[class="rowl locked unesigned"]').should('include.text', '2').and('include.text', 'Demographics')			

			cy.get('tr[class="rowl unlocked aesigned"]').should('include.text', '2').and('include.text', 'Randomization Form')
			
			cy.get('tr[class="rowl unlocked aesigned"]').should('include.text', '2').and('include.text', 'Baseline Data')


			cy.get('tr[class="rowl locked esigned"]').should('include.text', '3').and('include.text', 'Demographics')			

			cy.get('tr[class="rowl unlocked aesigned"]').should('include.text', '3').and('include.text', 'Randomization Form')
			
			cy.get('tr[class="rowl unlocked aesigned"]').should('include.text', '3').and('include.text', 'Baseline Data')


			cy.get('tr[class="rowl unlocked unesigned"]').should('include.text', '4').and('include.text', 'Demographics')			

			cy.get('tr[class="rowl locked aesigned"]').should('include.text', '4').and('include.text', 'Randomization Form')
			
			cy.get('tr[class="rowl unlocked aesigned"]').should('include.text', '4').and('include.text', 'Baseline Data')
	    })

	    it('Should display the E-Signature status of Data Collection instruments for all records', () => {

			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('tr[class="rowl locked unesigned"]').should('include.text', '2').and('include.text', 'Demographics')		

			cy.get('tr[class="rowl locked esigned"]').should('include.text', '3').and('include.text', 'Demographics')		

			cy.get('tr[class="rowl locked aesigned"]').should('include.text', '4').and('include.text', 'Randomization Form')

	    })

	    it('Should have the ability to navigate directly to a selected a record', () => {

			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('tr[class="rowl locked unesigned"]').should('include.text', '2').and('include.text', 'Demographics').find('a').invoke('removeAttr', 'target').click()

			cy.get('div[id="center"]').should('include.text', 'Demographics');

			cy.get('table[role="presentation"]').within(() => {
			
				cy.get('tr[id="study_id-tr"]').should('include.text', '2')
				
			})

	    })
	 })   

    describe('Customization', () => {

    	it('Should have the ability to enable display of the Lock option for each Data Collection instrument', () => {

			cy.visit_version({page: 'Locking/locking_customization.php', params: 'pid=7'})

			cy.get('div[role="dialog"]', { timeout: 10000 }).within(() => {

				cy.get('button').contains('I understand. Let me make changes.').click();

			})

			cy.get('tr[id="row-demographics"]').within(() => {

				cy.get('input[id="dispchk-demographics"]').check()

				cy.get('input[id="dispchk-demographics"]').uncheck()

				cy.get('input[id="dispchk-demographics"]').check()

			})	

			cy.get('tr[id="row-randomization_form"]').within(() => {

				cy.get('input[id="dispchk-randomization_form"]').check()

				cy.get('input[id="dispchk-randomization_form"]').uncheck()

				cy.get('input[id="dispchk-randomization_form"]').check()

			})	

			cy.get('tr[id="row-baseline_data"]').within(() => {

				cy.get('input[id="dispchk-baseline_data"]').check()

				cy.get('input[id="dispchk-baseline_data"]').uncheck()

				cy.get('input[id="dispchk-baseline_data"]').check()

			})	

			cy.get('tr[id="row-month_1_data"]').within(() => {

				cy.get('input[id="dispchk-month_1_data"]').check()

				cy.get('input[id="dispchk-month_1_data"]').uncheck()

				cy.get('input[id="dispchk-month_1_data"]').check()


			})	

			cy.get('tr[id="row-month_2_data"]').within(() => {

				cy.get('input[id="dispchk-month_2_data"]').check()

				cy.get('input[id="dispchk-month_2_data"]').uncheck()

				cy.get('input[id="dispchk-month_2_data"]').check()

			})	

			cy.get('tr[id="row-month_3_data"]').within(() => {

				cy.get('input[id="dispchk-month_3_data"]').check()

				cy.get('input[id="dispchk-month_3_data"]').uncheck()

				cy.get('input[id="dispchk-month_3_data"]').check()


			})	

			cy.get('tr[id="row-completion_data"]').within(() => {

				cy.get('input[id="dispchk-completion_data"]').check()

				cy.get('input[id="dispchk-completion_data"]').uncheck()

				cy.get('input[id="dispchk-completion_data"]').check()

			})	

    	})

    	it('Should have the ability to disable display of the Lock option for each Data Colllection instrument', () => {

			cy.visit_version({page: 'Locking/locking_customization.php', params: 'pid=7'})

			cy.get('div[role="dialog"]', { timeout: 10000 }).within(() => {

				cy.get('button').contains('I understand. Let me make changes.').click();

			})

			cy.get('tr[id="row-demographics"]').within(() => {

				cy.get('input[id="dispchk-demographics"]').uncheck()

			})	

			cy.get('tr[id="row-randomization_form"]').within(() => {

				cy.get('input[id="dispchk-randomization_form"]').uncheck()

			})	

			cy.get('tr[id="row-baseline_data"]').within(() => {

				cy.get('input[id="dispchk-baseline_data"]').uncheck()

			})	

			cy.get('tr[id="row-month_1_data"]').within(() => {

				cy.get('input[id="dispchk-month_1_data"]').uncheck()

			})	

			cy.get('tr[id="row-month_2_data"]').within(() => {

				cy.get('input[id="dispchk-month_2_data"]').uncheck()

			})	

			cy.get('tr[id="row-month_3_data"]').within(() => {

				cy.get('input[id="dispchk-month_3_data"]').uncheck()

			})	

			cy.get('tr[id="row-completion_data"]').within(() => {

				cy.get('input[id="dispchk-completion_data"]').uncheck()

			})	

    	})

    	it('Should have the ability to enable display of the E-Signature option for each Data Collection instrument', () => {

			cy.visit_version({page: 'Locking/locking_customization.php', params: 'pid=7'})

			cy.get('div[role="dialog"]', { timeout: 10000 }).within(() => {

				cy.get('button').contains('I understand. Let me make changes.').click();

			})

			cy.get('tr[id="row-demographics"]').within(() => {

				cy.get('input[id="dispchk-demographics"]').check()
				cy.get('input[onClick="setDisplayEsign(\'demographics\',this.checked)"]').check()

			})	

			cy.get('tr[id="row-randomization_form"]').within(() => {

				cy.get('input[id="dispchk-randomization_form"]').check()
				cy.get('input[onClick="setDisplayEsign(\'randomization_form\',this.checked)"]').check()

			})	

			cy.get('tr[id="row-baseline_data"]').within(() => {

				cy.get('input[id="dispchk-baseline_data"]').check()
				cy.get('input[onClick="setDisplayEsign(\'baseline_data\',this.checked)"]').check()

			})	

			cy.get('tr[id="row-month_1_data"]').within(() => {

				cy.get('input[id="dispchk-month_1_data"]').check()
				cy.get('input[onClick="setDisplayEsign(\'month_1_data\',this.checked)"]').check()

			})	

			cy.get('tr[id="row-month_2_data"]').within(() => {

				cy.get('input[id="dispchk-month_2_data"]').check()
				cy.get('input[onClick="setDisplayEsign(\'month_2_data\',this.checked)"]').check()

			})	

			cy.get('tr[id="row-month_3_data"]').within(() => {

				cy.get('input[id="dispchk-month_3_data"]').check()
				cy.get('input[onClick="setDisplayEsign(\'month_3_data\',this.checked)"]').check()

			})	

			cy.get('tr[id="row-completion_data"]').within(() => {

				cy.get('input[id="dispchk-completion_data"]').check()
				cy.get('input[onClick="setDisplayEsign(\'completion_data\',this.checked)"]').check()

			})	

    	})

    	it('Should have the ability to disable display of the E-Signature option for each Data Colllection instrument', () => {
    		
			cy.visit_version({page: 'Locking/locking_customization.php', params: 'pid=7'})

			cy.get('div[role="dialog"]', { timeout: 10000 }).within(() => {

				cy.get('button').contains('I understand. Let me make changes.').click();

			})

			cy.get('tr[id="row-demographics"]').within(() => {

				cy.get('input[id="dispchk-demographics"]').check()
				cy.get('input[onClick="setDisplayEsign(\'demographics\',this.checked)"]').uncheck()

			})	

			cy.get('tr[id="row-randomization_form"]').within(() => {

				cy.get('input[id="dispchk-randomization_form"]').check()
				cy.get('input[onClick="setDisplayEsign(\'randomization_form\',this.checked)"]').uncheck()

			})	

			cy.get('tr[id="row-baseline_data"]').within(() => {


				cy.get('input[id="dispchk-baseline_data"]').check()
				cy.get('input[onClick="setDisplayEsign(\'baseline_data\',this.checked)"]').uncheck()

			})	

			cy.get('tr[id="row-month_1_data"]').within(() => {

				cy.get('input[id="dispchk-month_1_data"]').check()
				cy.get('input[onClick="setDisplayEsign(\'month_1_data\',this.checked)"]').uncheck()

			})	

			cy.get('tr[id="row-month_2_data"]').within(() => {

				cy.get('input[id="dispchk-month_2_data"]').check()
				cy.get('input[onClick="setDisplayEsign(\'month_2_data\',this.checked)"]').uncheck()

			})	

			cy.get('tr[id="row-month_3_data"]').within(() => {

				cy.get('input[id="dispchk-month_3_data"]').check()
				cy.get('input[onClick="setDisplayEsign(\'month_3_data\',this.checked)"]').uncheck()

			})	

			cy.get('tr[id="row-completion_data"]').within(() => {

				cy.get('input[id="dispchk-completion_data"]').check()
				cy.get('input[onClick="setDisplayEsign(\'completion_data\',this.checked)"]').uncheck()

			})	

    	})

    	it('Should have the ability to edit Lock Record Custom Text', () => {

			cy.visit_version({page: 'Locking/locking_customization.php', params: 'pid=7'})

			cy.get('div[role="dialog"]', { timeout: 10000 }).within(() => {

				cy.get('button').contains('I understand. Let me make changes.').click();

			})

			cy.get('tr[id="row-demographics"]').within(() => {

				cy.get('input[id="dispchk-demographics"]').check()
				cy.get('textarea[id="label-demographics"]').clear().type("Custom Record Locking Label")
				cy.get('input[type="button"][value="Save"]').click()

				cy.get('td[id="cell-demographics"]').contains("Custom Record Locking Label")
				cy.get('td[id="cell-demographics"]').not('textarea');

				cy.get('a[onclick="editLockLabel(\'demographics\')"]').click()
				cy.get('textarea[id="label-demographics"]').clear().type("New Record Locking Label")
				cy.get('input[type="button"][value="Save"]').click()

				cy.get('td[id="cell-demographics"]').contains("New Record Locking Label")
				cy.get('td[id="cell-demographics"]').not('textarea');

			})	

			cy.get('tr[id="row-randomization_form"]').within(() => {

				cy.get('input[id="dispchk-randomization_form"]').check()
				cy.get('textarea[id="label-randomization_form"]').clear().type("Custom Record Locking Label")
				cy.get('input[type="button"][value="Save"]').click()
				
				cy.get('td[id="cell-randomization_form"]').contains("Custom Record Locking Label")
				cy.get('td[id="cell-randomization_form"]').not('textarea');

				cy.get('a[onclick="editLockLabel(\'randomization_form\')"]').click()
				cy.get('textarea[id="label-randomization_form"]').clear().type("New Record Locking Label")
				cy.get('input[type="button"][value="Save"]').click()

				cy.get('td[id="cell-randomization_form"]').contains("New Record Locking Label")
				cy.get('td[id="cell-randomization_form"]').not('textarea');

			})	

			cy.get('tr[id="row-baseline_data"]').within(() => {

				cy.get('input[id="dispchk-baseline_data"]').check()
				cy.get('textarea[id="label-baseline_data"]').clear().type("Custom Record Locking Label")
				cy.get('input[type="button"][value="Save"]').click()
				
				cy.get('td[id="cell-baseline_data"]').contains("Custom Record Locking Label")
				cy.get('td[id="cell-baseline_data"]').not('textarea');

				cy.get('a[onclick="editLockLabel(\'baseline_data\')"]').click()
				cy.get('textarea[id="label-baseline_data"]').clear().type("New Record Locking Label")
				cy.get('input[type="button"][value="Save"]').click()

				cy.get('td[id="cell-baseline_data"]').contains("New Record Locking Label")
				cy.get('td[id="cell-baseline_data"]').not('textarea');

			})	

			cy.get('tr[id="row-month_1_data"]').within(() => {

				cy.get('input[id="dispchk-month_1_data"]').check()
				cy.get('textarea[id="label-month_1_data"]').clear().type("Custom Record Locking Label")
				cy.get('input[type="button"][value="Save"]').click()
				
				cy.get('td[id="cell-month_1_data"]').contains("Custom Record Locking Label")
				cy.get('td[id="cell-month_1_data"]').not('textarea');

				cy.get('a[onclick="editLockLabel(\'month_1_data\')"]').click()
				cy.get('textarea[id="label-month_1_data"]').clear().type("New Record Locking Label")
				cy.get('input[type="button"][value="Save"]').click()

				cy.get('td[id="cell-month_1_data"]').contains("New Record Locking Label")
				cy.get('td[id="cell-month_1_data"]').not('textarea');

			})	

			cy.get('tr[id="row-month_2_data"]').within(() => {

				cy.get('input[id="dispchk-month_2_data"]').check()
				cy.get('textarea[id="label-month_2_data"]').clear().type("Custom Record Locking Label")
				cy.get('input[type="button"][value="Save"]').click()
				
				cy.get('td[id="cell-month_2_data"]').contains("Custom Record Locking Label")
				cy.get('td[id="cell-month_2_data"]').not('textarea');

				cy.get('a[onclick="editLockLabel(\'month_2_data\')"]').click()
				cy.get('textarea[id="label-month_2_data"]').clear().type("New Record Locking Label")
				cy.get('input[type="button"][value="Save"]').click()

				cy.get('td[id="cell-month_2_data"]').contains("New Record Locking Label")
				cy.get('td[id="cell-month_2_data"]').not('textarea');

			})	

			cy.get('tr[id="row-month_3_data"]').within(() => {

				cy.get('input[id="dispchk-month_3_data"]').check()
				cy.get('textarea[id="label-month_3_data"]').clear().type("Custom Record Locking Label")
				cy.get('input[type="button"][value="Save"]').click()
				
				cy.get('td[id="cell-month_3_data"]').contains("Custom Record Locking Label")
				cy.get('td[id="cell-month_3_data"]').not('textarea');

				cy.get('a[onclick="editLockLabel(\'month_3_data\')"]').click()
				cy.get('textarea[id="label-month_3_data"]').clear().type("New Record Locking Label")
				cy.get('input[type="button"][value="Save"]').click()

				cy.get('td[id="cell-month_3_data"]').contains("New Record Locking Label")
				cy.get('td[id="cell-month_3_data"]').not('textarea');

			})	

			cy.get('tr[id="row-completion_data"]').within(() => {

				cy.get('input[id="dispchk-completion_data"]').check()
				cy.get('textarea[id="label-completion_data"]').clear().type("Custom Record Locking Label")
				cy.get('input[type="button"][value="Save"]').click()
				
				cy.get('td[id="cell-completion_data"]').contains("Custom Record Locking Label")
				cy.get('td[id="cell-completion_data"]').not('textarea');

				cy.get('a[onclick="editLockLabel(\'completion_data\')"]').click()
				cy.get('textarea[id="label-completion_data"]').clear().type("New Record Locking Label")
				cy.get('input[type="button"][value="Save"]').click()

				cy.get('td[id="cell-completion_data"]').contains("New Record Locking Label")
				cy.get('td[id="cell-completion_data"]').not('textarea');

			})			

	    })

    	it('Should have the ability to remove Lock Record Custom Text', () => {
			cy.visit_version({page: 'Locking/locking_customization.php', params: 'pid=7'})

			cy.get('div[role="dialog"]', { timeout: 10000 }).within(() => {

				cy.get('button').contains('I understand. Let me make changes.').click();

			})

			cy.get('tr[id="row-demographics"]').within(() => {

				cy.get('input[id="dispchk-demographics"]').check()

				cy.get('td[id="cell-demographics"]').contains("New Record Locking Label")
				cy.get('td[id="cell-demographics"]').not('textarea');

				cy.get('a[onclick="delLabel(\'demographics\')"]').click()

				cy.get('td[id="cell-demographics"]').not('New Record Locking Label');

			})	

			cy.get('tr[id="row-randomization_form"]').within(() => {

				cy.get('input[id="dispchk-randomization_form"]').check()
				
				cy.get('td[id="cell-randomization_form"]').contains("New Record Locking Label")
				cy.get('td[id="cell-randomization_form"]').not('textarea');

				cy.get('a[onclick="delLabel(\'randomization_form\')"]').click()

				cy.get('td[id="cell-randomization_form"]').not('New Record Locking Label');

			})	

			cy.get('tr[id="row-baseline_data"]').within(() => {

				cy.get('input[id="dispchk-baseline_data"]').check()
				
				cy.get('td[id="cell-baseline_data"]').contains("New Record Locking Label")
				cy.get('td[id="cell-baseline_data"]').not('textarea');

				cy.get('a[onclick="delLabel(\'baseline_data\')"]').click()

				cy.get('td[id="cell-baseline_data"]').not('New Record Locking Label');

			})	

			cy.get('tr[id="row-month_1_data"]').within(() => {

				cy.get('input[id="dispchk-month_1_data"]').check()
				
				cy.get('td[id="cell-month_1_data"]').contains("New Record Locking Label")
				cy.get('td[id="cell-month_1_data"]').not('textarea');

				cy.get('a[onclick="delLabel(\'month_1_data\')"]').click()

				cy.get('td[id="cell-month_1_data"]').not('New Record Locking Label');

			})	

			cy.get('tr[id="row-month_2_data"]').within(() => {

				cy.get('input[id="dispchk-month_2_data"]').check()
				
				cy.get('td[id="cell-month_2_data"]').contains("New Record Locking Label")
				cy.get('td[id="cell-month_2_data"]').not('textarea');

				cy.get('a[onclick="delLabel(\'month_2_data\')"]').click()

				cy.get('td[id="cell-month_2_data"]').not('New Record Locking Label');

			})	

			cy.get('tr[id="row-month_3_data"]').within(() => {

				cy.get('input[id="dispchk-month_3_data"]').check()
				
				cy.get('td[id="cell-month_3_data"]').contains("New Record Locking Label")
				cy.get('td[id="cell-month_3_data"]').not('textarea');

				cy.get('a[onclick="delLabel(\'month_3_data\')"]').click()

				cy.get('td[id="cell-month_3_data"]').not('New Record Locking Label');

			})	

			cy.get('tr[id="row-completion_data"]').within(() => {

				cy.get('input[id="dispchk-completion_data"]').check()
				
				cy.get('td[id="cell-completion_data"]').contains("New Record Locking Label")
				cy.get('td[id="cell-completion_data"]').not('textarea');

				cy.get('a[onclick="delLabel(\'completion_data\')"]').click()

				cy.get('td[id="cell-completion_data"]').not('Custom Record Locking Label');

			})

	    })
    })

    describe('Filtering Options', () => {

		before( () =>{
			cy.mysql_db('projects/pristine')
			cy.set_user_type('admin')
			cy.visit_version({page: 'Locking/locking_customization.php', params: 'pid=7'})
	
			cy.get('div[role="dialog"]', { timeout: 10000 }).within(() => {
	
				cy.get('button').contains('I understand. Let me make changes.').click();
	
			})

			cy.get('[id="part11_forms"]', { timeout: 10000 }).within(() => {

				cy.get('tr[id="row-demographics"]').within(() => {
	
					cy.get('input[id="dispchk-demographics"]').check()
	
					cy.get('input[onClick="setDisplayEsign(\'demographics\',this.checked)"]').check()
	
					cy.get('input[type="button"][value="Save"]').click()
	
				})		
				
				cy.get('tr[id="row-month_1_data"]').within(() => {
	
					cy.get('input[id="dispchk-month_1_data"]').uncheck()
	
				})	
	
				cy.get('tr[id="row-month_2_data"]').within(() => {
	
					cy.get('input[id="dispchk-month_2_data"]').uncheck()
	
				})	
	
				cy.get('tr[id="row-month_3_data"]').within(() => {
	
					cy.get('input[id="dispchk-month_3_data"]').uncheck()
	
				})	
	
				cy.get('tr[id="row-completion_data"]').within(() => {
	
					cy.get('input[id="dispchk-completion_data"]').uncheck()

	
				})	
	
			})

		})

		
	    it('Should have the Filtering ability to display all rows', () => {
	            
			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('a[onclick="$(\'.rowl\').show();"]').click()

			cy.get('tr[class="rowl unlocked unesigned"]').should('include.text', '1').and('include.text', 'Demographics')			

			cy.get('tr[class="rowl unlocked aesigned"]').should('include.text', '1').and('include.text', 'Randomization Form')
			
			cy.get('tr[class="rowl unlocked aesigned"]').should('include.text', '1').and('include.text', 'Baseline Data')


			cy.get('tr[class="rowl locked unesigned"]').should('include.text', '2').and('include.text', 'Demographics')			

			cy.get('tr[class="rowl unlocked aesigned"]').should('include.text', '2').and('include.text', 'Randomization Form')
			
			cy.get('tr[class="rowl unlocked aesigned"]').should('include.text', '2').and('include.text', 'Baseline Data')


			cy.get('tr[class="rowl locked esigned"]').should('include.text', '3').and('include.text', 'Demographics')			

			cy.get('tr[class="rowl unlocked aesigned"]').should('include.text', '3').and('include.text', 'Randomization Form')
			
			cy.get('tr[class="rowl unlocked aesigned"]').should('include.text', '3').and('include.text', 'Baseline Data')


			cy.get('tr[class="rowl unlocked unesigned"]').should('include.text', '4').and('include.text', 'Demographics')			

			cy.get('tr[class="rowl locked aesigned"]').should('include.text', '4').and('include.text', 'Randomization Form')
			
			cy.get('tr[class="rowl unlocked aesigned"]').should('include.text', '4').and('include.text', 'Baseline Data')

	    })

	    it('Should have the Filtering ability to show timestamp / user', () => {

			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('a[onclick="$(\'.lock div\').show();$(\'.esign div\').show();$(\'.lock img\').hide();$(\'.esign img\').hide();"]').click()

			cy.get('tr[class="rowl locked unesigned"]').should('include.text', '2').and('include.text', 'Demographics').within(() => {

				cy.get('td[class="data lock"]').contains(/\d{2}\/\d{2}\/\d{4} \d{1,2}:\d{2}(am|pm)/).and('include.text', 'site_admin (Joe User)')	

				cy.get('td[class="data esign"]').should(($esign) => {
					expect($esign.text()).equal('');
				  });

			})

			cy.get('tr[class="rowl locked esigned"]').should('include.text', '3').and('include.text', 'Demographics').within(() => {

				cy.get('td[class="data lock"]').contains(/\d{2}\/\d{2}\/\d{4} \d{1,2}:\d{2}(am|pm)/).and('include.text', 'site_admin (Joe User)')

				cy.get('td[class="data esign"]').contains(/\d{2}\/\d{2}\/\d{4} \d{1,2}:\d{2}(am|pm)/).and('include.text', 'site_admin (Joe User)')

			})
			
			cy.get('tr[class="rowl locked aesigned"]').should('include.text', '4').and('include.text', 'Randomization Form').within(() => {

				cy.get('td[class="data lock"]').contains(/\d{2}\/\d{2}\/\d{4} \d{1,2}:\d{2}(am|pm)/).and('include.text', 'site_admin (Joe User)')

				cy.get('td[class="data esign"]').should(($esign) => {
					expect($esign.text()).equal('N/A');
				  });

			})
			

	    })

	    it('Should have the Filtering ability to hide timestamp / user', () => {
	            
			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('a[onclick="$(\'.lock div\').hide();$(\'.esign div\').hide();$(\'.lock img\').show();$(\'.esign img\').show();"]').click()

			cy.get('tr[class="rowl locked unesigned"]').should('include.text', '2').and('include.text', 'Demographics').within(() => {

				cy.get('td[class="data lock"]').should('have.descendants', 'img')

				cy.get('td[class="data esign"]').should(($esign) => {
					expect($esign.text()).equal('');
				  });

			})

			cy.get('tr[class="rowl locked esigned"]').should('include.text', '3').and('include.text', 'Demographics').within(() => {

				cy.get('td[class="data lock"]').should('have.descendants', 'img')

				cy.get('td[class="data esign"]').should('have.descendants', 'img')

			})
			
			cy.get('tr[class="rowl locked aesigned"]').should('include.text', '4').and('include.text', 'Randomization Form').within(() => {

				cy.get('td[class="data lock"]').should('have.descendants', 'img')

				cy.get('td[class="data esign"]').should(($esign) => {
					expect($esign.text()).equal('N/A');
				  });

			})

	    })

	    it('Should have the Filtering ability to show Locked records', () => {
	            
			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('a[onclick="$(\'.rowl\').show();$(\'.unlocked\').hide();"]').click()

			cy.get('tr[class="rowl locked unesigned"]').should('include.text', '2').and('include.text', 'Demographics').within(() => {

				cy.get('td[class="data lock"]').should('have.descendants', 'img')

				cy.get('td[class="data esign"]').should(($esign) => {
					expect($esign.text()).equal('');
				  });

			})

			cy.get('tr[class="rowl locked esigned"]').should('include.text', '3').and('include.text', 'Demographics').within(() => {

				cy.get('td[class="data lock"]').should('have.descendants', 'img')

				cy.get('td[class="data esign"]').should('have.descendants', 'img')

			})	
			
			cy.get('tr[class="rowl locked aesigned"]').should('include.text', '4').and('include.text', 'Randomization Form').within(() => {

				cy.get('td[class="data lock"]').should('have.descendants', 'img')

				cy.get('td[class="data esign"]').should(($esign) => {
					expect($esign.text()).equal('N/A');
				  });

			})

			cy.get('tr.unlocked').should('have.attr', 'style', 'display: none;')

	    })

	    it('Should have the Filtering ability to hide Locked records', () => {
	      
			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('a[onclick="$(\'.rowl\').show();$(\'.locked\').hide();"]').click()

			cy.get('tr.locked').should('have.attr', 'style', 'display: none;')

	    })

	    it('Should have the Filtering ability to show E-signed records', () => {
	            
			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('a[onclick="$(\'.rowl\').show();$(\'.unesigned\').hide();$(\'.aesigned\').hide();"]').click()

			cy.get('tr[class="rowl locked esigned"]').should('include.text', '3').and('include.text', 'Demographics').within(() => {

				cy.get('td[class="data lock"]').should('have.descendants', 'img')

				cy.get('td[class="data esign"]').should('have.descendants', 'img')

			})

			cy.get('tr.unesigned').should('have.attr', 'style', 'display: none;')

			cy.get('tr.aesigned').should('have.attr', 'style', 'display: none;')

	    })

	    it('Should have the Filtering ability to hide E-signed records', () => {
	            
			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('a[onclick="$(\'.rowl\').show();$(\'.unesigned\').hide();$(\'.aesigned\').hide();"]').click()

			cy.get('tr[class="rowl unlocked unesigned"]').should('include.text', '1').and('include.text', 'Demographics').within(() => {

				cy.get('td[class="data lock"]').should(($lock) => {
					expect($lock.text()).equal('');
				  });

				cy.get('td[class="data esign"]').should(($esign) => {
					expect($esign.text()).equal('');
				  });

			})

			cy.get('tr[class="rowl locked unesigned"]').should('include.text', '2').and('include.text', 'Demographics').within(() => {

				cy.get('td[class="data lock"]').should('have.descendants', 'img')

				cy.get('td[class="data esign"]').should(($esign) => {
					expect($esign.text()).equal('');
				  });

			})

			cy.get('tr[class="rowl unlocked unesigned"]').should('include.text', '4').and('include.text', 'Demographics').within(() => {

				cy.get('td[class="data lock"]').should(($lock) => {
					expect($lock.text()).equal('');
				  });

				cy.get('td[class="data esign"]').should(($esign) => {
					expect($esign.text()).equal('');
				  });

			})

			cy.get('tr.unesigned').should('have.attr', 'style', 'display: none;')
			cy.get('tr.aesigned').should('have.attr', 'style', 'display: none;')

	    })

	    it('Should have the Filtering ability to show both Locked and E-signed records', () => {
	            
			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('a[onclick="$(\'.rowl\').hide();$(\'.locked\').show();$(\'.unesigned\').hide();$(\'.aesigned\').hide();"]').click()

			cy.get('tr[class="rowl locked esigned"]').should('include.text', '3').and('include.text', 'Demographics').within(() => {

				cy.get('td[class="data lock"]').should('have.descendants', 'img')

				cy.get('td[class="data esign"]').should('have.descendants', 'img')

			})	

			cy.get('tr.unlocked').should('have.attr', 'style', 'display: none;')
			cy.get('tr.unesigned').should('have.attr', 'style', 'display: none;')			

	    })

	    it('Should have the Filtering ability to show neither Locked nor E-signed records', () => {
	            
			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('a[onclick="$(\'.rowl\').show();$(\'.locked\').hide();$(\'.esigned\').hide();$(\'.aesigned\').hide();"]').click()

			cy.get('tr[class="rowl unlocked unesigned"]').should('include.text', '1').and('include.text', 'Demographics').within(() => {

				cy.get('td[class="data lock"]').should(($lock) => {
					expect($lock.text()).equal('');
				  });

				cy.get('td[class="data esign"]').should(($esign) => {
					expect($esign.text()).equal('');
				  });

			})	

			cy.get('tr[class="rowl unlocked unesigned"]').should('include.text', '4').and('include.text', 'Demographics').within(() => {

				cy.get('td[class="data lock"]').should(($lock) => {
					expect($lock.text()).equal('');
				  });

				cy.get('td[class="data esign"]').should(($esign) => {
					expect($esign.text()).equal('');
				  });

			})	

			cy.get('tr.locked').should('have.attr', 'style', 'display: none;')
			cy.get('tr.esigned').should('have.attr', 'style', 'display: none;')	
			cy.get('tr.aesigned').should('have.attr', 'style', 'display: none;')	

	    })

	    it('Should have the Filtering ability to show Locked but not E-signed records', () => {
	            
			cy.visit_version({page: '/Locking/esign_locking_management.php', params: 'pid=7'})

			cy.get('a[onclick="$(\'.rowl\').show();$(\'.unlocked\').hide();$(\'.esigned\').hide();$(\'.aesigned\').hide();"]').click()

			cy.get('tr[class="rowl locked unesigned"]').should('include.text', '2').and('include.text', 'Demographics').within(() => {

				cy.get('td[class="data lock"]').should('have.descendants', 'img')

				cy.get('td[class="data esign"]').should(($esign) => {
					expect($esign.text()).equal('');
				  });

			})

			cy.get('tr.unesigned').should('have.attr', 'style', 'display: none;')	
			cy.get('tr.aesigned').should('have.attr', 'style', 'display: none;')	

	    })
    })

    describe('Editability', () => {

	    it('Should have the ability to support Edits in Development for standard project users', () => {

			cy.mysql_db('projects/pristine')
			cy.set_user_type('admin')

			cy.visit_version({page: 'ProjectSetup/other_functionality.php', params: 'pid=7'})

			cy.get('button').contains("Move back to").click()

			cy.clearCookies();

			cy.set_user_type('standard')

			cy.visit_version({page:'index.php'})
			
			cy.login({'username':'xxxxx', 'password':'xxxxx'})

			cy.visit_version({page: 'Design/online_designer.php', params: 'pid=7'})
			
			cy.get('span[id="formlabel-demographics"]').click()	

			cy.get('table[id="design-study_id"').within(() => {

				cy.get('img').click()

			})

			cy.get('div[role="dialog"][aria-describedby="div_add_field"]', { timeout: 10000 }).within(() => {
				
				cy.get('input[id="field_name"]').type("_test");

				cy.get('button').contains("Save").click();

			})

			cy.get('table[id="design-study_id_test"', { timeout: 10000 }).contains("study_id_test")

	    })

	    it('Should NOT have the ability to support Edits in Production for standard project users', () => {

			cy.mysql_db('projects/pristine')
			cy.clearCookies();
			cy.set_user_type('standard')

			cy.visit_version({page:'index.php'})
			
			cy.login({'username':'xxxxx', 'password':'xxxxx'})

			cy.visit_version({page: 'Design/online_designer.php', params: 'pid=7'})
			cy.get('input[type="button"][value="Enter Draft Mode"]').click()
			
			cy.get('span[id="formlabel-demographics"]').click()
			
			cy.get('table[id="design-study_id"').within(() => {

				cy.get('img').click()

			})

			cy.get('div[role="dialog"][aria-describedby="div_add_field"]', { timeout: 10000 }).within(() => {

				cy.get('input[id="field_label_rich_text_checkbox"]').uncheck();
				cy.get('input[id="field_name"]').click();

			})

			cy.get('div[role="dialog"][aria-describedby="varnameprod-nochange"]', { timeout: 10000 }).within(() => {

				cy.get('div[id="varnameprod-nochange"]').contains("The variable name cannot be changed because this variable name is already in use while the project is in Production status. Renaming the variable would cause permanent data loss.")

			})

	    })

	    it('Should have the ability to support Edits in Development for administrators', () => {
			
			cy.mysql_db('projects/pristine')
			cy.set_user_type('admin')

			cy.visit_version({page: 'ProjectSetup/other_functionality.php', params: 'pid=7'})

			cy.get('button').contains("Move back to").click()

			cy.visit_version({page: 'Design/online_designer.php', params: 'pid=7'})
			
			cy.get('span[id="formlabel-demographics"]').click()	

			cy.get('table[id="design-study_id"').within(() => {

				cy.get('img').click()

			})

			cy.get('div[role="dialog"][aria-describedby="div_add_field"]', { timeout: 10000 }).within(() => {
				
				cy.get('input[id="field_name"]').type("_test");

				cy.get('button').contains("Save").click();

			})

			cy.get('table[id="design-study_id_test"', { timeout: 10000 }).contains("study_id_test")

	    })

	    it('Should have the ability to support Edits in Production for administrators', () => {
			
			cy.mysql_db('projects/pristine')
			cy.set_user_type('admin')

			cy.visit_version({page: 'Design/online_designer.php', params: 'pid=7'})
			cy.get('input[type="button"][value="Enter Draft Mode"]').click()
			
			cy.get('span[id="formlabel-demographics"]').click()
			
			cy.get('table[id="design-study_id"').within(() => {

				cy.get('img').click()

			})

			cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/Design/online_designer_render_fields.php?*').as('online_designer')

			cy.get('div[role="dialog"][aria-describedby="div_add_field"]', { timeout: 10000 }).within(() => {

				cy.get('input[id="field_label_rich_text_checkbox"]').uncheck()
				cy.get('textarea[id="field_label"]').click().type(" Test")

				cy.get('button').contains("Save").click();

				cy.wait('@online_designer').then(({ request, response }) => {
					expect(response.statusCode).to.eq(200)
				})

			})
			
	    })
    })    

})