#!/bin/bash

source ./assembl_output.sh

full_output=$(assembl_full_output $1 $2 $3 $4)
if [[ $full_output != "" ]]; then
  echo "$full_output"
fi
