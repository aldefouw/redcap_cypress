// CORE functionality helper commands are in here.
// If you are hoping to add a command for your specific instance this is NOT the place.
//
// For INSTANCE-SPECIFIC implementations, use one of these spots as appropriate:
//   /support/projects/commands.js
//   /support/hooks/commands.js
//   /suport/modules/commands.js
//   /support/plugins/commands.js

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

Cypress.Commands.add('contains_cc_link', (link, title = '') => {
  if(title === '') title = link
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

Cypress.Commands.add('select_field_by_label', (name, timeout = 10000) => {
  cy.contains('td', name, { timeout: timeout }).parent().parentsUntil('tr').last().parent().then(($tr) => {
    const name = $tr[0]['attributes']['sq_id']['value']
    cy.get('[name="' + name + '"]', { force: true }).then(($a) => {
      return $a[0]
    })
  })
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
    cy.get('textarea#field_label').clear().type(field_name).then(() => {
      cy.get('select#val_type').select(type).should('have.value', type).then(() => {
        cy.save_field()
        cy.find_online_designer_field(field_name)
      })
    })
  })
})

Cypress.Commands.add('check_column_sort_values', (col_name, element, values) => {
  abstractSort(col_name, element, values)
})

Cypress.Commands.add('check_column_sort_classes', (col_name, values) => {
  abstractSort(col_name, 'table#table-proj_table tr:first span', values, 1)
})

Cypress.Commands.add('visible_projects_user_input_click_view', (input, project_name, total_projects) => {
  abstractProjectView(input, project_name, total_projects, true)
})

Cypress.Commands.add('visible_projects_user_input', (input, project_name, total_projects) => {
  abstractProjectView(input, project_name, total_projects, false)
})

Cypress.Commands.add('select_record', (params) => {
  cy.get('a[href="/redcap_v' + Cypress.env('redcap_version') + '' + params + ']').click()
})

Cypress.Commands.add('get_project_table_row_col', (row = '1', col = '0') => {
  cy.get('table#table-proj_table tr:nth-child(' + row + ') td:nth-child(' + col + ')')
})

Cypress.Commands.add('require_redcap_stats', () => {
  cy.server()
  cy.route({method: 'POST', url: '**/ProjectGeneral/project_stats_ajax.php'}).as('project_stats_ajax')
  cy.wait('@project_stats_ajax').then((xhr, error) => { })
})