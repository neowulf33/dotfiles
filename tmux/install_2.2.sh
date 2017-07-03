#!/bin/bash

sudo apt-get install -y python-software-properties \
  software-properties-common libevent-dev lib32ncurses5-dev

cd /tmp
wget https://github.com/tmux/tmux/releases/download/2.2/tmux-2.2.tar.gz
tar xvzf tmux-2.2.tar.gz

cd tmux-2.2
./configure --prefix=/usr
make && sudo make install
tmux -V

