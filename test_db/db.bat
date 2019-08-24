echo off

:: Replace all instances of / with \ so that we can keep our javascript code
set sql_file=%7
set sql_file=%sql_file:/=\%

set sql=%cd%\test_db\%sql_file%.sql
set tmp=%cd%\test_db\%sql_file%.sql.tmp
set replace=%cd%\test_db\replace.vbs
set in_place=%cd%\test_db\replace_in_place.vbs

IF [%8]==[] (
	cscript //NoLogo %replace% %sql% "REDCAP_DB_NAME" "%4" "%tmp%"
) ELSE (
 	cscript //NoLogo %replace% %sql% "REDCAP_DB_NAME" "%4" "%tmp%"
 	cscript //NoLogo %in_place% %tmp% "%8" "%4" "%tmp%"
)

IF [%9]==[] (
	set containers=%cd%\test_db\containers.tmp
	docker ps | findstr "3306" > containers
	for /f "tokens=1 delims= " %%a in (containers) do set db_cmd=docker exec -i %%a %1 -u%5 -p%6 %4
) ELSE (
 	set db_cmd=%1 -h%2 --port=%3 %4 -u%5 -p%6
)

%db_cmd% < %tmp%