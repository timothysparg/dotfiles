#!/bin/bash

main() {
    read_args "$@"
    install_exclude_message

    println "${On_Green}Installing system packages"
    println "${Green}\tGathering packages"
    # set -x
    while read -r pkg; do
        echo "$pkg"
        mapfile -t -O "${#pkgs[@]}" pkgs <$pkg
    done <<<"$(find . -name packages.apt)"

    println "${Green}\tInstalling"
    sudo apt update
    sudo apt install -y --no-install-recommends "${pkgs[@]}"
    setup_ca_certificates

    # find the installers and run them iteratively
    find . -mindepth 2 -name install.sh | while read -r installer; do
        dir_name=${installer//[0-9]/}
        dir_name=$(echo "$dir_name" | awk '{print substr($0,3)}' | cut -d / -f 1)
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

setup_ca_certificates(){
    sudo mkdir /usr/local/share/ca-certificates/cacert.org
    sudo wget -P /usr/local/share/ca-certificates/cacert.org http://www.cacert.org/certs/root.crt http://www.cacert.org/certs/class3.crt
    sudo update-ca-certificates
    git config --global http.sslCAinfo /etc/ssl/certs/ca-certificates.crt
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
