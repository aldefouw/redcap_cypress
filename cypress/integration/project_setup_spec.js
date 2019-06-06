describe('Project Setup', () => {

    describe('Online Designer', () => {

         before(() => {
            cy.visit_v({page: 'Design/online_designer.php', params: 'page=my_first_instrument&pid=13'}).then(() => {
                cy.get('input#btn-last').click().then(() => {
                    cy.get('select#field_type').select('text');
                    cy.get('textarea#field_label').type('My First Field');
                    cy.initial_save_field()
                }) 
            })            
        })

        describe('Date & Time Fields', () => {

            it('Should allow me to add an dmy format Date field', () => {
                cy.add_field('My DMY Field', 'datetime_dmy')            
            })

            it('Should allow me to add an mdy format Date field', () => {
                 cy.add_field('My MDY Field', 'datetime_mdy')    
            })

            it('Should allow me to add an ymd format Date field', () => {
                cy.add_field('My YMD Field', 'datetime_ymd')    
            })

            it ('Should allow me to add a Time field', () => {
                cy.add_field('My Time Field', 'time')     
            })

        })

        describe('Special Input Fields', function (){

            it ('Should allow me to add an Email field', function(){
                cy.add_field('My Special Email Field', 'email')         
            })

            it ('Should allow me to add an Integer field', function(){
                cy.add_field('My Special Integer Field', 'integer')
            })

            it ('Should allow me to add a Number field', function(){
                cy.add_field('My Special Number Field', 'number')
            })

            it ('Should allow me to add a Phone field', function(){
                cy.add_field('My Special Phone Field', 'phone')
            })

            it ('Should allow me to add a Zipcode field', function(){
                cy.add_field('My Special Zipcode Field', 'zipcode')
            })

        })

        describe('Text Area Fields', function (){

            it ('Should allow me to add a Text Area field', function(){
                cy.add_field('My Special Text Area Field', '', 'textarea')
            })

        })


    })

    describe('Surveys', () => {

        it ('Should allow me to enable surveys on the project', () => {
            cy.visit_v( {page: 'ProjectSetup/index.php', params: 'pid=13'} )
            cy.contains("Main project settings")
            cy.contains('button', 'Enable').click()
            cy.contains('Manage Survey Participants')
        })

    })

})
