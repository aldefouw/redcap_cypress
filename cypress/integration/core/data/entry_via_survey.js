describe('Data Entry through the Survey Feature', () => {

	before(() => {
		cy.set_user_type('admin')
		cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=9'})
	})

	it('Should have the ability to directly enter data through a survey', () => {
		//EXTERNAL
		let survey_url = null;
		cy.visit_version({page: 'Surveys/invite_participants.php', params: 'pid=9'}).then(() => {
			//Get the URL of the survey
			cy.get('input#longurl').then((field) => {
				survey_url = field.val()
			})
			console.log(survey_url)
			cy.visit(survey_url)
			cy.get('tr#email-tr').within(($t) => {
				cy.get('input').type('user1@yahoo.com')
			})
			cy.get('button#submit-btn-saverecord').first().click()
		})
		/*
		cy.get('a').contains('Add / Edit Records').click()
		cy.get('button').contains('Add new record').click()
		cy.get('table#event_grid_table').should(($t) => {
			expect($t).to.contain('Survey')
		})
		cy.get('table#event_grid_table').within(($t) => {
			cy.get('a').first().click()
		})
		cy.get('tr#email-tr').within(($t) => {
			cy.get('input').type('user1@yahoo.com')
		})
		cy.get('button#submit-btn-saverecord').first().click()
		*/
	})

	it('Should have the ability to delete all survey-related information and functions without impacting saved data', () => {
		//WITHIN
	})

	describe('User Interface - Survey Distribution', () => {
		it('Should have the ability to automatically create a participant list using a designated email field when a survey is not in the first instrument position', () => {
			//WITHIN
			cy.visit_version({page: 'Surveys/invite_participants.php', params: 'pid=9'})
			cy.get('a').contains('Participant List').click()
			cy.get('table').should(($t) => {
				expect($t).to.contain('Email')
			})
		})

		it('Should have the ability for a survey to be generated from within a participant record using Log Out + Open Survey', () => {
			//WITHIN
			cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=9'})
			cy.get('a').contains('Add / Edit Records').click()
			cy.get('button').contains('Add new record').click()
			cy.get('table#event_grid_table').within(($t) => {
				cy.get('a').first().click()
			})
			cy.get('button#submit-btn-saverecord').click()
			cy.visit_version({page: 'DataEntry/record_home.php', params: 'pid=9'})
			cy.get('select#record').select('1')
			cy.get('table#event_grid_table').within(($t) => {
				cy.get('a').first().click()
			})
			cy.get('button#SurveyActionDropDown').click()
			cy.get('ul#SurveyActionDropDownUl').should(($u) => {
				expect($u).to.contain('Log out')
			})

		})

		it('Should have the ability for a survey to be generated from within a participant record using Open Survey link', () => {
			//WITHIN
			cy.get('ul#SurveyActionDropDownUl').should(($u) => {
				expect($u).to.contain('Open survey')
			})
		})

		it('Should have the ability to prompt the user to leave the survey to avoid overwriting survey responses when opening surveys from a data entry form when using Open Survey link', () => {
			//WITHIN
			cy.get('a#surveyoption-openSurvey').first().click().then(() => {
				cy.get('div#popup6113115080932355').should(($d) => {
					expect($d).to.contain('overwrite any existing survey responses')
				})
			})


		})

		it('Should have the ability to creation of a participant list manually where each survey is assigned a unique survey link when the survey is in the first instrument position', () => {
			//WITHIN
			cy.get('ul#SurveyActionDropDownUl').should(($u) => {
				expect($u).to.contain('Compose survey invitation')
			})
		})
	})

	describe('User Interface', () => {
		before(() => {
			/*
			cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=9'})
			cy.get('a').contains('Add / Edit Records').click()
			cy.get('button').contains('Add new record').click()
			cy.get('table#event_grid_table').within(($t) => {
				cy.get('a').first().click()
			})
			*/
		})

		it('Should have the ability for a participant to enter data in a data collection instrument enabled and distributed as a survey', () => {
			//WITHIN
			let survey_url = null;
			cy.visit_version({page: 'Surveys/invite_participants.php', params: 'pid=9'}).then(() => {
				//Get the URL of the survey
				cy.get('input#longurl').then((field) => {
					survey_url = field.val()
				})
				cy.visit(survey_url).then(()=> {
					cy.get('table#questiontable').should('not.be.empty')
				})
			})
		})


		it('Should have the ability to support Incomplete surveys status', () => {
			//WITHIN
			let survey_url = null;
			cy.visit_version({page: 'Surveys/invite_participants.php', params: 'pid=9'}).then(() => {
				//Get the URL of the survey
				cy.get('input#longurl').then((field) => {
					survey_url = field.val()
				})
				cy.visit(survey_url).then(()=> {
					cy.get('select').should(($s) => {
						expect($s).to.contain('Incomplete')
					})
				})
			})

		})

		it('Should have the ability to support Partial Survey Response status', () => {
			//WITHIN
			let survey_url = null;
			cy.visit_version({page: 'Surveys/invite_participants.php', params: 'pid=9'}).then(() => {
				//Get the URL of the survey
				cy.get('input#longurl').then((field) => {
					survey_url = field.val()
				})
				cy.visit(survey_url).then(()=> {
					cy.get('select').should(($s) => {
						expect($s).to.contain('Unverified')
					})
				})
			})
		})

		it('Should have the ability to support Completed Survey Response status', () => {
			//WITHIN
			let survey_url = null;
			cy.visit_version({page: 'Surveys/invite_participants.php', params: 'pid=9'}).then(() => {
				//Get the URL of the survey
				cy.get('input#longurl').then((field) => {
					survey_url = field.val()
				})
				cy.visit(survey_url).then(()=> {
					cy.get('select').should(($s) => {
						expect($s).to.contain('Complete')
					})
				})
			})

		})

		it('Should have the ability to submitted survey responses to be changed by a user who has edit survey responses rights', () => {
			cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=9'})
			cy.visit_version({page: 'DataEntry/record_home.php', params: 'pid=9'})
			cy.get('select#record').select('1')
			cy.get('table#event_grid_table').within(($t) => {
				cy.get('a').first().click()
			})
			cy.get('tr#email-tr').within(($t) => {
				cy.get('input').clear()
				cy.get('input').type('user2@yahoo.com')
			})
			cy.get('button#submit-btn-saverecord').first().click()
		})

	})

	describe('Control Center', () => {

		before(() => {
			cy.set_user_type('admin')
			//cy.visit_base({url: 'ControlCenter/index.php'})
		})

		it('Should have the ability for the survey feature to be enabled or disabled', () => {
			cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=9'})
			cy.get('div').contains('Use surveys').parent().within(($d) => {
				expect($d).to.contain('Disable')
			})
		})

		it('Should have the ability for "Edit Survey Responses" feature to be enabled or disabled', () => {
			cy.visit_version({page: 'ControlCenter/user_settings.php'})
			cy.get('td').contains('edit survey responses?').parent().within(($td) => {
				expect($td).to.contain('Disable')
			})
		})
	})
})