#! /usr/bin/env sh

total_lines=0

if [ "$#" -eq 0 ]; then
  set -- "."
fi

for arg in "$@"; do
  files=()
  mapfile -t files <"$(find)"
  echo $files
done

echo $total_lines
