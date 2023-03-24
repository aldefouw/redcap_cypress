//#############################################################################
//# Commands       A B C D E F G H I J K L M N O P Q R S T U V W X Y Z        #
//#############################################################################

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

Cypress.Commands.add('import_data_file', (fixture_file,pid) => {
    let admin_user = Cypress.env('users')['admin']['user']
    let current_token = null;

    let current_user_type = window.user_info.get_previous_user_type()
    if(current_user_type !== 'admin'){
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

        if(current_user_type !== 'admin'){
            cy.set_user_type(current_user_type)
            cy.fetch_login()
        }
    })
})

Cypress.Commands.add('read_directory', (dir) => {
    cy.task('readDirectory', (dir)).then((files) => {
        return files
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

Cypress.Commands.add('upload_file', (fileName, fileType = ' ', selector = '', button_label, nearest_text = '') => {
    let label_selector = `:has(${selector}):visible`
    let upload_selector = 'input[type=file]:visible'
    let upload_element = ''
    if(nearest_text.length > 0) label_selector = `:contains("${nearest_text}"):has(${upload_selector}):visible`

    cy.top_layer(label_selector).within(() => {
        if(nearest_text.length > 0) {
            upload_element = cy.get_labeled_element(upload_selector, nearest_text).first()
        } else {
            upload_element = cy.get(selector)
        }

        upload_element.then(subject => {
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
})