//Here we are importing commands from the sub-folders that aren't quite as stable
import './core/commands'
import './hooks/commands'
import './modules/commands'
import './plugins/commands'
import './projects/commands'

import compareVersions from 'compare-versions';
import 'cypress-iframe';
import '@4tw/cypress-drag-drop'

// Commands in this file are CRUCIAL and are an embedded part of the REDCap Cypress Framework.
// They are very stable and do not change often, if ever

function preventClickTimeoutFail() {
    //Needed to prevent tests from failing on expected timeout due to
    //side effect of clicking on a download link that doesn't load a new page
    cy.window().document().then(function (doc) {
        doc.addEventListener('click', () => {
            setTimeout(function () {
                doc.location.reload()
            }, 2000)
        })
    })
}

//Useful for clicking buttons located within a stacked dialog box (i.e. a dialog box that is displayed ontop of
//another dialog box, based on z-index). Clicks the last visible button within the frontmost dialog box containing `label`
Cypress.Commands.add('click_top_dialog_button', (label) => {
    cy.get('div[role=dialog][style*="z-index"]:visible').then($divs => {
        //sort dialog boxes based on z-index, ascending order
        let sorted = $divs.sort((cur, prev) => {
            let zp = Cypress.dom.wrap(prev).css('z-index')
            let zc = Cypress.dom.wrap(cur).css('z-index')
            return zc - zp
        })
        //assign highest z-index div to $div
        // let $div = Cypress.dom.wrap(sorted).last() //Cypress last()
        let $div = Cypress.dom.wrap(sorted.last()) //jQuery last()
        //TODO: either works, revisit later to pick best option

        //wrap div and look within to click matching button
        cy.wrap($div).within(($div) => {
            cy.get(`button:contains("${label}"):visible`).last().click()
        })
        
    })
})

Cypress.Commands.add('login', (options) => {
    cy.logout()
    cy.visit('/')
    cy.intercept('POST', '/').as('loginStatus')
    cy.get('input[name=username]').invoke('attr', 'value', options['username'])
    cy.get('input[name=password]').invoke('attr', 'value', options['password'])
    cy.get('button').contains('Log In').click()
})

Cypress.Commands.add('logout', () => {
    const url = '/redcap_v' + Cypress.env('redcap_version') + '/index.php?logout=1'
    cy.visit('/redcap_v' + Cypress.env('redcap_version') + '/index.php?logout=1')
})

Cypress.Commands.add('visit_version', (options) => {
    let version = Cypress.env('redcap_version')
    let url = ''

    if('params' in options){
        url = '/redcap_v' + version + '/' + options['page'] +  '?' + options['params']
        cy.visit(url)
    } else {
        url = '/redcap_v' + version + '/' + options['page']
        cy.visit(url)
    }

})

Cypress.Commands.add('visit_base', (options) => {
    const url = options['url']
    if ('url' in options) cy.visit(url)
})

Cypress.Commands.add('base_db_seed', () => {

    let redcap_source_path = Cypress.env('redcap_source_path')

    if(redcap_source_path === undefined){
        alert('redcap_source_path, which defines where your REDCap source code exists, is missing in cypress.env.json.  Please configure it before proceeding.')
    }

    //Get MySQL array from Environment Variables
    let mysql = Cypress.env('mysql')

    // We can skip populating the base db seed on successive runs by adding a false value to the mysql['initial_db_seed'] key in cypress.env.json
    // This should really ever be run in development but shouldn't necessarily harm production since we still need a DB lock file to proceed
    cy.task('dbSeedLockExists').then((db_seed_exists) => {

        if(
            !mysql.hasOwnProperty('skip_db_seed') ||
            mysql.hasOwnProperty('skip_db_seed') && mysql['skip_db_seed'] && !db_seed_exists ||
            !mysql['skip_db_seed']
        ) {

            cy.task('populateStructureAndData', {
                redcap_version: Cypress.env('redcap_version'),
                advanced_user_info: compareVersions.compare(Cypress.env('redcap_version'), '10.1.0', '>='),
                source_location: redcap_source_path
            }).then((structure_and_data_file_exists) => {

                //Only run this block if the Structure and Data File exists and has gone through proper processes
                if (structure_and_data_file_exists) {

                    //Create the database if it doesn't exist
                    cy.mysql_db('create_database', '', false).then(() => {

                        //Pull in the structure and data from REDCap Source
                        cy.mysql_db('structure_and_data', window.base_url).then(() => {

                            if (Cypress.env('redcap_hooks_path') !== undefined) {
                                const redcap_hooks_path = "REDCAP_HOOKS_PATH/" + Cypress.env('redcap_hooks_path').replace(/\//g, "\\/");
                                cy.mysql_db('hooks_config', redcap_hooks_path) //Fetch the hooks SQL seed data
                            }

                            //Clear out all cookies
                            cy.clearCookies()

                            //Create a DB Seed Lock file
                            cy.task('createInitialDbSeedLock')
                        })

                    })

                } else {
                    alert('Warning: Error generating structure and data file.  This usually happpens because your REDCap source code is missing files.')
                }

            })
        }
    })
})

Cypress.Commands.add('fetch_login', () => {
    let user = window.user_info.get_current_user()
    let pass = window.user_info.get_current_pass()

    cy.login({ username: user, password:  pass })

    window.user_info.set_previous_user_type()
})

Cypress.Commands.add('set_user_type', (user_type) => {
    window.user_info.set_user_type(user_type)
})

Cypress.Commands.add('set_user_info', (users) => {
    if(users !== undefined){
        window.user_info.set_users(users)
    } else {
        alert('users, which defines what users are in your seed database, is missing from cypress.env.json.  Please configure it before proceeding.')
    }
})


Cypress.Commands.add('mysql_db', (type, replace = '', include_db_name = true) => {

    const mysql = Cypress.env("mysql")

    let version = Cypress.env('redcap_version')

    if(version === undefined){
        alert('redcap_version, which defines what version of REDCap you use in the seed database, is missing from cypress.env.json.  Please configure it before proceeding.')
    }

    //Create the MySQL Installation
    cy.task('generateMySQLCommand', {
                                mysql_name: mysql['path'],
                                host: mysql['host'],
                                port: mysql['port'],
                                db_name: mysql['db_name'],
                                db_user: mysql['db_user'],
                                db_pass: mysql['db_pass'],
                                type: type,
                                replace: replace,
                                include_db_name: include_db_name
                              }).then((mysql_cli) => {

                                    //Execute the MySQL Command
                                    cy.exec(mysql_cli['cmd'], { timeout: 100000}).then((data_import) => {
                                        expect(data_import['code']).to.eq(0)

                                        //Clean up after ourselves
                                        cy.task('deleteFile', { path: mysql_cli['tmp'] }).then((deleted_tmp_file) => {
                                            expect(deleted_tmp_file).to.eq(true)
                                        })
                                    })
                              })
})

function test_link (link, title, try_again = true) {
    cy.get('div#control_center_menu a').
        contains(link).
        click().
        then(($control_center) => {
            if($control_center.find('div#control_center_window').length){
                cy.get('div#control_center_window').then(($a) => {
                    if($a.find('div#control_center_window h4').length){
                        cy.get('div#control_center_window h4').contains(title)
                    } else if ($a.find('div#control_center_window div').length){
                        cy.get('div#control_center_window div').contains(title)
                    } else {
                        cy.get('body').contains(title)
                    }
                })
            } else {
                cy.get('body').contains(title)
            }
        })
}

Cypress.Commands.add('contains_cc_link', (link, title = '') => {
    if(title == '') title = link
    let t = Cypress.$("div#control_center_menu a:contains(" + JSON.stringify(link) + ")");
    t.length ? test_link(link, title) : test_link(link.split(' ')[0], title.split(' ')[0])
})

Cypress.Commands.add('find_online_designer_field', (name, timeout = 10000) => {
     cy.contains('td', name, { timeout: timeout })
})

Cypress.Commands.add('compare_value_by_field_label', (name, value, timeout = 10000) => {
    cy.contains('td', name, { timeout: timeout }).parent().parentsUntil('tr').last().parent().then(($tr) => {
        const name = $tr[0]['attributes']['sq_id']['value']
        cy.get('[name="' + name + '"]', { force: true }).should(($a) => {
            expect($a[0]['value']).to.equal(value)
        })
    })
})

Cypress.Commands.add('set_field_value_by_label', ($name, $value, $type, $prefix = '', $suffix = '', $last_suffix = '', timeout = 10000) => {
   cy.contains('td', $name, { timeout: timeout }).
      parent().
      parentsUntil('tr').
      last().
      parent().
      then(($tr) => {
        let selector = $type + '[name="' + $prefix + $tr[0]['attributes']['sq_id']['value'] + $suffix + '"]'
        cy.get(selector, { force: true}).then(($a) => {
            return $a[0]
        })
      })
})

Cypress.Commands.add('select_text_by_label', ($name, $value) => {
    cy.set_field_value_by_label($name, $value, 'input')
})

Cypress.Commands.add('select_textarea_by_label', ($name, $value) => {
    cy.set_field_value_by_label($name, $value, 'textarea')
})

Cypress.Commands.add('select_radio_by_label', ($name, $value, $click = true, $selected = true ) => {
    const radio_labels = cy.set_field_value_by_label($name, $value, 'input', '', '___radio')

    radio_labels.first().parents('tr').first().within(() => {

        if($click){
            cy.get('label[class=mc]').contains($value).click()
        } else {
            cy.get('label[class=mc]').contains($value).parent().find('input').should('have.attr', $selected ? "checked": "unchecked")
        }
    })
})

Cypress.Commands.add('select_value_by_label', ($name, $value) => {
    cy.set_field_value_by_label($name, $value, 'select', '', '')
})

Cypress.Commands.add('select_checkbox_by_label', ($name, $value) => {
    const checkbox_labels = cy.set_field_value_by_label($name, $value, 'input', '__chkn__', '')

    checkbox_labels.first().parents('tr').first().within(() => {
        cy.get('label[class=mc]').contains($value).click()
    })
})

Cypress.Commands.add('edit_field_by_label', (name, timeout = 10000) => {
    cy.find_online_designer_field(name).parent().parentsUntil('tr').find('img[title=Edit]').parent().click()
    cy.get('div[role=dialog]').contains('Edit Field').should('be.visible')
})

Cypress.Commands.add('select_field_choices', (timeout = 10000) => {
    cy.get('form#addFieldForm').children().get('span').contains('Choices').parent().parent().find('textarea')
})

Cypress.Commands.add('initial_save_field', () => {
    cy.get('input#field_name').then(($f) => {
        cy.contains('button', 'Save').
           should('be.visible').
           click().
           then(() => {

                cy.contains('Alert').then(($a) => {
                    if($a.length){
                        cy.get('button[title=Close]:last:visible').click()
                        cy.get('input#auto_variable_naming').click()
                        cy.contains('button', 'Enable auto naming').click().then(() => {
                            cy.contains('button', 'Save').click()
                        })
                    }
                })
            })
    })
})

Cypress.Commands.add('save_field', () => {
    cy.intercept({
        method: 'GET',
        url: '/redcap_v' + Cypress.env('redcap_version') + "/Design/online_designer_render_fields.php?*"
    }).as('save_field')

    cy.get('input#field_name').then(($f) => {
        cy.contains('button', 'Save').click()
    })

    cy.wait('@save_field')
})

Cypress.Commands.add('add_field', (field_name, type) => {
     cy.get('input#btn-last').click().then(() => {
        cy.get('select#field_type').select(type).should('have.value', type).then(() => {
            cy.get('input#field_name').type(field_name).then(() => {
                cy.save_field()
                cy.find_online_designer_field(field_name)
            })
        })
    })
})

function error(){
    console.log('error');
}

Cypress.Commands.add('require_redcap_stats', () => {
    cy.server()
    cy.route({method: 'POST', url: '**/ProjectGeneral/project_stats_ajax.php'}).as('project_stats_ajax')
    cy.wait('@project_stats_ajax').then((xhr, error) => { })
})

Cypress.Commands.add('get_project_table_row_col', (row = '1', col = '0') => {
    cy.get('table#table-proj_table tr:nth-child(' + row + ') td:nth-child(' + col + ')')
})

Cypress.Commands.add('upload_file', (fileName, fileType = ' ', selector) => {
    cy.get(selector).then(subject => {
      cy.fixture(fileName, 'base64')
        .then(Cypress.Blob.base64StringToBlob)
        .then(blob => {
          const el = subject[0]
          const testFile = new File([blob], fileName, { type: fileType })
          const dataTransfer = new DataTransfer()
          dataTransfer.items.add(testFile)
          el.files = dataTransfer.files
        })
    })
})


Cypress.Commands.add('upload_data_dictionary', (fixture_file, date_format = "DMY") => {
    cy.upload_file('/dictionaries/' + fixture_file, 'csv', 'input[name="uploadedfile"]')

    cy.get('button[name=submit]').click({ check_csrf: true })
    cy.get('html').should(($html) => {
        expect($html).to.contain('Commit Changes')
    })

    cy.get('button').contains('Commit Changes').click({ check_csrf: true })
    cy.get('html').should(($html) => {
        expect($html).to.contain('Changes')
    })
})

Cypress.Commands.add('create_cdisc_project', (project_name, project_type, cdisc_file) => {
    //Run through the steps to import the project via CDISC ODM
    cy.visit_base({url: 'index.php?action=create'})
    cy.get('input#app_title').type(project_name)
    cy.get('select#purpose').select(project_type)
    cy.get('input#project_template_radio2').click()
    cy.upload_file(cdisc_file, 'xml', 'input[name="odm"]')
    cy.get('button').contains('Create Project').click().then(() => {
        let pid = null;
        cy.url().should((url) => {
            return url
        })
    })
})

Cypress.Commands.add('add_api_user_to_project', (username, pid) => {
    cy.visit_version({ page: 'UserRights/index.php', params: 'pid=' + pid}).then(($e) => {

        cy.get('html').should('contain', 'User Rights')

        cy.get('#user_rights_roles_table').then(($r) => {

            //If username has already been added to the project
            if($r[0].innerText.indexOf(username) !== -1){

                cy.access_api_token(pid, username).then(($request) => {
                    return { token: $request }
                })

            } else {

                cy.get('input#new_username', {force: true}).clear({force: true}).type(username, {force: true}).then((element) => {
                    cy.get('button', {force: true}).contains('Add with custom rights').click({force: true}).then(() => {
                        cy.get('input[name=api_export]', {force: true}).click()
                        cy.get('input[name=api_import]', {force: true}).click()

                        cy.get('.ui-button', {force: true}).contains(/add user|save changes/i).click().then(() => {
                            cy.get('table#table-user_rights_roles_table').should(($e) => {
                                expect($e[0].innerText).to.contain(username)
                            })
                        })
                    })
                })

            }
        })


    })

})

Cypress.Commands.add('mysql_query', (query) => {
    const mysql = Cypress.env("mysql")

    const cmd = `${mysql['path']} -h${mysql['host']} --port=${mysql['port']} ${mysql['db_name']} -u${mysql['db_user']} -p${mysql['db_pass']} -e "${query}" -N -s`

    cy.exec(cmd, { timeout: 100000}).then((response) => {
        expect(response['code']).to.eq(0)
        return response['stdout']
    })
})

Cypress.Commands.add('num_projects_excluding_archived', () => {
    return cy.mysql_query("SELECT count(*) FROM redcap_projects WHERE status != 3;")
})

Cypress.Commands.add('delete_project_permanently', () => {
    cy.intercept({
        method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + "/ProjectGeneral/delete_project.php?*"
    }).as('delete_project')
    cy.get('button').contains('Delete the project').click()
    cy.get('input#delete_project_confirm').should('be.visible').type('DELETE').then((input) => {
        cy.get(input).closest('div[role="dialog"]').find('button').contains('Delete the project').click()
        cy.get('button').contains('Yes, delete the project').click()
    })
    cy.wait('@delete_project')
})

Cypress.Commands.add('delete_project_complete', (pid) => {
    cy.mysql_query(`START TRANSACTION;

        USE \`REDCAP_DB_NAME\`;
        SET AUTOCOMMIT=0;
        SET UNIQUE_CHECKS=0;
        SET FOREIGN_KEY_CHECKS=0;

        DELETE FROM redcap_data WHERE project_id = ${pid};
        DELETE FROM redcap_record_list WHERE project_id = ${pid};
        DELETE FROM redcap_record_counts WHERE project_id = ${pid};
        DELETE FROM redcap_user_rights WHERE project_id = ${pid};
        DELETE FROM redcap_projects WHERE project_id = ${pid};

        COMMIT;`
    )
})

Cypress.Commands.add('delete_records', (pid) => {
    cy.visit_version({ page: 'ProjectSetup/other_functionality.php', params: `pid=${pid}`})
    cy.get('button', {force: true}).contains('Erase all data').click({force: true})
    cy.get('div[role="dialog"]', {force: true}).find('button').contains('Erase all data').click({force: true})
    cy.get('span#ui-id-2', {force: true}).closest('div[role="dialog"]').find('button').contains('Close').click({force: true})
})

Cypress.Commands.add('access_api_token', (pid, user) => {
    // This assumes user already has API token created
    cy.fetch_login().then(($r) => {
        cy.request({ url: `/redcap_v${Cypress.env('redcap_version')}/ControlCenter/user_api_ajax.php?action=viewToken&api_pid=${pid}&api_username=${user}`})
            .then(($token) => {
                return cy.wrap(Cypress.$($token.body).children('div')[0].innerText);
            })
    })
})

Cypress.Commands.add('import_data_file', (fixture_file,pid) => {

    let admin_user = Cypress.env('users')['admin']['user']
    let current_token = null;

    let current_user_type = window.user_info.get_previous_user_type()
    if(current_user_type != 'admin'){
        cy.set_user_type('admin')
        cy.fetch_login()
    } 

    cy.add_api_user_to_project(admin_user, pid).then(($response) => {

        if($response.hasOwnProperty('token')){

            current_token = $response['token']

            cy.fixture(`import_files/${fixture_file}`).then(import_data => {

                cy.request({
                    method: 'POST',
                    url: '/api/',
                    headers: {
                        "Accept":"application/json",
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: {
                        token: current_token,
                        content: 'record',
                        format: 'csv',
                        type: 'flat',
                        data: import_data,
                        dateFormat: 'MDY',
                        returnFormat: 'json'
                    },
                    timeout: 50000
                }).should(($a) => {
                    expect($a.status).to.equal(200)
                })

            })

        } else {

            cy.request({ url: '/redcap_v' +
                    Cypress.env('redcap_version') +
                    '/ControlCenter/user_api_ajax.php?action=createToken&api_username=' +
                    admin_user +
                    '&api_pid=' +
                    pid +
                    '&api_export=1&api_import=1&mobile_app=0&api_send_email=0'}).should(($token) => {

                expect($token.body).to.contain('token has been created')
                expect($token.body).to.contain(admin_user)

                cy.request({ url: '/redcap_v' +
                        Cypress.env('redcap_version') +
                        '/ControlCenter/user_api_ajax.php?action=viewToken&api_username=' + admin_user + '&api_pid=' + pid}).then(($super_token) => {

                    current_token = Cypress.$($super_token.body).children('div')[0].innerText

                    cy.fixture(`import_files/${fixture_file}`).then(import_data => {

                        cy.request({
                            method: 'POST',
                            url: '/api/',
                            headers: {
                                "Accept":"application/json",
                                "Content-Type": "application/x-www-form-urlencoded"
                            },
                            body: {
                                token: current_token,
                                content: 'record',
                                format: 'csv',
                                type: 'flat',
                                data: import_data,
                                dateFormat: 'MDY',
                                returnFormat: 'json'
                            },
                            timeout: 50000
                        }).should(($a) => {
                            expect($a.status).to.equal(200)
                        })

                    })
                })
            })

        }

        if(current_user_type != 'admin'){
            cy.set_user_type(current_user_type)
            cy.fetch_login()
        }

    })

})

Cypress.Commands.add('assign_basic_user_right', (username, proper_name, rights_to_assign, project_id , assign_right = true, user_type = 'admin', selector = 'input', value = null) => {

    let user_has_rights_assigned = Cypress.$("a:contains(" + JSON.stringify(username + ' (' + proper_name + ')') + ")");
    
    if (!user_has_rights_assigned.length){
        cy.get('input#new_username', {force: true}).clear({force: true}).type(username, {force: true}).then((element) => {
            cy.get('button', {force: true}).contains('Add with custom rights').click({force: true}).then(() => {
                cy.get('div[role="dialog"]', {force: true}).find('button').contains(/add user|save changes/i).click().then(() => {
                    cy.get('table#table-user_rights_roles_table').should(($e) => {
                        expect($e[0].innerText).to.contain(username)
                    })
                })
            })
        })
    }
    
    cy.get('a').contains(username + ' (' + proper_name + ')').click()

    cy.get('button').contains('Edit user privileges').click()

    cy.get('div').should(($div) => { expect($div).to.contain('Editing existing user') })

    if(rights_to_assign === "Expiration Date"){

        console.log("VALUE: " + assign_right)

        if(assign_right === true){
            cy.get('input.hasDatepicker').click()
            cy.get('table.ui-datepicker-calendar').should('be.visible')
            cy.get('a.ui-state-highlight').click()

            let date = new Date()
            let day = String(date.getDate()).padStart(2, "0");
            let month = String(date.getMonth()+1).padStart(2, "0");
            let year = date.getFullYear();
            let expired_year = String(year - 1); //We are subtracting one year, so we know it's expired
            let fullDate = `${month}/${day}/${year}`;

            //Validate that we set today's date by clicking on highlight in datepicker
            cy.get('input#expiration').should(($expiration) => {
                expect($expiration).to.have.value(fullDate)
            })

            cy.get('table.ui-datepicker-calendar').should('not.be.visible')

            cy.get('input.hasDatepicker').click()

            cy.get('table.ui-datepicker-calendar').should('be.visible')

            cy.get('select.ui-datepicker-year').scrollIntoView().should('be.visible').select(expired_year)

            //Select the first date from the month we are on
            cy.get('.ui-state-default').first().click()

            let expiredDate = `${month}/01/${expired_year}`;

            //Validate that we set an expired date
            cy.get('input#expiration').should(($expiration) => {
                expect($expiration).to.have.value(expiredDate)
            })

            cy.get('button').contains(/add user|save changes/i).click()

            cy.get('body').should(($body) => {
                expect($body).to.contain('User "' + username + '" was successfully edited')
            })

            //Should not be visible before we start our next test
            cy.get('div').contains('User "' + username + '" was successfully edited').should('not.be.visible')

            cy.get('body').should(($body) => {
                expect($body).to.contain(expiredDate)
            })

        } else {

           console.log('Remove expiration date')

           cy.get('input.hasDatepicker').click().clear()
           cy.get('input#expiration').should(($expiration) => {
               expect($expiration).to.have.value("")
           })
           cy.get('button').contains(/add user|save changes/i).click()
           cy.get('body').should(($body) => {
               expect($body).to.contain('User "' + username + '" was successfully edited')
           })
           //Should not be visible before we start our next test
           cy.get('div').contains('User "' + username + '" was successfully edited').should('not.be.visible')     
        }

    } else {

        function check_or_uncheck_right($obj, rights_to_assign, assign_right){
            let check_info = ' RIGHT: ' + rights_to_assign + " | " + 'CHECKED? ' + Cypress.$($obj).is(":checked") + ' | ASSIGN RIGHT: ' + assign_right

            //If value is NOT checked and we want to assign the right
            if(!Cypress.$($obj).is(":checked") && assign_right){
                console.log('VALUE NOT CHECKED |' + check_info)
                $obj.click()
                //If value is checked and we want to REMOVE the right
            }else if(Cypress.$($obj).is(":checked") && !assign_right){
                console.log('VALUE CHECKED |' + check_info)
                $obj.click()
            } else {
                console.log('OTHER CONDITION |' + check_info)
            }

        }

        if(value !== null) selector = `${selector}[value='${value}']`

        cy.get('td').contains(rights_to_assign).then(($element) => {

            if($element.length > 0){

                //If we're in the TD cell, we can shortcut to the selector we're looking for
                if($element[0].tagName === 'TD'){

                    check_or_uncheck_right($element.next('td').find(selector), rights_to_assign, assign_right)

                    //If we're NOT in the TD cell, let's move out until TR and then find the selector in the next TD
                } else {
                    check_or_uncheck_right($element.parentsUntil('tr').next('td').find(selector), rights_to_assign, assign_right)
                }
            }
        })
    }

    if(rights_to_assign !== "Expiration Date") {

        console.log('Save changes non expiration date')

        cy.get('button').contains(/add user|save changes/i).click()

        cy.get('body').should(($body) => {
            expect($body).to.contain('User "' + username + '" was successfully edited')
        })

        //Should not be visible before we start our next test
        cy.get('div').contains('User "' + username + '" was successfully edited').should('not.be.visible')
    }
})

Cypress.Commands.add('remove_basic_user_right', (username, proper_name, rights_to_assign, user_type = 'admin', selector = 'input', value = null) => {
    cy.assign_basic_user_right(username, proper_name, rights_to_assign, null, false, user_type, selector, value)
})

Cypress.Commands.add('assign_expiration_date_to_user', (username, proper_name) => {
    cy.assign_basic_user_right(username, proper_name, "Expiration Date", null, true)
})

Cypress.Commands.add('remove_expiration_date_from_user', (username, proper_name) => {
    cy.assign_basic_user_right(username, proper_name, "Expiration Date", null, false)
})


Cypress.Commands.add('verify_user_rights_available', (user_type, path, pid) => {
    //Set user type we're checking permissions for
    cy.set_user_type(user_type)

    //Attempt to go to the path
    cy.visit_version({page: path + '/index.php', params: 'pid=' + pid})

    //We should be able to visit it
    cy.url().should('include', `/redcap_v${Cypress.env('redcap_version')}/${path}/index.php?pid=${pid}`)
})

Cypress.Commands.add('verify_user_rights_unavailable', (user_type, path, pid, redirect = true) => {
    //Set user type we're checking permissions for
    cy.set_user_type(user_type)

    //Attempt to go to the path
    cy.visit_version({page: path + '/index.php', params: 'pid=' + pid})

    //But ensure that we're actually redirect to index.php
    if(redirect){
        cy.url().should('include', `/redcap_v${Cypress.env('redcap_version')}/index.php?pid=`+ pid)

        //Otherwise do we get access denied?
    } else {
        cy.get('body').should(($body) => {
            expect($body).to.contain('ACCESS DENIED')
        })
    }

})

Cypress.Commands.add('assign_form_rights', (pid, username, form, rights_level) => {
    //Visit the version specified
    cy.visit_version({page:'index.php', params: 'pid=' + pid})
    cy.get('a').contains('User Rights').click()

    //Click on the user's name
    cy.get('table#table-user_rights_roles_table').within(() => {
        cy.get('a').contains(username).click()
    })

    //Edit the user's privileges
    cy.get('div').contains('User actions:').parent().within(() => {
        cy.get('button').contains('Edit user privileges').click()
    })

    //Should not display "Working"
    cy.get('div').contains('Working').should('not.be.visible')

    //Assign User Rights
    cy.get('table#form_rights').within(() => {
        let input_value = null;

        if(rights_level === "No Access"){
            input_value = 0;
        } else if (rights_level === "Read Only") {
            input_value = 2;
        } else if (rights_level === "View & Edit") {
            input_value = 1;
        } else {
            alert(`You set the rights level to ${rights_level} for #assign_form_rights.  This is invalid.  Please use 'No Access', 'Read Only', or 'View & Edit'`)
        }

        cy.get('td').contains(form).parent().find(`input[value=${input_value}]`).click()
    })

    //Click Save
    cy.get('button').contains('Save Changes').click()

    //User was successfully edited
    cy.get('body').should(($body) => {
        expect($body).to.contain('User "' + username + '" was successfully edited')
    })

    //Should not be visible before we start our next step or test
    cy.get('div').contains('User "' + username + '" was successfully edited').should('not.be.visible')
})

Cypress.Commands.add('change_survey_edit_rights', (pid, username, form) => {
    //Visit the version specified
    cy.visit_version({page:'index.php', params: 'pid=' + pid})
    cy.get('a').contains('User Rights').click()

    //Click on the user's name
    cy.get('table#table-user_rights_roles_table').within(() => {
        cy.get('a').contains(username).click()
    })

    //Edit the user's privileges
    cy.get('div').contains('User actions:').parent().within(() => {
        cy.get('button').contains('Edit user privileges').click()
    })

    //Should not display "Working"
    cy.get('div').contains('Working').should('not.be.visible')

    //Assign User Rights
    cy.get('table#form_rights').within(() => {
        cy.get('td').contains(form).parent().find(`input[type=checkbox]`).click()
    })

    //Click Save
    cy.get('button').contains('Save Changes').click()

    //User was successfully edited
    cy.get('body').should(($body) => {
        expect($body).to.contain('User "' + username + '" was successfully edited')
    })

    //Should not be visible before we start our next step or test
    cy.get('div').contains('User "' + username + '" was successfully edited').should('not.be.visible')
})

//Corey
//Creates a new instrument at the end of the instrument list
Cypress.Commands.add('create_instrument', (instr_name) => {
    cy.get('[onclick*="showAddForm()"]').click()
    //If there is already at least 1 instrument,REDCap lets us choose position
    //of new instrument in the list, so we choose last.

    cy.get('body').then(($body) => {
        //if at least 1 instrument already exists (true if table has more than 1 row),
        //we need to click a button to add after the last instrument
        if ($body.find('table#table-forms_surveys tr').length > 1) {
            cy.get('button:contains("Add instrument here")').last().click()
        }

        cy.get('table#table-forms_surveys tr.addNewInstrRow').last().within(($tr) => {
            cy.get(':text[id^="new_form"]').type(instr_name)
            cy.get('input[onclick*="addNewForm("]').click()
        })
    })
})

//TODO: consider refactoring to avoid get()'ing the row twice, reuse a reference instead
//TODO: wrap async commands in then() blocks
Cypress.Commands.add('rename_instrument', (from, to) => {
    //get row, click actions dropdown
    cy.get(`div.projtitle:contains("${from}")`).parentsUntil('tr').last().parent().within(($tr) => {
        cy.get('button:contains("Choose action")').click()
    })
    //dropdown menu is inserted into HTML outside of the tr, so we exit the within() block
    cy.get('ul#formActionDropdown').within(($ul) => {
        cy.get('a:contains("Rename")').click()
    })
    //back within tr, type new name and click save
    cy.get(`div.projtitle:contains("${from}")`).parentsUntil('tr').last().parent().within(($tr) => {
        cy.get('input[id^="form_menu_description_input-"]').clear().type(to)
        cy.get('input[id^="form_menu_save_btn-"]').click()
    })
})

//TODO: wrap async commands in then() blocks
Cypress.Commands.add('copy_instrument', (from, to, suffix) => {
    //get row, click actions dropdown
    cy.get(`div.projtitle:contains("${from}")`).parentsUntil('tr').last().parent().within(($tr) => {
        cy.get('button:contains("Choose action")').click()
    })
    //dropdown menu is inserted into HTML outside of the tr, so we exit the within() block
    cy.get('ul#formActionDropdown').within(($ul) => {
        cy.get('a:contains("Copy")').click()
    })
    //modal dialogue appears, enter new instrument name and variable suffix
    cy.get('input#copy_instrument_new_name').clear().type(to)
    cy.get('input#copy_instrument_affix').clear().type(suffix)
    cy.get('button:contains("Copy instrument")').click()
})

//TODO: not yet working, using a simple drag() or the below approach with move() cause instrument order to save unchanged
Cypress.Commands.add('reorder_instrument', (from, to) => {
    //get DOM elements of instruments at current position and target position
    const sel_from = `#row_${from} td.dragHandle`
    const sel_to = `#row_${to} td.dragHandle`
    const el_from = Cypress.$(sel_from)[0]
    const el_to = Cypress.$(sel_to)[0]
    //calculate distance needed to drag (`move()`) the first element
    const coords_from = el_from.getBoundingClientRect()
    const coords_to = el_to.getBoundingClientRect()
    const dX = coords_to.x - coords_from.x
    const dY = coords_to.y - coords_from.y
    //drag/move the instrument
    // cy.wrap(el_from).move({deltaX:dX, deltaY:dY})
    cy.log(cy.wrap(el_from) == cy.get(sel_from))
    cy.log(cy.wrap(el_from) === cy.get(sel_from))
})


Cypress.Commands.add('read_directory', (dir) => {
    cy.task('readDirectory', (dir)).then((files) => {
        return files
    })
})

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

Cypress.Commands.add('click_on_design_field_function', (type, field) => {
    cy.get('td[class=frmedit_row]').
    contains(field).
    parents('tr').
    find('img[title="' + type + '"]').
    click()
})

Cypress.Commands.add('change_event_name', (current_name, proposed_name, production = false) => {

    if(!production){
        cy.intercept({
            method: 'GET',
            url: '/redcap_v' + Cypress.env('redcap_version') + "/Design/define_events_ajax.php?*"
        }).as('define_ajax_events')
    }

    cy.get('td').contains(current_name).parents('tr').within(() => {
        cy.get('img[title="Edit"]').click()
    })

    if(!production) {
        cy.wait('@define_ajax_events')

        cy.intercept({
            method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + "/Design/define_events_ajax.php"
        }).as('save_events')

        cy.get('input[value="' + current_name + '"]').clear().type(proposed_name).parents('tr').within(() => {
            cy.get('input[value=Save]').click()
        })
        cy.wait('@save_events')
    }
})



Cypress.Commands.add('delete_event_name', (event_name) => {
    cy.intercept({
        method: 'GET',
        url: '/redcap_v' + Cypress.env('redcap_version') + "/Design/define_events_ajax.php?*"
    }).as('delete_ajax_events')

    cy.get('td').
    contains(event_name).
    parents('tr').within(() => {
        cy.get('img[title="Delete"]').click()
    })
    cy.wait('@delete_ajax_events')
})

Cypress.Commands.add("click_on_dialog_button", (text, selector = 'button') => {
    cy.get('div[role="dialog"]').then((divs) => {
        // can be multiple layers of dialogs, find the top most - tintin edit
        let topDiv = null
        for(let i = 0; i < divs.length; i++){
            // ignore invisible dialogs
            if(divs[i].style.display === 'none') {continue}

            if(topDiv == null || divs[i].style.zIndex > topDiv.style.zIndex){
                topDiv = divs[i]
            }
        }
        cy.wrap(topDiv).find(selector).contains(text).click()
    })
})

Cypress.Commands.add("verify_text_on_dialog", (text) => {
    cy.get('div[role="dialog"]').should('contain', text)
})

Cypress.Commands.add("adjust_or_verify_instrument_event", (instrument_name, event_name, checked= false, click = true) => {

    if(click) {
        cy.get('span#progress_save').should('be.hidden')
        cy.get('button').contains('Begin Editing').should('be.visible').click()
        cy.intercept({
            method: 'POST',
            url: '/redcap_v' + Cypress.env('redcap_version') + "/Design/designate_forms_ajax.php"
        }).as('designate_forms')
    }

    cy.get('table#event_grid_table').within(($table) => {
        cy.get('th').contains(event_name).then(($th) => {
            $th.parents('tr').children('th').each((thi, th) => {
                if(th.innerText.includes(event_name)){
                    cy.get('td').contains(instrument_name).then(($td) => {
                        $td.parent('tr').children('td').each((tdi, td) => {
                            //If we're in the correct row and column
                            if(tdi === thi){

                                const element = Cypress.$(td).find((click) ? 'input' : 'img')

                                if(element.length){

                                    if(click && element[0]['checked'] === checked){
                                        element[0].click()
                                    } else if (checked && !click) {
                                        expect(element.length).to.eq(1)
                                    } else if (!checked && !click) {
                                        expect(element.length).to.eq(0)
                                    }

                                } else {
                                    expect(element.length).to.eq(0)
                                }

                            }
                        })
                    })
                }
            })
        })
    })

    if(click) {
        cy.get('button').contains('Save').click()
        cy.wait('@designate_forms')
        cy.get('span#progress_save').should('be.hidden')
    }
})

Cypress.Commands.add("toggle_field_validation_type", (field_validation_type, button_text = 'Enable') => {
    cy.intercept({
        method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + "/ControlCenter/validation_type_setup.php"
    }).as('validation_type_setup')

    cy.get('td').contains(field_validation_type).parents('tr').children('td').each((td, i) => {
        //Get to third column
        if(i === 2 && td.length){
            if(td[0].innerText.includes(button_text)){
                td.find('button')[0].click()
                cy.wait('@validation_type_setup')
            } else {
                //Do nothing if we do not find the "button text" - it means we're already in the state we want to be!
            }
        }
    })
})

//

//yields the visible div with the highest z-index, or the <html> if none are found
Cypress.Commands.add('get_top_layer', (retryUntil) => {
    let top_layer
    cy.get('div[role=dialog][style*=z-index]:visible,html').should($els => {
        //if more than body found, find element with highest z-index
        if ($els.length > 1) {
            //remove html from $els so only elements with z-index remain
            $els = $els.filter(':not(html)')
            //sort by z-index (ascending)
            $els.sort((cur, prev) => {
                let zp = Cypress.dom.wrap(prev).css('z-index')
                let zc = Cypress.dom.wrap(cur).css('z-index')
                return zc - zp
                //return zp - zc
            })
        }
        top_layer = $els.last()
        retryUntil(top_layer) //run assertions, so get can retry on failure
    }).then(() => cy.wrap(top_layer)) //yield top_layer to any further chained commands
})

Cypress.Commands.add('ensure_csrf_token', () => {
    cy.url().then(($url) => {
        if($url !== undefined && $url !== 'about:blank'){
            if(Cypress.$('form').length > 0){
                cy.getCookies()
                    .should('have.length.greaterThan', 0)
                    .then(($cookies) => {

                        $cookies.forEach(($cookie) => {
                            //If our cookies include PHPSESSID, we can assume we're logged into REDCap
                            //If they do NOT include PHPSESSID, we shouldn't have to worry about this token
                            //It also appears that the Report Forms DO not need a CSRF token, which is interesting ...
                            if($cookie['name'] === 'PHPSESSID' && Cypress.$('form#create_report_form').length === 0){
                                cy.get('form input[name=redcap_csrf_token]').each(($form_token) => {
                                    cy.window().then((win) => {
                                        expect($form_token[0].value).to.not.be.null
                                    })
                                })

                                // === DETACHMENT PREVENTION === //
                                //Some common elements to tell us things are still loading!
                                if(Cypress.$('span#progress_save').length) cy.get('span#progress_save').should('not.be.visible')
                                if(Cypress.$('div#progress').length) cy.get('div#progress').should('not.be.visible')
                                if(Cypress.$('div#working').length) cy.get('div#working').should('not.be.visible')
                            }
                        })
                    })

            }
        }
    })
})

Cypress.Commands.overwrite(
    'click',
    (originalFn, subject, options) => {

        //If we say no CSRF check, then skip it ...
        if(options !== undefined && options['no_csrf_check']){
            delete(options['no_csrf_check'])
            return originalFn(subject, options)

        //For all other cases, check for CSRF token
        } else {
            if(options === undefined) options = {} //If no options object exists, create it
            options['no_csrf_check'] = true //Add the "no_csrf_check" to get back to the original click method!

            //console.log(subject)

            if(subject[0].nodeName === "A" ||
                subject[0].nodeName === "BUTTON" ||
                subject[0].nodeName === "INPUT" && subject[0].type === "button" && subject[0].onclick === ""
            ){

                //Is the element part of a form?
                if(subject[0].form){
                    cy.ensure_csrf_token() //Check for the CSRF token to be set in the form
                }

                //If our other detachment prevention measures failed, let's check to see if it detached and deal with it
                cy.wrap(subject).then($el => {
                    return Cypress.dom.isDetached($el) ? Cypress.$($el): $el
                }).click(options)

            } else {
                return originalFn(subject, options)
            }
        }
    }
)

// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This is will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })