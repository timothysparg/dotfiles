#!/bin/bash

current_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source $current_dir/../common.sh

git clone --depth=1 https://github.com/ryanoasis/nerd-fonts $current_dir/nerd-fonts
cd nerd-fonts
./install.sh "JetBrainsMono"