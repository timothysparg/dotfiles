#!/bin/bash

main() {
    read_args "$@"
    install_exclude_message

    println "${On_Green}Installing system packages"
    println "${Green}\tGathering packages"
    # set -x
    while read -r pkg; do
        dir_name=$(installerName "${pkg}")
        if [[ -n "${install_exclude}" && "${dir_name}" == *"${install_exclude}"* ]]; then
            println "${BYellow}\tIgnoring apt packages from ${dir_name}"
        else
            println "${BBlue}\t${pkg}"
            mapfile -t -O "${#pkgs[@]}" pkgs <"${pkg}"
        fi
    done <<<"$(find . -name packages.apt)"

    println "${On_Green}Installing"
    sudo apt update
    sudo apt install -y --no-install-recommends "${pkgs[@]}"

    # find the installers and run them iteratively
    find . -mindepth 2 -name install.sh | while read -r installer; do
        dir_name=$(installerName "${installer}")
        if [[ -n "${install_exclude}" && "${dir_name}" == *"${install_exclude}"* ]]; then
            install_exclude_message "${dir_name}"
        else
            println "Installing ${Green}${dir_name}"
            sh -c "chmod +x ${installer} && ${installer}"
        fi
    done
}

# https://stackoverflow.com/a/14203146/10862061
read_args() {
    POSITIONAL=()
    while [[ $# -gt 0 ]]; do
        key="$1"

        case $key in
        -e | --exclude)
            install_exclude="$2"
            shift # past argument
            shift # past value
            ;;
        *)                     # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift              # past argument
            ;;
        esac
    done
    set -- "${POSITIONAL[@]}" # restore positional parameters
}

install_exclude_message() {
    if [ -n "$install_exclude" ]; then
        if [ $# -eq 0 ]; then
            println "${On_IRed}Excluding ${BWhite}${install_exclude}"
        else
            println "${On_IRed}Excluding ${BWhite}$1"
        fi
    fi
}

set -e
source ./common.sh
main "$@"
