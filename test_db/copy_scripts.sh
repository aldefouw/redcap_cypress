# DEFINE REDCAP VERSION (FIRST PARAMETER)
redcap_version="$1"

# DEFINE PATHS
source_location="/Users/aldefouw/Dev/redcap/redcap-source"

cypress_location="$PWD/test_db"
seed_sql="${cypress_location}/cypress_data.sql"
db_prefix_sql="${cypress_location}/structure_prefix.sql"

sql_path="${source_location}/redcap_v${redcap_version}/Resources/sql"
install_sql="${sql_path}/install.sql"
data_sql="${sql_path}/install_data.sql"

#CREATE STRUCTURE FILE
structure_and_data_file="${cypress_location}/structure_and_data.sql"
version_substitution="s/REDCAP_VERSION_MAGIC_STRING/${redcap_version}/g"

#REMOVE EXISTING STRUCTURE AND DATA FILE
rm $structure_and_data_file
rm "${structure_and_data_file}.tmp"

#CREATE NEW STRUCTURE AND DATA FILE
cat $db_prefix_sql > $structure_and_data_file
cat $install_sql >> $structure_and_data_file
cat $data_sql >> $structure_and_data_file
cat $seed_sql | sed $version_substitution >> $structure_and_data_file