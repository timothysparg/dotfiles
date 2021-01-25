#!/bin/bash

current_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
# shellcheck source=../common.sh
source "$current_dir/../common.sh"


if kubeval --version ; then
    current_version=$( kubeval --version | grep Version | cut -d ':' -f2 | xargs)
fi
latest_version=$(get_latest_github_release "instrumenta/kubeval")

println "\tCurrent version: ${current_version}"
println "\tGithub version: ${latest_version}"

if [ "${current_version}" != "${latest_version}" ]; then
    DOWNLOAD_DIR=$(mktemp -d)
    echo "${DOWNLOAD_DIR}"
    cd ${DOWNLOAD_DIR}
    wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz
    tar xf kubeval-linux-amd64.tar.gz
    sudo cp kubeval /usr/local/bin
    cd -
    rm -rf "${DOWNLOAD_DIR}"
fi