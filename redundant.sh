#!/usr/bin/bash
# find redundant accouts via email
# author: Hugo Estrada @hugoestr
sql="select emailAddress from email order by emailAddress;"
user=
password=
db=
sql_query="mysql -uroot -pzekiah -D$db  -e \"$sql\""
#$sql_query
mysql -u$user -p$password -D$db  -e "$sql" | uniq -d | sed -e 's/\(.*\)/"\1"/' -e 's/$/,/' -e '1s/.*/select u.userName, e.emailAddress, u.userId from user as u join email as e on u.userId = e.userId where e.emailAddress in (/' -e '$s/,$/)/' | mysql -u$user -p$password -D$db | sed -e 's/\t/,/g'
