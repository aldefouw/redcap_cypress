@echo off

rem Get the Operating System bits
for /f "tokens=1 skip=1 delims=-" %%c in ('wmic os get osarchitecture') do (
	set os_bits=%%c
	GOTO BREAK
)
:BREAK

curl -o sed.zip https://codeload.github.com/mbuilov/sed-windows/zip/master

rem 64 Bit System
IF %os_bits% == 64 (

	curl -o mysql-cli.zip -L https://dev.mysql.com/get/Downloads/MySQL-Shell/mysql-shell-8.0.17-windows-x86-64bit.zip
	set folder=mysql-shell-8.0.17-windows-x86-64bit

rem 32 Bit System
) ELSE (

	curl -o mysql-cli.zip -L https://downloads.mysql.com/archives/get/file/mysql-shell-1.0.11-windows-x86-32bit.zip
	set folder=mysql-shell-1.0.11-windows-x86-32bit

)

tar zxvf sed.zip
tar zxvf mysql-cli.zip

ren .\%folder%\ mysql
ren .\sed-windows-master\ sed