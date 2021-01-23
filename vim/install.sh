#!/bin/bash

current_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
# shellcheck source=../common.sh
source "${current_dir}"/../common.sh
ln -fs "${current_dir}"/vimrc ~/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# https://octetz.com/docs/2020/2020-01-06-vim-k8s-yaml-support/
# Vim Kuberetes YAML Support
# bad practice dont look here
#  curl -sL install-node.now.sh/lts | sudo bash -s -- --force

# vim -es -u vimrc -i NONE -c "PlugInstall" -c "qa" -c "CocInstall coc-yaml"

vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"