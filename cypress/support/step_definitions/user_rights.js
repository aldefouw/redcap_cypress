import {Given} from "cypress-cucumber-preprocessor/steps";

Given("I want to assign the {string} user right to the user named {string} with the username of {string} on project ID {int}", (rights_to_assign, proper_name, username, project_id) => {
    cy.assign_basic_user_right(username, proper_name, rights_to_assign, project_id)
})

Given("I want to remove the {string} user right to the user named {string} with the username of {string} on project ID {int}", (rights_to_assign, proper_name, username, project_id) => {
    cy.remove_basic_user_right(username, proper_name, rights_to_assign, project_id)
})

Given("I want to assign an expiration date to user {string} with username of {string} on project ID {int}", (proper_name, username, project_id) => {
    cy.assign_expiration_date_to_user(username, proper_name, project_id)
})

Given("I want to remove the  expiration date to user {string} with username of {string} on project ID {int}", (username, proper_name, project_id) => {
    cy.remove_expiration_date_from_user(username, proper_name, project_id)
})

Given("I want to verify user rights are available for {string} user type on the path {string} on project ID {int}", (user_type, path, pid) => {
    cy.verify_user_rights_available(user_type, path, pid)
})

Given("I want to verify user rights are unavailable for {string} user type on the path {string} on project ID {int}", (user_type, path, pid) => {
    cy.verify_user_rights_unavailable(user_type, path, pid, true)
})