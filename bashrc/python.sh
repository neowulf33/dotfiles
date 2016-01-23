#!/bin/bash

# http://docs.python-guide.org/en/latest/dev/virtualenvs/#virtualenv
# http://www.jontourage.com/2011/02/09/virtualenv-pip-basics/
# http://mkelsey.com/2013/04/30/how-i-setup-virtualenv-and-virtualenvwrapper-on-my-mac/

## brew install python3
## gpip install virtualenv virtualenvwrapper

alias pip=pip3
alias python=python3

export PATH="/usr/local/bin:${PATH}"

## http://hackercodex.com/guide/python-development-environment-on-mac-osx/

# set where virutal environments will live
export WORKON_HOME=$HOME/.virtualenvs

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3

# export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv

# ensure all new environments are isolated from the site-packages directory
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'

# use the same directory for virtualenvs as virtualenvwrapper
export PIP_VIRTUALENV_BASE=$WORKON_HOME

# makes pip detect an active virtualenv and install to it
export PIP_RESPECT_VIRTUALENV=true
if [[ -r /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
else
    echo "WARNING: Can't find virtualenvwrapper.sh"
fi

# To allow for global pip installation
gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
