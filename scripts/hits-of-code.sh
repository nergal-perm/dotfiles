#!/bin/bash
#
# Check if a date argument is provided
if [ "$#" -ne 1 ]; then
	date_arg=$(date -d "yesterday" +"%Y-%m-%d")
else
	date_arg="$1"
fi

echo "Getting statistics for $date_arg"

# List of Git repository directories
repo_dirs=(
    "/home/eugene/Dev/vn/sales-market"
    "/home/eugene/Dev/DDD/logic-checker"
)

total_sum=0

# Function to sum numbers from git log output
sum_numbers() {
	local total_sum=$1
    while read -r line; do
        if [[ $line =~ ^([0-9]+)$'\t'([0-9]+) ]]; then
            num1=${BASH_REMATCH[1]}
            num2=${BASH_REMATCH[2]}
            total_sum=$((total_sum + num1 + num2))
        fi
    done
    echo "$total_sum"
}

# Iterate over Git repositories
for repo_dir in "${repo_dirs[@]}"; do
    echo "Processing repository: $repo_dir"
    
    # Change to the repository directory
    pushd "$repo_dir" > /dev/null
    
    total_sum=$(git log --pretty=tformat: --numstat --ignore-space-change --ignore-all-space --ignore-submodules --no-color --find-copies-harder -M --diff-filter=ACDM --after="$date_arg" --author=nergal --author=eterehov --all | sum_numbers "$total_sum")
    
    # Return to the previous directory
    popd > /dev/null
done

echo "Hits-of-code: $total_sum"
