##!/bin/bash

#if [ -z "$DOTFILES" ]; then
#  echo "FIRST"
#  export DOTFILES="{$HOME}/projects/dotfiles"
#fi
## failing glob expands to nothing, rather than itself
## shopt -s nullglob 
## shopt -s extglob

###################################################
## Load utilities functions
###################################################
#LIB="${DOTFILES}/bash/lib/*.sh"
#for _bash_lib_file in $LIB
#do
#  echo $_bash_lib_file
#done

###################################################
## Load Aliases, Completions
###################################################
#ALIAS_DIR=${DOTFILES}/bash/aliases/*
#for alias_file in $ALIAS_DIR
#do
#  echo "$alias_file"
#done

#COMPLETIONS_DIR=${DOTFILES}/bash/completions/*
#for completion_file in $COMPLETIONS_DIR
#do
#  echo "$completion_file"
#done


#shopt -u nullglob

if [ -f "${DOTFILES}/bash/colors.sh" ]; then
  source "${DOTFILES}/bash/colors.sh"
fi
source ~/projects/dotfiles/bash/lib/helpers.sh

  _doing 'loading'
  _success 'success'
  _fail 'fail'
  echo "test"
  _info 'someinfo...'
if  ! _command_exists gh; then
  echo 'gh does not exist' else
else
  echo "gh exists"
fi
# eval "$(gh completion -s bash)"
