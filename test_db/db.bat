echo off

set db_cmd=%1 --sql --host=%2 --port=%3 --user=%5 --password=%6

:: Replace all instances of / with \ so that we can keep our javascript code
set sql_file=%7
set sql_file=%sql_file:/=\%

set sql=%cd%\test_db\%sql_file%.sql
set tmp=%cd%\test_db\%sql_file%.sql.tmp

set first=s/REDCAP_DB_NAME/$4/g

rem Get the Operating System bits

for /f "tokens=1 skip=1 delims=-" %%c in ('wmic os get osarchitecture') do (
	set os_bits=%%c
	GOTO BREAK
)
:BREAK

rem 64 Bit System
IF %os_bits% == 64 (
	
	IF [%8]==[] (
		type %sql% > ..\sed\sed-4.7-x64.exe %first% > %tmp%
	) ELSE (
		type %sql% > ..\sed\sed-4.7-x64.exe %first% > ..\sed\sed-4.7-x64.exe s/%8/g > %tmp%
	)

rem 32 Bit System
) ELSE (

	echo 'test'

)

%db_cmd% < %tmp%