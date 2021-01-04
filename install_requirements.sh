#!/usr/bin/env bash

set -eou pipefail

if [ ! -d ansible_stdout_compact_logger ]; then
    git clone https://github.com/octplane/ansible_stdout_compact_logger.git
fi

ansible-galaxy install --role-file requirements.yml --roles-path ./external_roles $@

function lnIfNotExists() {
    src=$1
    dst=$2
    if [ ! -e $dst ]; then
        ln -sv $src $dst
    fi
}

secretConfRoot=/media/data_master/server_backup/configuration
if [ -d ${secretConfRoot} ] ; then
    echo "Linking secret configurations..."
    lnIfNotExists ${secretConfRoot}/commons.yaml commons_secret_vars.yaml
    lnIfNotExists ${secretConfRoot}/devm_server.yaml home_devm_secret_vars.yaml
    lnIfNotExists ${secretConfRoot}/home_server.yaml home_secret_vars.yaml
    lnIfNotExists ${secretConfRoot}/work_headless_secret_vars.yaml work_headless_secret_vars.yaml
    lnIfNotExists ${secretConfRoot}/work_station_server.yaml work_station_secret_vars.yaml
fi

