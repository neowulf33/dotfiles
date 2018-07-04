#!/usr/bin/env fish

set DIR (cd (dirname (status -f)); and pwd) 

# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ (uname) == "Darwin" ]
	alias "ij=open -a /Applications/IntelliJ\ IDEA*.app"
	alias ls='ls -G'
else
	alias ls='ls --color=auto'
end

alias grep="grep --color --exclude=\*.svn\*"

alias pj="python -mjson.tool"
alias pp="lsof -i -P"
alias sortdirs="du -k * | sort -n -r | head -n 20"
alias sumdirs="du -k -s * | sort -k1 -g -r"

alias vi="vim -u {$DIR}/../vim/vimrc"

alias activator="activator -mem 512"

alias agl="ag --pager less"

