redcap_version="$1"
source_location="/Users/aldefouw/Dev/redcap/redcap-source"
cypress_location="$PWD/test_db"

db_prefix_sql="${cypress_location}/structure_prefix.sql"

sql_path="${source_location}/redcap_v${redcap_version}/Resources/sql"
install_sql="${sql_path}/install.sql"
data_sql="${sql_path}/install_data.sql"


#CREATE STRUCTURE FILE
structure_filename="${cypress_location}/structure.sql"
cat $db_prefix_sql > $structure_filename
cat $install_sql >> $structure_filename

#CREATE DATA FILE
data_filename="${cypress_location}/data.sql"
version_substitution="s/'4.0.0'),/'${redcap_version}'),/g"
cat $db_prefix_sql > $data_filename
cat $data_sql | sed $version_substitution >> $data_filename