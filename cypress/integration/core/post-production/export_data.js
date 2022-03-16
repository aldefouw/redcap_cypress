const pid = 21
const admin = 'test_admin'
const standard = 'test_user'

// Step numbers taken from validation test script 21_ExportDataExtraction_v913.docx

describe('Export Data', () => {

    before(() => {
        // Prepare project
        cy.set_user_type('admin')
        cy.mysql_db('projects/pristine')
        cy.create_cdisc_project('Export Test', '0', 'cdisc_files/core/export_data.xml', pid)
        cy.add_users_to_project([standard], pid)
        cy.visit_version({page: 'UserRights/index.php', params: `pid=${pid}`}).then(() => {
            cy.get(`a.userLinkInTable[userid="${standard}"]`).should('be.visible').click().then(() =>{
                cy.get('div#tooltipBtnSetCustom').should('be.visible').find('button').click()
                cy.get('input[name="design"]').check()
                cy.get('input[name="user_rights"]').check()
                cy.get('input[name="data_export_tool"][value="1"]').check()
                cy.get('.ui-button').contains(/add user|save changes/i).click()
            })
        })

        // Mark records' forms as survey complete
        cy.visit_version({page: 'DataEntry/record_home.php', params: `pid=${pid}&arm=1&id=1`})
        cy.get('div#repeating_forms_table_parent').find('td.data').first().find('a').click()
        cy.get('#submit-btn-savecompresp').click({force: true})
        cy.visit_version({page: 'DataEntry/record_home.php', params: `pid=${pid}&arm=1&id=2`})
        cy.get('div#repeating_forms_table_parent').find('td.data').first().find('a').click()
        cy.get('#submit-btn-savecompresp').click({force: true})
    })
    
    describe('Basic Functionality', () => {

        before(() => {
            // Steps 1 (Step 2 not necessary)
            cy.set_user_type('standard')
        })

        it('Should have the ability to mark fields as identifiers', () => {
            // Step 3
            cy.visit_version({page: 'Design/online_designer.php', params: `pid=${pid}&page=export`})
            cy.get('table#design-lname').find('a').first().click()
            cy.get('input#field_phi1').click()
            cy.get('button').contains('Save').click()
            cy.get('table#design-fname').find('a').first().click()
            cy.get('input#field_phi1').click()
            cy.get('button').contains('Save').click()

            // Step 4
            cy.set_user_type('admin')
            cy.visit_version({page: 'ProjectSetup/index.php', params: `pid=${pid}`})
            cy.get('button').contains('Move project to production').click()
            cy.get('input#keep_data').click()
            cy.get('button').contains('YES, Move to Production Status').click()
            cy.get('div#actionMsg').should('be.visible')
            cy.set_user_type('standard')
        })

        it('Should have the ability to export all fields within a project', () => {


            // Step 6 - Label Data Export
            cy.visit_version({page: 'DataExport/index.php', params: `pid=${pid}`})
            cy.get('tr#reprow_ALL').find('button.data_export_btn').contains('Export Data').click()
            cy.get('input[value="csvlabels"]').click()
            cy.export_csv_report().should((csv) => {
                expect(csv[0].length).to.equal(13)                                                              // 13 columns
                expect(csv[0][0]).to.equal('Record ID')                                                         // Headers are field labels
                expect(csv[1][csv[0].indexOf('Event Name')]).to.equal('Event 1')                                // Data are labels
                expect([...new Set(csv.map((row) => row[0]).slice(1))].length).to.equal(8)                      // 8 records
                expect(csv.length - 1).to.equal(19)                                                             // 19 rows of data (subtract header)
                expect(csv.slice(1).reduce((acc, val) => {
                    return acc + (val[csv[0].indexOf('Repeat Instrument')] === "Survey" ? 1 : 0)
                }, 0)).to.equal(11)                                                                             // 11 rows show Survey instrument
                expect(csv.slice(1).reduce((acc, val) => {
                    return acc + (val[csv[0].indexOf('Survey Timestamp')] !== "" ? 1 : 0)
                }, 0)).to.equal(2)                                                                              // 2 rows show timestamps
            })

            // Step 7 - Raw Data Export
            cy.visit_version({page: 'DataExport/index.php', params: `pid=${pid}`})
            cy.get('tr#reprow_ALL').find('button.data_export_btn').contains('Export Data').click()
            cy.get('input[value="csvraw"]').click()
            cy.export_csv_report().should((csv) => {
                expect(csv[0].length).to.equal(13)                                                              // 13 columns
                expect(csv[0][0]).to.equal('record_id')                                                         // Headers are raw field names
                expect(csv[1][csv[0].indexOf('redcap_event_name')]).to.equal('event_1_arm_1')                   // Data are raw values
                expect([...new Set(csv.map((row) => row[0]).slice(1))].length).to.equal(8)                      // 8 records
                expect(csv.length - 1).to.equal(19)                                                             // 19 rows of data (subtract header)
                expect(csv.slice(1).reduce((acc, val) => {
                    return acc + (val[csv[0].indexOf('redcap_repeat_instrument')] === "survey" ? 1 : 0)
                }, 0)).to.equal(11)                                                                             // 11 rows show Survey instrument
                expect(csv.slice(1).reduce((acc, val) => {
                    return acc + (val[csv[0].indexOf('survey_timestamp')] !== "" ? 1 : 0)
                }, 0)).to.equal(2)                                                                              // 2 rows show timestamps

                expect(csv.filter((row) => (row[0] == "1" && row[csv[0].indexOf('dob')] !== ""))[0][csv[0].indexOf('dob')])
                    .to.equal('2019-06-17')                                                                     // Record 1 dob has value '6/17/19'

                expect(new Date(csv.filter((row) => {
                        return (row[0] == "1" && row[csv[0].indexOf('survey_timestamp')] !== "")
                    })[0][csv[0].indexOf('survey_timestamp')]).toLocaleDateString('en-US', { timeZone: 'America/New_York' }))
                    .to.equal(new Date().toLocaleDateString('en-US', { timeZone: 'America/New_York' }))         // Record 1 survey_timestamp is today
            })
        })

        it('Should allow the ability to export specific forms', () => {
            // Step 8
            cy.visit_version({page: 'DataExport/index.php', params: `pid=${pid}`})
            cy.get('tr#reprow_SELECTED').find('button').contains('Make custom selections').click()
            cy.get('#export_selected_instruments').select('survey')
            cy.get('#export_selected_events').select('Event 2')
            cy.get('tr#reprow_SELECTED').find('button.data_export_btn').contains('Export Data').click()
            cy.get('input[value="csvraw"]').click()
            cy.export_csv_report().should((csv) => {
                expect(csv[0].length).to.equal(8)                                                               // 8 columns
                expect(csv[0][0]).to.equal('record_id')                                                         // Headers are raw field names
                expect(csv[1][csv[0].indexOf('redcap_event_name')]).to.equal('event_2_arm_1')                   // Data are raw values
                expect([...new Set(csv.map((row) => row[0]).slice(1))].length).to.equal(8)                      // 8 records
                expect(csv.length - 1).to.equal(11)                                                             // 11 rows of data (subtract header)
                expect(csv.slice(1).reduce((acc, val) => {
                    return acc + (val[csv[0].indexOf('survey_timestamp')] !== "" ? 1 : 0)
                }, 0)).to.equal(2)                                                                              // 2 rows show timestamps
            })
        })
    })

    describe('Data Export Formats', () => {

        // Step 5
        before(() => {
            cy.visit_version({page: 'DataExport/index.php', params: `pid=${pid}`})
            cy.get('tr#reprow_ALL').find('button.data_export_btn').contains('Export Data').click()
        })

        it('Should have the ability to export to CSV format', () => {
            cy.verify_export_deidentification_options('input[name="export_format"][value="csvraw"]')
            cy.verify_export_deidentification_options('input[name="export_format"][value="csvlabels"]')
        })

        it('Should have the ability to export to SPSS format', () => {
            cy.verify_export_deidentification_options('input[name="export_format"][value="spss"]')
        })

        it('Should have the ability to export to SAS format', () => {
            cy.verify_export_deidentification_options('input[name="export_format"][value="sas"]')
        })

        it('Should have the ability to export to R format', () => {
            cy.verify_export_deidentification_options('input[name="export_format"][value="r"]')
        })

        it('Should have the ability to export to STATA format', () => {
            cy.verify_export_deidentification_options('input[name="export_format"][value="stata"]')
        })

        it('Should have the ability to export to CDISC ODM (XML) format', () => {
            cy.verify_export_deidentification_options('input[name="export_format"][value="odm"]')
        })
    })

    describe('De-Identification Options', () => {

        beforeEach(() => {
            cy.visit_version({page: 'DataExport/index.php', params: `pid=${pid}`})
            cy.get('tr#reprow_ALL').find('button.data_export_btn').contains('Export Data').click()
        })

        describe('Known Identifiers', () => {
            // Step 9

            it('Should have the ability to remove all known identifier fields', () => {
                cy.get('input[value="csvraw"]').click()
                cy.get('#deid-remove-identifiers').check()
                cy.export_csv_report().should((csv) => {
                    expect(csv[0]).to.have.lengthOf(10)                                                             // 10 columns
                    expect(csv[0]).to.not.include.members(['lname','fname','redcap_survey_identifier'])
                    expect([...new Set(csv.map((row) => row[0]).slice(1))]).to.have.lengthOf(8)                     // 8 records
                    expect(csv.length - 1).to.equal(19)                                                             // 19 rows of data (subtract header)
                    expect(csv.slice(1).reduce((acc, val) => {
                        return acc + (val[csv[0].indexOf('survey_timestamp')] !== "" ? 1 : 0)
                    }, 0)).to.equal(2)                                                                              // 2 rows show timestamps
                })
            })

            it('Should have the ability to hash the Record ID', () => {
                cy.visit_version({page: 'DataExport/index.php', params: `pid=${pid}`})
                cy.get('tr#reprow_ALL').find('button.data_export_btn').contains('Export Data').click()
                cy.get('input[value="csvraw"]').click()
                cy.get('#deid-hashid').check()
                cy.export_csv_report().should((csv) => {
                    expect([...new Set(csv.map((row) => row[0]).slice(1))]).to.have.lengthOf(8)                     // 8 records
                    expect(csv[1][csv[0].indexOf('record_id')].length).to.equal(32)                                 // record_id is 32 character hash
                })
            })

        })

        describe('Free Form Text', () => {
            // Step 9

            it('Should have the ability to remove unvalidated text fields', () => {
                cy.get('input[value="csvraw"]').click()
                cy.get('#deid-remove-text').check()
                cy.export_csv_report().should((csv) => {
                    expect(csv[0]).to.not.include.members(['lname', 'fname', 'reminder'])                           // remove unvalidated text fields
                    expect(csv[0]).to.include.members(['redcap_survey_identifier', 'dob', 'description'])           // include validated text fields, notes fields, and survey identifier fields
                })
            })

            it('Should have the ability to remove notes box fields', () => {
                cy.visit_version({page: 'DataExport/index.php', params: `pid=${pid}`})
                cy.get('tr#reprow_ALL').find('button.data_export_btn').contains('Export Data').click()
                cy.get('input[value="csvraw"]').click()
                cy.get('#deid-remove-notes').check()
                cy.export_csv_report().should((csv) => {
                    expect(csv[0]).to.not.include.members(['description'])                                                  // remove notes fields
                    expect(csv[0]).to.include.members(['lname', 'fname', 'reminder', 'redcap_survey_identifier', 'dob'])    // include everything else
                })
            })

        })

        describe('Date and Datetime Fields', () => {

            it('Should have the ability to remove all date and datetime fields', () => {
                // Step 9
                cy.get('input[value="csvraw"]').click()
                cy.get('#deid-dates-remove').check()
                cy.export_csv_report().should((csv) => {
                    expect(csv[0]).to.not.include.members(['dob'])                                                                  // remove date fields
                    expect(csv[0]).to.include.members(['redcap_survey_identifier', 'lname', 'fname', 'reminder', 'description'])    // include everything else
                })
            })

            it('Should have the ability to shift all dates by value between 0 and 364 days', () => {
                // Step 10
                cy.visit_version({page: 'DataExport/index.php', params: `pid=${pid}`})
                cy.get('tr#reprow_ALL').find('button.data_export_btn').contains('Export Data').click()
                cy.get('input[value="csvraw"]').click()
                cy.export_csv_report().then((csv_orig) => {
                    cy.visit_version({page: 'DataExport/index.php', params: `pid=${pid}`})
                    cy.get('tr#reprow_ALL').find('button.data_export_btn').contains('Export Data').click()
                    cy.get('input[value="csvraw"]').click()
                    cy.get('#deid-dates-shift').check()
                    cy.export_csv_report().should((csv_new) => {
                        let dob_orig = csv_orig[1][csv_orig[0].indexOf('dob')]
                        let dob_new = csv_new[1][csv_new[0].indexOf('dob')]
                        expect(dob_new).to.not.equal(dob_orig)
                    })
                })
            })

            it('Should have the ability to shift all survey completion timestamps by value between 0 and 364 days', () => {
                // Step 10
                cy.visit_version({page: 'DataExport/index.php', params: `pid=${pid}`})
                cy.get('tr#reprow_ALL').find('button.data_export_btn').contains('Export Data').click()
                cy.get('input[value="csvraw"]').click()
                cy.export_csv_report().then((csv_orig) => {
                    cy.visit_version({page: 'DataExport/index.php', params: `pid=${pid}`})
                    cy.get('tr#reprow_ALL').find('button.data_export_btn').contains('Export Data').click()
                    cy.get('input[value="csvraw"]').click()
                    cy.get('#deid-dates-shift').check()
                    cy.get('#deid-surveytimestamps-shift').check()
                    cy.export_csv_report().should((csv_new) => {
                        let st_orig = csv_orig[2][csv_orig[0].indexOf('survey_timestamp')]
                        let st_new = csv_new[2][csv_new[0].indexOf('survey_timestamp')]
                        expect(st_new).to.not.equal(st_orig)
                    })
                })
            })

        })

    })

    describe('Export Permissions', () => {

        before(() => {
            // Step 11
            cy.visit_version({page: 'UserRights/index.php', params: `pid=${pid}`}).then(() => {
                cy.get(`a.userLinkInTable[userid="${standard}"]`).should('be.visible').click().then(() =>{
                    cy.get('div#tooltipBtnSetCustom').should('be.visible').find('button').click()
                    cy.get('input[name="data_export_tool"][value="2"]').click()
                    cy.get('button').contains('Save Changes').click()
                })
            })
        })

        it('Should have the ability to restrict users from exporting data', () => {
            // Step 12

            // To get real data values
            cy.set_user_type('admin')
            cy.visit_version({page: 'DataExport/index.php', params: `pid=${pid}`})
            cy.get('tr#reprow_ALL').find('button.data_export_btn').contains('Export Data').click()
            cy.get('input[value="csvraw"]').click()
            cy.export_csv_report().then((csv_orig) => {
                cy.set_user_type('standard')
                cy.visit_version({page: 'DataExport/index.php', params: `pid=${pid}`})
                cy.get('tr#reprow_ALL').find('button.data_export_btn').contains('Export Data').click()
                cy.get('#deid-remove-identifiers').should($inpt => expect($inpt).to.be.checked)
                    .click().should($inpt => expect($inpt).to.be.checked)

                cy.get('input[value="csvraw"]').click()
                cy.export_csv_report().then((csv) => {
                    expect(csv[0]).to.have.lengthOf(8)                                                              // 8 columns
                    expect(csv[0][0]).to.equal('record_id')                                                         // Headers are raw field names
                    expect(csv[1][csv[0].indexOf('redcap_event_name')]).to.equal('event_1_arm_1')                   // Data are raw values
                    expect(csv.length - 1).to.equal(19)                                                             // 19 rows of data (subtract header)
                    expect(csv.slice(1).reduce((acc, val) => {
                        return acc + (val[csv[0].indexOf('survey_timestamp')] !== "" ? 1 : 0)
                    }, 0)).to.equal(2)                                                                              // 2 rows show timestamps

                    let dob_orig = csv_orig[1][csv_orig[0].indexOf('dob')]                                          // dob does not match actual data
                    let dob = csv[1][csv[0].indexOf('dob')]
                    expect(dob).to.not.equal(dob_orig)

                    let st_orig = csv_orig[2][csv_orig[0].indexOf('survey_timestamp')]                              // survey timestamp does not match
                    let st = csv[2][csv[0].indexOf('survey_timestamp')]                                             // actual data
                    expect(st).to.not.equal(st_orig)

                    let excluded_fields = ['lname', 'fname', 'redcap_survey_identifier', 'reminder', 'description'] // Does not include identifiers,
                    expect(csv[0]).to.not.include.members(excluded_fields)                                          // unvalidated text, or notes fields
                })
            })

            // Step 13
            cy.visit_version({page: 'UserRights/index.php', params: `pid=${pid}`}).then(() => {
                cy.get(`a.userLinkInTable[userid="${standard}"]`).should('be.visible').click().then(() =>{
                    cy.get('div#tooltipBtnSetCustom').should('be.visible').find('button').click()
                    cy.get('input[name="data_export_tool"][value="0"]').click()
                    cy.get('button').contains('Save Changes').click()
                })
            })

            // Step 14
            cy.visit_version({page: 'DataExport/index.php', params: `pid=${pid}`})
            cy.get('tr#reprow_ALL').find('button.data_export_btn').contains('Export Data').should('not.exist')
        })
    })
})