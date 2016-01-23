#!/bin/bash

# Usage:
#   Script to run: /PATH/TO/personal/mac_os_x/sourcetree/open_rep.sh
#   Parameters   : $REPO http://mod.lge.com/code/projects/FIM/repos/

set -x

REPO_NAME=$(basename ${1})

open "${2}/${REPO_NAME}"
