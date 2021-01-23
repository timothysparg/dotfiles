#!/bin/bash

set -e
source ./common.sh

println "${On_Green}Installing system packages"
println "${Green}\tGathering packages"
# set -x
while read pkg ;
do
    echo $pkg
    mapfile -t -O "${#pkgs[@]}" pkgs < $pkg
done <<< "$(find . -name packages.apt)"

println "${Green}\tInstalling"
sudo apt update
sudo apt install -y "${pkgs[@]}"

# find the installers and run them iteratively
find . -mindepth 2 -name install.sh | while read installer ;
do 
    dir_name=${installer//[0-9]/ } 
    echo ${dir_name}
    println "Installing ${Green}${dir_name}"
    sh -c "chmod +x ${installer} && ${installer}" ; 
done
