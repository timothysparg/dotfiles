#!/bin/bash

current_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
# shellcheck source=../common.sh
source "${current_dir}"/../common.sh

if [ ! -d /usr/local/share/ca-certificates/cacert.org ]; then
    sudo mkdir /usr/local/share/ca-certificates/cacert.org
    sudo wget -P /usr/local/share/ca-certificates/cacert.org http://www.cacert.org/certs/root.crt http://www.cacert.org/certs/class3.crt
    sudo update-ca-certificates
    git config --global http.sslCAinfo /etc/ssl/certs/ca-certificates.crt
fi