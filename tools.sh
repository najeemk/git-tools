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