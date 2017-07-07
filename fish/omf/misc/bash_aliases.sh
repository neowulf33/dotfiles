#!/bin/bash

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PERSONAL_DIR="$(cd "${CUR_DIR}" && cd .. && pwd )"

# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ $(uname) == "Darwin" ]; then
	alias "ij=open -a /Applications/IntelliJ\ IDEA\ 13.app"
	alias ls='ls -G'
else
	alias ls='ls --color=auto'
fi

alias grep="grep --color --exclude=\*.svn\*"

alias pj="python -mjson.tool"
alias pp="lsof -i -P"
alias sortdirs="du -k * | sort -n -r | head -n 20"
alias sumdirs="du -k -s * | sort -k1 -g -r"
alias vi="vim -u ${PERSONAL_DIR}/configs/vim/vimrc"

alias activator="activator -mem 512"

alias agl="ag --pager less"

