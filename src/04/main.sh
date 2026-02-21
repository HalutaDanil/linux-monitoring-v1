#!/bin/bash

source ./assembl_output.sh

full_output=$(assembl_full_output)

if [[ $full_output != "" ]]; then
  echo "$full_output"
fi
