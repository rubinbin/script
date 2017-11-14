#！/bin/bash 

#############################################################
#Date: 2017-8-15					    #
#Mail: 1275035607@qq.com				    #
#nginx启动脚本                                                        #
#                                                           #
#############################################################

[ -f /etc/init.d/functions ] && . /etc/init.d/functions
nginxpid=/application/nginx/logs/nginx.pid
nginxdir=/application/nginx/sbin/nginx

Start_nginx(){
	if [ -f $nginxpid ]
	  then
		echo "Nginx in progress"
	  else
		$nginxdir
		action "Nginx is start" /bin/true
	fi
}
Stop_nginx(){
	if [ -f $nginxpid ]
	  then
		$nginxdir -s stop
		action "Nginx is stop" /bin/true
	  else
		action "Nginx is stop" /bin/false
	fi	
}
Reload_nginx(){
	if [ -f $nginxpid ]
	  then
		$nginxdir -s reload
		action "Nginx is reload" /bin/true
	  else
		action "Nginx is reload" /bin/false
	fi
}

case "$1" in
	start)
		Start_nginx
		;;
	stop)
		Stop_nginx
		;;
	reload)
		Reload_nginx
		;;
	restart)
		Stop_nginx && Start_nginx
		;;
	*)
		echo "Usage:$1 {start|stop|reload|restart}"
esac
