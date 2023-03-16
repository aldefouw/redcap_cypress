//#############################################################################
//# Commands       A B C D E F G H I J K L M N O P Q R S T U V W X Y Z        #
//#############################################################################

Cypress.Commands.add("click_on_dialog_button", (text, selector = 'button') => {
    cy.get('div[role="dialog"]').then((divs) => {
        // can be multiple layers of dialogs, find the top most - tintin edit
        let topDiv = null
        for(let i = 0; i < divs.length; i++){
            // ignore invisible dialogs
            if(divs[i].style.display === 'none') {continue}

            if(topDiv == null || divs[i].style.zIndex > topDiv.style.zIndex){
                topDiv = divs[i]
            }
        }
        cy.wrap(topDiv).find(selector).contains(text).click()
    })
})

Cypress.Commands.add("verify_text_on_dialog", (text) => {
    cy.get('div[role="dialog"]:visible').should('contain', text)
})