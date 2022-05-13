#!/bin/bash
source misc/helper.sh; init;
echo "Copied '${branch}' to clipboard!"
echo $branch | pbcopy
