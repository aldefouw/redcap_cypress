# REDCap Cypress Test Framework

This repository is a template to assist you in writing **automated tests for REDCap**.  

It is intended to serve as a starting point for writing your own integration tests, which can be used to validate the features and functionality of your REDCap environment.

**This template uses the Cypress framework**, a library which allows non-environment-dependent testing.  

**The choice to use Cypress for testing REDCap was strategic.**  Because the framework is not environment-dependent, **the tests you write today will still be relevant down the road** - even if you change your server infrastructure down the road.  

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



## Scope of Documentation

This documentation will get you started on your journey to testing REDCap, but it will not cover how to write Cypress tests.  

If you are looking for examples of how to write tests, two sample test specs are included in the following folder:

`/cypress/integration/`

For specific information about how to write JavaScript tests in Cypress, please visit their website:
https://www.cypress.io/



## Configuring Your Environment

Configuring your environment is simultaneously the most crucial and difficult step to complete.  

Because this framework is flexible enough to test against any enviroment, several environment variables are necessary to tell the framework where servers are located, what ports they're located on, and what users you'd like to use.

### Environment Variables

The template has been written to incorporate environment variables to allow any REDCap consortium member to test against their specific test environment.  This is accomplished by creating an environment variable definition file.

### cypress.env.json

In the root of this repository, you will need to create `cypress.env.json`.  

To get you started, an example file named `cypress.env.json.example` is included.  

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


### Database Structure & Seeds

To create non-deterministic tests, we want to reset the database state before each individual test is run.

To accomplish this, a file located at `/test_db/seeds.sql` is run via the `db.sh` shell script within the beforeEach() block.  The beforeEach() block is run exactly when you'd expect it to be: before each individual test spec.

### Adding A Custom Seed

You can create any database state you want to prior to running your tests.  The included seeds.sql file is just what we are using at our institution.  

To add your own custom seeds, you simply need to do two things.

1. Add a custom `your_custom_seed_name_here.sql` file into the `/test_db/` folder.  

2. Reference that file in the beforeEach() block within the `/support/index.js` file.

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



