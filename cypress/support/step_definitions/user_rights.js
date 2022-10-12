import {Given} from "cypress-cucumber-preprocessor/steps";

/**
 * @module UserRights
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example 
  I want to assign the {string} user right to the user named {string} with the username of {string} on project ID {int}
 * @param {string} rights - the specific user right desired (e.g. Stats & Charts)
 * @param {string} name - the proper name of the user (e.g. Jane Doe)
 * @param {string} username - the username assigned to the user (e.g. jdoe)
 * @param {int} pid - the project ID where the user rights should be assigned (e.g. 13)
 * @description Assigns a specific user right to a given user when provided a valid Project ID.
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
 * @example I want to assign an expiration date to user {string} with username of {string} on project ID {int}
 * @param {string} name - the proper name of the user (e.g. Jane Doe)
 * @param {string} username - the username assigned to the user (e.g. jdoe)
 * @param {int} pid - the project ID where the user rights should be assigned (e.g. 13)
 * @description Assigns 'Expiration Date' user right to a given user when provided a valid Project ID.
 *
 */
Given("I want to assign an expiration date to user {string} with username of {string} on project ID {int}", (proper_name, username, project_id) => {
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
<<<<<<< HEAD
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
 * @example I add a new user named {string} to the project
 * @param {string} text - username of user to be added to the project
 * @description Add new user in the User Rights page
 */
 Given("I add a new user named {string} to the project", (text) => {
    cy.add_users_to_project([STANDARD2], PID)
    cy.visit_version({page: 'UserRights/index.php', params: `pid=${PID}`})
    cy.get(`a.userLinkInTable[userid="${STANDARD2}"]`).should('be.visible').click()
=======
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example
 I want to assign the {string} user right to the user named {string} with the username of {string} on project ID {int}
 * @param {string} rights - the specific user right desired (e.g. Stats & Charts)
 * @param {string} name - the proper name of the user (e.g. Jane Doe)
 * @param {string} username - the username assigned to the user (e.g. jdoe)
 * @param {int} pid - the project ID where the user rights should be assigned (e.g. 13)
 * @description Assigns a specific user right to a given user when provided a valid Project ID.
 */
Given("I change survey edit rights for {string} user on the form called {string} on project ID {int}", (user, form, pid) => {
    cy.change_survey_edit_rights(pid, user, form)
>>>>>>> upstream/v11.1.5
})