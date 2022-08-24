import { Given } from "cypress-cucumber-preprocessor/steps";

Given(/^I visit the "(.*)" page(?: with parameter string of "(.*)")?$/, (page_name, param_string = "") => {
    //Allows for easier entry of page aliases
    function expand(obj) {
        var keys = Object.keys(obj);
        for (var i = 0; i < keys.length; ++i) {
            var key = keys[i],
                subkeys = key.split(/\s*,\s*/),
                target = obj[key];
            delete obj[key];
            subkeys.forEach(function(key) { obj[key] = target; })
        }
        return obj;
    }
    
    //Define aliases for common pages not directly accessible via other step defs
    let paths = expand({
        'designer, design, online designer' : 'Design/online_designer.php',
        'browse users' : 'ControlCenter/view_users.php',
        'validation setup, validation type setup, field validation' : 'ControlCenter/validation_type_setup.php'
    })
    
    cy.visit_version({page: paths[page_name.toLowerCase()], params: '?' + param_string})
    
})