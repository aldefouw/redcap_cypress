describe('Data Entry through the Survey Feature', () => {

	before(() => {
		cy.set_user_type('admin')
	})

	it('Should have the ability to directly enter data through a survey', () => {
		cy.visit_version({page: 'index.php', params: 'pid=9'})
		cy.get('a').contains('Survey Distribution Tools').click()
		cy.get('div').contains('Public Survey URL').parent().find('input').then(($input) => {
			cy.visit_base({ url: $input[0].value }).then(() => {

				cy.get('tr#email-tr').within(($t) => {
					cy.get('input').type('user1@yahoo.com')
				})

				cy.get('button').contains('Submit').click().then(() => {
					cy.get('html').then(($html) => {
						expect($html).to.contain('Thank you for taking the survey.')
					})
				})
			})
		})
	})

	it('Should have the ability to delete all survey-related information and functions without impacting saved data', () => {
		cy.intercept({
			method: 'POST',
			url: '/redcap_v' + Cypress.env('redcap_version') + '/ProjectSetup/modify_project_setting_ajax.php?pid=9'
		}).as('projectSettings')

		//Verify that there is data already collected in this project
		cy.visit_version({page: 'DataEntry/index.php', params: 'pid=9&id=1&page=prescreening_survey&event_id=31&instance=1'})
		cy.get('td').contains('E-mail address').parentsUntil('tr').last().parent().find('input').should('have.value', 'user1@yahoo.com')

		//Visit the Project Setup page and Disable Survey usage
		cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=9'})

		cy.get('div').contains('Use surveys in this project?').parent().within(($div) => {
			cy.get('button').contains('Disable').click()
		}).then(() => {
			cy.get('div').contains('Disable the usage of surveys in this project?').should('be.visible').parent().parent().within(() => {
				cy.get('button').contains('Disable').click()
			})
		})

		//Wait to make sure that the AJAX request has completed before we move onto checking data
		cy.wait('@projectSettings')

		//Verify that the data already collected is still in project after we disabled the survey
		cy.visit_version({page: 'DataEntry/index.php', params: 'pid=9&id=1&page=prescreening_survey&event_id=31&instance=1'})
		cy.get('td').contains('E-mail address').parentsUntil('tr').last().parent().find('input').should('have.value', 'user1@yahoo.com')

		//Re-enable surveys before proceeding
		cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=9'})

		cy.get('div').contains('Use surveys in this project?').parent().within(($div) => {
			cy.get('button').contains('Enable').click()
		})

		//Wait to make sure that the AJAX request has completed before we move onto next test
		cy.wait('@projectSettings')
	})

	describe('User Interface - Survey Distribution', () => {

		it('Should have the ability to automatically create a participant list using a designated email field when a survey is not in the first instrument position', () => {
			cy.visit_version({page: 'Surveys/invite_participants.php', params: 'pid=9'})
			cy.get('a').contains('Participant List').click()
			cy.get('table').should(($t) => {
				expect($t).to.contain('Email')
			})
		})

		it('Should have the ability for a survey to be generated from within a participant record using Log Out + Open Survey', () => {
			cy.visit_version({page: 'ProjectSetup/index.php', params: 'pid=9'})
			cy.get('a').contains('Add / Edit Records').click()
			cy.get('button').contains('Add new record').click()

			cy.get('td').contains('Pre-Screening Survey').parent().find('a').click()

			cy.get('button').contains('Save & Exit Form').click()

			cy.get('td').contains('Pre-Screening Survey').parent().find('a').click()

			//Click the dropdown menu
			cy.get('button').contains('Survey options').click()

			//Stub the surveyOpen method to prevent the blank window from opening
			cy.window().then(win => {
				cy.stub(win, 'surveyOpen').callsFake((url, target) => {
					// call the original `win.surveyOpen` method
					// but pass the `_self` argument
					return win.open.wrappedMethod.call(win, url, '_self')
				}).as('open')
			})

			//This will be the best match we can find within the drop down
			cy.get('ul li').contains('Log out').then(($li) => {

				//Click the link
				cy.wrap($li[0]).click()

				//Get the survey link
				let onclick = Cypress.$($li[0]).prop('onclick').toString();
				let survey = onclick.split("surveyOpen('");
				let survey_link = survey[1].split("'")[0];

				//Check to see if the window would have opened
				cy.get('@open').should('have.been.calledOnceWithExactly', survey_link, 0)
			})
		})

		it('Should have the ability for a survey to be generated from within a participant record using Open Survey link', () => {
			cy.get('button').contains('Survey options').click()

			//Stub the surveyOpen method to prevent the blank window from opening
			cy.window().then(win => {
				cy.stub(win, 'surveyOpen').callsFake((url, target) => {
					// call the original `win.surveyOpen` method
					// but pass the `_self` argument
					return win.open.wrappedMethod.call(win, url, '_self')
				}).as('open')
			})

			//This will be the best match we can find within the drop down
			cy.get('ul li').contains('Open survey').then(($li) => {

				//Click the link
				cy.wrap($li[0]).click()

				//Get the survey link
				let onclick = Cypress.$($li[0]).prop('onclick').toString();
				let survey = onclick.split("surveyOpen('");
				let survey_link = survey[1].split("'")[0];

				//Check to see if the window would have opened
				cy.get('@open').should('have.been.calledOnceWithExactly', survey_link, 0)
			})
		})

		it('Should have the ability to prompt the user to leave the survey to avoid overwriting survey responses when opening surveys from a data entry form when using Open Survey link', () => {
			cy.get('button').contains('Survey options').click()

			//This will be the best match we can find within the drop down
			cy.get('ul li').contains('Open survey').then(($li) => {

				//Click the link
				cy.wrap($li[0]).click()
			})

			//This is the pop and it should allow us to either Leave or Stay
			cy.get('[id^=popup]').parent().within(() => {
				cy.get('button').should('contain', 'Leave')
				cy.get('button').should('contain', 'Stay')
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

			//Add a REQUIRED field

			//Visit Longitudinal Database
			cy.visit_version({page: 'Design/online_designer.php', params: "pid=9"})

			//Search for the Enter Draft Mode button
			let draft = cy.get('input[value="Enter Draft Mode"]').should(($draft_mode) => {
				if($draft_mode.length > 0){
					$draft_mode.first().click()
				}

				return $draft_mode;
			})

			if(draft.length > 0 ){
				cy.get('div#actionMsg').should(($alert) => {
					expect($alert).to.contain('The project is now in Draft Mode.')
				})
			}

			//Visit the demographics instrument
			cy.visit_version({page: 'Design/online_designer.php', params: "pid=9&page=prescreening_survey"}).then(() =>{

				//Select field to edit some choices for
				cy.edit_field_by_label('Date of birth')

				//Check required
				cy.get('input#field_req1').click()

				//Save this particular field we are editing
				cy.save_field()

				//Submit the changes for review
				cy.get('input[value="Submit Changes for Review"]').should(($i) => {
					$i.first().click()
				})

				//Submit for Appproval
				cy.get('button').contains('Submit').click()
			})
		})


		it('Should have the ability for a participant to enter data in a data collection instrument enabled and distributed as a survey', () => {
			cy.visit_version({page: 'Surveys/invite_participants.php', params: 'pid=9'})

			cy.get('div').contains('Public Survey URL').parent().find('input').then(($input) => {
				cy.visit_base({ url: $input[0].value }).then(() => {
					cy.get('html').should('contain', 'Date of birth')
					cy.get('html').should('contain', 'E-mail address')
					cy.get('html').should('contain', 'Type 2 Diabetes')
				})
			})
		})

		it('Should have the ability to support Incomplete surveys status', () => {
			cy.visit_version({page: 'Surveys/invite_participants.php', params: 'pid=9'})

			cy.get('div').contains('Public Survey URL').parent().find('input').then(($input) => {
				cy.visit_base({ url: $input[0].value }).then(() => {

					cy.get('button').contains('Submit').click()

					cy.get('div[role=dialog]').contains('required').parent().parent().within(() => {
						cy.get('button').contains('Okay').click()
					}).then(() => {
						cy.visit_version({page: '/DataEntry/index.php', params: 'pid=9&id=3&page=prescreening_survey&event_id=31&instance=1'})
						cy.get('td').contains('Complete?').parent().parent().find('select').contains('Incomplete')
					})
				})
			})
		})

		it('Should have the ability to support Partial Survey Response status', () => {
			cy.get('div').contains('Response is only partial and is not complete')
		})

		it('Should have the ability to support Completed Survey Response status', () => {
			cy.visit_version({page: '/DataEntry/index.php', params: 'pid=9&id=1&page=prescreening_survey&event_id=31&instance=1'})
			cy.get('td').contains('Complete?').parent().parent().find('select').contains('Complete')
		})

		it('Should have the ability to submitted survey responses to be changed by a user who has edit survey responses rights', () => {
			//Marking this twice seems to check all Edit Survey rights
			cy.change_survey_edit_rights(9, 'test_user', 'Pre-Screening Survey')
			cy.change_survey_edit_rights(9, 'test_user', 'Pre-Screening Survey')

			//Set to the standard user who has rights to this project
			cy.set_user_type('standard')

			cy.visit_version({page: '/DataEntry/index.php', params: 'pid=9&id=1&page=prescreening_survey&event_id=31&instance=1'})

			//Attempt to edit the response
			cy.get('button').contains('Edit response').click().then(() => {
				cy.get('html').then(($html) => {
					expect($html).to.contain('now editing')
				})
			})
		})
	})

	describe('Control Center', () => {

		before(() => {
			cy.set_user_type('admin')
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