// ***********************************************************
// This example plugins/index.js can be used to load plugins
//
// You can change the location of this file or turn off loading
// the plugins file with the 'pluginsFile' configuration option.
//
// You can read more here:
// https://on.cypress.io/plugins-guide
// ***********************************************************

// This function is called when a project is opened or re-opened (e.g. due to
// the project's config changing)
const shell = require('shelljs')
const sed_lite = require('sed-lite').sed
const fs = require('fs')
const csv = require('async-csv')

module.exports = (on, config) => {
  // `on` is used to hook into various events Cypress emits
  // `config` is the resolved Cypress config

  on('task', {

	populateStructureAndData({redcap_version, advanced_user_info, source_location}) {

 		// DEFINE OTHER LOCATIONS
		var test_seeds_location = shell.pwd() + '/test_db';
		var seeds_location = test_seeds_location + '/seeds';

		var db_prefix_sql = test_seeds_location + '/structure_prefix.sql';
		var sql_path = source_location + '/redcap_v' + redcap_version + '/Resources/sql';
		var install_sql = sql_path + '/install.sql';
		var data_sql = sql_path + '/install_data.sql';

		if(advanced_user_info === "true"){
			var user_sql = seeds_location + '/user_info/advanced.sql';
		} else {
			var user_sql=`${seeds_location}/user_info/standard.sql`
		}

		var auth_sql = seeds_location + '/auth.sql';
		var rights_sql = seeds_location + '/rights.sql';
		var config_sql = seeds_location + '/config.sql';
		var projects_sql = seeds_location + '/projects.sql';

		//CREATE STRUCTURE FILE
		var structure_and_data_file = test_seeds_location + '/structure_and_data.sql';

		//REMOVE EXISTING STRUCTURE AND DATA FILE
		shell.rm(structure_and_data_file);

		//CREATE NEW STRUCTURE AND DATA FILE FROM REDCAP SOURCE
		shell.cat(db_prefix_sql).to(structure_and_data_file);
		shell.cat(install_sql).toEnd(structure_and_data_file);
		shell.cat(data_sql).toEnd(structure_and_data_file);

		shell.cat(user_sql).toEnd(structure_and_data_file);
		shell.cat(auth_sql).toEnd(structure_and_data_file);

		//DEMO PROJECT SEEDS
		for(i = 1; i<=12; i++){
			let demo_sql=`${sql_path}/create_demo_db${i}.sql`
			shell.cat(demo_sql).toEnd(structure_and_data_file)
		}

		shell.cat(rights_sql).toEnd(structure_and_data_file);

		shell.cat(projects_sql).toEnd(structure_and_data_file);
		shell.cat(config_sql).sed('REDCAP_VERSION_MAGIC_STRING', redcap_version).toEnd(structure_and_data_file);

		shell.ShellString('\nCOMMIT;').toEnd(structure_and_data_file);

		if (fs.existsSync(structure_and_data_file)) {
        	return true
      	}

		return false
	},

	generateMySQLCommand({mysql_name, host, port, db_name, db_user, db_pass, type, replace, include_db_name}) {
  		if(include_db_name){
  			var db_cmd=`${mysql_name} -h${host} --port=${port} ${db_name} -u${db_user} -p${db_pass}`;
  		} else {
	  		var db_cmd=`${mysql_name} -h${host} --port=${port} -u${db_user} -p${db_pass}`;
  		}
  		
		var sql=`${shell.pwd()}/test_db/${type}.sql`;
		var tmp=`${sql}.tmp`;

		//REPLACE ALL INSTANCES OF THE REDCAP_DB_NAME MAGIC CONSTANT
		var replace_db_name = sed_lite(`s/REDCAP_DB_NAME/${db_name}/g`);
		var new_file = replace_db_name(shell.cat(sql));

		//REPLACE ALL INSTANCES OF THE REPLACEMENT CALLED FOR IN THE COMMAND
		if(replace === ''){

		} else {
			var replace_string = sed_lite(`s/${replace}/g`);
			new_file = replace_string(new_file);
		}

		var final_file = new shell.ShellString(new_file);

		//OUTPUT TO TEMPORARY FILE
		final_file.to(tmp)

		//FORMULATE DB CMD
		if (fs.existsSync(tmp)) {
        	return { cmd: `${db_cmd} < ${tmp}`, tmp: tmp };
      	}		
	},

	deleteFile({path}){
		if (fs.existsSync(path)) {
        	shell.rm(path)

        	if (!fs.existsSync(path)) {
        		return true
        	}

        	return false
      	}			
	},

	parseCsv({csv_string}) {
		return csv.parse(csv_string)
	},

	readDirectory(dir) {
		if (fs.existsSync(dir)) {
			return fs.readdirSync(dir)
		}

		return null
	},

  })

}