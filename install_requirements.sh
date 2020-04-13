#!/usr/bin/env bash

if [ ! -d ansible_stdout_compact_logger ]; then
    git clone https://github.com/octplane/ansible_stdout_compact_logger.git
fi

ansible-galaxy install --role-file requirements.yml --roles-path ./external_roles $@

