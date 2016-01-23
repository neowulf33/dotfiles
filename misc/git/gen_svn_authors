#!/usr/bin/env bash

# http://technicalpickles.com/posts/creating-a-svn-authorsfile-when-migrating-from-subversion-to-git/

svn log -q | grep -e '^r' | awk -F, 'BEGIN { FS = "|" } ; { print $2 > "./authors_nonunique.txt" }'
sort -u authors_nonunique.txt > authors.txt
sed -i 's/^ //g' authors.txt

while read author; do
    firstname=$(echo ${author} | cut -d ' ' -f 1)
    lastname=$(echo ${author} | cut -d ' ' -f 2)
    echo "${author} = ${author} <${firstname}.${lastname}@palm.com>";
done < authors.txt

rm authors.txt authors_nonunique.txt