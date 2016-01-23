#!/bin/sh

# TextMate2 installed in ~/Applications
# http://wiki.macromates.com/Main/SubversionCheckout

pushd ${HOME}/Library/Application\ Support/TextMate/Managed/Bundles
export LC_CTYPE=en_US.UTF-8
svn update
echo "--Textmate bundles updated..."
echo

#cd groovy.tmbundle
#git pull origin master
#echo "--Textmate groovy bundle updated..."

# hg clone https://bitbucket.org/croach/json.tmbundle
#pushd json.tmbundle
#hg pull
#echo "--Textmate json bundle updated..."
#popd

# git clone git://github.com/alkemist/Confluence.tmbundle.git
pushd Confluence.tmbundle > /dev/null
git pull origin master
echo "--Textmate Confluence bundle updated..."
popd > /dev/null

# 
# git clone git://github.com/l15n/fish-tmbundle.git "fish.tmbundle"
pushd fish.tmbundle > /dev/null
git pull origin master
echo "--Textmate Fish bundle updated..."
popd > /dev/null

#
# git clone https://github.com/miksago/jade-tmbundle Jade.tmbundle
pushd Jade.tmbundle > /dev/null
git pull origin master
echo "--Textmate Jade bundle updated..."
popd > /dev/null

#
# git clone https://github.com/xdbr/TextMate-Bundle-plantuml.git 

popd
#osascript -e 'tell app "TextMate" to reload bundles'
