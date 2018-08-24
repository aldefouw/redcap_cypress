db_cmd="$1 -h$2 --port=$3 $4 -u$5 -p$6"
sql="$PWD/test_db/$7.sql"
tmp="$PWD/test_db/$7.sql.tmp"

cat $sql | sed "s/REDCAP_DB_NAME/$4/g" > $tmp

bash -c "$db_cmd < $tmp"
rm -f $tmp