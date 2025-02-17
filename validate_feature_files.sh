#!/bin/bash

# Base directory for
repo_a_dir=redcap_rsvc

exitCode=0

# Required to retain variables from the while loop's subshell
shopt -s lastpipe

# Find all `.feature` files in Repo A
find "$repo_a_dir" -type f -name "*.feature" | while read -r file; do
  # Extract the directory and filename
  dir=${file%/*}
  base=${file##*/}

  # Match and extract the parts of the filename
  if [[ "$base" =~ ([A-C]\.[0-9]+\.[0-9]+\.)[0-9]+ ]]; then
    prefix="${BASH_REMATCH[1]}"                # Prefix up to the third period
    number="${base:${#prefix}:$((${#base} - ${#prefix}))}" # Extract after prefix
    number="${number%%[^0-9]*}"                # Extract numeric portion
    number=$((10#$number))                     # Ensure number is treated as decimal
    padded_number=$(printf "%04d" "$number")   # Pad number to 4 digits
    suffix="${base#* - }"                      # Suffix after " - "

    # Pad the number to four digits
    padded_number=$(printf "%04d" "$number")

    # Construct the new filename
    new_base="${prefix}${padded_number}. - ${suffix}"

    # echo "Processing file: $file"
    # echo "Prefix: $prefix"
    # echo "Number: $number"
    # echo "Suffix: $suffix"
    # echo "New Base: $new_base"

    if [ "$file" != "$dir/$new_base" ]; then
      echo "Invalid feature file name: Expected \"$dir/$new_base\" but found \"$file\"."
      exitCode=1
    fi

    # Uncomment this line to rename the file
    # mv "$file" "$dir/$new_base"
  fi
done

if [ $exitCode -ne 0 ]; then
  echo
  echo "Either rename the files above manually, or uncomment the 'mv' line above to allow this script do it automatically."
fi

exit $exitCode