function _update_completions() {
  # Docker completions
  DOCKER_VERSION=$(docker -v | cut -d ' ' -f 3 | cut -d ',' -f 1)
  DOCKER_COMPOSE_VERSION=$(docker-compose -v | cut -d ' ' -f 3 | cut -d ',' -f 1)
  DOCKER_MACHINE_VERSION=$(docker-machine -v | cut -d ' ' -f 3 | cut -d ',' -f 1)
  curl -fsSLo "$DOTFILES/bash/completions/docker.sh" "https://raw.githubusercontent.com/docker/cli/master/contrib/completion/bash/docker"
  curl -fsSLo "$DOTFILES/bash/completions/docker-compose.sh" "https://raw.githubusercontent.com/docker/compose/$DOCKER_COMPOSE_VERSION/contrib/completion/bash/docker-compose"
  curl -fsSLo "$DOTFILES/bash/completions/docker-machine.sh" "https://raw.githubusercontent.com/docker/machine/v$DOCKER_MACHINE_VERSION/contrib/completion/bash/docker-machine.bash"
  # nnn
  curl -fsSLo "$DOTFILES/bash/completions/nnn.sh" "https://raw.githubusercontent.com/jarun/nnn/master/misc/auto-completion/bash/nnn-completion.bash"
  # tmux
  curl -fsSLo "$DOTFILES/bash/completions/tmux.sh" "https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux"

  source ~/.bashrc
}
