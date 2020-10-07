#!/bin/bash

# sudo add-apt-repository ppa:neovim-ppa/stable
# cd ~ && sudo apt-get update -y \
#   && sudo apt-get upgrade -y;


# echo "Installing the basics: git, neovim, tmux, fzf, ripgrep"
# sudo apt-get install -y \
#   ca-certificates \
#   curl \
#   wget \
#   dirmngr \
#   gpg \
#   git \
#   vim \
#   neovim \
#   tmux \
#   # fzf \
#   # ripgrep \
#   tldr \
#   nnn \
#   neofetch \
#   openssh-client \
#   automake \
#   make \
#   unzip \
#   g++ \
#   gcc \
#   jq 

# bat installation isn't through apt yet
curl -fLo bat.deb https://github.com/sharkdp/bat/releases/download/v0.15.4/bat-musl_0.15.4_amd64.deb
sudo dpkg -i ./bat.deb
rm ./bat.deb

echo "As per https://github.com/junegunn/fzf/issues/1589 we'll have to install fzf manually on Ubuntu 18.04 at the moment";
wget http://mirrors.kernel.org/ubuntu/pool/universe/f/fzf/fzf_0.18.0-2_amd64.deb | sudo dpkg -i
wget https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb | sudo dpkg -i

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


#read -p "What email do you want associated with your git config? " gitemail
#git config --global user.email "$gitemail"
#read -p "And the name? " gitname
#git config --global user.name "$gitname"

mkdir ~/projects
mkdir ~/.local/share/nvim/undo -p

mkdir ~/.fonts

# echo "Making an SSH Key";
# ssh-keygen -t rsa
# eval `ssh-agent`
# ssh-add ~/.ssh/id_rsa

# echo $(cat ~/.ssh/id_rsa.pub)
#read -p "Press <Enter> once you have added the SSH key above to github." irrelevant

# git clone git@github.com:natac13/dotfiles.git ~/projects/dotfiles

# mkdir ~/.config/nvim
# rm ~/.bashrc ~/.bash_profile ~/.tmux.conf ~/.vimrc > /dev/null 2>&1
# ln -s ~/projects/dotfiles/ignore.symlink ~/.ignore
# ln -s ~/projects/dotfiles/bash_profile.symlink ~/.bash_profile
# ln -s ~/projects/dotfiles/bash_aliases.symlink ~/.bash_aliases
# ln -s ~/projects/dotfiles/bashrc.symlink ~/.bashrc
# ln -s ~/projects/dotfiles/tmux.conf.symlink ~/.tmux.conf
# ln -s ~/projects/dotfiles/vimrc.symlink ~/.config/nvim/init.vim

# source ~/.bash_profile
# source ~/.bashrc

read -p "Would you like to install NodeJS? [Y/n]" nodejs
case $nodejs in
 [Yy]* )
    Using Ubuntu
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    sudo apt-get install -y nodejs
   ;;
  [Nn]* );;
  * )
esac
# curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -


read -p "Would you like to install Yarn? [Y/n]" yarn
case $yarn in
 [Yy]* )
   # Install Yarn
   echo "Installing yarn"
   curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
   echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
   sudo apt-get install -y yarn
   ;;
 [Nn]* );;
 * )
esac

# neovim setup
echo "Setup of neovim"

mkdir -p ~/.local/share/nvim/site/pack/natac/start
cd ~/.local/share/nvim/site/pack/natac/start
git clone https://tpope.io/vim/fugitive.git
nvim -u NONE -c "helptags fugitive/doc" -c q
git clone --depth 1 https://github.com/morhetz/gruvbox.git && \
git clone --depth 1 https://github.com/vim-airline/vim-airline.git && \
git clone --depth 1 https://github.com/tpope/vim-fugitive.git && \
git clone --depth 1 https://github.com/tpope/vim-surround && \
git clone --depth 1 https://github.com/vim-syntastic/syntastic.git && \
git clone --depth 1 https://github.com/junegunn/fzf.git && \
git clone --depth 1 https://github.com/airblade/vim-gitgutter.git && \
git clone --depth 1 --branch release https://github.com/neoclide/coc.nvim.git


# Install extensions
mkdir -p ~/.config/coc/extensions
cd ~/.config/coc/extensions
if [ ! -f package.json ]
then
  echo '{"dependencies":{}}'> package.json
fi
Change extension names to the extensions you need
npm install coc-snippets coc-html coc-css coc-tsserver coc-json coc-graphql coc-yaml coc-pairs coc-prettier coc-eslint --only=prod

#nvim -c "call coc#util#install()|echo 'Quit vim using :qa when completed'"

#nvim -c "CocInstall coc-html coc-css coc-tsserver coc-json coc-graphql coc-yaml coc-paris coc-snippets |echo 'When the plugin is installed it will let you know, and you can exit with :qa'"


echo '==========================================================================='
echo "Done! You can now `rm ~/intall.sh`, and there is a copy in `~/projects/dotfiles` for reference if you're interested. Please read the README to see further details. Enjoy..."
echo '==========================================================================='
