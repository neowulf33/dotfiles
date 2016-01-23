#!/bin/bash

CUR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PERSONAL_DIR="$(cd "${CUR_DIR}" && cd .. && pwd )"

###############################
## FUNCTIONS
###############################

function videa() {
    if [ $(uname) == "Darwin" ]; then
        /Applications/IntelliJ\ IDEA\ 15.app/Contents/MacOS/idea `pwd`/${1}
    else
        idea `pwd`/$1
    fi
}

function ae {
    # gem install airplay airplay-cli airplayer airstream
    #air play $(youtube-dl -g "${@}")
    airstream $(youtube-dl -g "${@}") -o apple-tv ##`air list | grep ip | cut -d ':' -f 3`
}


function parse_git_branch_and_add_brackets {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\ \[\1\]/'
}

function date_txt {
    date +%H%M.%S
}

function memcache_flush_all {
    echo "flush_all" | nc localhost 11211
}

function killtcs {
    ps -ef | \grep Bootstrap | \grep -v 'grep' | awk '{print $2}' | xargs kill -9
}

function od {
    if [ $(uname) == "Darwin" ]; then
      opendiff $1 .svn/text-base/$1.svn-base;
	else
      diff $1 .svn/text-base/$1.svn-base;
	fi
}

function restartvpn {
    sudo launchctl stop com.apple.racoon
    sudo launchctl start com.apple.racoon
}

# Allows for iterm title to be updated - http://superuser.com/a/599156/261889
function iterm_title {
    echo -ne "\033]0;"$*"\007"
}

function mm {
    \grep Service ~/.ssh/magicmirror_formatted.json | \grep --colour $@
}

function local_servers {
    netstat -anp | grep java | awk '{print $4}' | cut -d ':' -f 1 | sort -u | grep \\.
}

function remote_servers {
    netstat -anp | grep java | awk '{print $5}' | cut -d ':' -f 1 | sort -u | grep \\.
}

function _update_brew {

    ### Force uninstalls failed python
    #$ brew uninstall -f python
    
    ### Clear the brew cache
    #$ rm -rf `brew --cache`
    
    ### Recreate the brew cache
    #$ mkdir `brew --cache`
    
    ### Cleanup - cleans up old homebrew files
    #$ brew cleanup
    
    ### Prune - removes dead symlinks in homebrew
    #$ brew prune
    
    ### Doctor - runs homebrew checks for common error causing issues
    #$ brew doctor
    
    brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup
}

function sshvm {
    ssh $(VBoxManage guestproperty get Ubuntu "/VirtualBox/GuestInfo/Net/0/V4/IP" | awk '{print $2}')
}


###############################
## Quick Navigation - Marks - http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
###############################

export MARKPATH=$HOME/.marks
function jump {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark {
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
_completemarks() {
    local curw=${COMP_WORDS[COMP_CWORD]}
    if [ $(uname) == "Darwin" ]; then
      local wordlist=$(find $MARKPATH -type l -print0 | xargs -0 | \sed 's/\/Users\/siva\/.marks\///g')
    else
      local wordlist=$(find $MARKPATH -type l -printf "%f\n")
    fi
    COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
    return 0
}

complete -F _completemarks jump unmark
