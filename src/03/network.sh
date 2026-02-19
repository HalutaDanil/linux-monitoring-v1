#!/bin/bash

check_ip() {
  local ip_a=""
  while read -r num _ _ ip _; do
    [[ $num == "2:" ]] || continue
    ip_a=$ip
  done < <(ip -o -4 a)
  local ip=${ip_a%/*}
  local prefix=${ip_a#*/}
  echo $ip $prefix
}

check_mask_bin() {
  local mask_bin=""
  for ((i = 1; i <= 32; i++)); do
    if [[ $i -le $1 ]]; then
      mask_bin+="1"
    else
      mask_bin+="0"
    fi
  done
  echo $mask_bin
}

check_mask() {
  local mask_bin=$(check_mask_bin $1)
  local j=7
  local sum_bin=0
  local mask=""
  local bit=""
  for ((i = 0; i < ${#mask_bin}; i++)); do
    local bit=${mask_bin:i:1}
    ((sum_bin += bit * (1 << j)))
    ((j--))
    if (((i + 1) % 8 == 0)); then
      if [[ $i -gt 24 ]]; then
        mask+="$sum_bin"
      else
        mask+="$sum_bin."
      fi
      j=7
      sum_bin=0
      continue
    fi
  done
  echo $mask
}

check_gateway() {
  read -r _ _ gateway _ < <(ip r | grep "default")
  echo $gateway
}
