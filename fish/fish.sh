# Install latest fish
sudo apt-add-repository ppa:fish-shell/release-2
sudo apt-get update
sudo apt-get install -y fish

# Install OMF
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish
