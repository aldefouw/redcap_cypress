require('./commands/api.js')
require('./commands/auth.js')
require('./commands/control_center.js')
require('./commands/data_import.js')
require('./commands/db.js')
require('./commands/dialog.js')
require('./commands/instruments.js')
require('./commands/longitudinal_events.js')
require('./commands/online_designer.js')
require('./commands/projects.js')
require('./commands/reports.js')
require('./commands/survey.js')
require('./commands/user_interface.js')
require('./commands/user_rights.js')
require('./commands/visit_urls.js')

// CORE functionality helper commands are in here.
// If you are hoping to add a command for your specific instance this is NOT the place.
//
// For INSTANCE-SPECIFIC implementations, use one of these spots as appropriate:
//   /support/projects/commands.js
//   /support/hooks/commands.js
//   /suport/modules/commands.js
//   /support/plugins/commands.js



Cypress.Commands.add("top_layer", (label_selector, base_element = 'div[role=dialog][style*=z-index]:visible,html') => {
    cy.get_top_layer(($el) => {
        expect($el.find(label_selector)).length.to.be.above(0)}
    , base_element).then((el) => { return el })
})

Cypress.Commands.add("get_labeled_element", (element_selector, label, value = null) => {
    cy.contains(label).then(($label) => {
        cy.get_element_by_label($label, element_selector, value)
    })
})

Cypress.Commands.add('filter_elements', (elements, selector, value) => {
    if(elements.find(`${selector}`).length > 1){

        let elms = elements.find(`${selector}`).filter(function() {
            if (value !== null && Cypress.$(this).children('option').length > 0){
                let ret_value = false

                if(Cypress.$(this).children('option').length > 1){
                    Cypress.$(this).children('option').each((num, elem) => {
                        console.log(elem)
                        console.log(elem.innerText === value)
                        if(elem.innerText === value) ret_value = true
                    })
                } else {
                    ret_value = true
                }

                return ret_value
            } else {
                return true
            }
        })

        if (elms.length >= 1){
            return elms.first()
        } else {
            return elements.find(`${selector}`).first()
        }

    } else {
        return elements.find(`${selector}`).first()
    }
})


Cypress.Commands.add('get_element_by_label', (label, selector = null, value = null, original_selector = null, i = 0) => {
    if (original_selector === null) { original_selector = selector }

    cy.wrap(label).then(($self) => {
        if(i === 0 && $self.find(selector).length){
            return cy.filter_elements($self, selector, value)
        } else if (i === 0 && $self.parent().find(selector).length){
            return cy.filter_elements($self.parent(), selector, value)
        } else {
            cy.wrap(label).parentsUntil(`:has(${selector})`).last().parent().then(($parent) => {
                if($parent.find(selector).length){
                    return cy.filter_elements($parent, selector, value)
                } else if (i <= 5) {
                    cy.get_element_by_label(label, `:has(${selector})`, value, original_selector, i + 1)
                }
            })
        }
    })
})

//Provide a robust way for this to find either a button or input button that contains this text
Cypress.Commands.add('button_or_input', (text_label) => {
    cy.get(':button').then(($button) => {
        $button.each(($i) => {
            if($button[$i].value === text_label){
                return cy.wrap($button[$i])
            } else if ($button[$i].innerText === text_label){
                return cy.wrap($button[$i])
            }
        })
    })
})

//yields the visible div with the highest z-index, or the <html> if none are found
Cypress.Commands.add('get_top_layer', (retryUntil, element = 'div[role=dialog][style*=z-index]:visible,html') => {
    let top_layer
    cy.get(element).should($els => {
        //if more than body found, find element with highest z-index
        if ($els.length > 1) {
            //remove html from $els so only elements with z-index remain
            $els = $els.filter(':not(html)')
            //sort by z-index (ascending)
            $els.sort((cur, prev) => {
                let zp = Cypress.dom.wrap(prev).css('z-index')
                let zc = Cypress.dom.wrap(cur).css('z-index')
                return zc - zp
                //return zp - zc
            })
        }

        top_layer = $els.last()
        retryUntil(top_layer) //run assertions, so get can retry on failure
    }).then(() => cy.wrap(top_layer)) //yield top_layer to any further chained commands
})

Cypress.Commands.add('ensure_csrf_token', () => {
    cy.url().then(($url) => {
        if($url !== undefined && $url !== 'about:blank'){

            //If this is a form but NOT the LOGIN form
            if(Cypress.$('form').length > 0 && Cypress.$('#redcap_login_a38us_09i85').length === 0){
                cy.getCookies()
                    .should('have.length.greaterThan', 0)
                    .then(($cookies) => {

                        $cookies.forEach(($cookie) => {
                            //If our cookies include PHPSESSID, we can assume we're logged into REDCap
                            //If they do NOT include PHPSESSID, we shouldn't have to worry about this token
                            //It also appears that the Report Forms DO not need a CSRF token, which is interesting ...
                            if($cookie['name'] === 'PHPSESSID' && Cypress.$('form#create_report_form').length === 0){
                                cy.get('form input[name=redcap_csrf_token]').each(($form_token) => {
                                    cy.window().then((win) => {
                                        expect($form_token[0].value).to.not.be.null
                                    })
                                })

                                // === DETACHMENT PREVENTION === //
                                //Some common elements to tell us things are still loading!
                                if(Cypress.$('span#progress_save').length) cy.get('span#progress_save').should('not.be.visible')
                                if(Cypress.$('div#progress').length) cy.get('div#progress').should('not.be.visible')
                                if(Cypress.$('div#working').length) cy.get('div#working').should('not.be.visible')
                            }
                        })
                    })

            }
        }
    })
})

Cypress.Commands.overwrite(
    'click',
    (originalFn, subject, options) => {

        //If we say no CSRF check, then skip it ...
        if(options !== undefined && options['no_csrf_check']){
            delete(options['no_csrf_check'])
            return originalFn(subject, options)

            //For all other cases, check for CSRF token
        } else {
            if(options === undefined) options = {} //If no options object exists, create it
            options['no_csrf_check'] = true //Add the "no_csrf_check" to get back to the original click method!

            //console.log(subject)

            if(subject[0].nodeName === "A" ||
                subject[0].nodeName === "BUTTON" ||
                subject[0].nodeName === "INPUT" && subject[0].type === "button" && subject[0].onclick === ""
            ){

                //Is the element part of a form?
                if(subject[0].form){
                    cy.ensure_csrf_token() //Check for the CSRF token to be set in the form
                }

                //If our other detachment prevention measures failed, let's check to see if it detached and deal with it
                cy.wrap(subject).then($el => {
                    return Cypress.dom.isDetached($el) ? Cypress.$($el): $el
                }).click(options)

            } else {
                return originalFn(subject, options)
            }
        }
    }
)








