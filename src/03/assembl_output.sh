#!/bin/bash

source ./timezone.sh
source ./os.sh
source ./uptime.sh
source ./network.sh
source ./memory.sh

assembl_full_output() {
  local err="$(check_input $1 $2 $3 $4)"

  if [[ $err != "" ]]; then
    echo "$err" >&2
    return 1
  fi
  local hostname="$(add_colors $1 $2 $3 $4 "HOSTNAME=$(hostname)")"

  local timezone="$(add_colors $1 $2 $3 $4 "TIMEZONE = $(check_timezone)")"

  local user="$(add_colors $1 $2 $3 $4 "USER = $USER")"

  local os="$(add_colors $1 $2 $3 $4 "OS = $(check_os)")"

  local date="$(add_colors $1 $2 $3 $4 "DATE = $(date +"%d %B %Y %H:%M:%S")")"

  local uptime="$(add_colors $1 $2 $3 $4 "UPTIME = $(check_uptime)")"
  local uptime_sec="$(add_colors $1 $2 $3 $4 "UPTIME_SEC = $(check_uptime_sec)")"

  read ip prefix < <(check_ip)
  local ip="$(add_colors $1 $2 $3 $4 "IP = $ip")"
  local mask="$(add_colors $1 $2 $3 $4 "MASK = $(check_mask $prefix)")"
  local gateway="$(add_colors $1 $2 $3 $4 "GATEWAY = $(check_gateway)")"

  local ram_total="$(add_colors $1 $2 $3 $4 "RAM_TOTAL = $(check_ram_total)")"
  local ram_used="$(add_colors $1 $2 $3 $4 "RAM_USED = $(check_ram_used)")"
  local ram_free="$(add_colors $1 $2 $3 $4 "RAM_FREE = $(check_ram_free)")"

  local space_root="$(add_colors $1 $2 $3 $4 "SPACE_ROOT = $(check_space_root)")"
  local space_root_used="$(add_colors $1 $2 $3 $4 "SPACE_ROOT_USED = $(check_space_root_used)")"
  local space_root_free="$(add_colors $1 $2 $3 $4 "SPACE_ROOT_FREE = $(check_space_root_free)")"

  echo -e "$hostname\n$timezone\n$user\n$os\n$date\n$uptime\n$uptime_sec\n$ip\n$mask\n$gateway\n$ram_total
$ram_used\n$ram_free\n$space_root\n$space_root_used\n$space_root_free"
}

check_input() {
  if [[ ! $1 =~ ^[1-6]$ || ! $2 =~ ^[1-6]$ || ! $3 =~ ^[1-6]$ || ! $4 =~ ^[1-6]$ ]]; then
    echo -e "Ваш ввод обязательно должен содержать цифры от 1 до 6, которые обозначают: 1 — white, 2 — red, 3 — green, 4 — blue, 5 – purple, 6 — black
Параметр 1 — это фон названий значений (HOSTNAME, TIMEZONE, USER и т. д.) 
Параметр 2 — это цвет шрифта названий значений (HOSTNAME, TIMEZONE, USER и т. д.) 
Параметр 3 — это фон значений (после знака '=') 
Параметр 4 — это цвет шрифта значений (после знака '=') 
Запустите скрипт снова, учитывая данное обстоятельство :)"
  elif [[ $1 -eq $2 || $3 -eq $4 ]]; then
    echo "Параметры одного столбца не должны совпадать! Запустите скрипт с разными параметрами в столбцах :)"
  fi
}

add_colors() {
  local colors_background=("\033[47m" "\033[41m" "\033[42m" "\033[44m" "\033[45m" "\033[40m")
  local colors_text=("\033[37m" "\033[31m" "\033[32m" "\033[34m" "\033[35m" "\033[30m")
  local end_color="\033[0m"

  IFS="=" read -r head value <<<"$5"

  echo -e "${colors_text[$(($2 - 1))]}${colors_background[$(($1 - 1))]}$head$end_color = ${colors_text[$(($4 - 1))]}${colors_background[$(($3 - 1))]}$value$end_color"
}
