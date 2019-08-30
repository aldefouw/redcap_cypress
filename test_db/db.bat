rem echo off

set db_cmd=%1 --sql --host=%2 --port=%3 --user=%5 --password=%6

:: Replace all instances of / with \ so that we can keep our javascript code
set sql_file=%7
set sql_file=%sql_file:/=\%

set sql=%cd%\test_db\%sql_file%.sql
set tmp=%cd%\test_db\%sql_file%.sql.tmp

rem IF [%8]==[] (

rem ) ELSE (

rem )

%db_cmd% < %tmp%