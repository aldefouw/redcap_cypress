//Here we are importing commands from the sub-folders that aren't quite as stable
import './core/commands'
import './hooks/commands'
import './modules/commands'
import './plugins/commands'
import './projects/commands'

import compareVersions from 'compare-versions';
import 'cypress-iframe';
import '@4tw/cypress-drag-drop'

// Commands in this file are CRUCIAL and are an embedded part of the REDCap Cypress Framework.
// They are very stable and do not change often, if ever


// -- This is a child command --
// Cypress.Commands.add("drag", { prevSubject: 'element'}, (subject, options) => { ... })
//
//
// -- This is a dual command --
// Cypress.Commands.add("dismiss", { prevSubject: 'optional'}, (subject, options) => { ... })
//
//
// -- This is will overwrite an existing command --
// Cypress.Commands.overwrite("visit", (originalFn, url, options) => { ... })