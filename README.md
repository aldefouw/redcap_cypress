# REDCap Cypress Test Framework

This repository is a template to assist you in writing **automated tests for REDCap**.  

It is intended to serve as a starting point for writing your own integration tests, which can be used to validate the features and functionality of your REDCap environment.

**This template uses the Cypress framework**, a library which allows non-environment-dependent testing.  

**The choice to use Cypress for testing REDCap was strategic.**  

Because the framework is not environment-dependent, **the tests you write today will still be relevant in the future** - even if you change your server infrastructure.  

*You could change from Windows to Linux or vice versa and your tests won't need to change.*

The non-platform-dependent nature of Cypress tests also opens the door for consortium members to share tests with other members of the REDCap consortium.  


## Vision for Testing

We all want to provide our end users with the latest and greatest version of REDCap, but we also want to mitigate the risks of upgrading.

I believe that by writing a robust and comprehensive test suite, we can exercise, test, verify, and validate REDCap to the point where the risks posed by the software itself are very low.

The vision, and the impetus to create this template repository, is that I want to see a future for REDCap where the software is thoroughly and comprehensively tested with a robust, automated test suite that each institution can run by pushing a button.


## Consortium Power

>"None of Us is as good as All of Us." - Ray Kroc

Writing a comprehensive test suite for REDCap will not be accomplished by an individual.  The software is too large and there are too many corners to test.  

It will take the power of the entire consortium.  But the good news is that it's easy to share what we do contribute individually.  


## Sharing Your Tests

The GitHub open source software community provides us a platform to easily share our tests via forking.

You can share the tests you have written with the rest of the consortium community by pushing your version of this repository to a fork.

My hope is that someday we can create a "master" repository that includes integration tests from several authors, which will give everyone a huge head-start on testing their environment.


## Writing Your Tests

This documentation will help you configure your Cypress testing environment, but it will not cover how to write Cypress tests.  

To give you a feel for how tests are written, however, below is a sample Login Spec.

##### Login Spec


            describe('Login Page', function () {

                const users = Cypress.env("users");
                const username = users['standard']['user'];
                const password = users['standard']['pass'];

                beforeEach(function () {
                    cy.visit('/')
                });

                it('sets auth cookie when logging in via form submission', function () {
                    cy.get('input#username').type(username);
                    cy.get('input#password').type(`${password}{enter}`);
                    cy.getCookie('PHPSESSID').should('exist');
                });

                it('requires a username', function () {
                    cy.get('input#password').type(`${password}{enter}`);
                    cy.contains('ERROR: You entered an invalid user name or password!');
                });

                it('requires a password', function () {
                    cy.get('input#username').type(`${username}{enter}`);
                    cy.contains('ERROR: You entered an invalid user name or password!');
                });

                it('requires a valid username and password', function () {
                    cy.get('input#username').type(username);
                    cy.get('input#password').type(password);
                    cy.contains('button', 'Log In').click();
                    cy.contains('Listed below are the REDCap projects to which you currently have access.')
                });

            });


If you are looking for examples of how to write tests, the sample specs are included in the following folder (within this repository):
`/cypress/integration/`

For specific information about how to write JavaScript tests in Cypress, please visit their website:
https://www.cypress.io/


## Getting Started

Automating testing of REDCap requires two things:
- Test Environment
- Test Framework

### Test Environment

What is the test environment?  Well, it's basically your test server that you run REDCap on.  

- **It can be located anywhere:** *local or remote*.  
- **It can run in any environment:** *virtualized or dedicated*.  
- **It can run any OS you want:** *Linux or insert your favorite OS here*.

There are really only **two requirements for your Test Environment**:
1. *It must be running prior to starting the test suite*
2. *It must be accessible through HTTP protocol via the test suite*

If your test environment is running and functional, this part is done.

**Caution:**
*Although the Cypress test framework can test against any server through HTTP protocol, **please do NOT use your production server as your test environment**.  You might think the best way to test your REDCap instance is to test against your actual server that people store data on.  That simply isn't the case.*

*The best way to test your REDCap instance is to configure an environment identical to production somewhere else.  An easy way to do this is through Docker.  That said, configuring your environment is outside the scope of this document.*

*The best test suites reset database state between each test spec.  This test suite resets database state between tests. That isn't something you should ever do against production!*

### Test Framework 

This is the repository you're looking at.  You will write tests on your machine and then run them against your Test Environment.

If you have a **Test Environment** running and you've cloned this repository (your **Test Framework**), you are now ready to **Tell your Test Framework about your Test Environment**.


## Tell your Test Framework about your Test Environment

Configuring your environment is simultaneously the most crucial and difficult step to complete.  

You will need to define several environment variables.

### Environment Variables

Cypress will understand your environment only if you describe it accurately.  

Your descriptoin will live inside an environment variable definition file.  

**You will need to set the variables in this file in order for your test suite to function.**

Let's get started by creating a `cypress.env.json` file.

### cypress.env.json

In the root of this repository, create a file named `cypress.env.json`.  

To get you started, an example file named `cypress.env.json.example` is included within this repository.  

Here is an example environment variable setup:

    {
      "baseUrl": "http://localhost:80",
      "users": {
        "admin": {
          "user": "admin_user",
          "pass": "Testing123"
        },
        "standard": {
          "user": "test_user",
          "pass": "Testing123"
        }
      },
      "redcap_version": "8.1.1",
      "mysql": {
        "host": "127.0.0.1",
        "path": "mysql",
        "port": "3306",
        "db_name": "redcap",
        "db_user": "root",
        "db_pass": "root"
      }
    }

Let's dive into these configuration values that are shown in the example above.

### baseURL ### 
The base URL that Cypress will use to access your REDCap instance.

### redcap_version ###
The version of REDCap that you are testing against.  This is a critical value to set so that Cypress knows the correct URLs to use when testing.

### mysql ### 
The JSON array that contains several keys, which are critical for your database structure and seeds to be populated correctly before each and every test spec.  

(See **Database Structure & Seeds** section for more information about how these work.)

### mysq['host'] ### 
The hostname or IP address of your MySQL database host.  For most of us, this will likely be either `localhost` or `127.0.0.1`.  Keep in mind that there are subtle nuances between localhost and 127.0.0.1 so depending on your setup, you need to choose the option best suited to your environment.

### mysql['path'] ### 
The path to your mysql binary.  For many of us, this will probably be `mysql`, but you could also use a full path like `/usr/local/opt/mysql@5.7/bin/mysql` if necessary.  

### mysql['port'] ### 
The port to your MySQL instance.  This is usually 3306 on standard setups, but for many of us running Docker instances we may wish to use an alternative port so we can differentiate between the standard MySQL instance that is installed on a local operating system and the Docker instance itself.

### mysql['db_name'] ### 
The name of your MySQL REDCap database.  This is typically `redcap` but not always.  You'll want to check your `database.php` file on your test instance of your REDCap installation to determine this value.

 ### mysql['db_user'] ### 
The username of your MySQL REDCap database user.  This is typically `root` on local instances of MySQL or local Docker containers.  You'll want to check your `database.php` file on your test instance of your REDCap installation to determine this value.

### mysql['db_pass'] ### 
The password of your MySQL REDCap database user.  This is typically `root` on local instances of MySQL or local Docker containers.  You'll want to check your `database.php` file on your test instance of your REDCap installation to determine this value.


## Database Structure & Seeds

To create non-deterministic tests, we want to reset the database state before each individual test is run.

To accomplish this, a file located at `/test_db/seeds.sql` is run via the `db.sh` shell script within the beforeEach() block.  The beforeEach() block is run exactly when you'd expect it to be: before each individual test spec.

### Adding A Custom Seed

You can create any database state you want to prior to running your tests.  The included seeds.sql file is just what we are using at our institution.  

To add your own custom seeds, you simply need to do two things.

1. Add a custom `your_custom_seed_name_here.sql` file into the `/test_db/` folder.  

2. Ensure that your custom SQL file is wrapper in a TRANSACTION and that is specifies the correct database.

To ensure it is using the correct database, please make sure to include the following line within your transaction code:

        USE `REDCAP_DB_NAME`;

3. Reference that file in the beforeEach() block within the `/support/index.js` file.

For example:

      ....

      //Set base URL from the environment variable that was set
      Cypress.config("baseUrl", Cypress.env("baseUrl"));

      before(() => {
          //Create the initial database structure
          cy.mysql_db('structure');
      });

      beforeEach(() => {
          //Clear out the cookies
          cy.clearCookie('PHPSESSID');

          //Set the Base URL in the REDCap Configuration Database
          const base_url = 'BASE_URL/' + Cypress.env('baseUrl').replace('http://', 'http\\:\\\\/\\\\/');

          //Seeds the database before each test
          cy.mysql_db('seeds', base_url);
          
          // ### YOUR CUSTOM SEED BELOW ### //
          cy.mysql_db('your_custom_seed_name_here');
      });

      ....



