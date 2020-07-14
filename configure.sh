#!/usr/bin/env bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 env [tags]"
    exit 1
fi

env=$1
tags=$2

extra_args=
if [[ $tags =~ "base" ]]; then
    extra_args="${extra_args} --ask-vault-pass"
fi

ansible-playbook ${extra_args} \
    --ask-become-pass \
    -i hosts playbook.yml \
    -l "${env}" \
    --extra-vars "@${env}_secret_vars.yaml" \
    --extra-vars "@commons_secret_vars.yaml" \
    --tags "${tags}"

