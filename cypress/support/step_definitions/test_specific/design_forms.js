import {Given} from "cypress-cucumber-preprocessor/steps";

Given('I download the data dictionary', () => {
	//cy.get('[onclick="downloadDD(0,0);"')//.invoke('downloadDD', 0, 0)
	//cy.window().invoke('downloadDD', 0, 0)
	//cy.visit_version(de)
	//Design/data_dictionary_download.php?pid='+pid+'&delimiter='+delimiter

	cy.window().document().then(function (doc) {
		doc.addEventListener('click', () => {
		  setTimeout(function () { doc.location.reload() }, 5000)
		})
		
		/* Make sure the file exists */
		cy.intercept('/', (req) => {
		  req.reply((res) => {

			expect(res.statusCode).to.equal(201);
			cy.log(res)
			var a = 0
			var b = 1/a

		  });
		}).as('dataDict');
	  
		cy.get('[onclick="downloadDD(0,0);"]').click()

		// cy.wait('@dataDict').then((interception) => {
		// 	cy.log(interception.response)
		// })
	  })
})

