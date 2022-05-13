#!/bin/bash

# index contains element
# args=()
# containsElement $arg "${args[@]}"
containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

init () {
  repo="https://github.com/$(git remote get-url origin | sed 's/https:\/\/github.com\///' | sed 's/git@github.com://' | sed 's/\.git//')"
  branch=$(git branch | grep '^\*' | cut -d' ' -f2 | tr -d '\n')
}
