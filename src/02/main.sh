#!/bin/bash

hostname=$( hostname )

timezone=""
for elem in $(timedatectl | grep "Time zone")
do
	if [[ $elem != "Time" && $elem != "zone:" ]]; then
		timezone+=" $elem"
	fi
done

user=$USER

os=""
for elem in $(cat /etc/issue)
do
	if [[ $elem == '\n' ]]; then
		break
	fi
	os+=" ${elem}"
done

date=$(date +"%d %B %Y %H:%M:%S")

uptime=""
IFS=,
for elem in $(uptime)
do
	i=0
	IFS=" "
	for word in $elem
	do
		if [[ $i == 2 ]]; then
			uptime+=$word
		fi
		i=$(($i + 1))
	done
	break	
done

uptime_sec=0
i=0
for elem in $(uptime -p)
do
	if [[ $i == 0 && $elem =~ ^-?[0-9]+$ ]]; then
		uptime_sec=$(( $uptime_sec + $elem * 3600 ))
		i=$(( $i + 1))
	elif [[ $i == 1 && $elem =~ ^-?[0-9]+$ ]]; then
		uptime_sec=$(( $uptime_sec + $elem * 60 ))
		break
	fi
done

ip=""
i=0
prefix=""
for elem in $(ip a)
do 
	if [[ $elem == "inet" ]]; then
		i=$(($i + 1))
	elif [[ $i == 2 ]]; then
		IFS=/
		for ips in $elem
		do
			if [[ $i == 2 ]]; then
				ip+=$ips
				i=$(( $i + 1 ))
			else
				prefix+=$ips
			fi
		done
		break
	fi
done	

mask_bin=""
for ((i=1;i<=32;i++))
do 
	if [[ $i -le $prefix ]]; then
		mask_bin+="1/"
	else
		mask_bin+="0/"
	fi
	if [[ $(( $i % 8 )) == 0 && $i -lt 30 ]]; then
		mask_bin+="."
	fi
done

IFS=.
mask=""
j=0
for elem in $mask_bin
do
	octet_mask_10=0
	i=7
	IFS="/"
	for num in $elem
	do
		octet_mask_10=$(( $octet_mask_10 + $num * 2 ** i))
		i=$(($i - 1))
	done
	j=$(( $j + 1 ))
	mask+="$octet_mask_10"
	if [[ $j -lt 4 ]]; then
		mask+="."
	fi
done

gateway=""
i=0
IFS=" "
for elem in $( ip r | grep default)
do
	if [[ $i == 2 ]]; then
		gateway+=$elem
		break
	fi
	i=$(( $i + 1 ))
done	
echo $hostname $timezone $user $os $date $uptime $uptime_sec $ip $mask $gateway
