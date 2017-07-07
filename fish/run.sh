#!/usr/bin/env bash

sudo apt-add-repository -y ppa:fish-shell/release-2
sudo apt-get update
sudo apt-get install -y fish

sudo sed -i 's/^auth\s\+required\s\+pam_shells.so/auto  sufficient  pam_shells.so/' /etc/pam.d/chsh
sudo chsh -s `command -v fish`
fish

# Install OMF
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish
omf install 

