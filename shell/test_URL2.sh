#!/bin/bash

[ -f /etc/init.d/functions ] && . /etc/init.d/functions

msg=`date +'%F %T'`


if [ $# -ne 1 ]
	then 
		echo "usage:$0 uri"
		exit 1
fi


http=$(curl -o /dev/null -sL $1 -w "%{http_code}\n" | egrep "200" | wc -l)

if [ $http -eq 1 ]
   then
     action "$msg $1 is yes." /bin/true
   else
     action "$msg is no." /bin/false
fi
