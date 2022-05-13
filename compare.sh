#!/bin/bash

read -p "Repository URL: " repo_url

read -p "Branch to Compare From: " branch_from
echo "Comparing From: $branch_from"

read -p "Branch to Compare To   : " branch_to
echo "Comparing To: $branch_to"
