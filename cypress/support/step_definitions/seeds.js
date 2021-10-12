import { Given } from "cypress-cucumber-preprocessor/steps";

Given("the {string} folder seed {string} has been run", (folder, filename) => {
    cy.mysql_db(folder + '/' + filename)
})

