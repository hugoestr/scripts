set table=%1

set database=name
set user=name
set port=portNumer
set password=yourpassword
set host=hostName

mysqldump --opt %database% -u%user% -p%password% -h%host% -P%port% --tables %table% > %table%.sql

