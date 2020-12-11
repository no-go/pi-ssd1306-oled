#!/bin/bash

# please add this executable(!) bash script as root into your crontab -e :
#
# * * * * * /home/pi/pi-ssd1306-oled/infos-and-poweroff.sh >/dev/null 2>&1

echo "27" > /sys/class/gpio/export
THEDIRECTION=$(cat /sys/class/gpio/gpio27/direction)

if [ $THEDIRECTION != 'in' ] ; then
	echo "in" > /sys/class/gpio/gpio27/direction
fi

IPADDR=$(hostname -I | cut -d' ' -f1)
CPULOAD=$(top -bn1 | grep load | tr , . | awk '{printf "%5.2f", $(NF-2)}')
NOWTIME=$(date +'%H:%M')
THEGPIO=$(cat /sys/class/gpio/gpio27/value)
FREEDISK=$(($(stat -f --format="%a*%S/(1024*1024)" /)))

/home/pi/pi-ssd1306-oled/oled \
	-t "IP:  $IPADDR" \
	-t "load & time:   $CPULOAD - $NOWTIME" \
	-t "GPIO27:           $THEGPIO" \
	-t "disk free:      $FREEDISK MB"

if [ $THEGPIO = '0' ] ; then
	systemctl poweroff -i
fi

