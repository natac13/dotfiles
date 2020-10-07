FROM ubuntu:18.04

RUN apt-get update && \
  apt-get install -y software-properties-common && \
  add-apt-repository ppa:neovim-ppa/stable && \
  apt-get -y update && \
  apt-get -y upgrade && \
  apt-get -y install \
  sudo \
  ca-certificates \
  curl \
  wget \
  dirmngr \
  gpg \
  git \
  vim \
  neovim \
  tmux \
  # fzf \
  # ripgrep \
  tldr \
  nnn \
  neofetch \
  openssh-client \
  automake \
  make \
  unzip \
  g++ \
  gcc \
  jq

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  apt-get -y install nodejs && \
  ln -s /usr/bin/nodejs /usr/local/bin/node

COPY install.sh /home/root/install.sh

WORKDIR  /home/root

# RUN "bash ./install.sh"

CMD ["/bin/bash"]
