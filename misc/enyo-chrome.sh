#!/bin/bash

/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --user-data-dir=${HOME}/applications/chrome/datadir --allow-file-access-from-files --disable-web-security --allow-outdated-plugins --always-authorize-plugins $@ %U > /dev/null 2> /dev/null &

#/usr/lib/chromium-browser/chromium-browser --user-data-dir=/home/siva/.config/google-chrome/Testing --allow-file-access-from-files --disable-web-security %U

#/opt/google/chrome/google-chrome --user-data-dir=/home/siva/google-chrome/Testing --allow-file-access-from-files --disable-web-security $@ %U

#/usr/lib/chromium-browser/chromium-browser --user-data-dir=/home/siva/.config/google-chrome/Testing --allow-file-access-from-files --disable-web-security --allow-outdated-plugins --always-authorize-plugins $@ %U
