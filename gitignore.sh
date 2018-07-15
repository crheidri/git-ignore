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

error_exit() {
#error_exit display message and exit as error.
# Inputs:
#   'lineno': line number of error
#   'msg': error message to display
	echo "$0: $1: ${2:-"Unknown Error"}" 1>&2
	exit 1
}

github_api() {
#github_api fetch template from GitHub  as .gitignore
# Inputs:
#   'owner': owner of repo on GitHub (default 'github')
#   'repo': name of repo (default 'gitignore')
#   'file': filename (with Global/ prefix if --global)
# Outputs:
#   None

    local baseurl="https://raw.githubusercontent.com"
    curl --silent --fail \
        --output ".gitignore" \
        "$baseurl/$1/$2/master/$3"
    status=$? # return status of curl call
}

# parse variables
global=
name=
while [ "$1" != "" ]; do
    case "$1" in
        -g | --global )     global="Global/"
                            ;;
        -h | --help )       usage
                            exit
                            ;;
        * )                 name=$1
    esac
    shift
done

# exit if no gitignore_name given
if [ -z "$name" ]
then
    error_exit $LINENO "gitignore_name input required."
fi

# get file
owner="github"
repo="gitignore"
file="$global$name.gitignore"
github_api $owner $repo $file

# check if url exists
if [ "$status" != "0" ]
then
    error_exit $LINENO "No gitignore template found for '$global$name'. Check case-sensitive name, or check --global flag."
else
    echo "Retrieved '$name.gitignore' as './.gitignore'"
fi
