describe('Project Setup', () => {

    const users = Cypress.env("users");

    const standard_user = users['standard']['user'];
    const standard_pass = users['standard']['pass'];

    const admin_user = users['admin']['user'];
    const admin_pass = users['admin']['pass'];

    beforeEach(() => {

    });

    describe('Test of Administrative Function', () => {

        beforeEach(() => {
            cy.login( { username: admin_user, password: admin_pass } );
        });

    });

    describe('Online Designer', () => {

        beforeEach(function() {
            cy.login( { username: standard_user, password: standard_pass } );
            cy.visit_v( {page: 'Design/online_designer.php', params: 'page=my_first_instrument&pid=13'} );
            cy.get('input#btn-last').click();
        });

        describe('Date & Time Fields', () => {

            beforeEach(() => {
                cy.get('select#field_type').select('text');
                cy.get('textarea#field_label').type('My Date Field');
                cy.contains('button', 'Save').click();
                cy.contains('Alert');
                cy.get('button[title=Close]:last').click();
                cy.get('input#auto_variable_naming').click();
                cy.contains('button', 'Enable auto naming').click();
            });

            it('Should allow me to add an dmy format Date field', () => {
                cy.get('select#val_type').select('date_dmy');
                cy.contains('button', 'Save').click();
                cy.contains('My Date Field');
            });

            it('Should allow me to add an mdy format Date field', () => {
                cy.get('select#val_type').select('date_mdy');
                cy.contains('button', 'Save').click();
                cy.contains('My Date Field');
            });

            it('Should allow me to add an ymd format Date field', () => {
                cy.get('select#val_type').select('date_ymd');
                cy.contains('button', 'Save').click();
                cy.contains('My Date Field');
            });

            it('Should allow me to add an dmy format Datetime field', () => {
                cy.get('select#val_type').select('datetime_dmy');
                cy.contains('button', 'Save').click();
                cy.contains('My Date Field');
            });

            it('Should allow me to add an mdy format Datetime field', () => {
                cy.get('select#val_type').select('datetime_mdy');
                cy.contains('button', 'Save').click();
                cy.contains('My Date Field');
            });

            it('Should allow me to add an ymd format Datetime field', () => {
                cy.get('select#val_type').select('datetime_ymd');
                cy.contains('button', 'Save').click();
                cy.contains('My Date Field');
            });

            it ('Should allow me to add a Time field', function(){
                cy.get('select#val_type').select('time');
                cy.contains('button', 'Save').click();
                cy.contains('My Date Field');
            })

        });

        describe('Special Input Fields', function (){

            beforeEach(() => {
                cy.get('select#field_type').select('text');
                cy.get('textarea#field_label').type('My Special Field');
                cy.contains('button', 'Save').click();
                cy.contains('Alert');
                cy.get('button[title=Close]:last').click();
                cy.get('input#auto_variable_naming').click();
                cy.contains('button', 'Enable auto naming').click();
            });

            it ('Should allow me to add an Email field', function(){
                cy.get('select#val_type').select('email');
                cy.contains('button', 'Save').click();
                cy.contains('My Special Field');
            });

            it ('Should allow me to add an Integer field', function(){
                cy.get('select#val_type').select('integer');
                cy.contains('button', 'Save').click();
                cy.contains('My Special Field');
            });

            it ('Should allow me to add a Number field', function(){
                cy.get('select#val_type').select('number');
                cy.contains('button', 'Save').click();
                cy.contains('My Special Field');
            });

            it ('Should allow me to add a Phone field', function(){
                cy.get('select#val_type').select('phone');
                cy.contains('button', 'Save').click();
                cy.contains('My Special Field');
            });

            it ('Should allow me to add a Zipcode field', function(){
                cy.get('select#val_type').select('zipcode');
                cy.contains('button', 'Save').click();
                cy.contains('My Special Field');
            })

        });

        describe('Text Area Fields', function (){
            it ('Should allow me to add a Text Area field', function(){
                cy.get('select#field_type').select('textarea');
                cy.get('textarea#field_label').type('My First Text Area');
            })
        })


    });

    describe('Surveys', () => {
        beforeEach(() => {
            cy.login( { username: standard_user, password: standard_pass } );
            cy.visit_v( {page: 'ProjectSetup/index.php', params: 'pid=13'} )
        });

        it ('Should allow me to enable surveys on the project', () => {
            cy.contains("Main project settings");
            cy.contains('button', 'Enable').click();
            cy.contains('Manage Survey Participants');
        });

    });

});