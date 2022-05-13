#!/bin/bash
source ./tools.sh
repo="https://github.com/$(git remote get-url origin | sed 's/https:\/\/github.com\///' | sed 's/git@github.com://' | sed 's/\.git//')"
base_branch=$(git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n')

# arg 1 validation: branch present
branches=()
eval "$(git for-each-ref --shell --format='branches+=(%(refname))' refs/heads/ | sed 's/refs\/heads\///')"
comparison_branch=$1
if ! containsElement $comparison_branch "${branches[@]}"; then
    echo "Invalid branch '${comparison_branch}'. Run 'git fetch' to fetch latest branches."
    exit 1
fi

## arg 2 validation: comparison mode selected, and if custom, branch present
# n, normal, or blank : comparison_branch <- current repo branch
# r, reverse,         : current repo branch <- comparison_branch
# c, custom,          : comparison_branch <- second_comparison_branch
comparison_mode=$2
if [[ $comparison_mode = "n" ]] || [[ $comparison_mode = "normal" ]] || [[ $comparison_mode = "" ]]; then
  generate_url="${repo}/compare/${comparison_branch}...${base_branch}"
elif [[ $comparison_mode = "r" ]] || [[ $comparison_mode = "reverse" ]]; then
  generate_url="${repo}/compare/${base_branch}...${comparison_branch}"
elif [[ $comparison_mode = "c" ]] || [[ $comparison_mode = "custom" ]]; then
    base_branch=$3
    if containsElement $base_branch "${branches[@]}"; then
        generate_url="${repo}/compare/${comparison_branch}...${base_branch}"
    else
        echo "Invalid branch '${base_branch}'. Run 'git fetch' to fetch latest branches."
        exit 1
    fi
else
    echo "Invalid argument '${comparison_mode}'. Either add argument 'normal', 'reverse', or leave empty."
    exit 1
fi
echo $generate_url
