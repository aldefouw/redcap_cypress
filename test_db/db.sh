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

$db_cmd < $tmp

if [ $? -eq 0 ]
then
  echo "success"
  rm -f $tmp
else
  echo "failure" >&2
fi


