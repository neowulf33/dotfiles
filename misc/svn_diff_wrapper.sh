#!/bin/sh

#URL: http://dtobi.wordpress.com/2010/05/27/use-filemerge-with-svn-diff/

DIFF="$(which opendiff)"
$DIFF $6 $7
