#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function install_fish {
	sudo apt-add-repository -y ppa:fish-shell/release-2
	sudo apt-get update
	sudo apt-get install -y fish
	
	sudo sed -i 's/^auth\s\+required\s\+pam_shells.so/auto  sufficient  pam_shells.so/' /etc/pam.d/chsh
	sudo chsh -s `command -v fish`
}

[[ `fish -version` == "fish, version 2.6.0" ]] || install_fish

${DIR}/omf_run.fish