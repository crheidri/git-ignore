# gitignore.sh
This bash script sources .gitignore templates from GitHub to the current directory as ./.gitignore. See the list of templates available at [github/gitignore](https://github.com/github/gitignore).

NOTE: names are case-sensitive (e.g. 'TeX' is a valid template, but 'tex' is not).

## Getting Started
Clone this repo and add it to your path, or create an alias in your ~/.bashrc such as:
```
alias gitignore="~/gitignore/gitignore.sh"
```

## Examples
The easiest way to use this script is from the root of a git repository you want to add a .gitignore template to.

### Project-specific gitignore
```console
foo@bar:~$ mkdir python_project
foo@bar:~$ cd python_project
foo@bar:~/python_project$ git init .
foo@bar:~/python_project$ gitignore Python
```
This will create the Python .gitignore template as ~/python_project/.gitignore

### Global gitignore
Templates organized as Global (operating system or editor specific) need to use the --global (-g) flag
```console
foo@bar:~$ gitignore --global VisualStudioCode
```

## License
GNU General Public License
