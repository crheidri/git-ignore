#!/bin/bash
## DESCRIPTION:
## This script sources .gitignore templates from https://github.com/github/gitignore
## to the current directory.
##
## See ./gitignore.sh --help for more help.
##
## AUTHOR: Casey Heidrich
## LICENSE: GNU General Public License
## UPDATED: 7/9/2018

# usage
usage() {
    echo "usage: ./gitignore.sh [-g] gitignore_name"
    echo "  -g, --global      Look for global template (operating system or editor specific)."
    echo
    echo "This script sources .gitignore templates from https://github.com/github/gitignore"
    exit 1
}

# parse variables
global=
name=
while [ "$1" != "" ]; do
    case "$1" in
        -g | --global )     global=1
                            ;;
        -h | --help )       usage
                            exit
                            ;;
        * )                 name=$1
    esac
    shift
done

# find gitignore url
baseurl="https://raw.githubusercontent.com/github/gitignore/master"
if [ -z "$global" ]
then
    url="$baseurl/$name.gitignore"
else
    url="$baseurl/Global/$name.gitignore"
fi

# check if url exists
status=$(curl -s --head -w %{http_code} $url -o /dev/null)
if [ "$status" = "404" ]
then
    echo "No gitignore template found for '$name'. Check case-sensitive name, or use '--global' flag."
    exit 1
fi

# get the file
curl -o .gitignore $url 2> /dev/null
echo "Retrieved '$name.gitignore' as './.gitignore'"
