import {defineParameterType, Given} from "cypress-cucumber-preprocessor/steps";
import { ordinal_to_int } from '../../core/commands'

// TODO: Move code into appropriate step/parameter definition files. Left as-is for easier code review.
// TODO: Add JSDoc comments to each step definition.

defineParameterType({
    name: 'clickable',
    regexp: /(link|button|checkbox|radio)/ //add more as needed
})

defineParameterType({
    name: 'ordinal',
    regexp: /(?:(first|second|third|fourth|fifth|sixth|seventh|eighth|last) )?/,
    transformer: ordinal_to_int
})

// Compare against the commented-out, less abstract step definitions at the end of the file. I think this is preferable.
Given('I click on the {ordinal}{clickable} near the text {string}', (n, type, text) => {
    let subsels = {link: 'a', button: 'button', checkbox: 'input[type=checkbox]', radio: 'input[type=radio]'}
    let subsel = subsels[type]
    let sel = `:contains(${text}):has(${subsel}):not(:has(:contains(${text}):has(${subsel})))`
    cy.get_top_layer(($el) => {expect($el.find(sel)).length.to.be.above(0)})
        .within(() => {
            cy.get(sel).within(() => {
                cy.get(`${subsel}:nth(${n})`).click()
            })
        })
})

Given('I select {string} from the {ordinal}dropdown nearest the text {string}', (option, n, text) => {
    let sel = `:contains(${text}):has(select):not(:has(:contains(${text}):has(select)))`
    cy.get_top_layer(($el) => {expect($el.find(sel)).length.to.be.above(0)})
        .within(() => {
            cy.get(sel).within(() => {
                cy.get(`select:nth(${n})`).select(option)
            })
        })
})

// Given(/^I click on the(?: (first|second|third|fourth|fifth|sixth|seventh|eighth|last))? link near the text "(.*)"/, (n, text) => {
//     n = ordinal_to_int(n)
//     let sel = `:contains(${text}):has(a):not(:has(:contains(${text}):has(a)))`
//     cy.get_top_layer(($el) => {expect($el.find(sel)).length.to.be.above(0)})
//         .within(() => {
//             cy.get(sel).within(() => {
//                 cy.get(`a:nth(${n})`).click()
//             })
//         })
// })

// Given(/^I click on the(?: (first|second|third|fourth|fifth|sixth|seventh|eighth|last))? button near the text "(.*)"/, (n, text) => {
//     n = ordinal_to_int(n)
//     let sel = `:contains(${text}):has(button):not(:has(:contains(${text}):has(button)))`
//     cy.get_top_layer(($el) => {expect($el.find(sel)).length.to.be.above(0)})
//         .within(() => {
//             cy.get(sel).within(() => {
//                 cy.get(`button:nth(${n})`).click()
//             })
//         })
// })

// Given(/^I click on the(?: (first|second|third|fourth|fifth|sixth|seventh|eighth|last))? checkbox near the text "(.*)"/, (n, text) => {
//     n = ordinal_to_int(n)
//     let sel = `:contains(${text}):has(input[type=checkbox]):not(:has(:contains(${text}):has(input[type=checkbox])))`
//     cy.get_top_layer(($el) => {expect($el.find(sel)).length.to.be.above(0)})
//         .within(() => {
//             cy.get(sel).within(() => {
//                 cy.get(`input[type=checkbox]:nth(${n})`).click()
//             })
//         })
// })