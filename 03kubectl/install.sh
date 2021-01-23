#!/bin/bash

current_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source $current_dir/../common.sh

if ! command -v kubectl &> /dev/null
then
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
fi