#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function install_tmux {
	sudo apt-get install -y python-software-properties \
	  software-properties-common libevent-dev lib32ncurses5-dev

	cd /tmp
	wget https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz
	tar xvzf tmux-2.5.tar.gz

	cd tmux-2.5
	./configure --prefix=/usr
	make && sudo make install
}


[[ `tmux -V` == "tmux 2.5" ]] || install_tmux

ln -fs ${DIR}/tmux.conf.symlink ~/.tmux.conf
