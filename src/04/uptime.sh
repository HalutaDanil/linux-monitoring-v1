#!/bin/bash

check_uptime() {
	IFS=, read -r output_uptime _ < <(uptime)
	local uptime=${output_uptime#*up[[:space:]]*}
	echo $uptime
}

check_uptime_sec() {
	read -r uptime_sec _ < <(cat /proc/uptime)
	echo $uptime_sec
}
