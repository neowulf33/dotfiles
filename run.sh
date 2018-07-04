#!/bin/bash

#sudo apt-get update
sudo apt-get install -y tree

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR
./git/run.sh
./fish/run.sh
./tmux/run.sh
