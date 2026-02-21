#!/bin/bash

check_ram_total() {
  read -ra arr < <(free | grep "^Mem:")
  local total=$((${arr[1]} * 1000 / 1024 / 1024))
  local integer=$(($total / 1000))
  local float=$(($total % 1000))
  printf "%d.%03d" "$integer" "$float"
}

check_ram_used() {
  read -ra arr < <(free | grep "^Mem:")
  local total=$((${arr[2]} * 1000 / 1024 / 1024))
  local integer=$(($total / 1000))
  local float=$(($total % 1000))
  printf "%d.%03d" "$integer" "$float"
}

check_ram_free() {
  read -ra arr < <(free | grep "^Mem:")
  local total=$((${arr[3]} * 1000 / 1024 / 1024))
  local integer=$(($total / 1000))
  local float=$(($total % 1000))
  printf "%d.%03d" "$integer" "$float"
}

check_space_root() {
  read -ra arr < <(df | grep "/$")
  local total=$((${arr[1]} * 100 / 1024))
  local integer=$(($total / 100))
  local float=$(($total % 100))
  printf "%d.%02d" "$integer" "$float"
}

check_space_root_used() {
  read -ra arr < <(df | grep "/$")
  local total=$((${arr[2]} * 100 / 1024))
  local integer=$(($total / 100))
  local float=$(($total % 100))
  printf "%d.%02d" "$integer" "$float"
}

check_space_root_free() {
  read -ra arr < <(df | grep "/$")
  local total=$((${arr[3]} * 100 / 1024))
  local integer=$(($total / 100))
  local float=$(($total % 100))
  printf "%d.%02d" "$integer" "$float"
}
