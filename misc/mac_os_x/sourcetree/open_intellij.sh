#!/bin/bash

echo $* 

SCRIPT_DIR=$(dirname $0)
DIR_NAME=$(dirname ${1})
FILE_NAME=$(basename ${1})

. ${SCRIPT_DIR}/../../bashrc/functions.sh

echo "Opening: " $1

pushd ${DIR_NAME}
videa ${FILE_NAME} &
