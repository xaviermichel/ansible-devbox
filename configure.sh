#!/usr/bin/env bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 env [tags]"
    exit 1
fi

env=$1
tags=$2

ansible-playbook --ask-become-pass -i hosts playbook.yml --extra-vars "@${env}_secret_vars.yaml" --extra-vars "@commons_secret_vars.yaml" --tags "${tags}"

