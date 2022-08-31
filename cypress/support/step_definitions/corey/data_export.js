import {Given} from "cypress-cucumber-preprocessor/steps";
/**
 * @module DataExport
 * @example I download the data dictionary for PID {int}
 * @param {string} pid - the Project ID for which you want to download the Data Dictionary
 * @description Download the Data Dictionary of a specific project identified by a Project ID.
 */
Given(/^I download the data dictionary(?: for PID (\d+))?$/, (pid) => {
	cy.download_data_dictionary(pid)
})