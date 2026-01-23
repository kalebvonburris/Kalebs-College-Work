#! /usr/bin/env sh

total_lines=0

if [ "$#" -eq 0 ]; then
  set -- "$PWD"
fi

index=0

files_list=()

for arg in "$@"; do
  files_list[index]="$(find "$arg" -type f)"
  index=$index+1
done

for arg in "${files_list[@]}"; do
  cat $arg | while read line; do
    echo "$line"
    total_lines=$total_lines+1
  done
done

echo $total_lines
