// ***********************************************
// This example commands.js shows you how to
// create various custom commands and overwrite
// existing commands.
//
// For more comprehensive examples of custom
// commands please read more here:
// https://on.cypress.io/custom-commands
// ***********************************************
//
//
// -- This is a parent command --

Cypress.Commands.add("login", (options) => {
    cy.request({
        method: 'POST',
        url: '/', // baseUrl is prepended to url
        form: true, // indicates the body should be form urlencoded and sets Content-Type: application/x-www-form-urlencoded headers
        body: {
            'username': options['username'],
            'password': options['password'],
            'submitted': 1,
            'redcap_login_a38us_09i85':'redcap_login_a38us_09i85'
        }
    }).should(($a) => {
        expect($a.status).to.equal(200)
    })
})

Cypress.Commands.add("visit_v", (options) => {
    const users = Cypress.env("users");
    const admin_user = users['admin']['user'];
    const admin_pass = users['admin']['pass'];

    cy.maintain_login(admin_user, admin_pass).then(() => {

        const redcap_version = Cypress.env("redcap_version")
    
        if('params' in options){
            cy.visit('/redcap_v' + redcap_version + '/' + options['page'] + '?' + options['params'])
        } else {
            cy.visit('/redcap_v' + redcap_version + '/' + options['page'])
        }

    })
   
})

Cypress.Commands.add("maintain_login", (user, pass) => {

    cy.getCookies()
      .should((cookies) => {

        //In most cases, we'll have cookies to preserve to maintain a login
        if (cookies.length > 0){

            cookies.map(cookie =>  Cypress.Cookies.preserveOnce(cookie['name']) )

        //But, if we don't, then let's simply re-login, right?    
        } else {     

            cy.login({ username: user, password:  pass })
            cy.visit('/')
        }        
        
    })    
})

Cypress.Commands.add("mysql_db", (type, replace = '') => {
    const mysql = Cypress.env("mysql")

    const cmd = 'sh test_db/db.sh' +
        ' ' + mysql['path'] +
        ' ' + mysql['host'] +
        ' ' + mysql['port'] +
        ' ' + mysql['db_name'] +
        ' ' + mysql['db_user'] +
        ' ' + mysql['db_pass'] +
        ' ' + type +
        ' ' + replace

    cy.exec(cmd).then((response) => {
        console.log(response)
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

Cypress.Commands.add("contains_cc_link", (link, title = '') => {
   cy.visit_v({page: "ControlCenter/index.php"}).then(() => {
        if(title == '') title = link
        let t = Cypress.$("div#control_center_menu a:contains(" + JSON.stringify(link) + ")");
        t.length ? test_link(link, title) : test_link(link.split(' ')[0], title.split(' ')[0])
    })
})

Cypress.Commands.add("find_online_designer_field", (name, timeout = 10000) => {
     cy.contains('td', name, { timeout: timeout })
})

Cypress.Commands.add("initial_save_field", () => {
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

Cypress.Commands.add("save_field", () => {
    cy.get('input#field_name').then(($f) => {
        cy.contains('button', 'Save').click()
    }) 
   
})

Cypress.Commands.add("add_field", (field_name, type) => {
     cy.get('input#btn-last').click().then(() => {
        cy.get('textarea#field_label').clear().type(field_name)
        cy.get('select#val_type').select(type)
        cy.save_field()
        cy.find_online_designer_field(field_name)
    })
})

Cypress.Commands.add("require_redcap_stats", () => {
    cy.server()
    cy.route('POST', '**/ProjectGeneral/project_stats_ajax.php').as('stats')
    cy.wait('@stats').then((xhr) => { })
})

function abstractSort(col_name, element, values, klass = 0){
    const sortCompare1 = sorterCompare(col_name, element, values[0], klass)
    const sortCompare2 = sorterCompare(col_name, element, values[1], klass)
    sortCompare1.then(() => { sortCompare2 })
}

function sorterCompare(col_name, element, values, klass){
    return cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
        cy.get('th div').contains(col_name).click().then(()=>{
            cy.get(element).then(($e) => {
                cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
                    klass ? expect($e).to.have.class(values) : expect($e).to.contain(values)       
                })                                
            })
        })
    })
}

Cypress.Commands.add("check_column_sort_values", (col_name, element, values) => {
    abstractSort(col_name, element, values)
})

Cypress.Commands.add("check_column_sort_classes", (col_name, values) => {
    abstractSort(col_name, 'table#table-proj_table tr:first span', values, 1)
})

function abstractProjectView(input, project_name, total_projects, dropdown_click){
    cy.get('input#user_search').clear()

    cy.get('input#user_search').type(input).then(() => {   

        let $t = dropdown_click ? cy.get('button#user_search_btn') : cy.get('ul#ui-id-1 li a')

        $t.click().then(($a) => {
            cy.get('table#table-proj_table tr span').should('not.contain', "Loading").then(() => {
                 cy.get('table#table-proj_table tr:first div.projtitle').then(($a) => {
                    expect($a).to.contain(project_name)
                    cy.get('table#table-proj_table').find('tr:visible').should('have.length', total_projects)
                })
            })
        })
    })
}

Cypress.Commands.add("visible_projects_user_input_click_view", (input, project_name, total_projects) => {
    abstractProjectView(input, project_name, total_projects, true)
})

Cypress.Commands.add("visible_projects_user_input", (input, project_name, total_projects) => {
    abstractProjectView(input, project_name, total_projects, false)
})





//
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
