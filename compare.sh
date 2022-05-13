#!/bin/bash
source misc/helper.sh; init;
base_branch=$branch

# arg 1 validation: branch present
branches=()
eval "$(git for-each-ref --shell --format='branches+=(%(refname))' refs/heads/ | sed 's/refs\/heads\///')"
comparison_branch=$1
if ! containsElement $comparison_branch "${branches[@]}"; then
    echo "Error: Invalid branch '${comparison_branch}'. Run 'git fetch' to fetch latest branches."
    exit 1
fi

## arg 2 validation: comparison mode selected, and if custom, arg 3 validation branch present
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
        echo "Error: Invalid branch '${base_branch}'. Run 'git fetch' to fetch latest branches."
        exit 1
    fi
else
    echo "Error: Invalid argument '${comparison_mode}'. Either add argument 'normal', 'reverse', or leave empty."
    exit 1
fi


## ensure that branch not compared against self
if [[ $comparison_branch = $base_branch ]]; then
    echo "Error: Attempting to compare branch '${comparison_branch}' against itself."
    exit 1
else
    echo $generate_url
fi
