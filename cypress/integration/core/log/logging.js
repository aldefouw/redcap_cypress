const ADMIN 	= 'test_admin'
const STANDARD 	= 'test_user'
const STANDARD2 = 'test_user2'
const PID = 23

describe('Logging', () => {

    before(() => {
        // Prepare project
        cy.set_user_type('admin')
        cy.mysql_db('projects/pristine')
        cy.create_cdisc_project('Logging Test', '0', 'cdisc_files/core/logging.xml', PID)
        cy.add_users_to_project([STANDARD, STANDARD2], PID)
        cy.visit_version({page: 'UserRights/index.php', params: `pid=${PID}`})

        // Add User 1
        cy.get(`a.userLinkInTable[userid="${STANDARD}"]`).should('be.visible').click()
        cy.get('div#tooltipBtnSetCustom').should('be.visible').find('button').click()
        cy.get('input[name="design"]').should('be.visible').check()	                // Enable Design Rights
        cy.get('input[name="user_rights"]').check()					                // Enable User Rights
        cy.get('input[name="data_export_tool"]').check('1')                         // Enable Full Data Export
        cy.get('input[name="data_logging"]').check()					            // Enable Logging
        cy.get('input[name="record_delete"]').check({force: true})					// Enable Delete Records
        cy.get('input[name="lock_record_customize"]').should('not.be.checked')		// Record Locking Customization *Disabled*
        cy.get('input[name="lock_record"][value="2"]').should('not.be.checked') 	// Lock/Unlock Records with E-signature authority *Disabled*
        cy.get('input[name="record_create"]').should('be.checked')					// Create Records *Enabled*
        cy.get('.ui-button').contains(/add user|save changes/i).click()
        
        // Add User 2
        cy.get('div.userSaveMsg').should('not.be.visible')
        cy.get(`a.userLinkInTable[userid="${STANDARD2}"]`).should('be.visible').click()
        cy.get('div#tooltipBtnSetCustom').should('be.visible').find('button').click()
        cy.get('input[name="design"]').should('be.visible').check()	                // Enable Design Rights
        cy.get('.ui-button').contains(/add user|save changes/i).click()

        // Enable E-Signature
        cy.visit_version({page: '/Locking/locking_customization.php', params: `pid=${PID}`})
        cy.get('#savedEsign-text_validation').closest('td').find('input').check()

        // Move to production
        cy.visit_version({page: 'ProjectSetup/index.php', params: `pid=${PID}`})
        cy.get('button').contains('Move project to production').click()
        cy.get('input#keep_data').click()
        cy.get('button').contains('YES, Move to Production Status').click()
        cy.get('div#actionMsg').should('be.visible')

        ///////////////////////////////////////////////////////////////
        // Take all project actions that will be checked in the logs //
        ///////////////////////////////////////////////////////////////

        // Steps come from manual testing protocol script #23 (Logging)
        cy.set_user_type('standard')

        // Step 3 - Add record
        cy.visit_version({page: 'DataEntry/record_home.php', params: `pid=${PID}`})
        cy.get('button').contains('Add new record').should('be.visible').click()
        cy.get('input[name="ptname"]').type('Test')
        cy.get('input[name="email"').type('test@test.com')
        cy.get('button#submit-btn-dropdown').first().click()
        .closest('div').find('a#submit-btn-savecontinue').should('be.visible').click()

        cy.get('input[name="ptname"]').clear().type('Testing')
        cy.get('button#submit-btn-saverecord').first().click()

        // Step 4 - Add new record
        cy.visit_version({page: 'DataEntry/record_home.php', params: `pid=${PID}`})
        cy.get('button').contains('Add new record').should('be.visible').click()
        cy.get('input[name="ptname"]').type('Test2')
        cy.get('input[name="email"').type('test2@test.com')
        cy.get('button#submit-btn-saverecord').first().click()

        // Step 5 - Add new record
        cy.visit_version({page: 'DataEntry/record_home.php', params: `pid=${PID}`})
        cy.get('button').contains('Add new record').should('be.visible').click()
        cy.get('input[name="ptname"]').type('Delete')
        cy.get('input[name="email"').type('delete@test.com')
        cy.get('button#submit-btn-saverecord').first().click()

        // Step 6 - Delete 3rd record
        cy.get('button#recordActionDropdownTrigger').click()
        cy.get('a').contains('Delete record (all forms)').should('be.visible').click()
        cy.get('button').contains('DELETE RECORD').should('be.visible').click()
        // This should be avoided if possible
        cy.focused().should('have.text', 'Close').click()

        // Step 7 - Create user role
        cy.visit_version({page: "UserRights/index.php", params: `pid=${PID}`})
        cy.get('input#new_rolename').should('be.visible').type('Data')
        cy.get('button#createRoleBtn').click()
        cy.get('div#editUserPopup').should('be.visible').parent().find('button').contains("Create role").should('be.visible').click()
        cy.get('div.userSaveMsg').should('not.be.visible')

        // Step 8 - Edit new role
        cy.get('a[title="Edit role privileges"]').contains('Data').should('be.visible').click()
        cy.get('input[name="design"]').should('be.visible').check()
        cy.get('div#editUserPopup').parent().find('button').contains("Save Changes").should('be.visible').click()
        cy.get('div.userSaveMsg').should('not.be.visible')
        cy.get('div#working').should('not.be.visible')

        // Step 9 - Delete new role
        cy.get('a[title="Edit role privileges"]').contains('Data').should('be.visible').click().then(() => {
            cy.get('button').should(($button) => {
                expect($button).to.contain('Delete role')
            })
            cy.get('button').contains("Delete role").click({ force: true })
            cy.get('div[role="dialog"][aria-describedby!="editUserPopup"]').find('button').contains('Delete role').should('be.visible').click()
            cy.get('div.userSaveMsg').should('not.be.visible')
            cy.get('div#working').should('not.be.visible')
        })
    
        // Steps 10, 11 - Add and edit new user (completed in project setup)

        // Step 12 - Remove user (user913_3)
        cy.get(`a.userLinkInTable[userid="${STANDARD2}"]`).should('be.visible').click()
        cy.get('div#tooltipBtnSetCustom').should('be.visible').find('button').click()
        cy.get('div#editUserPopup').should('be.visible').parent().find('button').contains("Remove user").should('be.visible').click()
        cy.get('span').contains("Remove user?").should('be.visible').closest('div[role="dialog"]').find('button').contains("Remove user").click()
        cy.get('div.userSaveMsg').should('not.be.visible')

        // Add User 2 (user913_4)
        cy.add_users_to_project([STANDARD2], PID)
        cy.visit_version({page: 'UserRights/index.php', params: `pid=${PID}`})
        cy.get(`a.userLinkInTable[userid="${STANDARD2}"]`).should('be.visible').click()
        cy.get('div#tooltipBtnSetCustom').should('be.visible').find('button').click()
        cy.get('input[name="design"]').should('be.visible').check()	                // Enable Design Rights
        cy.get('input[name="user_rights"]').check()					                // Enable User Rights
        cy.get('input[name="data_export_tool"]').check('1')                     	// Enable Full Data Export
        cy.get('input[name="data_export_tool"][value="1"]').should('be.checked')
        cy.get('input[name="data_logging"]').check()				  				// Enable Logging
        cy.get('input[name="record_delete"]').check()								// Enable Delete Records
        cy.get('input[name="lock_record_customize"]').check()
        cy.get('input[name="lock_record"][value="2"]').click()
        cy.get('.ui-dialog-buttonset').contains('Close').click()
        cy.get('input[name="record_create"]').should('be.checked')					// Create Records *Enabled*
        cy.get('.ui-button').contains(/add user|save changes/i).click()
    })

    //Step 14 - Raw Export Data
    it('Should have the ability to export the logs to a CSV file', () => {
        cy.set_user_type('standard2')

        cy.visit_version({page: 'DataExport/index.php', params: `pid=${PID}`})
        cy.get('tr#reprow_ALL').find('button.data_export_btn').should('be.visible').contains('Export Data').click()
        cy.get('input[value="csvraw"]').click()
        cy.export_csv_report().should((csv) => {
            expect([...new Set(csv.map((row) => row[0]).slice(1))]).to.have.lengthOf(2)                     // 2 records
        })
    })

    // Step 15 - Enable record locking/unlocking with e-signature authority
    it('Should have the ability enable record locking/unlocking with e-signature authority', () => {
        cy.visit_version({page: "UserRights/index.php", params: `pid=${PID}`})
        cy.get(`a.userLinkInTable[userid="${STANDARD}"]`).click()
        cy.get('div#tooltipBtnSetCustom').should('be.visible').find('button').click()
        cy.get('input[name="lock_record_customize"]').check()
        cy.get('input[name="lock_record"][value="2"]').click()
        cy.get('.ui-dialog-buttonset').contains('Close').click()
        cy.get('.ui-button').contains(/add user|save changes/i).click()

    })

    // Step 16,17,18 - Add/Edit record
    it('Should have the ability to Add/Edit record', () => {
        cy.visit_version({page: "DataEntry/record_home.php", params: `pid=${PID}`})
        
        //Step 16
        cy.get('select[id="record"]').select('1').should('have.value', '1')
        cy.get('a[href*="/redcap_v' + Cypress.env('redcap_version') + '/DataEntry/index.php?pid=23&id=1&event_id=41&page=text_validation"]').click()
        cy.get('input[id="__LOCKRECORD__"]').check()

        cy.intercept('redcap_v' + Cypress.env('redcap_version') + '/Locking/single_form_action.php?*').as('single_form_action')

        cy.get('button#submit-btn-dropdown').first().click()
        .closest('div').find('a#submit-btn-savecontinue').should('be.visible').click()

        cy.wait('@single_form_action')

        cy.get('input[id="__LOCKRECORD__"]').should('be.checked')

        //Step 17
        cy.get('input[id="__ESIGNATURE__"]').check()
        cy.get('button#submit-btn-savecontinue').first().click()

        cy.get('input[id="esign_username"]').type('test_user2')
        cy.get('input[id="esign_password"').type('Testing123')
        cy.get('.ui-dialog-buttonset').contains('Save').click()

        cy.wait('@single_form_action')

        cy.get('input[id="__ESIGNATURE__"]').should('be.checked')

        //Step 18
        cy.get('input[value="Unlock form"]').click() 
        cy.get('.ui-dialog-buttonset').contains('Unlock').click()
        cy.get('.ui-dialog-buttonset').contains('Close').click()
    })

    // Step 19 and 20 - enter draft mode and create new instrument
    it('Should have the ability to enter draft mode and create new instrument', () => {
        cy.visit_version({page: "Design/online_designer.php", params: `pid=${PID}`})

        //Enter Draft Mode in the project
        cy.get('input[value="Enter Draft Mode"]').click()

        //Check to see that REDCap indicates we're in DRAFT mode
        cy.get('div#actionMsg').should(($alert) => {
            expect($alert).to.contain('The project is now in Draft Mode.')
        })

        cy.get('div').
        contains('a new instrument from scratch').
        parent().
        within(($div) => {
            cy.get('button').contains('Create').click()
        })

        //Create new instrument
        cy.get('button').contains('Add instrument here').click()

        cy.get('td').contains('New instrument name').parent().within(($td) => {
            cy.get('input[type=text]', {force: true}).type('Form 2')
            cy.get('input[value=Create]', {force: true}).click()
        })

        cy.get('span').should(($span) => {
            expect($span).to.contain('Form 2')
        })
        
        cy.get('input[value="Submit Changes for Review"]').should(($i) => {
            $i.first().click()
        })

        //Submit for Appproval
        cy.get('button').contains('Submit').click()
        cy.get('.ui-dialog-buttonset').contains('Close').click()
    })
    
    describe('Filtering Options', () => {

        describe('By Event Type', () => {

            before(() => {
                cy.visit_version({page: "Logging/index.php", params: `pid=${PID}`})
            })

            it('Should allow filtering on ALL Event Types (excluding Page Views)', () => {
                cy.contains('Time / Date')
                .parent('tr')
                .within(() => {
                    cy.get('td').eq(1).contains('Username')
                    cy.get('td').eq(2).contains('Action')
                    cy.get('td').eq(3).contains('List of Data Changes')
                })
            })

            it('Should allow filtering by Data Export type', () => {
                cy.get('select[id="logtype"]').select('Data export').should('have.value', 'export')
                cy.get('table').contains('td', 'Download exported data file (CSV raw)');
                cy.get('table').contains('td', 'report_id: ALL, export_format: CSV, rawOrLabel: raw, fields: "record_id, ptname, email, text_validation_complete"');
            })

            it('Should allow filtering by Manage/Design type', () => {
                cy.get('select[id="logtype"]').select('Manage/Design').should('have.value', 'manage')
                cy.get('table').contains('td', 'Approve production project modifications (automatic)');
                cy.get('table').contains('td', 'Create data collection instrument');
                //cy.get('table').contains('td', 'Create project field');
                cy.get('table').contains('td', 'Enter draft mode');
            })

            it('Should allow filtering by User or Role (created-updated-deleted)', () => {
                cy.get('select[id="logtype"]').select('User or role created-updated-deleted').should('have.value', 'user')
                cy.get('table').contains('td', 'Updated User');
                cy.get('table').contains('td', 'Created User');
                cy.get('table').contains('td', 'Deleted User');
                cy.get('table').contains('td', 'user = \'test_user\'');
                cy.get('table').contains('td', 'user = \'test_user2\'');
                cy.get('table').contains('td', 'role = \'Data\'');
            })

            it('Should allow filtering by Record (created-updated-deleted)', () => {
                cy.get('select[id="logtype"]').select('Record created-updated-deleted').should('have.value', 'record')
                cy.get('table').contains('td', 'Updated Record');
                cy.get('table').contains('td', 'Created Record');
                cy.get('table').contains('td', 'Deleted Record');
                cy.get('table').contains('td', 'record_id = \'3\'');
                cy.get('table').contains('td', 'ptname = \'Delete\', email = \'delete@test.com\', text_validation_complete = \'0\', record_id = \'3\'');
                cy.get('table').contains('td', 'ptname = \'Test2\', email = \'test2@test.com\', text_validation_complete = \'0\', record_id = \'2\'');
                cy.get('table').contains('td', 'ptname = \'Testing\'');
                cy.get('table').contains('td', 'ptname = \'Test\', email = \'test@test.com\', text_validation_complete = \'0\', record_id = \'1\'');
            })

            it('Should allow filtering by Record (created only)', () => {
                cy.get('select[id="logtype"]').select('Record created (only)').should('have.value', 'record_add')
                cy.get('table').contains('td', 'Created Record');
                cy.get('table').contains('td', 'ptname = \'Test\', email = \'test@test.com\', text_validation_complete = \'0\', record_id = \'1\'');
                cy.get('table').contains('td', 'ptname = \'Test2\', email = \'test2@test.com\', text_validation_complete = \'0\', record_id = \'2\'');
                cy.get('table').contains('td', 'ptname = \'Delete\', email = \'delete@test.com\', text_validation_complete = \'0\', record_id = \'3\'');
            })

            it('Should allow filtering by Record (updated only)', () => {
                cy.get('select[id="logtype"]').select('Record updated (only)').should('have.value', 'record_edit')
                cy.get('table').contains('td', 'Updated Record');
                cy.get('table').contains('td', 'ptname = \'Testing\'');
            })

            it('Should allow filtering by Record (deleted only)', () => {
                cy.get('select[id="logtype"]').select('Record deleted (only)').should('have.value', 'record_delete')
                cy.get('table').contains('td', 'Deleted Record');
                cy.get('table').contains('td', 'record_id = \'3\'');
            })

            it('Should allow filtering by Record locking and e-signatures', () => {
                cy.get('select[id="logtype"]').select('Record locking & e-signatures').should('have.value', 'lock_record')
                cy.get('table').contains('td', 'Lock/Unlock Record');
                cy.get('table').contains('td', 'E-signature');
                cy.get('table').contains('td', 'Action: Lock record');
                cy.get('table').contains('td', 'Action: Unlock record');
                cy.get('table').contains('td', 'Action: Save e-signature');
                cy.get('table').contains('td', 'Action: Negate e-signature');
            })

            it('Should allow filtering by Page Views', () => {
                cy.get('select[id="logtype"]').select('Page Views').should('have.value', 'page_view')
                cy.get('table').contains('td', 'Page View');
                cy.get('table').contains('td', '/redcap_v' + Cypress.env('redcap_version') + '/Logging/index.php?pid=23');
            })
            
        })

        describe('By Specific Username', () => {

            it('Should allow filtering by Username (all users for a given study selectable)', () => {
                cy.visit_version({page: "Logging/index.php", params: `pid=${PID}`})
                cy.get('select[id="usr"]').select('test_admin').should('have.value', 'test_admin')
                cy.get('select[id="usr"]').select('test_user').should('have.value', 'test_user')
                cy.get('select[id="usr"]').select('test_user2').should('have.value', 'test_user2')
            })	

        })

        describe('By Specific Record', () => {

            it('Should allow filtering by Record (all records for a given study selectable)', () => {
                cy.visit_version({page: "Logging/index.php", params: `pid=${PID}`})
                cy.get('select[id="record"]').select('2').should('have.value', '2')
                cy.get('table').contains('td', 'Created Record');
                cy.get('table').contains('td', 'ptname = \'Test2\', email = \'test2@test.com\', text_validation_complete = \'0\', record_id = \'2\'');
            })				

        })

        describe('Export All Logging', () => {

            it('Should allow all logging export)', () => {
                var today = new Date();
                var day = ("0"+today.getDate()).slice(-2);
                var month = ("0"+(today.getMonth() + 1)).slice(-2);
                var year = today.getFullYear();

                cy.visit_version({page: "Logging/index.php", params: `pid=${PID}`})
                cy.export_logging_csv_report().should((csv) => {
                    expect(csv[0].length).to.equal(4)
                    
                    //Headers
                    expect(csv[0][0]).to.contain('Time / Date')
                    expect(csv[0][1]).to.contain('Username')
                    expect(csv[0][2]).to.contain('Action')
                    expect(csv[0][3]).to.contain('List of Data Changes OR Fields Exported')

                    //Check if Time/Date columns contains date/time when the action occured
                    expect(csv[1][0]).to.contain(`${year}-${month}-${day}`)
                    
                    //Users
                    expect(csv[1][1]).to.contain('test_user2')
                    expect(csv[14][1]).to.contain('test_user')
                    expect(csv[25][1]).to.contain('test_admin')

                    //Actions
                    expect(csv[1][2]).to.contain('Manage/Design')
                    expect(csv[4][2]).to.contain('E-signature')
                    expect(csv[5][2]).to.contain('Lock/Unlock Record')
                    expect(csv[6][2]).to.contain('Updated Record 1')
                    expect(csv[11][2]).to.contain('Data Export')
                    expect(csv[13][2]).to.contain('Updated User test_user2')
                    expect(csv[14][2]).to.contain('Created User test_user2')
                    expect(csv[15][2]).to.contain('Deleted User test_user2')
                    expect(csv[16][2]).to.contain('Deleted Role ')
                    expect(csv[18][2]).to.contain('Created Role')
                    expect(csv[17][2]).to.contain('Edited Role')
                    expect(csv[19][2]).to.contain('Deleted Record')
                    expect(csv[20][2]).to.contain('Created Record')

                    //List of Data Changes OR Fields Exported
                    expect(csv[1][3]).to.contain('Approve production project modifications (automatic)')
                    expect(csv[4][3]).to.contain('e-signature Record: 1 Form: Text Validation')
                    expect(csv[9][3]).to.contain('Lock record Record: 1 Form: Text Validation')
                    expect(csv[11][3]).to.contain('Download exported data file (CSV raw)')
                    expect(csv[13][3]).to.contain('user = \'test_user2\'')
                    expect(csv[14][3]).to.contain('user = \'test_user2\'')
                    expect(csv[15][3]).to.contain('user = \'test_user2\'')
                    expect(csv[16][3]).to.contain('role = \'Data\'')
                    expect(csv[17][3]).to.contain('role = \'Data\'')
                    expect(csv[18][3]).to.contain('role = \'Data\'')
                    expect(csv[19][3]).to.contain('record_id = \'3\'')
                    expect(csv[20][3]).to.contain('ptname = \'Delete\', email = \'delete@test.com\', text_validation_complete = \'0\', record_id = \'3\'')
                })	
            })				
        })

        describe('Delete a record’s logging activity when deleting the records', () => {

            //step 32
            it('Should allow deleting a record’s logging activity when deleting the records)', () => {
                cy.set_user_type('admin')

                cy.visit_version({page: 'ControlCenter/edit_project.php', params: `pid=${PID}`})
                cy.get('select').select('Logging Test').should('have.value', '23')
                cy.get('select[name="allow_delete_record_from_log"]').select('Yes, delete the record\'s logged events when deleting the record').should('have.value', '1')
                cy.get('input[type=submit]').click()
            })		
            
            //step 34
            it('Should allow deleting a record', () => {
                cy.set_user_type('standard')

                cy.maintain_login()

                cy.visit_version({page: "DataEntry/record_home.php", params: `pid=${PID}`})
                cy.get('select[id="record"]').select('2').should('have.value', '2')
                cy.get('button#recordActionDropdownTrigger').click()
                cy.get('a').contains('Delete record (all forms)').should('be.visible').click()
                cy.get('input[id="allow_delete_record_from_log"]').check()
                cy.get('input[type=text]', {force: true}).type('DELETE')
                cy.get('.ui-dialog-buttonset').contains('Confirm').click()
                cy.get('button').contains('DELETE RECORD').should('be.visible').click()
                cy.focused().should('have.text', 'Close').click()
            })

            //step 35
            it('Should show recently deleted record in logging)', () => {
                cy.visit_version({page: "Logging/index.php", params: `pid=${PID}`})
                cy.get('select[id="logtype"]').select('Record created-updated-deleted').should('have.value', 'record')
                cy.get('table').contains('td', '[*DATA REMOVED*]');
                cy.get('table').contains('td', '[All data values were removed from this record\'s logging activity.]');
            })	

        })
    
        //Step 37
        describe('Enter draft mode, enable longitudinal data collection, designate instrument', () => {
            before(() => {
                cy.set_user_type('admin')
            })
            
            it('Should have the ability to enter draft mode)', () => {
                cy.visit_version({page: "Design/online_designer.php", params: `pid=${PID}`})

                //Enter Draft Mode in the project
                cy.get('input[value="Enter Draft Mode"]').click()
        
                //Check to see that REDCap indicates we're in DRAFT mode
                cy.get('div#actionMsg').should(($alert) => {
                    expect($alert).to.contain('The project is now in Draft Mode.')
                })
            })	

            it('Should have the ability to enable Longitudinal data collection and designate instrument)', () => {
                cy.visit_version({page: "ProjectSetup/index.php", params: `pid=${PID}`})

                //enable longitudinal data collection
                cy.get('button[id="setupLongiBtn"]').click()

                //Submit changes for review
                cy.visit_version({page: "Design/online_designer.php", params: `pid=${PID}`})
                cy.get('input[value="Submit Changes for Review"]').should(($i) => {
                    $i.first().click()
                })
        
                cy.get('button').contains('Submit').click()
                cy.get('.ui-dialog-buttonset').contains('Close').click()

                //Create new arm
                cy.visit_version({page: "Design/define_events.php", params: `pid=${PID}`})

                cy.get('a[href*="/redcap_v' + Cypress.env('redcap_version') + '/Design/define_events.php?pid=23&arm=2"]').click()
                cy.get('input[id=arm_name]').type('Arm 2')
                cy.get('input[value=Save]').click()

                cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/Design/define_events_ajax.php?*').as('define_events')

                //Create event in arm 2
                cy.get('input[id=descrip]').type('Event 1')
                cy.get('input[value="Add new event"]').click()
                cy.wait('@define_events')

                //Designate instrument to event
                cy.visit_version({page: 'Design/designate_forms.php', params: `pid=${PID}`})
                cy.get('a[href*="/redcap_v' + Cypress.env('redcap_version') + '/Design/designate_forms.php?pid=23&arm=2"]').click()
                cy.get('button').contains('Begin Editing').click().then(() => {
                    cy.get('td').contains('Text Validation').parent().within(() => {
                        cy.get('input#text_validation--42').check()
                    })

                    cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/Design/designate_forms_ajax.php').as('designate_forms')

                    cy.get('button#save_btn').click().then(() => {

                        cy.wait('@designate_forms')
                        
                        cy.get('tr td').contains('Text Validation').parent().within(($p) => {
                            cy.wrap($p).find('img#img--text_validation--42')
                        })
                    })
                })
            })	
        })
        
        describe('Add new record to Arm 2', () => {

            before(() => {
                cy.set_user_type('standard')
            })

            //Step 39  
            it('Should have the ability to add a new record to a Arm)', () => {
                cy.visit_version({page: 'DataEntry/record_home.php', params: `pid=${PID}`})
                cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/DataEntry/record_home.php?*').as('record_home')
                cy.get('select[id="arm_name"]').select('Arm 2: Arm 2').should('have.value', '2')
                cy.wait('@record_home')
                cy.get('button').contains('Add new record for the arm selected above').should('be.visible').click()
                cy.get('input[name="ptname"]').type('Arm2')
                cy.get('button#submit-btn-saverecord').first().click()
            })	
            
            //check if arm 2 record 2 is visible
            it('Should show new record created in arm 2 in record status dashboard)', () => {
                cy.visit_version({page: 'DataEntry/record_status_dashboard.php', params: `pid=${PID}`})
                cy.get('table').contains('a', '1');
            })		

            //Step 40
            it('Should show arm 2 name in Action column of logging page)', () => {
                cy.visit_version({page: 'Logging/index.php', params: `pid=${PID}`})
                cy.get('table').contains('td', '(Event 1 - Arm 2: Arm 2)');
                cy.get('table').contains('td', 'ptname = \'Arm2\', text_validation_complete = \'0\', record_id = \'2\'');
            })		

            //Step 41
            it('Should have the ability to delete record from arm 2 )', () => {
                cy.visit_version({page: "DataEntry/record_home.php", params: `pid=${PID}`})
                cy.intercept('/redcap_v' + Cypress.env('redcap_version') + '/DataEntry/record_home.php?*').as('record_home')
                cy.get('select[id="arm_name"]').select('Arm 2: Arm 2').should('have.value', '2')
                cy.wait('@record_home')
                cy.get('select[id="record"]').select('2').should('have.value', '2')
                cy.get('button#recordActionDropdownTrigger').click()
                cy.get('a').contains('Delete record (all forms/events)').should('be.visible').click()
                cy.get('input[id="allow_delete_record_from_log"]').check()
                cy.get('input[type=text]', {force: true}).type('DELETE')
                cy.get('.ui-dialog-buttonset').contains('Confirm').click()
                cy.get('button').contains('DELETE RECORD').should('be.visible').click()
                cy.focused().should('have.text', 'Close').click()

            })	
            
            it('Should show recently deleted record in logging)', () => {
                cy.visit_version({page: "Logging/index.php", params: `pid=${PID}`})
                cy.get('select[id="logtype"]').select('Record created-updated-deleted').should('have.value', 'record')
                cy.get('table').contains('td', '[*DATA REMOVED*]');
                cy.get('table').contains('td', '[All data values were removed from this record\'s logging activity.]');
            })
        })
    })
})
