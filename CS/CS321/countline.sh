#! /usr/bin/env sh

total_lines=0

# Reset error.txt
true >errors.txt

# Check all files in dir if no input provided
if [ $# -eq 0 ]; then
  # Append all files in dir to $@
  # Magic: `set --` resets all positional parameters
  # and then the `*` expands to all files in the current directory
  # which set then appends to $@
  set -- *
fi
for var in "$@"; do
  # Collect all files
  files=$(find "$var" -type f 2>>errors.txt)
  for file in $files; do
    # Count the number of lines in each file
    # Using grep here because wc -l counts newlines,
    # not actual lines written.
    # Additionally, we redirect stderr to errors.txt
    lines=$(grep -c ^ "$file" 2>>errors.txt)
    # Check for an error
    if [ $? -ne 0 ]; then
      continue
    fi
    # Add the number of lines to the total
    total_lines=$((total_lines + lines))
  done
done
echo "Total number of lines: $total_lines"
