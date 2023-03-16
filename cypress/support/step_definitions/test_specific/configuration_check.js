import {Given} from "cypress-cucumber-preprocessor/steps";

/**
 * @module ConfigurationCheck
 * @author Adam De Fouw <aldefouw@medicine.wisc.edu>
 * @example I should be able to locate and visit the Control Center link labeled {string} and see the title {string}
 * @param {string} link_label - the name of the link label in the Control Center panel
 * @param {string} title - the title of the page visited (optional)
 * @description Verifies a Control Center link is visible and visitable.
 */
Given(/^I should be able to locate and visit the Control Center link labeled "(.*)"(?: and see the title "(.*)")?$/, (link_label, title) => {
	if(title !== undefined){
		cy.contains_cc_link(link_label, title)
	} else {
		cy.contains_cc_link(link_label)
	}
})