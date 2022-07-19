import {Given} from "cypress-cucumber-preprocessor/steps";

Given('I should see a Control Center link labeled {string}', (link) => {
	cy.contains_cc_link(link)
})

