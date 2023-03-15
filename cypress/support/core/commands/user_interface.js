//#############################################################################
//# Commands       A B C D E F G H I J K L M N O P Q R S T U V W X Y Z        #
//#############################################################################

Cypress.Commands.add("dragTo", { prevSubject: 'element'}, (subject, target) => {
    let rect = cy.get(target).then((element) => {
        let rect = element[0].getBoundingClientRect()
        return rect
    })
    //click on element
    cy.wrap(subject).trigger('mousedown')

    //move mouse to new position
    cy.get(target).trigger('mousemove', 'bottom')
        .trigger('mousemove', 'center')

    // target position changed, mouseup on original element
    cy.wrap(subject).trigger('mouseup')

})