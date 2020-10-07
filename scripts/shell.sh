# neovim setup
printf "Setup bash shell"

if [ ! -d $DOTFILES_DIR ]
then
  source ./utils.sh
fi


mkdir ~/projects
mkdir ~/.local/share/fonts

doing "Linking MyOperatorMono custom font"
for font in $DOTFILES_DIR/fonts/*
do
  ln -s $font "$HOME/`basename $file`"
done
success

# link required files
doing "Linking bash + git + tmux configs..."
for file in $DOTFILES_DIR/{bash,git,tmux}/*
do
  [ -e "$HOME/.`basename $file`" ] && rm "$HOME/.`basename $file`" &>/dev/null
  ln -s $file "$HOME/.`basename $file`"
done
success

printf "Downloading git-prompt and git-completions for bash"
cd $HOME
wget https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
wget https://github.com/git/git/blob/master/contrib/completion/git-completion.bash