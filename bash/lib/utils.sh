#!/bin/bash

#####################################################
# Functions
#####################################################

function ssh-key-create () {
	cat /dev/zero | ssh-keygen -t ed25519 -C "made with ssh-key-create" -q -N ""
	xclip -sel clip < ~/.ssh/id_ed25519.pub
	echo "ssh-key copied to clipboard"
}

gist_id=1669066880bd89489de27ed9a8b2e760

function pull_aliases() {
    echo "Backing up current .bash_aliases file"
    mv -v ~/.bash_aliases ~/.bash_aliases_orginal
    echo "Updating Bash shell aliases."
    echo "Writing new ~/.bash_aliases"
    curl -L https://gist.github.com/natac13/"$gist_id"/raw > ~/.bash_aliases
    source ~/.bashrc
    cat ~/.bash_aliases
}

function push_aliases() {
    FILE=/home/natac/.gist
    if [ -f "$FILE" ]; then
        echo "Sending .bash_aliases file to Gist"
        docker container run -i --mount type=bind,source="$FILE",target=/root/.gist natac13/gistgem:1.0 -f .bash_aliases -u "$gist_id" <~/.bash_aliases
    else 
        echo "$FILE does not exist"
    fi
}

# Git
function gitignore() { 
  curl -sL https://www.gitignore.io/api/$@ >> .gitignore;
  echo "Create .gitignore file for $@";
}
alias gi=gitignore

# Make a directory and immediately cd into it
function mkcd() {
  if [ $# != 1 ]; then
    echo "Usage: mkcd <dir>"
  else
    mkdir -p $1 && cd $1
  fi
}

# dvim -Opens the current working directory bind mounted to /src in the image.
# dvim /path/to/file.text - Opens the editor bind mounted to the provided directory and file.
function dvim() {
docker_image=natac13/neovim
# If a file name was provided when calling the function
if [[ "$1" = /* ]]; then
    file_name="$(basename ${1})"
    dir_name="$(dirname ${1})"
    shift
    # Run the docker command with the input directory and file name
    docker container run --rm --name nvim -it -v "$dir_name":/src "${docker_image}" "$file_name" "$@"
else
    # Run the docker command with the current directory
    docker container run --rm --name nvim -it -v "$(pwd)":/src "${docker_image}" "$@"
fi
}

