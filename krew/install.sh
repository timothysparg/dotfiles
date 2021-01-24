#!/bin/bash

current_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
# shellcheck source=../common.sh
source "${current_dir}"/../common.sh

if [ ! -d  ~/.krew/ ]; then
    cd "$(mktemp -d)"
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz"
    tar zxvf krew.tar.gz &&
    KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_$(uname -m | sed -e 's/x86_64/amd64/' -e 's/arm.*$/arm/')" &&
    "$KREW" install krew

    export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

    kubectl krew install access-matrix
    kubectl krew install doctor
    kubectl krew install example
    kubectl krew install rbac-lookup
    kubectl krew install rbac-view
    kubectl krew install sick-pods
    kubectl krew install who-can    
else
    println "${On_Purple}krew already installed"
fi
