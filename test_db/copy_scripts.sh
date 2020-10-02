redcap_version="10.3.4"
source_location="/Users/aldefouw/Dev/redcap/redcap-source"
cypress_location="$PWD"
cypress_data_file="${cypress_location}/cypress_data.sql"

sql_path="${source_location}/redcap_v${redcap_version}/Resources/sql"
install_sql="${sql_path}/install.sql"
data_sql="${sql_path}/install_data.sql"

version_substitution="s/'4.0.0'),/'${redcap_version}'),/g"

echo "$(cat $db_prefix_file) $(cat $install_sql)" > "${redcap_version}_structure.sql"
echo "$(cat $db_prefix_file) $(cat $data_sql)" | sed $version_substitution > "${redcap_version}_data.sql"