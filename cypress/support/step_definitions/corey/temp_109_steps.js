import {defineParameterType, Given} from "cypress-cucumber-preprocessor/steps";
require('../parameter_types.js')

// TODO: Move code into appropriate step/parameter definition files. Left as-is for easier code review.
// TODO: Add JSDoc comments to each step definition.

defineParameterType({
    name: 'clickable',
    regexp: /(link|button|checkbox|radio)/ //add more as needed
})

// Compare against the commented-out, less abstract step definitions at the end of the file. I think this is preferable.
Given('I click on the {ordinal}{clickable} near the text {string}', (n, type, text) => {
    let subsels = {link: 'a', button: 'button', checkbox: 'input[type=checkbox]', radio: 'input[type=radio]'}
    let subsel = subsels[type] + `:visible:nth(${n})` //'a:visible:nth(0)', 'button:visible:nth(2)', etc.
    let sel = `:contains(${text}):has(${subsel}):not(:has(:contains(${text}):has(${subsel})))`
    cy.get_top_layer(($el) => {expect($el.find(sel)).length.to.be.above(0)})
        .within(() => {
            cy.get(sel).within(() => {
                cy.get(subsel).click()
            })
        })
})

Given('I select {string} from the {ordinal}dropdown near the text {string}', (option, n, text) => {
    let subsel = `select:visible:nth(${n})`
    let sel = `:contains(${text}):has(${subsel}):not(:has(:contains(${text}):has(${subsel})))`
    cy.get_top_layer(($el) => {expect($el.find(sel)).length.to.be.above(0)})
        .within(() => {
            cy.get(sel).within(() => {
                cy.get(subsel).select(option)
            })
        })
})

// Known issue: Will not always correctly select the text's ancestor with at least n text input elements
// This is because with two subselectors (:text + textarea), the above approach using :has(el:nth(n)) won't work.
// In other words, ':has((:text,textarea):nth(n)' is not a valid selector, and ':has(:text:nth(n),textarea:nth(n))'
// would not count them as desired. We want :has(subsel:nth(n)) where 'subsel' matches the same as ':text,textarea'.
// Unfortunately, the :is() pseudo-class doesn't seem to be working here either: subsel = ':is(textarea,:text)'
// This is because it does not support pseudo-selectors in its argument
// This would probably need to be solved by using some JQuery rather than only using selectors. Very low priority.
Given('I enter {string} into the {ordinal}input field near the text {string}', (input, n, text) => {
    let subsel = `:text:visible,textarea:visible`
    let sel = `:contains(${text}):has(:text,textarea):not(:has(:contains(${text}):has(:text,textarea)))`
    cy.get_top_layer(($el) => {expect($el.find(sel)).length.to.be.above(0)})
        .within(() => {
            cy.get(sel).within(() => {
                cy.get(`:text:visible,textarea:visible`).eq(n).clear().type(input)
            })
        })
})

// defineParameterType({
//    name: 'trailingInt',
//    regexp: '(?:/\s*,\s*(\d+)\s*)?/',
//    transformer: parseInt
//})

// Given('I enter {string} into the field near the text {string}{trailingInt}{trailingInt}', (input, text, i, j) => {
//     // Enter `input` into the i'th input field near the j'th occurence of `text`
// })

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