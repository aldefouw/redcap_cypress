import { Given } from "cypress-cucumber-preprocessor/steps";

/**
 * @module DesignFormsTests
 * @author Corey DeBacker <debacker@wisc.edu>
 * @description Asserts that 'Text Box', 'Notes Box', 'Calculated Field', 'Multiple Choice - Drop-down', 
 * 'Multiple Choice - Radio', 'Checkboxes', 'Signature', 'File Upload', 'Descriptive Text', and 'Begin New Section' 
 * are all available choices in the field type dropdown when adding a new field to an instrument.
 */
Given('The field types specified in step 20 of script 07 should be available',  () => {
    let options = [
        'Text Box', 'Notes Box', 'Calculated Field', 'Multiple Choice - Drop-down', 'Multiple Choice - Radio',
        'Checkboxes', 'Signature', 'File Upload', 'Descriptive Text', 'Begin New Section'
    ]
    cy.get('select#field_type').should(($select) => {
        options.forEach((option) => {
            expect($select).to.contain(option)
        })
    })
})