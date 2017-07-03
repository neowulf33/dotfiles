#!/bin/bash

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PERSONAL_DIR="$(cd "${CUR_DIR}" && cd .. && pwd )"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ${HOME}/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ $(uname) == "Darwin" ]; then
	# gsed is a sed from cellar
	# alias sed="gsed"
	alias "ij=open -a /Applications/IntelliJ\ IDEA\ 13.app"
	alias ls='ls -G'
else
	alias ls='ls --color=auto'
fi

alias grep="grep --color --exclude=\*.svn\*"
#alias killtcs="ps -ef | mgrep -i bootstrap | awk '{print $2}' | xargs kill"
alias mgrep="grep -v grep | grep"
alias pj="python -mjson.tool"
alias pp="lsof -i -P"
alias sortdirs="du -k * | sort -n -r | head -n 20"
alias sumdirs="du -k -s * | sort -k1 -g -r"
alias t="${PERSONAL_DIR}/misc/todo.txt-cli/todo.sh -d ${PERSONAL_DIR}/sub_directory_configs/todo/todo.cfg"
alias vi="vim -u ${PERSONAL_DIR}/configs/vim/vimrc"

alias activator="activator -mem 512"

alias agl="ag --pager less"

# alias enclock="fusermount -u ${HOME}/.passwords"
# alias sc="enclock  && gnome-screensaver-command --lock"
# alias unlock="(df | grep '/home/siva/.passwords' > /dev/null) || encfs ${HOME}/.passwords.encrypted ${HOME}/.passwords"
# function encrypt() { openssl des3 -e -a -in $1 -out $1.des3; mv $1.des3 $1; }
# function decrypt() { openssl des3 -d -a -in $1 -out $1.tmp; mv $1.tmp $1; }