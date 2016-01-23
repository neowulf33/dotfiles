#!/bin/bash

## from http://blogs.coreboot.org/blog/2010/08/27/git-svn-info-unable-to-determine-upstream-svn-information-from-working-tree-history/

git log|
        grep git-svn-id|
        sed 's/.*git-svn-id:[[:blank:]]*\([^@]\+\)@[0-9]\+[[:blank:]]\+\([^[:blank:]]\+\)/\1 \2/'|
        sort|
        uniq|
        while read url uuid; do
                revision=$(git log --grep="git-svn-id.*$uuid"|grep git-svn-id|sed 's/.*@//;s/[[:blank:]].*//'|sort -n|tail -1)
                author=$(git log --grep="git-svn-id: $url@$revision $uuid" --pretty=format:"%an")
                #date=$(git log --grep="git-svn-id: $url@$revision $uuid" --pretty=format:"%ad" --date=local)
                #echo "Path: "
                echo "URL: $url"
                #echo "Repository Root: "
                echo "Repository UUID: $uuid"
                echo "Revision: $revision"
                #echo "Node Kind: "
                #echo "Schedule: "
                echo "Last Changed Author: $author"
                #echo "Last Changed Rev: "
                #echo "Last Changed Date: "
        done
