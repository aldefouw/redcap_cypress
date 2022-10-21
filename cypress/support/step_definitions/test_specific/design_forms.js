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

//TODO: refactor to custom cypress command
//Requires that the current page is the instrument editing page within the online designer
//Current implementation does not support matrix variables
Given('I should see that the choice {string} for the field {string} is coded as {string}', (choice_text, field_name, code) => {

    cy.get(`#${field_name}-tr`).within(() => {
        cy.get(`label:contains(${choice_text}), option:contains(${choice_text})`).then($e => {
            //filter matches for exact text match, in case one choice is a substring of another
            $e = $e.filter(function() {
                return (
                    cy.$$(this).text() === choice_text
                    && ! cy.$$(this).hasClass('fl')) //don't include field label
            })

            let foundCorrectCode = false
            
            if ($e.prop('tagName') === 'OPTION') {
                if ($e.attr('value') === code) {
                    foundCorrectCode = true
                }
            } else if ($e.prop('tagName') === 'LABEL') {
                let $i = $e.parent().find('input:visible')
                let type = $i.attr('type')
                if (type === 'checkbox') {
                    if ($i.attr('code') === code) {
                        foundCorrectCode = true
                    }
                } else if (type === 'radio') {
                    if ($i.attr('value') === code) {
                        foundCorrectCode = true
                    }
                }
            }

            expect(foundCorrectCode).to.be.true
        })
    })
})