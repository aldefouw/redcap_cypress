db_cmd="$1 -h$2 --port=$3 $4 -u$5 -p$6"
sql="$PWD/test_db/$7.sql"
tmp="$PWD/test_db/$7.sql.tmp"

first="s/REDCAP_DB_NAME/$4/g"

if [ ! $8 ]
then
      echo | cat $sql | sed $first > $tmp
else
      echo | cat $sql | sed $first | sed s/$8/g > $tmp
fi

pv $tmp | $db_cmd
rm -f $tmp