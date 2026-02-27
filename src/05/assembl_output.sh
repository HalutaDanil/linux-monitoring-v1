#!/bin/bash

assebl() {
  local err
  err="$(check_input "$1")"

  if [[ -n $err ]]; then
    printf "%s\n" "$err" >&2
    return 1
  fi

  folders "$1"
  file "$1"
  top_all_file "$1"
  top_exec_file "$1"
}

check_input() {
  local path="$1"

  if [[ "$path" == "" ]]; then
    printf "Параметр обязателен! И должен содержать абсолютный или относительный путь до папки!"
  elif [[ ! "$path" =~ /$ ]]; then
    printf "Параметр должен должен содержать / в конце!"
  elif [[ ! -d "$path" ]]; then
    printf "Такой директории не сущестует!"
  fi
}

convert() {
  local bytes=$1
  local unit_measurm=("B" "KB" "MB" "GB")
  local i=0

  while (($i < 3)); do
    if [[ $(($bytes / 1024)) -gt 0 ]]; then
      bytes=$(($bytes / 1024))
    else
      break
    fi
    ((i++))
  done

  printf "%s" "$bytes ${unit_measurm[$i]}"
}

type_file() {
  local file_name="$1"
  IFS=/ read -ra arr <<<"$file_name"
  IFS=. read -r name type <<<"${arr[-1]}"

  if [[ $type == "" || $name == "" ]]; then
    type="unknown"
  fi

  printf "%s" "$type"
}

hash_file() {
  local file_name="$1"
  read -r hash _ < <(md5sum "$file_name")
  printf "%s" "$hash"
}

top_exec_file() {
  local path="$1"
  printf "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):\n"
  local i=1

  while read -r size path_to_file; do
    printf "%d - %s, %s, %s\n" "$i" "$path_to_file" "$(convert "$size")" "$(hash_file "$path_to_file")"
    ((i++))
  done < <(find "$path" -type f -executable -printf "%s %p\n" | sort -rn | head -10)
}

top_all_file() {
  local path="$1"
  printf "TOP 10 files of maximum size arranged in descending order (path, size and type):\n"
  local i=1

  while read -r size path_to_file; do
    printf "%d - %s, %s, %s\n" "$i" "$path_to_file" "$(convert $size)" "$(type_file "$path_to_file")"
    ((i++))
  done < <(find "$path" -type f -printf "%s %p\n" | sort -rn | head -10)
}

folders() {
  local path="$1"
  printf "Total number of folders (including all nested ones) = %d\n" "$(du -h "$path" | wc -l)"
  printf "TOP 5 folders of maximum size arranged in descending order (path and size):\n"
  local i=1

  while read -r size path_to_folder; do
    if [[ $path_to_folder != $path ]]; then
      printf "%d - %s, %s\n" "$i" "$path_to_folder" "$size"
      ((i++))
    fi
  done < <(du -h "$path" | sort -hr | head -6)
}

file() {
  local path="$1"
  printf "Total number of files = %d\nNumber of:\n" "$(find "$path" \( -type f -o -type l \) | wc -l)"
  local count_conf=0
  local count_text=0
  local count_exec=0
  local count_log=0
  local count_archive=0
  local count_link=0

  while IFS= read -r -d '' file; do
    if [[ -L "$file" ]]; then
      ((count_link++))
    elif [[ "$file" == *.log ]]; then
      ((count_log++))
    elif [[ "$file" == *.conf ]]; then
      ((count_conf++))
    elif case "$file" in
      *.tar | *.gz | *.tgz | *.bz2 | *.xz | *.zip | *.7z | *.rar) true ;;
      *) false ;;
      esac then
      ((count_archive++))
    elif [[ -x "$file" ]]; then
      ((count_exec++))
    elif case "$file" in
      *.txt | *.md | *.csv | *.json | *.xml | *.html | *.css | *.js | *.py | *.sh) true ;;
      *) false ;;
      esac then
      ((count_text++))
    fi
  done < <(find "$path" \( -type f -o -type l \) -print0)

  printf "Configuration files (with the .conf extension) = %d\n" "$count_conf"
  printf "Text files = %d\n" "$count_text"
  printf "Executable files = %d\n" "$count_exec"
  printf "Log files (with the extension .log) = %d\n" "$count_log"
  printf "Archive files = %d\n" "$count_archive"
  printf "Symbolic links = %d\n" "$count_link"
}
