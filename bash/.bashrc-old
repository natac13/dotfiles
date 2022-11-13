# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# failing glob expands to nothing, rather than itself
shopt -s nullglob

##################################################
# Dotfiles repo variable
##################################################
# if [ -z "$DOTFILES" ]; then
export DOTFILES="$HOME/projects/dotfiles"
# fi

##################################################
# Color variables
##################################################
if [ -f "${DOTFILES}/bash/colors.sh" ]; then
  source "${DOTFILES}/bash/colors.sh"
fi


#######################################################
# PATH
#######################################################
if [ ! -d "$HOME/bin" ] ; then
  mkdir "$HOME/bin"
fi

if [ ! -d "$HOME/.local/bin" ] ; then
  mkdir "$HOME/.local/bin"
fi
# set PATH so it includes user's private bin if it exists
# This is where you put your hand rolled scripts (remember to chmod them)
export PATH="$HOME/bin:$PATH"
# various installed python programs
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/npm-global/bin:$PATH"

##################################################
# Utilities functions
##################################################
LIB="${DOTFILES}/bash/lib/"
for _bash_lib_file in "$LIB"/*.sh
do
  source "$_bash_lib_file"
done

##################################################
# Aliases, Completions
##################################################
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
 if ! shopt -oq posix; then
   if [ -f /usr/share/bash-completion/bash_completion ]; then
     . /usr/share/bash-completion/bash_completion
   elif [ -f /etc/bash_completion ]; then
     . /etc/bash_completion
   elif [ -f /etc/profile.d/bash_completion.sh ]; then
     . /etc/profile.d/bash_completion.sh
   fi
 fi

ALIAS_DIR="${DOTFILES}/bash/aliases/"
for alias_file in "$ALIAS_DIR"/*.sh
do
  source "$alias_file"
done

COMPLETIONS_DIR="${DOTFILES}/bash/completions/"
for completion_file in "$COMPLETIONS_DIR"/*.sh
do
  source "$completion_file"
done

shopt -u nullglob

##################################################
# Bash History
##################################################
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000


##################################################
# bashrc defaults
##################################################
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.bash ] && . ~/.config/tabtab/__tabtab.bash || true

#######################################################
# Custom bash prompt
#######################################################
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE='true'
GIT_PS1_SHOWUPSTREAM="auto"
# with date
# CUSTOM_PROMPT="\[$Cyan\]|\d - \A|\[$Green\][\u]\[$White\]\w\[$IBlue\]\$(__git_ps1)\[$Color_Off\] $"
# without date
function makePrompt() {
  if [ $UID -eq 0 ]; then
    # root user
    UC="${BPurple}"
  else
    UC="${Green}"
  fi
  if [ "$?" -eq "0" ]; then
    # success / normal prompt
    CC="${IBlue}"
  else
    CC="${BRed}"
    # last command has failed - error prompt
  fi
  CUSTOM_PROMPT="\[$Yellow\][\A]\[$UC\][\u] \[$White\]\w\\n\[$CC\][!\!]\[$ICyan\]\$(__git_ps1)\[$Color_Off\]$ "
  export PS1=$CUSTOM_PROMPT
}
export PROMPT_COMMAND=makePrompt
# Download a custom terminfo that defines sitm and ritm
# wget https://gist.githubusercontent.com/sos4nt/3187620/raw/8e13c1fec5b72d415ed2917590348451de5f8e58/xterm-256color-italic.terminfo
# Compile it
# tic xterm-256color-italic.terminfo
# Activate xterm-256color-italic.terminfo automatically
#export TERM=xterm-256color
#export TERM=xterm-256color-italic
eval "$(/home/natac/.linuxbrew/bin/brew shellenv)"
#######################################################
# Editor
#######################################################

if [ -x /usr/bin/nvim ]; then
  export EDITOR=nvim
  export VISUAL=nvim
else
  export EDITOR=vim
  export VISUAL=vim
fi

#######################################################
# FZF
#######################################################
export FZF_DEFAULT_OPTS='--layout=reverse --height 50%'
export FZF_DEFAULT_COMMAND="rg --smart-case --files --no-ignore --hidden --follow \
  --glob '!.git/*' \
  --glob '!.DS_Store' \
  --glob '!node_modules/*' \
  --glob '!bin/*' \
  --glob '!build/*' \
  --glob '!coverage/*' \
  --glob '!.aws/*' \
  --glob '!.serverless/*' \
  --glob '!dist/*' \
  --glob '!target/*'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
