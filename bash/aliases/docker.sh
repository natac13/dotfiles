#!/bin/bash

#####################################################
# Docker
#####################################################
# Tools
alias bcryptToolContainer='docker container run --rm epicsoft/bcrypt'

alias dk='docker'
# container
alias dklc='docker container ps -l'  # List last Docker container
alias dklcid='docker container ps -l -q'  # List last Docker container ID
alias dklcip='docker container inspect --format="{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)'  # Get IP of last Docker container
alias dkps='docker container ps'  # List running Docker containers
alias dkpsa='docker container ps -a'  # List all Docker containers
alias dkrmac='docker container rm $(docker container ps -a -q)'  # Delete all Docker containers

alias dkelc='docker container exec -it $(dklcid) bash --login' # Enter last container (works with Docker 1.3 and above)
alias dkrmflast='docker container rm -f $(dklcid)'
alias dkbash='dkelc'
alias dkex='docker container exec -it ' # Useful to run any commands into container without leaving host
alias dkri='docker container run --rm -i '
alias dkric='docker container run --rm -i -v $PWD:/cwd -w /cwd '
alias dkrit='docker container run --rm -it '
alias dkritc='docker container run --rm -it -v $PWD:/cwd -w /cwd '

# image
alias dki='docker images'  # List Docker images


# Added more recent cleanup options from newer docker versions
alias dkip='docker image prune -a -f'
alias dkvp='docker volume prune -f'
alias dksp='docker system prune -a -f'

# Admin commands
alias dprune='docker container kill $(docker ps -a -q) && docker system prune -f'
alias drmai='docker image rmi $(docker images -q)'
alias dwipe='docker container kill $(docker ps -a -q) && docker system prune -af'

#Docker Stack
alias dsd='docker stack deploy -c'
alias dslf='docker service logs -f'
alias dsl='docker service logs'
alias dsls='docker service ls'

