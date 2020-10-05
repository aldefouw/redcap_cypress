redcap_version="$1"
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

rm $structure_and_data_file
rm "${structure_and_data_file}.tmp"

cat $db_prefix_sql > $structure_and_data_file
cat $install_sql >> $structure_and_data_file
cat $data_sql >> $structure_and_data_file
cat $seed_sql | sed $version_substitution >> $structure_and_data_file