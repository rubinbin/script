#!/bin/bash

msg(){
        echo "`date +'%F %T'` $1"
}


if [ $# -ne 1 ]
        then
                echo "usage:$0 uri"
                exit 1
fi


http=$(curl -o /dev/null -sL $1 -w "%{http_code}\n" | egrep "200" | wc -l)

if [ $http -eq 1 ]
   then
     msg "$1 链接正常"
   else
     msg "$1 链接失败"
fi
