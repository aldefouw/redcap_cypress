import {defineParameterType, Given} from "cypress-cucumber-preprocessor/steps";

/**
 * @module ControlCenter
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I enable the Field Validation Type named {string} within the Control Center
 * @param {string} field_validation_type - the label of the Field Validation type
 * @description Enables a specific Field Validation Type (for all projects) within the Control Center
 */
Given('I enable the Field Validation Type named {string} within the Control Center', (field_validation_type) => {
    cy.toggle_field_validation_type(field_validation_type)
})

/**
 * @module ControlCenter
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I disable the Field Validation Type named {string} within the Control Center
 * @param {string} field_validation_type - the label of the Field Validation type
 * @description Disables a specific Field Validation Type (for all projects) within the Control Center
 */
Given('I disable the Field Validation Type named {string} within the Control Center', (field_validation_type) => {
    cy.toggle_field_validation_type(field_validation_type, 'Disable')
})