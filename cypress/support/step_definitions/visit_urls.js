import { Given } from "cypress-cucumber-preprocessor/steps";

Given(/^I visit the "(.*)"(?: with parameter string of "(.*)")?$/, (base_folder, params) => {
    if(params !== undefined){
        cy.visit_version({page: base_folder.split(" ").join("") + "/index.php?", params: params})
    } else {
        cy.visit_version({page: base_folder.split(" ").join("") + "/index.php"})
    }
})
