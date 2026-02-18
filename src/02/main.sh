#!/bin/bash

source ./assembl_output.sh

full_output=$(assembl_full_output)

echo "$full_output"

read -p "Дружок, нужно ли это все занести в файл? (y|n) " user_response

if [[ $user_response == "Y" || $user_response == "y" ]]; then
  echo "$full_output" >"$(date +"%d_%m_%y_%H_%M_%S").status"
  echo "Успех!"
else
  echo "Ну и ладно!"
fi
