#!/bin/bash

current_dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
# shellcheck source=../common.sh
source "${current_dir}"/../common.sh

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -fs "${current_dir}"/tmux.conf ~/.tmux.conf
~/.tmux/plugins/tpm/bin/update_plugins all || ~/.tmux/plugins/tpm/bin/update_plugins all