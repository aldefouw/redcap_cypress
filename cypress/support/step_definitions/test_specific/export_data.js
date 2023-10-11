/**
 * @module export_data
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I enable the Data Collection Instrument labeled {string} as survey
 * @param {string} label the name of the survey
 * @description Enable the survey
 */
Given('I enable the Data Collection Instrument labeled {string} as survey', (label) => {
    cy.get('table[id=table-forms_surveys]').contains('td', label).parents('tr').find('button').contains('Enable').click().then(() => {
        cy.get('button').contains('Save Changes').click()
    })  
})

/**
 * @module export_data
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I open the survey from Survey options and submit it
 * @param {string} label the name of the survey
 * @description Open the survey from Survey Options and submit it
 */
Given('I open the survey from Survey options and submit it', () => {
    let newurl = ''
    let pid = ''
    //cy.wrap(newurl).as('newurl')
    cy.window().then((win) => {     
        cy.stub(win,'surveyOpen').callsFake(url => {
            newurl = url
            pid = win.pid
            // return win.open.wrappedMethod.call(win, url, '_self')
            cy.visit(url)
            // return win.location.href = url
            // cy.wrap(newurl).as('newurl')
            
        }).as('surveyOpen')
      })

    cy.get('a').contains('Open survey').click()
    cy.get('@surveyOpen').should('be.called')
   
            
    
    // cy.get("@newurl").then(newurl => {
        // cy.visit(newurl)
    // })

    // cy.visit(newurl)
    
    // cy.visit_version({page: '/DataEntry/record_status_dashboard.php', params: 'pid=' + pid})

    // cy.get('div').contains('Public Survey URL').parent().find('input').then(($input) => {
    //     return $input[0].value
    // }).then(($url) => {
    //     //Make sure we aren't logged in
    //     cy.logout()

    //     //Now we can visit the URL as an external user
    //     cy.visit_base({ url: $url })
    // })
})

/**
 * @module export_data
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should have a {string} file that contains the data {string} for record ID {string} and fieldname {string}
 * @param {string} format the text format of the data export you are looking to receive
 * @param {string} data the data to verify
 * @param {string} recordId The Record ID of the record
 * @param {string} fieldName the fieldname that contains data
 * @description Verifies the data present in a field for a given record
 */
Given("I should have a {string} file that contains the data {string} for record ID {string} and fieldname {string}", (format, data, recordId, fieldName) => {
    cy.readFile("cypress/downloads" + '/test_file.' + format).then( ($text) => {
        let lines = $text.trim().split('\n')
        let columnNum = -1
        let dataCount = 0
        let columns = lines[0].trim().split(',')
        for(let i = 0; i < columns.length; i++) {
            if(columns[i] == fieldName)
                columnNum = i
        }
        
        for(let i = 1; i < lines.length; i++){
            let columns = lines[i].trim().split(',')
            if(columns[0] == recordId) {
                if(columns[columnNum] == data) {
                   dataCount++
                }
            }       
        }
        expect(dataCount).to.not.equal(0)
    })
})

/**
 * @module export_data
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should have a {string} file that contains today's date for the fieldname {string} for record ID {string}
 * @param {string} format the text format of the data export you are looking to receive
 * @param {string} fieldName the fieldname that contains data
 * @param {string} recordId The Record ID of the record
 * @description Verifies today's date is present in a field for a given record
 */
Given("I should have a {string} file that contains today's date for the fieldname {string} for record ID {string}", (format, fieldName, recordId) => {
    cy.readFile("cypress/downloads" + '/test_file.' + format).then( ($text) => {
        let lines = $text.trim().split('\n')
        let columnNum = -1
        let dataCount = 0
        let today = new Date()
        var dd = String(today.getDate()).padStart(2, '0')
        var mm = String(today.getMonth() + 1).padStart(2, '0')
        var yyyy = today.getFullYear()

        today = yyyy + '-' + mm + '-' + dd
    
        let header = lines[0].trim().split(',')
        for(let i = 0; i < header.length; i++) {
            if(header[i] == fieldName)
                columnNum = i
        }
        
        for(let i = 1; i < lines.length; i++){
            let columns = lines[i].trim().split(',')
            if(columns[0] == recordId) {
                if(columns[columnNum]) {               
                    if(columns[columnNum].substr(1,10) == today) {
                        dataCount++
                    }
                }
            }       
        }
        
        expect(dataCount).to.not.equal(0)
    })
})

/**
 * @module export_data
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should have a {string} file that contains data in {string} listed on {int} row(s)
 * @param {string} format the text format of the data export you are looking to receive
 * @param {string} fieldname Field name which contains data
 * @param {string} num the number of rows that contain the record ID
 * @description Verifies data is listed in a given field name for the given number of rows
 */
Given("I should have a {string} file that contains data in field {string} listed on {int} row(s)", (format, fieldname, num) => {
    cy.readFile("cypress/downloads" + '/test_file.' + format).then( ($text) => {
        let lines = $text.trim().split('\n')
        let recCount = 0
        let colNum = -1

        let header = lines[0].trim().split(',')
        for(let i = 0; i < header.length; i++){
            if(header[i] == fieldname){
                colNum = i
            }
        }

        for(let i = 1; i < lines.length; i++){
            let columns = lines[i].trim().split(',')
            if(columns[colNum]) {
                recCount++
            }       
        }
        expect(recCount).to.equal(num)
    })
})

/**
 * @module export_data
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should have a {string} file that contains record ID {string} listed on {int} row(s)
 * @param {string} format the text format of the data export you are looking to receive
 * @param {string} recordId The Record ID of the record
 * @param {string} num the number of rows that contain the record ID
 * @description Verifies the record ID is listed in the given number of rows
 */
Given("I should have a {string} file that contains record ID {string} listed on {int} row(s)", (format, recordId, num) => {
    cy.readFile("cypress/downloads" + '/test_file.' + format).then( ($text) => {
        let lines = $text.trim().split('\n')
        let recCount = 0
        for(let i = 1; i < lines.length; i++){
            let columns = lines[i].trim().split(',')
            if(columns[0] == recordId) {
                recCount++
            }       
        }
        expect(recCount).to.equal(num)
    })
})

/**
 * @module export_data
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should have a {string} file that contains {int} repeating instance(s) of the event {string} for record ID {string}
 * @param {string} format the text format of the data export you are looking to receive
 * @param {string} num the number of repeating instances of the event
 * @param {string} eventName the event name that repeats
 * @param {string} recordId The Record ID of the record
 * @description Verifies the event repeats a given number of times in a record
 */
Given("I should have a {string} file that contains {int} repeating instance(s) of the event {string} for record ID {string}", (format, num, eventName, recordId) => {
    cy.readFile("cypress/downloads" + '/test_file.' + format).then( ($text) => {
        let lines = $text.trim().split('\n')
        let recCount = 0
        for(let i = 1; i < lines.length; i++){
            let columns = lines[i].trim().split(',')
            if(columns[0] == recordId && columns[1] == eventName) {
                recCount++
            }       
        }
        expect(recCount).to.equal(num)
    })  
})

/**
 * @module export_data
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I select the option {string} from the list of {fieldLabel} in the custom selection option
 * @param {string} option the option to select
 * @param {string} label the string which is either Events or Instruments
 * @description Selects the given option from Events or Instruments in Custom Selection of Export Data
 */
defineParameterType({
    name: 'fieldLabel',
    regexp: /(Events|Instruments)/
})

Given("I select the option {string} from the list of {fieldLabel} in the custom selection option", (option, label) => {
    let selectId = ""
    if(label == "Events")
        selectId = "export_selected_events"
    else 
        selectId = "export_selected_instruments"
    
    cy.get('select[id=' + selectId + ']').select(option)
})

/**
 * @module export_data
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should have a {string} file that contains hashed record ID of length 32
 * @param {string} format the text format of the data export you are looking to receive
 * @description Verifies the file has hashed Record ID of length 32
 */
Given("I should have a {string} file that contains hashed record ID of length 32", (format) => {
    cy.readFile("cypress/downloads" + '/test_file.' + format).then( ($text) => {
        let lines = $text.trim().split('\n')
        let recCount = 0
        for(let i = 1; i < lines.length; i++){
            let columns = lines[i].trim().split(',')
            if(columns[0].length != 32) {
                recCount++
            }       
        }
        expect(recCount).to.equal(0)
    })  
})

/**
 * @module export_data
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should have a {string} file that does not contain the fieldname {string}
 * @param {string} format the text format of the data export you are looking to receive
 * @param {string} fieldName the fieldname to check
 * @description Verifies the fieldname is not present in the file
 */
Given("I should have a {string} file that does not contain the fieldname {string}", (format, fieldName) => {

    cy.readFile("cypress/downloads" + '/test_file.' + format).then( ($text) => {
        let lines = $text.trim().split('\n')
        let headings = lines[0].trim().split(',')
        let fieldCount = 0
        for(let i = 0; i < headings.length; i++){
            if(headings[i] == fieldName)
                fieldCount++
        }
        expect(fieldCount).to.equal(0)
    })

})

/**
 * @module export_data
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should have a {string} file that does not contain the data {string} for record ID {string} and fieldname {string}
 * @param {string} format the text format of the data export you are looking to receive
 * @param {string} data the data to verify
 * @param {string} recordId The Record ID of the record
 * @param {string} fieldName the fieldname that contains data
 * @description Verifies the data is not present in a field for a given record
 */
Given("I should have a {string} file that does not contain the data {string} for record ID {string} and fieldname {string}", (format, data, recordId, fieldName) => {
    cy.readFile("cypress/downloads" + '/test_file.' + format).then( ($text) => {
        let lines = $text.trim().split('\n')
        let columnNum = -1
        let dataCount = 0

        let columns = lines[0].trim().split(',')
        for(let i = 0; i < columns.length; i++) {
            if(columns[i] == fieldName)
                columnNum = i
        }
        
        for(let i = 1; i < lines.length; i++){
            let columns = lines[i].trim().split(',')
            if(columns[0] == recordId) {
                if(columns[columnNum] == data) {
                   dataCount++
                }
            }       
        }

        expect(dataCount).to.equal(0)
    })
})

/**
 * @module export_data
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should have a {string} file that contains today's date for the fieldname {string} for record ID {string}
 * @param {string} format the text format of the data export you are looking to receive
 * @param {string} fieldName the fieldname that contains data
 * @param {string} recordId The Record ID of the record
 * @description Verifies today's date is not present in a field for a given record
 */
Given("I should have a {string} file that does not contain today's date for the fieldname {string} for record ID {string}", (format, fieldName, recordId) => {
    cy.readFile("cypress/downloads" + '/test_file.' + format).then( ($text) => {
        let lines = $text.trim().split('\n')
        let columnNum = -1
        let dataCount = 0
        let today = new Date()
        var dd = String(today.getDate()).padStart(2, '0')
        var mm = String(today.getMonth() + 1).padStart(2, '0')
        var yyyy = today.getFullYear()

        today = yyyy + '-' + mm + '-' + dd
    
        let header = lines[0].trim().split(',')
        for(let i = 0; i < header.length; i++) {
            if(header[i] == fieldName)
                columnNum = i
        }
        
        for(let i = 1; i < lines.length; i++){
            let columns = lines[i].trim().split(',')
            if(columns[0] == recordId) {
                if(columns[columnNum]) {               
                    if(columns[columnNum].substr(1,10) == today) {
                        dataCount++
                    }
                }
            }       
        }
        
        expect(dataCount).to.equal(0)
    })
})


/**
 * @module export_data
 * @author Mintoo Xavier <min2xavier@gmail.com>
 * @example I should NOT see the button labeled {string}
 * @param {string} label the label on button
 * @description Visually verifies the button does not exist
 */
Given("I should NOT see a button labeled {string}", (label) => {
    cy.get('button').contains(label).should('not.exist')
})
