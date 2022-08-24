import { Given } from "cypress-cucumber-preprocessor/steps";

//Instead of using verify_user_rights_available from commands.js, which only works for paths
//ending in index.php, uses a path dictionary.
//Step could be modified to require URL params (entered as empty string in case of none)
//for more fluid autocompletion and to allow for params other than pid
Given(/^I should be able to access the "(.*)" page(?: for PID (\d+))?$/, (page_name, pid) => {
    function expand(obj) {
        var keys = Object.keys(obj);
        for (var i = 0; i < keys.length; ++i) {
            var key = keys[i],
                subkeys = key.split(/,\s?/),
                target = obj[key];
            delete obj[key];
            subkeys.forEach(function(key) { obj[key] = target; })
        }
        return obj;
    }
    
    let paths = expand({
        'designer,design,online designer' : 'Design/online_designer.php',
        'browse users' : 'ControlCenter/view_users.php'
    })

    if(pid !== undefined) {
        cy.visit_version({page: paths[page_name.toLowerCase()], params: "pid=" + pid})
        
    } else {
        cy.visit_version({page: paths[page_name.toLowerCase()]})
    }
    cy.get('html').then(($html) => { expect($html).to.not.contain("ACCESS DENIED") })
})

Given("I click on the element identified by {string}", (sel) => {
    cy.get(sel).should('be.visible').click()
})

Given("I enter {string} into the field identified by {string}", (text, sel) => {
    cy.get(sel).clear().type(text)
})