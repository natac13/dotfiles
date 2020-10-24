#!/bin/bash

# neovim setup
echo "Setup of neovim"

mkdir -p "$HOME/.local/share/nvim/site/pack/natac/start"
mkdir -p "$HOME/.local/share/nvim/undo"
mkdir -p "$HOME/.config/nvim"

if [ -x /usr/bin/nvim ]; then
  export EDITOR=nvim
  export VISUAL=nvim
else
  export EDITOR=vim
  export VISUAL=vim
fi

COC_EXT_PATH="$HOME/.config/coc/extensions"


echo "Clone all vim plugins."
cd ~/.local/share/nvim/site/pack/natac/start
git clone --depth 1 https://github.com/sheerun/vim-polyglot.git
nvim -u NONE -c "helptags vim-polyglot/doc" -c q
git clone --depth 1 https://github.com/vim-airline/vim-airline.git
nvim -u NONE -c "helptags vim-airline/doc" -c q
git clone --depth 1 https://github.com/tpope/vim-fugitive.git
nvim -u NONE -c "helptags vim-fugitive/doc" -c q
git clone --depth 1 https://github.com/tpope/vim-surround.git
nvim -u NONE -c "helptags vim-surround/doc" -c q
git clone --depth 1 https://github.com/tomtom/tcomment_vim.git
nvim -u NONE -c "helptags tcomment_vim/doc" -c q
git clone --depth 1 https://github.com/junegunn/fzf.git
./fzf/install
nvim -u NONE -c "helptags fzf/doc" -c q
git clone --depth 1 https://github.com/junegunn/fzf.vim.git
nvim -u NONE -c "helptags fzf.vim/doc" -c q
git clone --depth 1 https://github.com/airblade/vim-gitgutter.git
nvim -u NONE -c "helptags vim-gitgutter/doc" -c q
git clone --depth 1 --branch release https://github.com/neoclide/coc.nvim.git
nvim -u NONE -c "helptags coc.nvim/doc" -c q
git clone --depth 1 https://github.com/chrisbra/unicode.vim.git
nvim -u NONE -c "helptags unicode.vim/doc" -c q
git clone --depth 1 https://github.com/justinmk/vim-sneak.git
nvim -u NONE -c "helptags vim-sneak/doc" -c q
git clone --depth 1 https://github.com/sainnhe/gruvbox-material.git
nvim -u NONE -c "helptags gruvbox-material/doc" -c q

cd ../opt
git clone --depth 1 https://github.com/lifepillar/vim-gruvbox8.git
nvim -u NONE -c "helptags vim-gruvbox8/doc" -c q

cd $HOME
# Install extensions
if [ ! -d "$COC_EXT_PATH" ]; then
  mkdir -p "$HOME/.config/coc/extensions"
fi
cd ~/.config/coc/extensions
if [ ! -f package.json ]; then
  echo '{"dependencies":{}}'> package.json
fi

flags="--global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod"
# Change extension names to the extensions you need
npm install coc-snippets coc-explorer coc-html coc-css coc-tsserver coc-json coc-graphql coc-yaml coc-pairs coc-prettier coc-eslint coc-emoji $flags
