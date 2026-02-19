#!/bin/bash

check_timezone() {
	read -r _ _ timezone utc time _ < <(timedatectl | grep "Time zone")
	echo "$timezone $utc $time"
}


