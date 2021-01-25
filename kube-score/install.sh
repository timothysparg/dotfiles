#!/bin/bash

current_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
# shellcheck source=../common.sh
source "$current_dir/../common.sh"


if kube-score version ; then
    current_version=$(kube-score version | cut -d ':' -f2 | cut -d ',' -f1 | xargs)    
fi
latest_version=$(get_latest_github_release "zegl/kube-score")
latest_version=$(cut -c 2- <<< $latest_version)

println "\tCurrent version: ${current_version}"
println "\tGithub version: ${latest_version}"

if [ "${current_version}" != "${latest_version}" ]; then
    DOWNLOAD_DIR=$(mktemp -d)
    echo "${DOWNLOAD_DIR}"
    cd ${DOWNLOAD_DIR}
    
    wget "https://github.com/zegl/kube-score/releases/latest/download/kube-score_${latest_version}_linux_amd64.tar.gz"
    tar xf kube-score*
    sudo cp kube-score /usr/local/bin
    cd -
    rm -rf "${DOWNLOAD_DIR}"
fi