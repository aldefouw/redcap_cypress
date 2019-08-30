echo off

set db_cmd=%1 -h"%2" %4 --port=%3 -u%5 -p%6

:: Replace all instances of / with \ so that we can keep our javascript code
set sql_file=%7
set sql_file=%sql_file:/=\%

set sql=%cd%\test_db\%sql_file%.sql
set tmp=%cd%\test_db\%sql_file%.sql.tmp

set first=s/REDCAP_DB_NAME/%4/g

IF [%8]==[] (
	echo | type %sql% | sed %first% > %tmp%
) ELSE (
	echo | type %sql% | sed %first% | sed s/%8/g > %tmp%
)

%db_cmd% < %tmp%

del %tmp%