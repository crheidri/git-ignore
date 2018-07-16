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

status_exit() {
#status_exit exit script with message if 0 status
# Inputs:
#   'status': status of command
#   'msg': message to display if 0 status
# Outputs:
#   None
    if [ "$1" = "0" ]
    then
        echo "$2"
        exit 0
    fi
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
        --output $ignorefile \
        "$baseurl/$1/$2/master/$3"
    status=$? # return status of curl call
}

# parse variables
OPTIONS=gh
LONGOPTS=global,help
PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
eval set -- "$PARSED"

# get inputs
global= name=
while true; do
    case "$1" in
        -g|--global)    global=1
                        shift
                        ;;
        -h|--help)      usage
                        ;;
        -- )            shift
                        break
                        ;;
        * )             break
                        ;;
    esac
done
name=$1

# exit if no gitignore_name given
if [ "$#" -ne "1" ]
then
    error_exit $LINENO "A single gitignore_name input is required."
fi

# find repo top level
gitroot=$(git rev-parse --show-toplevel) || error_exit $LINENO
ignorefile="$gitroot/.gitignore"

# get file
owner="github"
repo="gitignore"
file="${global:+"Global/"}$name.gitignore"
github_api $owner $repo $file
status_exit $status "Retrieved '$file' as '$ignorefile'"

# if operation failed
error_exit $LINENO "No gitignore template found for '$name'. Check case-sensitive name, or check --global flag."
