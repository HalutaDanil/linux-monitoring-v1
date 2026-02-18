#!/bin/bash

check_os() {
  read -r os < <(cat /etc/issue)
  os=${os%'\n'*}
  echo "$os"
}
