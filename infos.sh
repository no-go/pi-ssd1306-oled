#!/bin/bash
IPADDR=$(hostname -I | cut -d' ' -f1)
CPULOAD=$(top -bn1 | grep load | tr , . | awk '{printf "%5.2f", $(NF-2)}')
NOWTIME=$(date +'%H:%M')
PIHOLE=$(curl -s http://127.0.0.1/admin/api.php | tr -d '{}\"' | tr ',' '\n' | tr ':' ' ')
BLOCKED=$(echo "${PIHOLE}" | grep "ads_blocked_today")
QUERIES=$(echo "${PIHOLE}" | grep "dns_queries_today")
/home/pi/pi-ssd1306-oled/oled -t "$IPADDR" -t "load & time   $CPULOAD - $NOWTIME" -t "$BLOCKED" -t "$QUERIES"
