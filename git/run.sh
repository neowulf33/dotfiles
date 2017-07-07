#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function install_git {
	sudo add-apt-repository -y ppa:git-core/ppa  
	sudo apt-get update  
	sudo apt-get install -y git  
}

[[ `git --version` == "git version 2.13.0" ]] || install_git

ln -fs ${DIR}/gitconfig.symlink ~/.gitconfig
ln -fs ${DIR}/gitignore.symlink ~/.gitignore