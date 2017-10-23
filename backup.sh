#!/bin/bash

#备份web下面的站点，根据传参的参数，做出相应动作

date=$(date +%F)
date2=$(date +%Y\/%m\/%d)
Ddate=$(date -d '-$2 day' +%Y\/%m\/%d &>/dev/null)


backupdir=/data/backup/web
webdir=/application/nginx/html
websie="blog web www"
nginxdir=/application/nginx

option_l(){
        echo $websie
}

option_a(){
    for x in $websie
    do
		d="$backupdir/$x/$date2"
        if [ -d $d ]
        then
            cd $webdir
            ar -zcf $d/$x_$date.tar.gz $x
        else
            mkdir -p $d
            cd $webdir
            tar -zcf $d/"$x"_$date.tar.gz $x
        fi
    done
}

option_f(){
	d="$backupdir/html/$date2"
    if [ -d $d ]
    then
        cd $nginxdir
        tar -zcf $d/html_$date.tar.gz html
    else
        mkdir -p $d
        cd $nginxdir
        tar -zcf $d/html_$date.tar.gz html
    fi
}

option_n(){
	d="$backupdir/$1/$date2"
    if [ -d $d ]
    then
        cd $webdir
        tar -zcf $d/$1_$date.tar.gz $1
    else
        mkdir -p $d
        cd $webdir
        tar -zcf $d/$1_$date.tar.gz $1
    fi
}

option_h(){
    echo "-l,         列出web目录下全部站点；
-a,         备份web目录下全部站点；
-f,         全备；
-n <name>， 仅备份匹配 name的站点
-h,         输出帮助信息
-d,         删除N天前备份, 比如 -d 5 删除5天前备份"

}

option_d(){
        for n in $websie
        do
          rm -fr $backupdir/$n/$Ddate/
        done
}

case "$1" in
        -l) option_l ;;
        -a) option_a ;;
        -f) option_f ;;
        -n) option_n $2 ;;
        -d) option_d ;;
		*)  option_h ;;
esac
