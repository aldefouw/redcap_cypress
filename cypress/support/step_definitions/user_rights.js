import {Given, defineParameterType} from "cypress-cucumber-preprocessor/steps";
/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I want to assign the {string} user right to the user named {string} with the username of {string} on project ID {int}
 * @param {string} rights - the specific user right desired (e.g. Stats & Charts)
 * @param {string} name - the proper name of the user (e.g. Jane Doe)
 * @param {string} username - the username assigned to the user (e.g. jdoe)
 * @param {int} pid - the project ID where the user rights should be assigned (e.g. 13)
 * @description Assigns a specific user right to a given user when provided a valid Project ID.
 *
 */
Given("I want to assign the {string} user right to the user named {string} with the username of {string} on project ID {int}", (rights_to_assign, proper_name, username, project_id) => {
    cy.assign_basic_user_right(username, proper_name, rights_to_assign, project_id)
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I want to remove the {string} user right to the user named {string} with the username of {string} on project ID {int}
 * @param {string} rights - the specific user right desired (e.g. Stats & Charts)
 * @param {string} name - the proper name of the user (e.g. Jane Doe)
 * @param {string} username - the username assigned to the user (e.g. jdoe)
 * @param {int} pid - the project ID where the user rights should be assigned (e.g. 13)
 * @description Removes a specific user right to a given user when provided a valid Project ID.
 *
 */
Given("I want to remove the {string} user right to the user named {string} with the username of {string} on project ID {int}", (rights_to_assign, proper_name, username, project_id) => {
    cy.remove_basic_user_right(username, proper_name, rights_to_assign, project_id)
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I assign an expiration date to user {string} with username of {string} on project ID {int}
 * @param {string} name - the proper name of the user (e.g. Jane Doe)
 * @param {string} username - the username assigned to the user (e.g. jdoe)
 * @param {int} pid - the project ID where the user rights should be assigned (e.g. 13)
 * @description Assigns 'Expiration Date' user right to a given user when provided a valid Project ID.
 *
 */
Given("I assign an expired expiration date to user {string} with username of {string} on project ID {int}", (proper_name, username, project_id) => {
    cy.assign_expiration_date_to_user(username, proper_name, project_id)
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I want to assign an expiration date to user {string} with username of {string} on project ID {int}
 * @param {string} name - the proper name of the user (e.g. Jane Doe)
 * @param {string} username - the username assigned to the user (e.g. jdoe)
 * @param {int} pid - the project ID where the user rights should be assigned (e.g. 13)
 * @description Removes 'Expiration Date' user right to a given user when provided a valid Project ID.
 *
 */
Given("I want to remove the expiration date to user {string} with username of {string} on project ID {int}", (proper_name, username, project_id) => {
    cy.remove_expiration_date_from_user(username, proper_name, project_id)
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I want to verify user rights are available for {string} user type on the path {string} on project ID {int}
 * @param {string} user_type - the type of user (e.g. 'standard' - reference "Users" object within cypress.env.json)
 * @param {string} path - the URL path we are testing to see if that user can access (e.g. /ProjectSetup/)
 * @param {int} pid - the project ID where the user rights should be assigned (e.g. 13)
 * @description Verifies a user is unable to access a specific path of a specific project given a Project ID.
 *
 */
Given("I want to verify user rights are available for {string} user type on the path {string} on project ID {int}", (user_type, path, pid) => {
    cy.verify_user_rights_available(user_type, path, pid)
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I want to verify user rights are unavailable for {string} user type on the path {string} on project ID {int}
 * @param {string} user_type - the type of user (e.g. 'standard' - reference "Users" object within cypress.env.json)
 * @param {string} path - the URL path we are testing to see if that user can access (e.g. /ProjectSetup/)
 * @param {int} pid - the project ID where the user rights should be assigned (e.g. 13)
 * @description Verifies a user is unable to access a specific path of a specific project given a Project ID.
 *
 */
Given("I want to verify user rights are unavailable for {string} user type on the path {string} on project ID {int}", (user_type, path, pid) => {
    cy.verify_user_rights_unavailable(user_type, path, pid, false)
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I want to assign the {string} user right to the user named {string} with the username of {string} on project ID {int}
 * @param {string} rights - the specific user right desired (e.g. Stats & Charts)
 * @param {string} name - the proper name of the user (e.g. Jane Doe)
 * @param {string} username - the username assigned to the user (e.g. jdoe)
 * @param {int} pid - the project ID where the user rights should be assigned (e.g. 13)
 * @description Assigns a specific user right to a given user when provided a valid Project ID.
 */
Given("I change survey edit rights for {string} user on the form called {string} on project ID {int}", (user, form, pid) => {
    cy.change_survey_edit_rights(pid, user, form)
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

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I select the user right identified by {string}
 * @param {string} text - name of user right
 * @description Assign user right to role/user
 *
 */
Given("I check the user right identified by {string}", (text) => {
    cy.get(text).should('be.visible').check()
})

/**
 * @module UserRights
 * @author Rushi Patel <rushi.patel@uhnresearch.ca>
 * @example I check the user right identified by {string} and check option {string}
 * @param {string} text - name of user right
 * @description Assign user right to role/user
 *
 */
Given("I check the user right identified by {string} and select option {string}", (text, option) => {
    cy.get(text).check(option)
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
    cy.get('.ui-button').contains(/add user|save changes/i).click()
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

defineParameterType({
    name: 'data_viewing_rights',
    regexp: /No Access|Read Only|View & Edit/
})

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I grant < No Access | Read Only | View & Edit > level of Data Entry Rights on the {string} instrument for the username {string}
 * @param {string} rights_level - the level of user rights to grant for the selected instrument
 * @param {string} username - username
 * @param {string} instrument - name of instrument to apply the rights to
 * @description Applies a given level of user rights to a specific instrument.  Note: Step assumes a user is not part of a Role.
 */
Given("I grant {data_viewing_rights} level of Data Entry Rights on the {string} instrument for the username {string} for project ID {int}", (rights_level, instrument, username, project_id) => {
    cy.assign_form_rights(project_id, username, instrument, rights_level)
})
