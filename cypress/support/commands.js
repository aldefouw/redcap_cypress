//Here we are importing commands from the sub-folders that aren't quite as stable
import './core/commands'
import './hooks/commands'
import './modules/commands'
import './plugins/commands'
import './projects/commands'

import compareVersions from 'compare-versions';
import 'cypress-iframe';
import '@4tw/cypress-drag-drop'
const shell = require('shelljs')

// Commands in this file are CRUCIAL and are an embedded part of the REDCap Cypress Framework.
// They are very stable and do not change often, if ever

Cypress.Commands.add('login', (options) => {
    cy.clearCookies()
    
    cy.request({
        method: 'POST',
        url: '/', // baseUrl is prepended to url
        form: true, // indicates the body should be form urlencoded and sets Content-Type: application/x-www-form-urlencoded headers
        body: {
            'username': options['username'],
            'password': options['password'],
            'submitted': 1,
            'redcap_login_a38us_09i85':'SG1nx2MZGGeW6vnUwnkRz5j/vHgHwPUCcw8TFRBWLSZ9/XxMdP2uQMfwph/TbCpOkG2FtO9R25SL4YMyPAI4Bg=='
        }
    }).should(($a) => {
        expect($a.status).to.equal(200)
    })
})

Cypress.Commands.add('logout', () => {
    cy.visit('/redcap_v' + Cypress.env('redcap_version') + '/index.php?logout=1')
})

Cypress.Commands.add('visit_version', (options) => {

    let version = Cypress.env('redcap_version')

    cy.maintain_login().then(() => {
        if('params' in options){
            cy.visit('/redcap_v' + version + '/' + options['page'] +  '?' + options['params'])
        } else {
            cy.visit('/redcap_v' + version + '/' + options['page'])
        }
    })
})

Cypress.Commands.add('visit_base', (options) => {
    cy.maintain_login().then(() => {
        if ('url' in options) cy.visit(options['url']) 
    })
})

Cypress.Commands.add('base_db_seed', () => {    

    let redcap_source_path = Cypress.env('redcap_source_path')

    if(redcap_source_path === undefined){
        alert('redcap_source_path, which defines where your REDCap source code exists, is missing in cypress.env.json.  Please configure it before proceeding.')
    }

    cy.task('populateStructureAndData', {   
                                            redcap_version: Cypress.env('redcap_version'), 
                                            advanced_user_info: compareVersions.compare(Cypress.env('redcap_version'), '10.1.0', '>='), 
                                            source_location: redcap_source_path
                                        }).then((structure_and_data_file_exists) => {

        //Only run this block if the Structure and Data File exists and has gone through proper processes
        if(structure_and_data_file_exists){

            //Create the database if it doesn't exist
            cy.mysql_db('create_database', '', false).then(() => {

                //Pull in the structure and data from REDCap Source
                cy.mysql_db('structure_and_data', window.base_url).then(() => {

                    if(Cypress.env('redcap_hooks_path') !== undefined){
                        const redcap_hooks_path = "REDCAP_HOOKS_PATH/" + Cypress.env('redcap_hooks_path').replace(/\//g, "\\/");
                        cy.mysql_db('hooks_config', redcap_hooks_path) //Fetch the hooks SQL seed data
                    }

                    //Clear out all cookies
                    cy.clearCookies()
                })

            })          

        } else {
            alert('Warning: Error generating structure and data file.  This usually happpens because your REDCap source code is missing files.')
        }
     
    })
})

Cypress.Commands.add('maintain_login', () => {
    let user = window.user_info.get_current_user()
    let pass = window.user_info.get_current_pass()

    let user_type = window.user_info.get_user_type()
    let previous_user_type = window.user_info.get_previous_user_type()

    console.log('previous: ' + previous_user_type)
    console.log('current: ' + user_type)

    if(user_type === previous_user_type){
        cy.getCookies()
          .should((cookies) => {

            //In most cases, we'll have cookies to preserve to maintain a login
            if (cookies.length > 0){
                console.log('Cookie Login')
                cookies.map(cookie =>  Cypress.Cookies.preserveOnce(cookie['name']) )

            //But, if we don't, then let's simply re-login, right?
            } else {
                console.log('Regular Login')
                cy.login({ username: user, password: pass })
            }

        })

    //If user type has changed, let's clear cookies and login again
    } else {
        console.log('User Type Change to ' + user_type + '.')

        //Ensure we logout when a user changes
        cy.logout()
        cy.login({ username: user, password:  pass })
    }

    window.user_info.set_previous_user_type()
})

Cypress.Commands.add('set_user_type', (user_type) => {
    window.user_info.set_user_type(user_type)
    cy.maintain_login()
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

Cypress.Commands.add('select_radio_by_label', ($name, $value) => {   
    cy.set_field_value_by_label($name, $value, 'input', '', '___radio')
})

Cypress.Commands.add('select_value_by_label', ($name, $value) => {   
    cy.set_field_value_by_label($name, $value, 'select', '', '')
})

Cypress.Commands.add('select_checkbox_by_label', ($name, $value) => {
    cy.set_field_value_by_label($name, $value, 'input', '__chkn__', '')
})

Cypress.Commands.add('edit_field_by_label', (name, timeout = 10000) => {
    cy.find_online_designer_field(name).parent().parentsUntil('tr').find('img[title=Edit]').parent().click()
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
    cy.get('input#field_name').then(($f) => {
        cy.contains('button', 'Save').click()
    }) 
   
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


Cypress.Commands.add('upload_data_dictionary', (fixture_file, pid, date_format = "DMY") => {

    let admin_user = Cypress.env('users')['admin']['user']
    let current_token = null;

    cy.maintain_login().then(($r) => {

        cy.add_api_user_to_project(admin_user, pid).then(() => {

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
                                    '/ControlCenter/user_api_ajax.php?action=viewToken&api_username=test_admin&api_pid=' + pid}).then(($super_token) => {
                        
                        current_token = Cypress.$($super_token.body).children('div')[0].innerText

                        cy.fixture(`dictionaries/${fixture_file}`).then(data_dictionary => {

                                cy.request({
                                    method: 'POST',
                                    url: '/api/',
                                    headers: {
                                      "Accept":"application/json",
                                      "Content-Type": "application/x-www-form-urlencoded"
                                    },
                                    body: {
                                        token: current_token,
                                        content: 'metadata',
                                        format: 'csv',
                                        data: data_dictionary,
                                        returnFormat: 'json'
                                    },
                                    timeout: 50000

                                }).should(($a) => {                                    
                                    expect($a.status).to.equal(200)

                                    cy.request('/redcap_v' + Cypress.env('redcap_version') + '/Logging/index.php?pid=' + pid).should(($e) => {
                                        expect($e.body).to.contain('List of Data Changes')
                                        expect($e.body).to.contain('Manage/Design')
                                    })
                                })
                        })
                })
            })
        })        
    })

})

Cypress.Commands.add('create_cdisc_project', (project_name, project_type, cdisc_file, project_id) => {
    //Set the Desired Project ID
    const desired_pid = 'MAGIC_AUTO_NUMBER/' + project_id;
    cy.mysql_db('set_auto_increment_value', desired_pid)

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
    cy.visit_version({ page: 'UserRights/index.php', params: 'pid=' + pid}).then(() => {
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

Cypress.Commands.add('delete_project', (pid) => {
    cy.visit_version({ page: 'ProjectSetup/other_functionality.php', params: `pid=${pid}`})
    cy.get('button').contains('Delete the project').click()
    cy.get('input#delete_project_confirm').type('DELETE').then((input) => {
        cy.get(input).closest('div[role="dialog"]').find('button').contains('Delete the project').click()
        cy.get('button').contains('Yes, delete the project').click()
        cy.get('span#ui-id-3').closest('div[role="dialog"]').find('button').contains('Close').click({force: true})
    })
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
    cy.maintain_login().then(($r) => {
        cy.request({ url: `/redcap_v${Cypress.env('redcap_version')}/ControlCenter/user_api_ajax.php?action=viewToken&api_pid=${pid}&api_username=${user}`})
            .then(($token) => {
                return cy.wrap(Cypress.$($token.body).children('div')[0].innerText);
            })
    })
})

Cypress.Commands.add('import_data_file', (fixture_file, api_token) => {

    cy.fixture(`import_files/${fixture_file}`).then(import_data => {

        cy.request({
            method: 'POST',
            url: '/api/',
            headers: {
              "Accept":"application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: {
                token: api_token,
                content: 'record',
                format: 'csv',
                type: 'flat',
                data: import_data,
                returnFormat: 'json'
            },
            timeout: 50000
        }).should(($a) => {                                    
            expect($a.status).to.equal(200)
        })
        
    })
    
})



Cypress.Commands.add('assign_basic_user_right', (username, proper_name, rights_to_assign, project_id, assign_right = true, user_type = 'admin', selector = 'input', value = null) => {
    //Now login as admin and add Project Design and Setup Rights to Test User
    cy.set_user_type(user_type)

    cy.visit_version({page:'index.php', params: 'pid='+project_id})
    cy.get('html').should('contain', 'User Rights')

    cy.get('a').contains('User Rights').click()
    cy.get('a').contains(username + ' (' + proper_name + ')').click()
    cy.get('button').contains('Edit user privileges').click()

    cy.get('div').should(($div) => { expect($div).to.contain('Editing existing user') })

    if(rights_to_assign === "Expiration Date"){

        if(assign_right){
            cy.get('input.hasDatepicker').click()
            cy.get('a.ui-state-highlight').click()

            cy.get('input#expiration').should(($expiration) => {
                let date = new Date()
                let day = String(date.getDate()).padStart(2, "0");
                let month = String(date.getMonth()+1).padStart(2, "0");
                let year = date.getFullYear();
                let fullDate = `${month}/${day}/${year}`;

                expect($expiration).to.have.value(fullDate)
            })
        } else {
            cy.get('input.hasDatepicker').click().clear()

            cy.get('input#expiration').should(($expiration) => {
                expect($expiration).to.have.value("")
            })
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

    cy.get('button').contains('Save Changes').click()

    cy.get('body').should(($body) => {
        expect($body).to.contain('User "' + username + '" was successfully edited')
    })

    //Should not be visible before we start our next test
    cy.get('div').contains('User "' + username + '" was successfully edited').should('not.be.visible')
})

Cypress.Commands.add('remove_basic_user_right', (username, proper_name, rights_to_assign, project_id, user_type = 'admin', selector = 'input', value = null) => {
    cy.assign_basic_user_right(username, proper_name, rights_to_assign, project_id, false, user_type, selector, value)
})

Cypress.Commands.add('assign_expiration_date_to_user', (username, proper_name, project_id) => {
    cy.assign_basic_user_right(username, proper_name, "Expiration Date", project_id, true)
})

Cypress.Commands.add('remove_expiration_date_from_user', (username, proper_name, project_id) => {
    cy.assign_basic_user_right(username, proper_name, "Expiration Date", project_id, false)
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

Cypress.Commands.add('read_directory', (dir) => {
    cy.task('readDirectory', (dir)).then((files) => {
        return files
    })
})


//
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