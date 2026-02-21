#!/bin/bash

source ./timezone.sh
source ./os.sh
source ./uptime.sh
source ./network.sh
source ./memory.sh

assembl_full_output() {
  IFS=. read -r color_1 color_2 color_3 color_4 < <(check_config_file)
  read -r color_1 color_2 color_3 color_4 < <(add_default_color $color_1 $color_2 $color_3 $color_4)

  read -r err < <(check_correct_config $color_1 $color_2 $color_3 $color_4)
  if [[ $err != "" ]]; then
    echo "$err" >&2
    return 1
  fi

  read -r color_1 output_1 < <(use_color_output $color_1 1)
  read -r color_2 output_2 < <(use_color_output $color_2 2)
  read -r color_3 output_3 < <(use_color_output $color_3 3)
  read -r color_4 output_4 < <(use_color_output $color_4 4)

  local hostname="$(add_colors $color_1 $color_2 $color_3 $color_4 "HOSTNAME=$(hostname)")"

  local timezone="$(add_colors $color_1 $color_2 $color_3 $color_4 "TIMEZONE = $(check_timezone)")"

  local user="$(add_colors $color_1 $color_2 $color_3 $color_4 "USER = $USER")"

  local os="$(add_colors $color_1 $color_2 $color_3 $color_4 "OS = $(check_os)")"

  local date="$(add_colors $color_1 $color_2 $color_3 $color_4 "DATE = $(date +"%d %B %Y %H:%M:%S")")"

  local uptime="$(add_colors $color_1 $color_2 $color_3 $color_4 "UPTIME = $(check_uptime)")"
  local uptime_sec="$(add_colors $color_1 $color_2 $color_3 $color_4 "UPTIME_SEC = $(check_uptime_sec)")"

  read ip prefix < <(check_ip)
  local ip="$(add_colors $color_1 $color_2 $color_3 $color_4 "IP = $ip")"
  local mask="$(add_colors $color_1 $color_2 $color_3 $color_4 "MASK = $(check_mask $prefix)")"
  local gateway="$(add_colors $color_1 $color_2 $color_3 $color_4 "GATEWAY = $(check_gateway)")"

  local ram_total="$(add_colors $color_1 $color_2 $color_3 $color_4 "RAM_TOTAL = $(check_ram_total)")"
  local ram_used="$(add_colors $color_1 $color_2 $color_3 $color_4 "RAM_USED = $(check_ram_used)")"
  local ram_free="$(add_colors $color_1 $color_2 $color_3 $color_4 "RAM_FREE = $(check_ram_free)")"

  local space_root="$(add_colors $color_1 $color_2 $color_3 $color_4 "SPACE_ROOT = $(check_space_root)")"
  local space_root_used="$(add_colors $color_1 $color_2 $color_3 $color_4 "SPACE_ROOT_USED = $(check_space_root_used)")"
  local space_root_free="$(add_colors $color_1 $color_2 $color_3 $color_4 "SPACE_ROOT_FREE = $(check_space_root_free)")"

  echo -e "$hostname\n$timezone\n$user\n$os\n$date\n$uptime\n$uptime_sec\n$ip\n$mask\n$gateway\n$ram_total
$ram_used\n$ram_free\n$space_root\n$space_root_used\n$space_root_free\n\n$output_1\n$output_2\n$output_3\n$output_4"
}

check_correct_config() {
  if [[ "$1" == "$2" || "$3" == "$4" ]]; then
    echo "Параметры одного столбца не должны совпадать! Исправьте конфиг с этим знанием и запустите скрипт снова :)"
  fi
}

check_config_file() {
  declare -A map_str_conf
  if [[ -f "script.conf" ]]; then
    while IFS="=" read -r column color; do
      map_str_conf["$column"]="$color"
    done <script.conf
  fi

  local color_1="${map_str_conf["column1_background"]}"
  local color_2="${map_str_conf["column1_font_color"]}"
  local color_3="${map_str_conf["column2_background"]}"
  local color_4="${map_str_conf["column2_font_color"]}"

  echo $color_1 $color_2 $color_3 $color_4
}

use_color_output() {
  local colors=("white" "red" "green" "blue" "purple" "black")
  local output=""
  local color=$1
  local column=$2

  if [[ $color =~ ^[0-6]d$ ]]; then
    IFS="d" read -r color <<<$color
    case $column in
    "1") output="Column 1 background = default ("${colors[$(($color - 1))]}")" ;;
    "2") output="Column 1 font color = default ("${colors[$(($color - 1))]}")" ;;
    "3") output="Column 2 background = default ("${colors[$(($color - 1))]}")" ;;
    "4") output="Column 2 font color = default ("${colors[$(($color - 1))]}")" ;;
    esac
  else
    case $column in
    "1") output="Column 1 background = $color  ("${colors[$(($color - 1))]}")" ;;
    "2") output="Column 1 font color = $color ("${colors[$(($color - 1))]}")" ;;
    "3") output="Column 2 background = $color ("${colors[$(($color - 1))]}")" ;;
    "4") output="Column 2 font color = $color ("${colors[$(($color - 1))]}")" ;;
    esac
  fi
  echo $color $output
}

add_default_color() {
  local color_1=$1
  local color_2=$2
  local color_3=$3
  local color_4=$4

  if [[ ! $color_1 =~ ^[1-6]$ ]]; then
    color_1="6d"
  fi

  if [[ ! $color_2 =~ ^[1-6]$ ]]; then
    color_2="1d"
  fi

  if [[ ! $color_3 =~ ^[1-6]$ ]]; then
    color_3="6d"
  fi

  if [[ ! $color_4 =~ ^[1-6]$ ]]; then
    color_4="1d"
  fi

  echo $color_1 $color_2 $color_3 $color_4
}

add_colors() {
  local colors_background=("\033[47m" "\033[41m" "\033[42m" "\033[44m" "\033[45m" "\033[40m")
  local colors_text=("\033[37m" "\033[31m" "\033[32m" "\033[34m" "\033[35m" "\033[30m")
  local end_color="\033[0m"

  IFS="=" read -r head value <<<"$5"

  echo -e "${colors_text[$(($2 - 1))]}${colors_background[$(($1 - 1))]}$head$end_color = ${colors_text[$(($4 - 1))]}${colors_background[$(($3 - 1))]}$value$end_color"
}
