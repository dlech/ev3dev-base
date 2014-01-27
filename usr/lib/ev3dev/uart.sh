#!/bin/bash

dev_node="/dev/tty_"$2
pid_file="/var/run/ev3-"$2"-uart.pid"

case "$1" in
start)
	/sbin/start-stop-daemon --start --exec /usr/sbin/ldattach --pidfile $pid_file -- 29 $dev_node || exit $?
	echo $(/usr/bin/pgrep -f "/usr/sbin/ldattach 29 $dev_node") > $pid_file
	exit $?
	;;
stop)
	/sbin/start-stop-daemon --stop --oknodo --pidfile $pid_file || exit $?
	rm -f $pid_file
	;;
esac

exit 1
