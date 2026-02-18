#!/bin/bash

source ./timezone.sh
source ./os.sh
source ./uptime.sh
source ./network.sh
source ./memory.sh

assembl_full_output() {
  hostname="HOSTNAME = $(hostname)"

  timezone="TIMEZONE = $(check_timezone)"

  user="USER = $USER"

  os="OS = $(check_os)"

  date="DATE = $(date +"%d %B %Y %H:%M:%S")"

  uptime="UPTIME = $(check_uptime)"
  uptime_sec="UPTIME_SEC = $(check_uptime_sec)"

  read ip prefix < <(check_ip)
  ip="IP = $ip"
  mask="MASK = $(check_mask $prefix)"
  gateway="GATEWAY = $(check_gateway)"

  ram_total="RAM_TOTAL = $(check_ram_total)"
  ram_used="RAM_USED = $(check_ram_used)"
  ram_free="RAM_FREE = $(check_ram_free)"

  space_root="SPACE_ROOT = $(check_space_root)"
  space_root_used="SPACE_ROOT_USED = $(check_space_root_used)"
  space_root_free="SPACE_ROOT_FREE = $(check_space_root_free)"

  echo -e "$hostname\n$timezone\n$user\n$os\n$date\n$uptime\n$uptime_sec\n$ip\n$mask\n$gateway\n$ram_total
$ram_used\n$ram_free\n$space_root\n$space_root_used\n$space_root_free"
}
