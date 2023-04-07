import {Given} from "cypress-cucumber-preprocessor/steps";
import escapeStringRegexp from 'escape-string-regexp'
import compareVersions from "compare-versions";
require('./parameter_types.js')

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I assign the {string} user right to the user named {string} with the username of {string} on project ID {int}
 * @param {string} rights - the specific user right desired (e.g. Stats & Charts)
 * @param {string} name - the proper name of the user (e.g. Jane Doe)
 * @param {string} username - the username assigned to the user (e.g. jdoe)
 * @param {int} pid - the project ID where the user rights should be assigned (e.g. 13)
 * @description Assigns a specific user right to a given user when provided a valid Project ID.
 *
 */

Given("I assign the {string} user right to the user named {string} with the username of {string}", (rights_to_assign, proper_name, username) => {
    cy.assign_basic_user_right(username, proper_name, rights_to_assign)
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I remove the {string} user right to the user named {string} with the username of {string} on project ID {int}
 * @param {string} rights - the specific user right desired (e.g. Stats & Charts)
 * @param {string} name - the proper name of the user (e.g. Jane Doe)
 * @param {string} username - the username assigned to the user (e.g. jdoe)
 * @description Removes a specific user right to a given user when provided a valid Project ID.
 *
 */
Given("I remove the {string} user right to the user named {string} with the username of {string}", (rights_to_assign, proper_name, username) => {
    cy.remove_basic_user_right(username, proper_name, rights_to_assign)
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I assign an expiration date to user {string} with username of {string} on project ID {int}
 * @param {string} name - the proper name of the user (e.g. Jane Doe)
 * @param {string} username - the username assigned to the user (e.g. jdoe)
 * @description Assigns 'Expiration Date' user right to a given user when provided a valid Project ID.
 *
 */
Given("I assign an expired expiration date to user {string} with username of {string}", (proper_name, username) => {
    cy.assign_expiration_date_to_user(username, proper_name)
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I assign an expired expiration date to user {string} with username of {string} on project ID {int}
 * @param {string} name - the proper name of the user (e.g. Jane Doe)
 * @param {string} username - the username assigned to the user (e.g. jdoe)
 * @description Removes 'Expiration Date' user right to a given user when provided a valid Project ID.
 *
 */
Given("I remove the expiration date to user {string} with username of {string}", (proper_name, username) => {
    cy.remove_expiration_date_from_user(username, proper_name)
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I verify user rights are available for {string} user type on the path {string} on project ID {int}
 * @param {string} user_type - the type of user (e.g. 'standard' - reference "Users" object within cypress.env.json)
 * @param {string} path - the URL path we are testing to see if that user can access (e.g. /ProjectSetup/)
 * @description Verifies a user is unable to access a specific path of a specific project given a Project ID.
 *
 */
Given("I verify user rights are available for {string} user type on the path {string}", (user_type, path, pid) => {
    cy.verify_user_rights_available(user_type, path)
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I verify user rights are unavailable for {string} user type on the path {string} on project ID {int}
 * @param {string} user_type - the type of user (e.g. 'standard' - reference "Users" object within cypress.env.json)
 * @param {string} path - the URL path we are testing to see if that user can access (e.g. /ProjectSetup/)
 * @param {int} pid - the project ID where the user rights should be assigned (e.g. 13)
 * @description Verifies a user is unable to access a specific path of a specific project given a Project ID.
 *
 */
Given("I verify user rights are unavailable for {string} user type on the path {string} on project ID {int}", (user_type, path, pid) => {
    cy.verify_user_rights_unavailable(user_type, path, pid, false)
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I change survey edit rights for {string} user on the form called {string} on project ID {int}
 * @param {string} user - the username
 * @param {string} instrument - name of instrument to apply the rights to
 * @param {int} pid - the project ID where the user rights should be assigned (e.g. 13)
 * @description Assigns a specific user right to a given user when provided a valid Project ID.
 */
Given("I change survey edit rights for {string} user on the form called {string} on project ID {int}", (user, instrument, pid) => {
    cy.change_survey_edit_rights(pid, user, instrument)
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I grant < No Access | Read Only | View & Edit > level of Data Entry Rights on the {string} instrument for the username {string} for project ID {int}
 * @param {string} rights_level - the level of user rights to grant for the selected instrument
 * @param {string} username - username
 * @param {string} instrument - name of instrument to apply the rights to
 * @param {int} pid - the project ID where the user rights should be assigned (e.g. 13)
 * @description Applies a given level of user rights to a specific instrument.  Note: Step assumes a user is not part of a Role.
 */
Given("I grant {data_viewing_rights} level of Data Entry Rights on the {string} instrument for the username {string} for project ID {int}", (rights_level, instrument, username, project_id) => {
    cy.assign_form_rights(project_id, username, instrument, rights_level)
})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I enter {string} into the rolename input field
 * @param {string} text - rolename
 * @description Enters a rolename
 *
 */
Given("I enter {string} into the rolename input field", (text) => {
    cy.get('input#new_rolename').should('be.visible').type(text)
})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I click on the button labeled {string} and I create role
 * @param {string} text - name of button
 * @description Click on the create role button and create role
 *
 */
Given("I click on the button labeled {string} and I create role", (text) => {
    cy.get('button').contains(text).click()
    cy.get('div#editUserPopup').should('be.visible').parent().find('button').contains("Create role").should('be.visible').click()
    cy.get('div.userSaveMsg').should('not.be.visible')
})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I click to edit role name {string}
 * @param {string} text - name of role
 * @description Edit role
 *
 */
Given("I click to edit role name {string}", (text) => {
    cy.get('a[title="Edit role privileges"]').contains(text).should('be.visible').click()
})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I click to edit username {string}
 * @param {string} text - username
 * @description Edit username
 *
 */
Given("I click to edit username {string}", (text) => {
    cy.get('a[title="Edit user privileges or assign to role"]').contains(text).should('be.visible').click()
})

const user_right_check_mappings = {
    'Project Setup & Design' : 'design',
    'User Rights' : 'user_rights',
    'Data Access Groups' : 'data_access_groups',
    'Stats & Charts' : 'graphical',
    'Create Records' : 'record_create',
    'Survey Distribution Tools' : 'participants',
    'Add/Edit/Organize Reports': 'reports',
    'Rename Records' : 'record_rename',
    'Delete Records' : 'record_delete',
    'Calendar' : 'calendar',
    'Data Import Tool'  : 'data_import_tool',
    'Data Comparison Tool' : 'data_comparison_tool',
    'Logging'  : 'data_logging',
    'File Repository' : 'file_repository',
    'Record Locking Customization' : 'lock_record_customize',
    'Lock/Unlock *Entire* Records' : 'lock_record_multiform',
    'Data Quality - Create & edit rules' : 'data_quality_design',
    'Data Quality - Execute rules' : 'data_quality_execute',
}

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I check the User Right named {string}
 * @param {string} text - name of User Right
 * @description Assign the user right
 *
 */
Given("I check the User Right named {string}", (text) => {
    cy.get('div[role=dialog]').should('be.visible')
    cy.get('input[name="' + user_right_check_mappings[text] + '"]').scrollIntoView().should('be.visible').check()
})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I uncheck the User Right named {string}
 * @param {string} text - name of User Right
 * @description Unassign the user right
 *
 */
Given("I uncheck the User Right named {string}", (text) => {
    cy.get('div[role=dialog]').should('be.visible')
    cy.get('input[name="' + user_right_check_mappings[text] + '"]').scrollIntoView().should('be.visible').uncheck()
})

const single_choice_mappings = {
    'Data Exports' : 'data_export_tool',
    'API' : 'data_access_groups',
    'Lock/Unlock Records' : 'lock_record'
}

//These apply to REDCap v12+
const data_export_mappings = {
    'No Access' : '0',
    'De-Identified' : '2',
    'Remove All Identifier Fields' : '3',
    'Full Data Set' : '1'
}

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I check the user right identified by {string} and check option {string}
 * @param {string} text - name of user right
 * @description Assign user right to role/user
 *
 */
Given("I select the User Right named {string} and choose {string}", (text, option) => {
    cy.get('div[role=dialog]').should('be.visible')

    //For REDCap v12 + we have per instrument data exports, so let's handle that case here
    if(text === "Data Exports" && compareVersions.compare(Cypress.env('redcap_version'), '12.0.0', '>=')){

        //TODO: Possibly generate a Step Definition that allows us to configure this on a per instrument basis
        //For now, we are going to select every form to have the same option
        cy.get(`input[type=radio][name*="export-form-"]`).then(($e) => {
            $e.each((i) => {
                if($e[i].value === data_export_mappings[option]) {
                    cy.wrap($e[i]).click()
                }
            })
        })

    } else {

        cy.get('input[name="' + single_choice_mappings[text] + '"]').
            parent().
            parent().
            within(() => {
                cy.get('div').
                contains(new RegExp(escapeStringRegexp(option))).
                find('input').
                scrollIntoView().
                should('be.visible').
                click()
            })

    }

})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I click the user right identified by {string}
 * @param {string} text - name of user right
 * @description select user right for role/user
 *
 */
Given("I click the user right identified by {string}", (text) => {
    cy.get(text).click()
})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example the user right identified by {string} should be checked
 * @param {string} text - name of user right
 * @description User right should be checked
 *
 */
Given("the user right identified by {string} should be checked", (text) => {
    cy.get(text).should('be.checked')
})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example the user right identified by {string} should not be checked
 * @param {string} text - name of user right
 * @description User right should not be checked
 *
 */
Given("the user right identified by {string} should not be checked", (text) => {
    cy.get(text).should('not.be.checked')
})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I delete role name {string}
 * @param {string} text - role name
 * @description Delete role
 *
 */
Given("I delete role name {string}", (text) => {
    cy.get('a[title="Edit role privileges"]').contains(text).should('be.visible').click().then(() => {
        cy.get('button').should(($button) => {
            expect($button).to.contain('Delete role')
        })
        cy.get('button').contains("Delete role").click({ force: true })
        cy.get('div[role="dialog"][aria-describedby!="editUserPopup"]').find('button').contains('Delete role').should('be.visible').click()
    })
})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I enter {string} into the username input field
 * @param {string} text - username of user to be added to the project
 * @description Add new user in the User Rights page
 */
Given("I enter {string} into the username input field", (text) => {
    cy.get('input#new_username').should('be.visible').type(text)
})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I save changes within the context of User Rights
 * @description Click on the create add user button and add user
 *
 */
Given("I save changes within the context of User Rights", () => {
    cy.intercept({  method: 'POST',
        url: '/redcap_v' + Cypress.env('redcap_version') + '/UserRights/edit_user.php?*'
    }).as('saved_user')

    cy.get('button').contains(/add user|save changes/i).click()

    cy.wait('@saved_user')

    if(Cypress.$('div#working').length) cy.get('div#working').should('not.be.visible')
})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I select the option to display E-signature option for the instrument identified by {string}
 * @param {string} text - Instrument name
 * @description Enable E-Signature option on instrument
 *
 */
Given("I select the option to display E-signature option for the instrument identified by {string}", (text) => {
    cy.get(text).closest('td').find('input').check()
})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I scroll the user rights page to the bottom
 * @description scroll user rights pop up page to the bottom
 */
Given('I scroll the user rights page to the bottom', () => {
    cy.get('input[name="api_import"]').scrollIntoView()
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I (add | remove) all basic user rights for the open User Rights dialog box
 * @description Checks or Unchecks all Basic Rights within the User Rights dialog box.
 */
Given('I {user_right_action} all Basic Rights within the open User Rights dialog box', (action) => {
    cy.get('div[role=dialog]').should('be.visible').then(() => {

        //"Full Access" to Data Export Tool - does NOT apply to v12+
        if(action === "add" && Cypress.$('input[name=data_export_tool]').length !== 0){
            cy.get('input[name=data_export_tool]').should('be.visible').check('1')

            //"No Access" to Data Export Tool - does NOT apply to v12+
        } else if (action === "remove" && Cypress.$('input[name=data_export_tool]').length !== 0){
            cy.get('input[name=data_export_tool]').should('be.visible').check('0')
        }

        for(var key in user_right_check_mappings) {
            const input = cy.get('input[name="' + user_right_check_mappings[key] + '"]').scrollIntoView().should('be.visible')

            if(action === "add"){
                input.check()
            } else if (action === "remove"){
                input.uncheck()
            }
        }

        cy.get('div[role=dialog]').should('be.visible')
    })

})

// Achieves same result as Adam's "I grant {data_viewing_rights} level of Data Entry Rights on the {string} instrument for the username {string} for project ID {int}"
// However, the old method uses a cy.visit which we are trying to move away from. This also eliminates unnecessary parameters,
// but requires that the user rights configuration dialog is open
/**
 * @module UserRights
 * @author Corey DeBacker <debacker@wisc.edu>
 * @example I set Data Viewing Rights to < No Access | Read Only | View & Edit > for the instrument {string}
 * @param {data_viewing_rights} level - the level of rights to be assigned
 * @param {string} instrument - the label of the instrument for which to configure data entry rights
 * @description Selects a radio option for Data Entry Rights for the specified instrument within the user rights configuration dialog.
 */
Given('I set Data Viewing Rights to {data_viewing_rights} for the instrument {string}', (level, instrument) => {
    cy.get('div[role=dialog]').should('be.visible')
    let selectors = {'No Access': 'input[value=0]', 'Read Only': 'input[value=2]', 'View & Edit': 'input[value=1]', 'Edit survey responses': 'input[type=checkbox]'}
    cy.get(`table#form_rights tr:has(td:contains(${instrument})) ${selectors[level]}`)
        .check()
})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I click on the button labeled Remove User
 * @description Clicks the button to remove user from the User Rights page
 */
Given('I click on the button labeled Remove User', () => {
    cy.get('div#editUserPopup').should('be.visible').parent().find('button').contains("Remove user").should('be.visible').click()
    cy.get('span').contains("Remove user?").should('be.visible').closest('div[role="dialog"]').find('button').contains("Remove user").click()
})
