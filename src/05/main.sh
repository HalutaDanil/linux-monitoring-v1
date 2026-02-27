#!/bin/bash

source ./assembl_output.sh

SECONDS=0

full_output=$(assebl $1)

if [[ -n full_output ]]; then
  printf "%s\nScript execution time (in seconds) = %d\n" "$full_output" "$SECONDS"
fi
