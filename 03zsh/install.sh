#!/bin/bash

current_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
# shellcheck source=../common.sh
source "$current_dir/../common.sh"

if [ ! -d ~/.oh-my-zsh ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    sudo chsh -s /bin/zsh "$(whoami)"
    ln -fs "$current_dir"/zshrc ~/.zshrc

    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

    curl -L https://github.com/alecthomas/chroma/releases/download/v0.8.2/chroma-0.8.2-linux-amd64.tar.gz -o chroma-0.8.2-linux-amd64.tar.gz
    mkdir chroma
    tar xvf chroma-0.8.2-linux-amd64.tar.gz -C chroma
    sudo cp chroma/chroma /usr/local/bin/chroma
    rm -rf chroma-0.8.2-linux-amd64.tar.gz chroma
else
    println "${On_Purple}zsh already installed"
fi