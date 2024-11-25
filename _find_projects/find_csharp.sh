#!/bin/bash

# Initialize an empty array to store the directories
declare -a result_array=()

# Define the base directory (can be replaced with another directory if needed)
#base_dir="${1:-.}"
base_dir="/mnt/c/modus_create/GitHub/fernandomatsuo-monorepo-csharpcsharp"

# Find all .csproj files, closest to the root directory
# Sort and remove duplicates by folder
mapfile -t result_array < <(
  find "$base_dir" -type f \( -name "*.csproj" \) \
  | awk -F '/' '{paths[$0]=NF} END {for (path in paths) print path}' \
  | sort -t '/' -k2,2
)

# Filter unique directories containing .csproj
result_array=($(for file in "${result_array[@]}"; do dirname "$file"; done | sort -u))

# Print the array of directories
echo "Directories containing .csproj files:"
for dir in "${result_array[@]}"; do
  echo "$dir"
done

echo "projects_list=$(echo "$result_array")" >> $GITHUB_OUTPUT