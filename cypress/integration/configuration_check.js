describe('Configuration Check', () => {

    it('should have tabs to My Projects, New Project, Help & FAQ, Control Center"', () => {
        cy.visit('/').then(() => {                
            cy.get('a').contains('My Projects')
            cy.get('a').contains('New Project')
            cy.get('a').contains('Help & FAQ')
            cy.get('a').contains('Control Center')    
        })
    })

    describe('Control Center', () => {

    	before(() => {

    	})

    	describe('Control Center Home', () => {
    		it('should have Notifications & Reporting', () => { cy.contains_cc_link('Notifications & Reporting', 'Notifications') })
			it('should have To-Do List', () => { cy.contains_cc_link('To-Do List') })
    	})

    	describe('Dashboard', () => {
			it('should have System Statistics', () => { cy.contains_cc_link('System Statistics') })
			it('should have Activity Log', () => { cy.contains_cc_link('Activity Log') })
			it('should have Activity Graphs', () => { cy.contains_cc_link('Activity Graphs', 'View graphs for:') })
			it('should have Map of Users', () => { cy.contains_cc_link('Map of Users') })
    	})

    	describe('Projects', () => {
			it('should have Browse Projects', () => { cy.contains_cc_link('Browse Projects') })
			it('should have Edit a Project\'s Settings', () => { cy.contains_cc_link('Edit a Project\'s Settings') })
    	})

    	describe('Users', () => {
			it('should have Browse Users', () => { cy.contains_cc_link('Browse Users') })
			it('should have Add Users (Table-based Only)', () => { cy.contains_cc_link('Add Users (Table-based Only)', 'User Management for Table-based Authentication') })
			it('should have User Whitelist', () => { cy.contains_cc_link('User Whitelist') })
			it('should have Email Users', () => { cy.contains_cc_link('Email Users') })
			it('should have API Tokens', () => { cy.contains_cc_link('API Tokens') })
			it('should have Administrators & Acct Managers', () => { cy.contains_cc_link('Administrators & Acct Managers', 'Designating REDCap Administrators and Account Managers') })
    	})

    	describe('Miscellaneous Modules', () => {
			it('should have Custom Application Links', () => { cy.contains_cc_link('Custom Application Links') })
			it('should have Publication Matching', () => { cy.contains_cc_link('Publication Matching') })
			it('should have Dynamic Data Pull (DDP)', () => { cy.contains_cc_link('Dynamic Data Pull (DDP)') })
			it('should have Find Calculation Errors in Projects', () => { cy.contains_cc_link('Find Calculation Errors in Projects') })
    	})

    	describe('Technical / Developer Tools', () => {
			it('should have MySQL Dashboard', () => { cy.contains_cc_link('MySQL Dashboard') })
			it('should have API Documentation', () => { cy.contains_cc_link('API Documentation') })
			it('should have Plugin & Hook Documentation', () => { cy.contains_cc_link('Plugin & Hook Documentation') })
    	})

    	describe('System Configuration', () => {
			it('should have Configuration Check', () => { cy.contains_cc_link('Configuration Check') })
			it('should have General Configuration', () => { cy.contains_cc_link('General Configuration') })
			it('should have Security & Authentication', () => { cy.contains_cc_link('Security & Authentication') })
			it('should have User Settings', () => { cy.contains_cc_link('User Settings') })
			it('should have File Upload Settings', () => { cy.contains_cc_link('File Upload Settings') })
			it('should have Modules Configuration', () => { cy.contains_cc_link('Modules Configuration') })
			it('should have Field Validation Types', () => { cy.contains_cc_link('Field Validation Types') })
			it('should have Home Page Settings', () => { cy.contains_cc_link('Home Page Settings', 'Home Page Configuration') })
			it('should have Project Templates', () => { cy.contains_cc_link('Project Templates') })
			it('should have Default Project Settings', () => { cy.contains_cc_link('Default Project Settings') })
			it('should have Footer Settings (All Projects)', () => { cy.contains_cc_link('Footer Settings (All Projects)') })
			it('should have Cron Jobs', () => { cy.contains_cc_link('Cron Jobs') })

			it ('should contain the expected Configuration Check', () => {
				cy.visit_v({ page: "ControlCenter/check.php" }).then(() => {
				cy.get("h4").contains("Configuration Check")
				cy.get("body").contains("TEST 1")
				cy.get("body").contains("TEST 2")
				cy.get("body").contains("TEST 3")
				cy.get("body").contains("TEST 4")
				cy.get("body").contains("TEST 5")
				cy.get("body").contains("TEST 6")
			})

	    })
		})

	})

	
})