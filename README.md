# git-ignore
This bash script sources .gitignore templates from GitHub to the root of the current git repository as "/.gitignore". See the list of templates available at [github/gitignore](https://github.com/github/gitignore).

NOTE: names are case-sensitive (e.g. 'TeX' is a valid template, but 'tex' is not).

## Getting Started
Clone this project and add it to your path:
```console
foo@bar:~$ git clone https://github.com/crheidri/git-ignore.git ~/git-ignore
foo@bar:~$ export PATH=$PATH:$HOME/git-ignore
```

Currently git-ignore requires ```curl``` to source templates from GitHub. On Ubuntu Linux you can install it with:
```console
foo@bar:~$ sudo apt-get install curl
```

## Examples
Use the command `git ignore <template>` from anywhere within a git repository to download a .gitignore template matching `<template>`.

### Project-specific .gitignore
```console
foo@bar:~$ mkdir python_project
foo@bar:~$ cd python_project
foo@bar:~/python_project$ git init .
foo@bar:~/python_project$ git ignore Python
```
This will create the Python .gitignore template as ~/python_project/.gitignore

### Global .gitignore
Templates organized as Global (operating system or editor specific) need to use the --global (-g) flag
```console
foo@bar:~$ git ignore --global VisualStudioCode
```

## License
GNU General Public License
