#!/usr/bin/env fish

set DIR (cd (dirname (status -f)); and pwd) 

if ! type omf > /dev/null 2>&1;  or `omf --version` != "Oh My Fish version 5" ; 
	curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install > /tmp/omf_install
	/tmp/omf_install --noninteractive
	omf install 
end


ln -fs {$DIR}/omf/init.fish {$OMF_CONFIG}/init.fish
ln -fs {$DIR}/omf/misc {$OMF_CONFIG}/
