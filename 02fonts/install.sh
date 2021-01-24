#!/bin/bash

download(){
    base_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono"
    subfolder="$1"
    font=$(urlEncode "$2")
    
    url="${base_url}/${subfolder}/${font}"
    curl -fLo "$2" "$url"
}

current_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
# shellcheck source=../common.sh
source "$current_dir/../common.sh"

if [ ! -d ~/.local/share/fonts ]; then
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts

    download 'Bold-Italic/complete' 'JetBrains Mono Bold Italic Nerd Font Complete Mono Windows Compatible.ttf'
    download 'Bold-Italic/complete' 'JetBrains Mono Bold Italic Nerd Font Complete Mono.ttf'
    download 'Bold-Italic/complete' 'JetBrains Mono Bold Italic Nerd Font Complete Windows Compatible.ttf'
    download 'Bold-Italic/complete' 'JetBrains Mono Bold Italic Nerd Font Complete.ttf'

    download 'Bold/complete' 'JetBrains Mono Bold Nerd Font Complete Mono Windows Compatible.ttf'
    download 'Bold/complete' 'JetBrains Mono Bold Nerd Font Complete Mono.ttf'
    download 'Bold/complete' 'JetBrains Mono Bold Nerd Font Complete Windows Compatible.ttf'
    download 'Bold/complete' 'JetBrains Mono Bold Nerd Font Complete.ttf'

    download 'ExtraBold-Italic/complete' 'JetBrains Mono ExtraBold Italic Nerd Font Complete Mono Windows Compatible.ttf'
    download 'ExtraBold-Italic/complete' 'JetBrains Mono ExtraBold Italic Nerd Font Complete Mono.ttf'
    download 'ExtraBold-Italic/complete' 'JetBrains Mono ExtraBold Italic Nerd Font Complete Windows Compatible.ttf'
    download 'ExtraBold-Italic/complete' 'JetBrains Mono ExtraBold Italic Nerd Font Complete.ttf'

    download 'ExtraBold/complete' 'JetBrains Mono ExtraBold Nerd Font Complete Mono Windows Compatible.ttf'
    download 'ExtraBold/complete' 'JetBrains Mono ExtraBold Nerd Font Complete Mono.ttf'
    download 'ExtraBold/complete' 'JetBrains Mono ExtraBold Nerd Font Complete Windows Compatible.ttf'
    download 'ExtraBold/complete' 'JetBrains Mono ExtraBold Nerd Font Complete.ttf'

    download 'Italic/complete' 'JetBrains Mono Italic Nerd Font Complete Mono Windows Compatible.ttf'
    download 'Italic/complete' 'JetBrains Mono Italic Nerd Font Complete Mono.ttf'
    download 'Italic/complete' 'JetBrains Mono Italic Nerd Font Complete Windows Compatible.ttf'
    download 'Italic/complete' 'JetBrains Mono Italic Nerd Font Complete.ttf'

    download 'Medium-Italic/complete' 'JetBrains Mono Medium Italic Nerd Font Complete Mono Windows Compatible.ttf'
    download 'Medium-Italic/complete' 'JetBrains Mono Medium Italic Nerd Font Complete Mono.ttf'
    download 'Medium-Italic/complete' 'JetBrains Mono Medium Italic Nerd Font Complete Windows Compatible.ttf'
    download 'Medium-Italic/complete' 'JetBrains Mono Medium Italic Nerd Font Complete.ttf'

    download 'Medium/complete' 'JetBrains Mono Medium Nerd Font Complete Mono Windows Compatible.ttf'
    download 'Medium/complete' 'JetBrains Mono Medium Nerd Font Complete Mono.ttf'
    download 'Medium/complete' 'JetBrains Mono Medium Nerd Font Complete Windows Compatible.ttf'
    download 'Medium/complete' 'JetBrains Mono Medium Nerd Font Complete.ttf'

    download 'Regular/complete' 'JetBrains Mono Regular Nerd Font Complete Mono Windows Compatible.ttf'
    download 'Regular/complete' 'JetBrains Mono Regular Nerd Font Complete Mono.ttf'
    download 'Regular/complete' 'JetBrains Mono Regular Nerd Font Complete Windows Compatible.ttf'
    download 'Regular/complete' 'JetBrains Mono Regular Nerd Font Complete.ttf'
else
    println "${On_Purple}fonts already installed"
fi