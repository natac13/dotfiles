#####################################################
# General
#####################################################

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../../"
alias b="cd -"

alias c="clear"
alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -lh'      #long list
alias lll='ls -l -a'

alias cpu="top -F -R -o cpu"
alias sizeOf='du -hs'
alias ydl="youtube-dl"

alias his='history'
alias less='less -FSRXc'
alias srcb='source ~/.bashrc'

# alias xclip to systemwide clipboard if installed
if type xclip &> /dev/null
then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

#####################################################
# Docker
#####################################################
# Tools
alias bcryptToolContainer='docker container run --rm epicsoft/bcrypt'

# Docker-compose
alias dcb='docker-compose build'
alias dcdn='docker-compose down'
alias dce='docker-compose exec'
alias dcl='docker-compose logs'
alias dclf='docker-compose logs -f'
alias dco=docker-compose
alias dcps='docker-compose ps'
alias dcr='docker-compose run'
alias dcrestart='docker-compose restart'
alias dcrm='docker-compose rm'
alias dcstop='docker-compose stop'
alias dcup='docker-compose up'

#Docker Stack
alias dsd='docker stack deploy -c'
alias dslf='docker service logs -f'
alias dsl='docker service logs'
alias dsls='docker service ls'
# docker-machine
alias dm='docker-machine'
alias dmssh='docker-machine ssh'
alias dmc='docker-machine create'
alias dmls='docker-machine ls'
alias dmnode1='docker-machine env node1'
# Admin commands
alias dprune='docker container kill $(docker ps -a -q) && docker system prune -f'
alias drip='docker container inspect --format="{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'
alias drit='docker container exec -it'
alias drma='docker container rm $(docker container ps -aq)'
alias drmai='docker image rmi $(docker images -q)'
alias dwipe='docker container kill $(docker ps -a -q) && docker system prune -af'


#####################################################
# AWS
#####################################################

alias daws='docker container run --rm -it -v ~/.aws:/root/.aws amazon/aws-cli'
alias aws-shell='docker run -v ~/.aws:/root/.aws -it pahud/aws-shell'

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