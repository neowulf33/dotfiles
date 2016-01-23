#!/bin/bash

export LC_CTYPE=C

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PERSONAL_DIR="$(cd "${CUR_DIR}" && cd .. && pwd )"

. ${CUR_DIR}/bash_aliases.sh

. ${CUR_DIR}/functions.sh

. ${CUR_DIR}/docker.sh

#. ${CUR_DIR}/python.sh

source ${CUR_DIR}/../misc/todo.txt-cli/todo_completion

###############################
## PROMPT
###############################
PS1='`date "+%H%M.%S"` \u@\h:\W\$ '
# Mint Flavor
PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\]"
PS1="\$(date_txt) \u@\h:\W\[\033[0;32m\]\$(parse_git_branch_and_add_brackets)\[\033[0m\] \$ "

###############################
## HISTORY
###############################
# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# Add "shopt -s checkwinsize" to your .bashrc to make sure terminals wrap lines correctly after resizing them.
# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
export LESS="-XgmR"
[ -x lesspipe.sh ] && eval "$(SHELL=/bin/sh lesspipe)"

###############################
## ENV VARIABLES
###############################

if [ $(uname) == "Darwin" ]; then
	#export EDITOR='mate -w'
	export EDITOR='vim'
	#export JAVA_HOME=$(/usr/libexec/java_home)
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_76.jdk/Contents/Home"
	export GROOVY_HOME="/usr/local/Cellar/groovy/2.1.1/libexec"
	export GIT_EDITOR="mate -w -l 1"
	export M3_HOME="/usr/local/Cellar/maven/3.2.3"
    export PATH="${M2_HOME}:${PERSONAL_DIR}/bin/mac_os_x:${PERSONAL_DIR}/bin/git:${PATH}"
	export SCALA_HOME="/usr/local/opt/scala/idea"
else
    export EDITOR="vi"
	export SVN_EDITOR="vi"
	export JAVA_HOME="/usr/lib/jvm/java-6-sun"
fi

export MAVEN_OPTS="-Xms128m -Xmx512m"
export PATH="${JAVA_HOME}:${PERSONAL_DIR}/bin:${PATH}"

# homebrew sbt uses this file
# http://stackoverflow.com/a/8332600/1216965
SBT_OPTS="-XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M"

source /usr/local/opt/autoenv/activate.sh
